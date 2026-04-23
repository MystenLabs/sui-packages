module 0x5b1bde6bfef532d5753cfeabfe71d409aea33701c3ab6408373d7c6803248922::plsa_vault {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct PLSAConfig has key {
        id: 0x2::object::UID,
        deposit_min: u64,
        deposit_cap: u64,
        lockup_period_sec: u64,
        early_withdraw_penalty_bps: u64,
        liquidity_reserve: u64,
        paused: bool,
        vault_initialized: bool,
    }

    struct PLSAVault<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
    }

    struct Deposit has copy, drop, store {
        principal: u64,
        deposited_at: u64,
        remaining: u64,
    }

    struct UserDeposits has key {
        id: 0x2::object::UID,
        deposits: 0x2::table::Table<address, vector<Deposit>>,
        depositors: vector<address>,
        time_unit_sec: u64,
    }

    struct PendingRedemption has copy, drop, store {
        redemption_id: u64,
        gross_amount: u64,
        penalty: u64,
        net_amount: u64,
        requested_at: u64,
        status: u8,
        finalized_at: u64,
    }

    struct RedemptionRegistry has key {
        id: 0x2::object::UID,
        redemptions: 0x2::table::Table<address, vector<PendingRedemption>>,
        next_redemption_id: u64,
        total_pending_net: u64,
    }

    struct VaultCreated has copy, drop {
        vault_id: address,
    }

    struct DepositEvent has copy, drop {
        user: address,
        amount: u64,
        timestamp: u64,
        deposit_index: u64,
    }

    struct RedeemRequested has copy, drop {
        user: address,
        redemption_id: u64,
        gross_amount: u64,
        penalty: u64,
        net_amount: u64,
        requested_at: u64,
    }

    struct RedeemSettled has copy, drop {
        user: address,
        redemption_id: u64,
        net_paid: u64,
        penalty_final: u64,
        entries_lost: u64,
        timestamp: u64,
    }

    struct RedeemCancelled has copy, drop {
        user: address,
        redemption_id: u64,
        timestamp: u64,
    }

    struct AdminWithdrawEvent has copy, drop {
        amount: u64,
        balance_after: u64,
        timestamp: u64,
    }

    struct AdminInjectEvent has copy, drop {
        amount: u64,
        balance_after: u64,
        timestamp: u64,
    }

    struct ConfigUpdated has copy, drop {
        deposit_min: u64,
        deposit_cap: u64,
        lockup_period_sec: u64,
        early_withdraw_penalty_bps: u64,
        liquidity_reserve: u64,
    }

    struct PausedChanged has copy, drop {
        paused: bool,
    }

    struct TimeUnitChanged has copy, drop {
        time_unit_sec: u64,
    }

    public entry fun admin_inject<T0>(arg0: &AdminCap, arg1: &mut PLSAVault<T0>, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock) {
        0x2::balance::join<T0>(&mut arg1.balance, 0x2::coin::into_balance<T0>(arg2));
        let v0 = AdminInjectEvent{
            amount        : 0x2::coin::value<T0>(&arg2),
            balance_after : 0x2::balance::value<T0>(&arg1.balance),
            timestamp     : 0x2::clock::timestamp_ms(arg3) / 1000,
        };
        0x2::event::emit<AdminInjectEvent>(v0);
    }

    public entry fun admin_withdraw<T0>(arg0: &AdminCap, arg1: &PLSAConfig, arg2: &mut PLSAVault<T0>, arg3: &RedemptionRegistry, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<T0>(&arg2.balance);
        assert!(v0 >= arg4, 4);
        let v1 = v0 - arg4;
        assert!(v1 >= arg1.liquidity_reserve + arg3.total_pending_net, 12);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg2.balance, arg4), arg6), 0x2::tx_context::sender(arg6));
        let v2 = AdminWithdrawEvent{
            amount        : arg4,
            balance_after : v1,
            timestamp     : 0x2::clock::timestamp_ms(arg5) / 1000,
        };
        0x2::event::emit<AdminWithdrawEvent>(v2);
    }

    public fun calculate_full_entries(arg0: u64, arg1: u64) : u64 {
        if (arg1 <= 30) {
            arg0 * arg1
        } else if (arg1 <= 60) {
            arg0 * 30 + arg0 * (arg1 - 30) / 5
        } else if (arg1 <= 90) {
            arg0 * 30 + arg0 * 6 + arg0 * (arg1 - 60) / 10
        } else {
            arg0 * 30 + arg0 * 6 + arg0 * 3 + arg0 * (arg1 - 90) / 20
        }
    }

    public fun calculate_user_entries(arg0: &UserDeposits, arg1: address, arg2: &0x2::clock::Clock) : u64 {
        if (!0x2::table::contains<address, vector<Deposit>>(&arg0.deposits, arg1)) {
            return 0
        };
        let v0 = 0x2::clock::timestamp_ms(arg2) / 1000;
        let v1 = 0x2::table::borrow<address, vector<Deposit>>(&arg0.deposits, arg1);
        let v2 = 0;
        let v3 = 0;
        while (v3 < 0x1::vector::length<Deposit>(v1)) {
            let v4 = 0x1::vector::borrow<Deposit>(v1, v3);
            if (v4.remaining > 0) {
                let v5 = if (v0 > v4.deposited_at) {
                    (v0 - v4.deposited_at) / arg0.time_unit_sec
                } else {
                    0
                };
                v2 = v2 + calculate_full_entries(v4.remaining, v5);
            };
            v3 = v3 + 1;
        };
        v2
    }

    public entry fun cancel_redeem(arg0: &mut RedemptionRegistry, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::clock::timestamp_ms(arg2) / 1000;
        assert!(0x2::table::contains<address, vector<PendingRedemption>>(&arg0.redemptions, v0), 10);
        let v2 = 0x2::table::borrow_mut<address, vector<PendingRedemption>>(&mut arg0.redemptions, v0);
        let v3 = find_redemption_index(v2, arg1);
        assert!(v3 < 0x1::vector::length<PendingRedemption>(v2), 10);
        let v4 = 0x1::vector::borrow_mut<PendingRedemption>(v2, v3);
        assert!(v4.status == 0, 9);
        v4.status = 2;
        v4.finalized_at = v1;
        arg0.total_pending_net = arg0.total_pending_net - v4.net_amount;
        let v5 = RedeemCancelled{
            user          : v0,
            redemption_id : arg1,
            timestamp     : v1,
        };
        0x2::event::emit<RedeemCancelled>(v5);
    }

    fun compute_penalty_fifo(arg0: &vector<Deposit>, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<Deposit>(arg0) && arg1 > 0) {
            let v2 = 0x1::vector::borrow<Deposit>(arg0, v1);
            if (v2.remaining > 0) {
                let v3 = if (v2.remaining >= arg1) {
                    arg1
                } else {
                    v2.remaining
                };
                let v4 = if (arg2 > v2.deposited_at) {
                    arg2 - v2.deposited_at
                } else {
                    0
                };
                if (v4 < arg3) {
                    v0 = v0 + v3 * arg4 / 10000;
                };
                arg1 = arg1 - v3;
            };
            v1 = v1 + 1;
        };
        v0
    }

    public entry fun create_vault<T0>(arg0: &AdminCap, arg1: &mut PLSAConfig, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.vault_initialized, 13);
        arg1.vault_initialized = true;
        let v0 = PLSAVault<T0>{
            id      : 0x2::object::new(arg2),
            balance : 0x2::balance::zero<T0>(),
        };
        0x2::transfer::share_object<PLSAVault<T0>>(v0);
        let v1 = VaultCreated{vault_id: 0x2::object::id_address<PLSAVault<T0>>(&v0)};
        0x2::event::emit<VaultCreated>(v1);
    }

    public entry fun deposit<T0>(arg0: &PLSAConfig, arg1: &mut PLSAVault<T0>, arg2: &mut UserDeposits, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 1);
        let v0 = 0x2::coin::value<T0>(&arg3);
        let v1 = 0x2::tx_context::sender(arg5);
        let v2 = 0x2::clock::timestamp_ms(arg4) / 1000;
        assert!(v0 >= arg0.deposit_min, 2);
        assert!(get_user_active_principal(arg2, v1) + v0 <= arg0.deposit_cap, 3);
        let v3 = Deposit{
            principal    : v0,
            deposited_at : v2,
            remaining    : v0,
        };
        if (!0x2::table::contains<address, vector<Deposit>>(&arg2.deposits, v1)) {
            0x2::table::add<address, vector<Deposit>>(&mut arg2.deposits, v1, 0x1::vector::empty<Deposit>());
            0x1::vector::push_back<address>(&mut arg2.depositors, v1);
        };
        let v4 = 0x2::table::borrow_mut<address, vector<Deposit>>(&mut arg2.deposits, v1);
        0x1::vector::push_back<Deposit>(v4, v3);
        0x2::balance::join<T0>(&mut arg1.balance, 0x2::coin::into_balance<T0>(arg3));
        let v5 = DepositEvent{
            user          : v1,
            amount        : v0,
            timestamp     : v2,
            deposit_index : 0x1::vector::length<Deposit>(v4),
        };
        0x2::event::emit<DepositEvent>(v5);
    }

    public fun deposit_deposited_at(arg0: &Deposit) : u64 {
        arg0.deposited_at
    }

    public fun deposit_principal(arg0: &Deposit) : u64 {
        arg0.principal
    }

    public fun deposit_remaining(arg0: &Deposit) : u64 {
        arg0.remaining
    }

    fun fifo_consume_remaining(arg0: &mut vector<Deposit>, arg1: u64, arg2: u64, arg3: u64) : u64 {
        prune_leading_zero_deposits(arg0);
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<Deposit>(arg0) && arg1 > 0) {
            let v2 = 0x1::vector::borrow_mut<Deposit>(arg0, v1);
            if (v2.remaining > 0) {
                let v3 = if (v2.remaining >= arg1) {
                    arg1
                } else {
                    v2.remaining
                };
                let v4 = if (arg2 > v2.deposited_at) {
                    (arg2 - v2.deposited_at) / arg3
                } else {
                    0
                };
                v0 = v0 + calculate_full_entries(v3, v4);
                v2.remaining = v2.remaining - v3;
                arg1 = arg1 - v3;
            };
            v1 = v1 + 1;
        };
        prune_leading_zero_deposits(arg0);
        v0
    }

    fun find_redemption_index(arg0: &vector<PendingRedemption>, arg1: u64) : u64 {
        let v0 = 0;
        let v1 = 0x1::vector::length<PendingRedemption>(arg0);
        while (v0 < v1) {
            if (0x1::vector::borrow<PendingRedemption>(arg0, v0).redemption_id == arg1) {
                return v0
            };
            v0 = v0 + 1;
        };
        v1
    }

    public fun get_deposit_cap(arg0: &PLSAConfig) : u64 {
        arg0.deposit_cap
    }

    public fun get_deposit_min(arg0: &PLSAConfig) : u64 {
        arg0.deposit_min
    }

    public fun get_depositors(arg0: &UserDeposits) : &vector<address> {
        &arg0.depositors
    }

    public fun get_liquidity_reserve(arg0: &PLSAConfig) : u64 {
        arg0.liquidity_reserve
    }

    public fun get_lockup_period(arg0: &PLSAConfig) : u64 {
        arg0.lockup_period_sec
    }

    public fun get_next_redemption_id(arg0: &RedemptionRegistry) : u64 {
        arg0.next_redemption_id
    }

    public fun get_penalty_bps(arg0: &PLSAConfig) : u64 {
        arg0.early_withdraw_penalty_bps
    }

    public fun get_redeemable_principal(arg0: &UserDeposits, arg1: &RedemptionRegistry, arg2: address) : u64 {
        let v0 = get_user_active_principal(arg0, arg2);
        if (!0x2::table::contains<address, vector<PendingRedemption>>(&arg1.redemptions, arg2)) {
            return v0
        };
        let v1 = 0x2::table::borrow<address, vector<PendingRedemption>>(&arg1.redemptions, arg2);
        let v2 = 0;
        let v3 = 0;
        while (v2 < 0x1::vector::length<PendingRedemption>(v1)) {
            let v4 = 0x1::vector::borrow<PendingRedemption>(v1, v2);
            if (v4.status == 0) {
                v3 = v3 + v4.gross_amount;
            };
            v2 = v2 + 1;
        };
        if (v3 >= v0) {
            0
        } else {
            v0 - v3
        }
    }

    public fun get_time_unit_sec(arg0: &UserDeposits) : u64 {
        arg0.time_unit_sec
    }

    public fun get_total_pending_net(arg0: &RedemptionRegistry) : u64 {
        arg0.total_pending_net
    }

    public fun get_user_active_principal(arg0: &UserDeposits, arg1: address) : u64 {
        if (!0x2::table::contains<address, vector<Deposit>>(&arg0.deposits, arg1)) {
            return 0
        };
        let v0 = 0x2::table::borrow<address, vector<Deposit>>(&arg0.deposits, arg1);
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<Deposit>(v0)) {
            v1 = v1 + 0x1::vector::borrow<Deposit>(v0, v2).remaining;
            v2 = v2 + 1;
        };
        v1
    }

    public fun get_user_deposits(arg0: &UserDeposits, arg1: address) : &vector<Deposit> {
        0x2::table::borrow<address, vector<Deposit>>(&arg0.deposits, arg1)
    }

    public fun get_user_original_principal(arg0: &UserDeposits, arg1: address) : u64 {
        if (!0x2::table::contains<address, vector<Deposit>>(&arg0.deposits, arg1)) {
            return 0
        };
        let v0 = 0x2::table::borrow<address, vector<Deposit>>(&arg0.deposits, arg1);
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<Deposit>(v0)) {
            v1 = v1 + 0x1::vector::borrow<Deposit>(v0, v2).principal;
            v2 = v2 + 1;
        };
        v1
    }

    public fun get_user_redemptions(arg0: &RedemptionRegistry, arg1: address) : &vector<PendingRedemption> {
        0x2::table::borrow<address, vector<PendingRedemption>>(&arg0.redemptions, arg1)
    }

    fun has_pending(arg0: &RedemptionRegistry, arg1: address) : bool {
        if (!0x2::table::contains<address, vector<PendingRedemption>>(&arg0.redemptions, arg1)) {
            return false
        };
        let v0 = 0x2::table::borrow<address, vector<PendingRedemption>>(&arg0.redemptions, arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<PendingRedemption>(v0)) {
            if (0x1::vector::borrow<PendingRedemption>(v0, v1).status == 0) {
                return true
            };
            v1 = v1 + 1;
        };
        false
    }

    public fun has_user(arg0: &UserDeposits, arg1: address) : bool {
        0x2::table::contains<address, vector<Deposit>>(&arg0.deposits, arg1)
    }

    public fun has_user_redemptions(arg0: &RedemptionRegistry, arg1: address) : bool {
        0x2::table::contains<address, vector<PendingRedemption>>(&arg0.redemptions, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = PLSAConfig{
            id                         : 0x2::object::new(arg0),
            deposit_min                : 1000000,
            deposit_cap                : 1500000000,
            lockup_period_sec          : 2592000,
            early_withdraw_penalty_bps : 500,
            liquidity_reserve          : 0,
            paused                     : false,
            vault_initialized          : false,
        };
        0x2::transfer::share_object<PLSAConfig>(v1);
        let v2 = UserDeposits{
            id            : 0x2::object::new(arg0),
            deposits      : 0x2::table::new<address, vector<Deposit>>(arg0),
            depositors    : 0x1::vector::empty<address>(),
            time_unit_sec : 86400,
        };
        0x2::transfer::share_object<UserDeposits>(v2);
        let v3 = RedemptionRegistry{
            id                 : 0x2::object::new(arg0),
            redemptions        : 0x2::table::new<address, vector<PendingRedemption>>(arg0),
            next_redemption_id : 1,
            total_pending_net  : 0,
        };
        0x2::transfer::share_object<RedemptionRegistry>(v3);
    }

    public fun is_paused(arg0: &PLSAConfig) : bool {
        arg0.paused
    }

    public fun is_vault_initialized(arg0: &PLSAConfig) : bool {
        arg0.vault_initialized
    }

    fun prune_leading_zero_deposits(arg0: &mut vector<Deposit>) {
        while (!0x1::vector::is_empty<Deposit>(arg0) && 0x1::vector::borrow<Deposit>(arg0, 0).remaining == 0) {
            0x1::vector::remove<Deposit>(arg0, 0);
        };
    }

    public fun redemption_finalized_at(arg0: &PendingRedemption) : u64 {
        arg0.finalized_at
    }

    public fun redemption_gross(arg0: &PendingRedemption) : u64 {
        arg0.gross_amount
    }

    public fun redemption_id(arg0: &PendingRedemption) : u64 {
        arg0.redemption_id
    }

    public fun redemption_net(arg0: &PendingRedemption) : u64 {
        arg0.net_amount
    }

    public fun redemption_penalty(arg0: &PendingRedemption) : u64 {
        arg0.penalty
    }

    public fun redemption_requested_at(arg0: &PendingRedemption) : u64 {
        arg0.requested_at
    }

    public fun redemption_status(arg0: &PendingRedemption) : u8 {
        arg0.status
    }

    public entry fun request_redeem<T0>(arg0: &PLSAConfig, arg1: &mut PLSAVault<T0>, arg2: &mut UserDeposits, arg3: &mut RedemptionRegistry, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 1);
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::clock::timestamp_ms(arg5) / 1000;
        assert!(0x2::table::contains<address, vector<Deposit>>(&arg2.deposits, v0), 6);
        assert!(!has_pending(arg3, v0), 8);
        assert!(arg4 > 0 && arg4 <= get_user_active_principal(arg2, v0), 4);
        let v2 = compute_penalty_fifo(0x2::table::borrow<address, vector<Deposit>>(&arg2.deposits, v0), arg4, v1, arg0.lockup_period_sec, arg0.early_withdraw_penalty_bps);
        let v3 = arg4 - v2;
        let v4 = arg3.next_redemption_id;
        arg3.next_redemption_id = v4 + 1;
        if (!0x2::table::contains<address, vector<PendingRedemption>>(&arg3.redemptions, v0)) {
            0x2::table::add<address, vector<PendingRedemption>>(&mut arg3.redemptions, v0, 0x1::vector::empty<PendingRedemption>());
        };
        let v5 = PendingRedemption{
            redemption_id : v4,
            gross_amount  : arg4,
            penalty       : v2,
            net_amount    : v3,
            requested_at  : v1,
            status        : 0,
            finalized_at  : 0,
        };
        0x1::vector::push_back<PendingRedemption>(0x2::table::borrow_mut<address, vector<PendingRedemption>>(&mut arg3.redemptions, v0), v5);
        arg3.total_pending_net = arg3.total_pending_net + v3;
        let v6 = RedeemRequested{
            user          : v0,
            redemption_id : v4,
            gross_amount  : arg4,
            penalty       : v2,
            net_amount    : v3,
            requested_at  : v1,
        };
        0x2::event::emit<RedeemRequested>(v6);
        if (0x2::balance::value<T0>(&arg1.balance) >= v3) {
            settle_inline<T0>(arg0, arg1, arg2, arg3, v0, v4, arg5, arg6);
        };
    }

    public entry fun set_paused(arg0: &AdminCap, arg1: &mut PLSAConfig, arg2: bool) {
        arg1.paused = arg2;
        let v0 = PausedChanged{paused: arg2};
        0x2::event::emit<PausedChanged>(v0);
    }

    public entry fun set_time_unit(arg0: &AdminCap, arg1: &mut UserDeposits, arg2: u64) {
        assert!(arg2 >= 60 && arg2 <= 86400, 15);
        arg1.time_unit_sec = arg2;
        let v0 = TimeUnitChanged{time_unit_sec: arg2};
        0x2::event::emit<TimeUnitChanged>(v0);
    }

    fun settle_inline<T0>(arg0: &PLSAConfig, arg1: &mut PLSAVault<T0>, arg2: &mut UserDeposits, arg3: &mut RedemptionRegistry, arg4: address, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg6) / 1000;
        assert!(0x2::table::contains<address, vector<PendingRedemption>>(&arg3.redemptions, arg4), 10);
        let v1 = 0x2::table::borrow<address, vector<PendingRedemption>>(&arg3.redemptions, arg4);
        let v2 = find_redemption_index(v1, arg5);
        assert!(v2 < 0x1::vector::length<PendingRedemption>(v1), 10);
        let v3 = *0x1::vector::borrow<PendingRedemption>(v1, v2);
        assert!(v3.status == 0, 9);
        let v4 = v3.gross_amount;
        let v5 = v3.penalty;
        assert!(0x2::table::contains<address, vector<Deposit>>(&arg2.deposits, arg4), 6);
        let v6 = compute_penalty_fifo(0x2::table::borrow<address, vector<Deposit>>(&arg2.deposits, arg4), v4, v0, arg0.lockup_period_sec, arg0.early_withdraw_penalty_bps);
        let v7 = if (v5 < v6) {
            v5
        } else {
            v6
        };
        let v8 = v4 - v7;
        assert!(0x2::balance::value<T0>(&arg1.balance) >= v8, 4);
        let v9 = 0x2::table::borrow_mut<address, vector<Deposit>>(&mut arg2.deposits, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance, v8), arg7), arg4);
        let v10 = 0x1::vector::borrow_mut<PendingRedemption>(0x2::table::borrow_mut<address, vector<PendingRedemption>>(&mut arg3.redemptions, arg4), v2);
        v10.status = 1;
        v10.finalized_at = v0;
        arg3.total_pending_net = arg3.total_pending_net - v3.net_amount;
        let v11 = RedeemSettled{
            user          : arg4,
            redemption_id : arg5,
            net_paid      : v8,
            penalty_final : v7,
            entries_lost  : fifo_consume_remaining(v9, v4, v0, arg2.time_unit_sec),
            timestamp     : v0,
        };
        0x2::event::emit<RedeemSettled>(v11);
    }

    public entry fun settle_redeem<T0>(arg0: &AdminCap, arg1: &PLSAConfig, arg2: &mut PLSAVault<T0>, arg3: &mut RedemptionRegistry, arg4: &mut UserDeposits, arg5: address, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        settle_inline<T0>(arg1, arg2, arg4, arg3, arg5, arg6, arg7, arg8);
    }

    public fun status_cancelled() : u8 {
        2
    }

    public fun status_pending() : u8 {
        0
    }

    public fun status_settled() : u8 {
        1
    }

    public entry fun update_config(arg0: &AdminCap, arg1: &mut PLSAConfig, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) {
        assert!(arg5 <= 1000, 14);
        assert!(arg4 <= 31536000, 14);
        assert!(arg2 <= arg3, 14);
        arg1.deposit_min = arg2;
        arg1.deposit_cap = arg3;
        arg1.lockup_period_sec = arg4;
        arg1.early_withdraw_penalty_bps = arg5;
        arg1.liquidity_reserve = arg6;
        let v0 = ConfigUpdated{
            deposit_min                : arg2,
            deposit_cap                : arg3,
            lockup_period_sec          : arg4,
            early_withdraw_penalty_bps : arg5,
            liquidity_reserve          : arg6,
        };
        0x2::event::emit<ConfigUpdated>(v0);
    }

    public fun vault_balance<T0>(arg0: &PLSAVault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    // decompiled from Move bytecode v7
}

