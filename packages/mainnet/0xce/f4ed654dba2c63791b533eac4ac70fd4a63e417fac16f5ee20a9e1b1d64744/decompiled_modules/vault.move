module 0xcef4ed654dba2c63791b533eac4ac70fd4a63e417fac16f5ee20a9e1b1d64744::vault {
    struct Vault<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        admin: address,
        operator: address,
        fee_recipient: address,
        pending_admin: address,
        pending_admin_effective_ms: u64,
        pending_operator: address,
        pending_operator_effective_ms: u64,
        role_change_delay_ms: u64,
        deposit_fee_bps: u64,
        mgmt_fee_bps: u64,
        redeem_fee_bps: u64,
        share_price: u64,
        total_shares: u64,
        pending_deposit: 0x2::balance::Balance<T0>,
        claim_reserve: 0x2::balance::Balance<T0>,
        rcusdp_custody: 0x2::balance::Balance<T1>,
        pending_redeem_rcusdp: 0x2::balance::Balance<T1>,
        last_deposit_settle_ms: u64,
        last_redeem_settle_ms: u64,
        settle_interval_ms: u64,
        paused: bool,
        accumulated_mgmt_fee: u64,
        last_mgmt_fee_ms: u64,
        instant_redeem_fee_bps: u64,
        reserve_fund: 0x2::balance::Balance<T0>,
        instant_redeem_enabled: bool,
        withdraw_fee_bps: u64,
        cancel_deposit_fee_bps: u64,
        cancel_deposit_enabled: bool,
        withdraw_rcusdp_enabled: bool,
    }

    struct PendingDeposits<phantom T0> has key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
        amounts: 0x2::table::Table<address, u64>,
        users: vector<address>,
    }

    struct PendingRedeems<phantom T0> has key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
        amounts: 0x2::table::Table<address, u64>,
        users: vector<address>,
    }

    struct Claims<phantom T0> has key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
        amounts: 0x2::table::Table<address, u64>,
    }

    struct Balances<phantom T0> has key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
        amounts: 0x2::table::Table<address, u64>,
    }

    struct UserRecord has copy, drop, store {
        record_id: u64,
        action: u8,
        amount: u64,
        fee: u64,
        shares: u64,
        status: u8,
        created_at: u64,
        settled_at: u64,
        related_record_id: u64,
    }

    struct UserRecords has key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
        records: 0x2::table::Table<address, vector<UserRecord>>,
        next_record_id: u64,
    }

    struct DepositQueued has copy, drop {
        user: address,
        amount: u64,
        fee: u64,
    }

    struct DepositSettled has copy, drop {
        total_usdc: u64,
        minted_shares: u64,
    }

    struct RedeemQueued has copy, drop {
        user: address,
        shares: u64,
        rcusdp_estimate: u64,
    }

    struct RedeemSettled has copy, drop {
        total_rcusdp: u64,
    }

    struct RedeemFinalized has copy, drop {
        total_rcusdp: u64,
        usdc_net: u64,
        fee: u64,
    }

    struct Claimed has copy, drop {
        user: address,
        amount: u64,
    }

    struct FeesTaken has copy, drop {
        amount: u64,
        fee_type: u8,
    }

    struct SharePriceSynced has copy, drop {
        share_price: u64,
        total_shares: u64,
    }

    struct Paused has copy, drop {
        state: bool,
    }

    struct AdminChangeInitiated has copy, drop {
        current_admin: address,
        pending_admin: address,
        effective_ms: u64,
    }

    struct AdminChangeCompleted has copy, drop {
        old_admin: address,
        new_admin: address,
    }

    struct AdminChangeCancelled has copy, drop {
        cancelled_admin: address,
    }

    struct OperatorChangeInitiated has copy, drop {
        current_operator: address,
        pending_operator: address,
        effective_ms: u64,
    }

    struct OperatorChangeCompleted has copy, drop {
        old_operator: address,
        new_operator: address,
    }

    struct OperatorChangeCancelled has copy, drop {
        cancelled_operator: address,
    }

    struct RoleChangeDelayUpdated has copy, drop {
        old_delay_ms: u64,
        new_delay_ms: u64,
    }

    struct FeesUpdated has copy, drop {
        deposit_fee_bps: u64,
        mgmt_fee_bps: u64,
        redeem_fee_bps: u64,
    }

    struct MgmtFeeCharged has copy, drop {
        amount: u64,
        timestamp_ms: u64,
    }

    struct InstantRedeemed has copy, drop {
        user: address,
        shares: u64,
        usdc_gross: u64,
        usdc_net: u64,
        fee: u64,
    }

    struct ReserveFundDeposited has copy, drop {
        amount: u64,
        new_balance: u64,
    }

    struct ReserveFundWithdrawn has copy, drop {
        amount: u64,
        new_balance: u64,
    }

    struct RcusdpWithdrawn has copy, drop {
        user: address,
        shares: u64,
        rcusdp_gross: u64,
        rcusdp_net: u64,
        fee: u64,
    }

    struct DepositCancelled has copy, drop {
        user: address,
        deposit_id: u64,
        usdc_gross: u64,
        usdc_net: u64,
        fee: u64,
    }

    struct DepositRecordCreated has copy, drop {
        user: address,
        deposit_id: u64,
        amount: u64,
        fee: u64,
        timestamp_ms: u64,
    }

    struct DepositRecordSettled has copy, drop {
        user: address,
        deposit_id: u64,
        shares: u64,
        settle_time: u64,
    }

    struct PendingUsdcTaken has copy, drop {
        operator: address,
        amount: u64,
    }

    struct PendingRcusdpTaken has copy, drop {
        operator: address,
        amount: u64,
    }

    public fun accept_admin_change<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x2::clock::Clock) {
        assert!(arg0.pending_admin != @0x0, 11);
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.pending_admin_effective_ms, 12);
        let v0 = arg0.pending_admin;
        arg0.admin = v0;
        arg0.pending_admin = @0x0;
        arg0.pending_admin_effective_ms = 0;
        let v1 = AdminChangeCompleted{
            old_admin : arg0.admin,
            new_admin : v0,
        };
        0x2::event::emit<AdminChangeCompleted>(v1);
    }

    public fun accept_operator_change<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x2::clock::Clock) {
        assert!(arg0.pending_operator != @0x0, 11);
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.pending_operator_effective_ms, 12);
        let v0 = arg0.pending_operator;
        arg0.operator = v0;
        arg0.pending_operator = @0x0;
        arg0.pending_operator_effective_ms = 0;
        let v1 = OperatorChangeCompleted{
            old_operator : arg0.operator,
            new_operator : v0,
        };
        0x2::event::emit<OperatorChangeCompleted>(v1);
    }

    fun add_user_record(arg0: &mut UserRecords, arg1: address, arg2: u8, arg3: u64, arg4: u64, arg5: u64, arg6: u8, arg7: u64, arg8: u64) : u64 {
        let v0 = arg0.next_record_id;
        arg0.next_record_id = v0 + 1;
        let v1 = if (arg6 == 1) {
            arg7
        } else {
            0
        };
        let v2 = UserRecord{
            record_id         : v0,
            action            : arg2,
            amount            : arg3,
            fee               : arg4,
            shares            : arg5,
            status            : arg6,
            created_at        : arg7,
            settled_at        : v1,
            related_record_id : arg8,
        };
        if (0x2::table::contains<address, vector<UserRecord>>(&arg0.records, arg1)) {
            0x1::vector::push_back<UserRecord>(0x2::table::borrow_mut<address, vector<UserRecord>>(&mut arg0.records, arg1), v2);
        } else {
            let v3 = 0x1::vector::empty<UserRecord>();
            0x1::vector::push_back<UserRecord>(&mut v3, v2);
            0x2::table::add<address, vector<UserRecord>>(&mut arg0.records, arg1, v3);
        };
        v0
    }

    public fun cancel_admin_change<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x2::tx_context::TxContext) {
        only_admin<T0, T1>(arg0, arg1);
        assert!(arg0.pending_admin != @0x0, 11);
        arg0.pending_admin = @0x0;
        arg0.pending_admin_effective_ms = 0;
        let v0 = AdminChangeCancelled{cancelled_admin: arg0.pending_admin};
        0x2::event::emit<AdminChangeCancelled>(v0);
    }

    fun cancel_all_pending_deposits(arg0: &mut UserRecords, arg1: address) : u64 {
        if (!0x2::table::contains<address, vector<UserRecord>>(&arg0.records, arg1)) {
            return 0
        };
        let v0 = 0x2::table::borrow_mut<address, vector<UserRecord>>(&mut arg0.records, arg1);
        let v1 = 0;
        let v2 = 0;
        while (v1 < 0x1::vector::length<UserRecord>(v0)) {
            let v3 = 0x1::vector::borrow_mut<UserRecord>(v0, v1);
            if (v3.action == 0 && v3.status == 0) {
                v3.status = 2;
                v2 = v3.record_id;
            };
            v1 = v1 + 1;
        };
        v2
    }

    public fun cancel_deposit<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &mut PendingDeposits<T0>, arg2: &mut UserRecords, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        verify_pending_deposits<T0, T1>(arg0, arg1);
        verify_user_records<T0, T1>(arg0, arg2);
        assert!(arg0.cancel_deposit_enabled, 10);
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x2::table::contains<address, u64>(&arg1.amounts, v0), 9);
        let v1 = 0x2::table::remove<address, u64>(&mut arg1.amounts, v0);
        let (v2, v3) = 0x1::vector::index_of<address>(&arg1.users, &v0);
        if (v2) {
            0x1::vector::remove<address>(&mut arg1.users, v3);
        };
        let v4 = v1 * arg0.cancel_deposit_fee_bps / 10000;
        let v5 = v1 - v4;
        let v6 = 0x2::balance::split<T0>(&mut arg0.pending_deposit, v1);
        if (v4 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v6, v4), arg4), arg0.fee_recipient);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v6, arg4), v0);
        let v7 = cancel_all_pending_deposits(arg2, v0);
        add_user_record(arg2, v0, 5, v5, v4, 0, 1, 0x2::clock::timestamp_ms(arg3), v7);
        let v8 = DepositCancelled{
            user       : v0,
            deposit_id : v7,
            usdc_gross : v1,
            usdc_net   : v5,
            fee        : v4,
        };
        0x2::event::emit<DepositCancelled>(v8);
    }

    public fun cancel_deposit_by_id<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &mut PendingDeposits<T0>, arg2: &mut UserRecords, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        verify_pending_deposits<T0, T1>(arg0, arg1);
        verify_user_records<T0, T1>(arg0, arg2);
        assert!(arg0.cancel_deposit_enabled, 10);
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(0x2::table::contains<address, vector<UserRecord>>(&arg2.records, v0), 9);
        let v1 = 0x2::table::borrow_mut<address, vector<UserRecord>>(&mut arg2.records, v0);
        let v2 = false;
        let v3 = 0;
        let v4 = 0;
        while (v4 < 0x1::vector::length<UserRecord>(v1)) {
            let v5 = 0x1::vector::borrow_mut<UserRecord>(v1, v4);
            let v6 = if (v5.record_id == arg3) {
                if (v5.action == 0) {
                    v5.status == 0
                } else {
                    false
                }
            } else {
                false
            };
            if (v6) {
                v3 = v5.amount;
                v5.status = 2;
                v2 = true;
                break
            };
            v4 = v4 + 1;
        };
        assert!(v2, 9);
        assert!(0x2::table::contains<address, u64>(&arg1.amounts, v0), 9);
        let v7 = *0x2::table::borrow<address, u64>(&arg1.amounts, v0);
        if (v7 > v3) {
            *0x2::table::borrow_mut<address, u64>(&mut arg1.amounts, v0) = v7 - v3;
        } else {
            0x2::table::remove<address, u64>(&mut arg1.amounts, v0);
            let (v8, v9) = 0x1::vector::index_of<address>(&arg1.users, &v0);
            if (v8) {
                0x1::vector::remove<address>(&mut arg1.users, v9);
            };
        };
        let v10 = v3 * arg0.cancel_deposit_fee_bps / 10000;
        let v11 = v3 - v10;
        let v12 = 0x2::balance::split<T0>(&mut arg0.pending_deposit, v3);
        if (v10 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v12, v10), arg5), arg0.fee_recipient);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v12, arg5), v0);
        add_user_record(arg2, v0, 5, v11, v10, 0, 1, 0x2::clock::timestamp_ms(arg4), arg3);
        let v13 = DepositCancelled{
            user       : v0,
            deposit_id : arg3,
            usdc_gross : v3,
            usdc_net   : v11,
            fee        : v10,
        };
        0x2::event::emit<DepositCancelled>(v13);
    }

    public fun cancel_operator_change<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x2::tx_context::TxContext) {
        only_admin<T0, T1>(arg0, arg1);
        assert!(arg0.pending_operator != @0x0, 11);
        arg0.pending_operator = @0x0;
        arg0.pending_operator_effective_ms = 0;
        let v0 = OperatorChangeCancelled{cancelled_operator: arg0.pending_operator};
        0x2::event::emit<OperatorChangeCancelled>(v0);
    }

    public fun charge_mgmt_fee<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        only_operator<T0, T1>(arg0, arg2);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        if (arg0.last_mgmt_fee_ms == 0) {
            arg0.last_mgmt_fee_ms = v0;
            return
        };
        let v1 = v0 - arg0.last_mgmt_fee_ms;
        if (v1 == 0 || arg0.mgmt_fee_bps == 0) {
            return
        };
        let v2 = 0x2::balance::value<T1>(&arg0.rcusdp_custody);
        let v3 = (((v2 as u128) * (arg0.mgmt_fee_bps as u128) * (v1 as u128) / (10000 as u128) * 365 * (86400000 as u128)) as u64);
        if (v3 > 0 && v3 <= v2) {
            arg0.accumulated_mgmt_fee = arg0.accumulated_mgmt_fee + v3;
            if (v3 <= arg0.total_shares) {
                arg0.total_shares = arg0.total_shares - v3;
            };
            let v4 = MgmtFeeCharged{
                amount       : v3,
                timestamp_ms : v0,
            };
            0x2::event::emit<MgmtFeeCharged>(v4);
        };
        arg0.last_mgmt_fee_ms = v0;
    }

    public fun claim<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &mut Claims<T0>, arg2: &mut UserRecords, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        verify_claims<T0, T1>(arg0, arg1);
        verify_user_records<T0, T1>(arg0, arg2);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = if (0x2::table::contains<address, u64>(&arg1.amounts, v0)) {
            *0x2::table::borrow<address, u64>(&arg1.amounts, v0)
        } else {
            0
        };
        assert!(v1 >= arg3, 4);
        if (v1 > arg3) {
            *0x2::table::borrow_mut<address, u64>(&mut arg1.amounts, v0) = v1 - arg3;
        } else {
            0x2::table::remove<address, u64>(&mut arg1.amounts, v0);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.claim_reserve, arg3), arg5), v0);
        add_user_record(arg2, v0, 2, arg3, 0, 0, 1, 0x2::clock::timestamp_ms(arg4), 0);
        let v2 = Claimed{
            user   : v0,
            amount : arg3,
        };
        0x2::event::emit<Claimed>(v2);
    }

    fun complete_pending_redeem_records(arg0: &mut UserRecords, arg1: address, arg2: u64) {
        if (!0x2::table::contains<address, vector<UserRecord>>(&arg0.records, arg1)) {
            return
        };
        let v0 = 0x2::table::borrow_mut<address, vector<UserRecord>>(&mut arg0.records, arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<UserRecord>(v0)) {
            let v2 = 0x1::vector::borrow_mut<UserRecord>(v0, v1);
            if (v2.action == 1 && v2.status == 0) {
                v2.status = 1;
                v2.settled_at = arg2;
            };
            v1 = v1 + 1;
        };
    }

    public fun create<T0, T1>(arg0: address, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg2);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = Vault<T0, T1>{
            id                            : v0,
            admin                         : arg0,
            operator                      : arg0,
            fee_recipient                 : arg1,
            pending_admin                 : @0x0,
            pending_admin_effective_ms    : 0,
            pending_operator              : @0x0,
            pending_operator_effective_ms : 0,
            role_change_delay_ms          : 86400000,
            deposit_fee_bps               : 0,
            mgmt_fee_bps                  : 0,
            redeem_fee_bps                : 0,
            share_price                   : 1000000000000000000,
            total_shares                  : 0,
            pending_deposit               : 0x2::balance::zero<T0>(),
            claim_reserve                 : 0x2::balance::zero<T0>(),
            rcusdp_custody                : 0x2::balance::zero<T1>(),
            pending_redeem_rcusdp         : 0x2::balance::zero<T1>(),
            last_deposit_settle_ms        : 0,
            last_redeem_settle_ms         : 0,
            settle_interval_ms            : 0,
            paused                        : false,
            accumulated_mgmt_fee          : 0,
            last_mgmt_fee_ms              : 0,
            instant_redeem_fee_bps        : 700,
            reserve_fund                  : 0x2::balance::zero<T0>(),
            instant_redeem_enabled        : false,
            withdraw_fee_bps              : 0,
            cancel_deposit_fee_bps        : 0,
            cancel_deposit_enabled        : true,
            withdraw_rcusdp_enabled       : false,
        };
        0x2::transfer::share_object<Vault<T0, T1>>(v2);
        let v3 = PendingDeposits<T0>{
            id       : 0x2::object::new(arg2),
            vault_id : v1,
            amounts  : 0x2::table::new<address, u64>(arg2),
            users    : 0x1::vector::empty<address>(),
        };
        0x2::transfer::share_object<PendingDeposits<T0>>(v3);
        let v4 = PendingRedeems<T1>{
            id       : 0x2::object::new(arg2),
            vault_id : v1,
            amounts  : 0x2::table::new<address, u64>(arg2),
            users    : 0x1::vector::empty<address>(),
        };
        0x2::transfer::share_object<PendingRedeems<T1>>(v4);
        let v5 = Claims<T0>{
            id       : 0x2::object::new(arg2),
            vault_id : v1,
            amounts  : 0x2::table::new<address, u64>(arg2),
        };
        0x2::transfer::share_object<Claims<T0>>(v5);
        let v6 = Balances<T1>{
            id       : 0x2::object::new(arg2),
            vault_id : v1,
            amounts  : 0x2::table::new<address, u64>(arg2),
        };
        0x2::transfer::share_object<Balances<T1>>(v6);
        let v7 = UserRecords{
            id             : 0x2::object::new(arg2),
            vault_id       : v1,
            records        : 0x2::table::new<address, vector<UserRecord>>(arg2),
            next_record_id : 1,
        };
        0x2::transfer::share_object<UserRecords>(v7);
    }

    public fun deposit<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &mut PendingDeposits<T0>, arg2: &mut UserRecords, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        verify_pending_deposits<T0, T1>(arg0, arg1);
        verify_user_records<T0, T1>(arg0, arg2);
        assert!(!arg0.paused, 0);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::coin::value<T0>(&arg3);
        let v2 = 0x2::clock::timestamp_ms(arg4);
        let v3 = v1 * arg0.deposit_fee_bps / 10000;
        let v4 = v1 - v3;
        if (v3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg3, v3, arg5), arg0.fee_recipient);
            let v5 = FeesTaken{
                amount   : v3,
                fee_type : 0,
            };
            0x2::event::emit<FeesTaken>(v5);
        };
        0x2::balance::join<T0>(&mut arg0.pending_deposit, 0x2::coin::into_balance<T0>(arg3));
        let v6 = &mut arg1.amounts;
        let v7 = &mut arg1.users;
        upsert_add(v6, v7, v0, v4);
        let v8 = DepositRecordCreated{
            user         : v0,
            deposit_id   : add_user_record(arg2, v0, 0, v4, v3, 0, 0, v2, 0),
            amount       : v4,
            fee          : v3,
            timestamp_ms : v2,
        };
        0x2::event::emit<DepositRecordCreated>(v8);
        let v9 = DepositQueued{
            user   : v0,
            amount : v4,
            fee    : v3,
        };
        0x2::event::emit<DepositQueued>(v9);
    }

    public fun deposit_reserve<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::tx_context::TxContext) {
        only_admin<T0, T1>(arg0, arg2);
        0x2::balance::join<T0>(&mut arg0.reserve_fund, 0x2::coin::into_balance<T0>(arg1));
        let v0 = ReserveFundDeposited{
            amount      : 0x2::coin::value<T0>(&arg1),
            new_balance : 0x2::balance::value<T0>(&arg0.reserve_fund),
        };
        0x2::event::emit<ReserveFundDeposited>(v0);
    }

    public fun finalize_redeems<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &mut PendingRedeems<T1>, arg2: &mut UserRecords, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        verify_pending_redeems<T0, T1>(arg0, arg1);
        verify_user_records<T0, T1>(arg0, arg2);
        only_operator<T0, T1>(arg0, arg5);
        let v0 = 0x2::coin::value<T0>(&arg3);
        let v1 = v0 * arg0.redeem_fee_bps / 10000;
        let v2 = v0 - v1;
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg3, v1, arg5), arg0.fee_recipient);
            let v3 = FeesTaken{
                amount   : v1,
                fee_type : 1,
            };
            0x2::event::emit<FeesTaken>(v3);
        };
        let v4 = sum_pending_values(&arg1.amounts, &arg1.users);
        let v5 = 0x2::clock::timestamp_ms(arg4);
        let v6 = 0x2::coin::into_balance<T0>(arg3);
        while (!0x1::vector::is_empty<address>(&arg1.users)) {
            let v7 = 0x1::vector::pop_back<address>(&mut arg1.users);
            let v8 = if (v4 == 0) {
                0
            } else {
                (((v2 as u128) * (0x2::table::remove<address, u64>(&mut arg1.amounts, v7) as u128) / (v4 as u128)) as u64)
            };
            complete_pending_redeem_records(arg2, v7, v5);
            if (v8 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v6, v8), arg5), v7);
                add_user_record(arg2, v7, 2, v8, 0, 0, 1, v5, 0);
                let v9 = Claimed{
                    user   : v7,
                    amount : v8,
                };
                0x2::event::emit<Claimed>(v9);
            };
        };
        if (0x2::balance::value<T0>(&v6) > 0) {
            0x2::balance::join<T0>(&mut arg0.claim_reserve, v6);
        } else {
            0x2::balance::destroy_zero<T0>(v6);
        };
        let v10 = RedeemFinalized{
            total_rcusdp : v4,
            usdc_net     : v2,
            fee          : v1,
        };
        0x2::event::emit<RedeemFinalized>(v10);
    }

    public fun get_all_user_records(arg0: &UserRecords, arg1: address) : vector<UserRecord> {
        if (0x2::table::contains<address, vector<UserRecord>>(&arg0.records, arg1)) {
            *0x2::table::borrow<address, vector<UserRecord>>(&arg0.records, arg1)
        } else {
            0x1::vector::empty<UserRecord>()
        }
    }

    public fun get_cancel_deposit_config<T0, T1>(arg0: &Vault<T0, T1>) : (u64, bool) {
        (arg0.cancel_deposit_fee_bps, arg0.cancel_deposit_enabled)
    }

    public fun get_fees<T0, T1>(arg0: &Vault<T0, T1>) : (u64, u64, u64) {
        (arg0.deposit_fee_bps, arg0.mgmt_fee_bps, arg0.redeem_fee_bps)
    }

    public fun get_instant_redeem_config<T0, T1>(arg0: &Vault<T0, T1>) : (u64, u64, bool) {
        (arg0.instant_redeem_fee_bps, 0x2::balance::value<T0>(&arg0.reserve_fund), arg0.instant_redeem_enabled)
    }

    public fun get_pending_deposit_records(arg0: &UserRecords, arg1: address) : vector<UserRecord> {
        let v0 = 0x1::vector::empty<UserRecord>();
        if (0x2::table::contains<address, vector<UserRecord>>(&arg0.records, arg1)) {
            let v1 = 0x2::table::borrow<address, vector<UserRecord>>(&arg0.records, arg1);
            let v2 = 0;
            while (v2 < 0x1::vector::length<UserRecord>(v1)) {
                let v3 = 0x1::vector::borrow<UserRecord>(v1, v2);
                if (v3.action == 0 && v3.status == 0) {
                    0x1::vector::push_back<UserRecord>(&mut v0, *v3);
                };
                v2 = v2 + 1;
            };
        };
        v0
    }

    public fun get_pending_role_changes<T0, T1>(arg0: &Vault<T0, T1>) : (address, u64, address, u64, u64) {
        (arg0.pending_admin, arg0.pending_admin_effective_ms, arg0.pending_operator, arg0.pending_operator_effective_ms, arg0.role_change_delay_ms)
    }

    public fun get_record_by_id(arg0: &UserRecords, arg1: address, arg2: u64) : vector<UserRecord> {
        let v0 = 0x1::vector::empty<UserRecord>();
        if (0x2::table::contains<address, vector<UserRecord>>(&arg0.records, arg1)) {
            let v1 = 0x2::table::borrow<address, vector<UserRecord>>(&arg0.records, arg1);
            let v2 = 0;
            while (v2 < 0x1::vector::length<UserRecord>(v1)) {
                let v3 = 0x1::vector::borrow<UserRecord>(v1, v2);
                if (v3.record_id == arg2) {
                    0x1::vector::push_back<UserRecord>(&mut v0, *v3);
                    break
                };
                v2 = v2 + 1;
            };
        };
        v0
    }

    public fun get_tvl<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.rcusdp_custody)
    }

    public fun get_user_balance<T0>(arg0: &Balances<T0>, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.amounts, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.amounts, arg1)
        } else {
            0
        }
    }

    public fun get_user_claimable<T0>(arg0: &Claims<T0>, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.amounts, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.amounts, arg1)
        } else {
            0
        }
    }

    public fun get_user_pending_deposit<T0>(arg0: &PendingDeposits<T0>, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.amounts, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.amounts, arg1)
        } else {
            0
        }
    }

    public fun get_user_pending_redeem<T0>(arg0: &PendingRedeems<T0>, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.amounts, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.amounts, arg1)
        } else {
            0
        }
    }

    public fun get_user_records_by_action(arg0: &UserRecords, arg1: address, arg2: u8) : vector<UserRecord> {
        let v0 = 0x1::vector::empty<UserRecord>();
        if (0x2::table::contains<address, vector<UserRecord>>(&arg0.records, arg1)) {
            let v1 = 0x2::table::borrow<address, vector<UserRecord>>(&arg0.records, arg1);
            let v2 = 0;
            while (v2 < 0x1::vector::length<UserRecord>(v1)) {
                let v3 = 0x1::vector::borrow<UserRecord>(v1, v2);
                if (v3.action == arg2) {
                    0x1::vector::push_back<UserRecord>(&mut v0, *v3);
                };
                v2 = v2 + 1;
            };
        };
        v0
    }

    public fun get_user_records_by_status(arg0: &UserRecords, arg1: address, arg2: u8) : vector<UserRecord> {
        let v0 = 0x1::vector::empty<UserRecord>();
        if (0x2::table::contains<address, vector<UserRecord>>(&arg0.records, arg1)) {
            let v1 = 0x2::table::borrow<address, vector<UserRecord>>(&arg0.records, arg1);
            let v2 = 0;
            while (v2 < 0x1::vector::length<UserRecord>(v1)) {
                let v3 = 0x1::vector::borrow<UserRecord>(v1, v2);
                if (v3.status == arg2) {
                    0x1::vector::push_back<UserRecord>(&mut v0, *v3);
                };
                v2 = v2 + 1;
            };
        };
        v0
    }

    public fun get_user_records_summary(arg0: &UserRecords, arg1: address) : (u64, u64, u64, u64, u64, u64) {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0;
        let v3 = 0;
        let v4 = 0;
        let v5 = 0;
        if (0x2::table::contains<address, vector<UserRecord>>(&arg0.records, arg1)) {
            let v6 = 0x2::table::borrow<address, vector<UserRecord>>(&arg0.records, arg1);
            let v7 = 0;
            while (v7 < 0x1::vector::length<UserRecord>(v6)) {
                let v8 = 0x1::vector::borrow<UserRecord>(v6, v7);
                v0 = v0 + 1;
                v4 = v4 + v8.amount;
                v5 = v5 + v8.shares;
                if (v8.status == 0) {
                    v1 = v1 + 1;
                } else if (v8.status == 1) {
                    v2 = v2 + 1;
                } else if (v8.status == 2) {
                    v3 = v3 + 1;
                };
                v7 = v7 + 1;
            };
        };
        (v0, v1, v2, v3, v4, v5)
    }

    public fun get_vault_info<T0, T1>(arg0: &Vault<T0, T1>) : (u64, u64, u64, u64, u64, bool) {
        (arg0.share_price, arg0.total_shares, 0x2::balance::value<T0>(&arg0.pending_deposit), 0x2::balance::value<T1>(&arg0.rcusdp_custody), 0x2::balance::value<T0>(&arg0.claim_reserve), arg0.paused)
    }

    public fun get_vault_metrics<T0, T1>(arg0: &Vault<T0, T1>) : (u64, u64, u64, u64, u64) {
        (0x2::balance::value<T1>(&arg0.rcusdp_custody), 0x2::balance::value<T0>(&arg0.pending_deposit), 0x2::balance::value<T1>(&arg0.pending_redeem_rcusdp), 0x2::balance::value<T0>(&arg0.claim_reserve), 0x2::balance::value<T0>(&arg0.reserve_fund))
    }

    public fun get_withdraw_rcusdp_config<T0, T1>(arg0: &Vault<T0, T1>) : (u64, bool) {
        (arg0.withdraw_fee_bps, arg0.withdraw_rcusdp_enabled)
    }

    public fun get_withdrawal_fees<T0, T1>(arg0: &Vault<T0, T1>) : (u64, u64) {
        (arg0.withdraw_fee_bps, arg0.cancel_deposit_fee_bps)
    }

    public fun initiate_admin_change<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: address, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        only_admin<T0, T1>(arg0, arg3);
        let v0 = 0x2::clock::timestamp_ms(arg2) + arg0.role_change_delay_ms;
        arg0.pending_admin = arg1;
        arg0.pending_admin_effective_ms = v0;
        let v1 = AdminChangeInitiated{
            current_admin : arg0.admin,
            pending_admin : arg1,
            effective_ms  : v0,
        };
        0x2::event::emit<AdminChangeInitiated>(v1);
    }

    public fun initiate_operator_change<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: address, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        only_admin<T0, T1>(arg0, arg3);
        let v0 = 0x2::clock::timestamp_ms(arg2) + arg0.role_change_delay_ms;
        arg0.pending_operator = arg1;
        arg0.pending_operator_effective_ms = v0;
        let v1 = OperatorChangeInitiated{
            current_operator : arg0.operator,
            pending_operator : arg1,
            effective_ms     : v0,
        };
        0x2::event::emit<OperatorChangeInitiated>(v1);
    }

    public fun instant_redeem<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &mut Balances<T1>, arg2: &mut UserRecords, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        verify_balances<T0, T1>(arg0, arg1);
        verify_user_records<T0, T1>(arg0, arg2);
        assert!(!arg0.paused, 0);
        assert!(arg0.instant_redeem_enabled, 7);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = arg0.share_price;
        let v2 = if (0x2::table::contains<address, u64>(&arg1.amounts, v0)) {
            *0x2::table::borrow<address, u64>(&arg1.amounts, v0)
        } else {
            0
        };
        assert!(v2 >= arg3, 2);
        let v3 = if (v1 == 0) {
            arg3
        } else {
            (((arg3 as u128) * (v1 as u128) / (1000000000000000000 as u128)) as u64)
        };
        assert!(0x2::balance::value<T0>(&arg0.reserve_fund) >= v3, 8);
        if (v2 > arg3) {
            *0x2::table::borrow_mut<address, u64>(&mut arg1.amounts, v0) = v2 - arg3;
        } else {
            0x2::table::remove<address, u64>(&mut arg1.amounts, v0);
        };
        let v4 = v3 * arg0.instant_redeem_fee_bps / 10000;
        let v5 = v3 - v4;
        let v6 = 0x2::balance::split<T0>(&mut arg0.reserve_fund, v3);
        0x2::balance::join<T1>(&mut arg0.pending_redeem_rcusdp, 0x2::balance::split<T1>(&mut arg0.rcusdp_custody, arg3));
        if (v4 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v6, v4), arg5), arg0.fee_recipient);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v6, arg5), v0);
        arg0.total_shares = arg0.total_shares - arg3;
        add_user_record(arg2, v0, 3, v5, v4, arg3, 1, 0x2::clock::timestamp_ms(arg4), 0);
        let v7 = InstantRedeemed{
            user       : v0,
            shares     : arg3,
            usdc_gross : v3,
            usdc_net   : v5,
            fee        : v4,
        };
        0x2::event::emit<InstantRedeemed>(v7);
    }

    fun only_admin<T0, T1>(arg0: &Vault<T0, T1>, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg1), 5);
    }

    fun only_operator<T0, T1>(arg0: &Vault<T0, T1>, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.operator == 0x2::tx_context::sender(arg1), 6);
    }

    public fun queue_redeem<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &mut PendingRedeems<T1>, arg2: &mut Balances<T1>, arg3: &mut UserRecords, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        verify_pending_redeems<T0, T1>(arg0, arg1);
        verify_balances<T0, T1>(arg0, arg2);
        verify_user_records<T0, T1>(arg0, arg3);
        assert!(!arg0.paused, 0);
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = if (0x2::table::contains<address, u64>(&arg2.amounts, v0)) {
            *0x2::table::borrow<address, u64>(&arg2.amounts, v0)
        } else {
            0
        };
        assert!(v1 >= arg4, 2);
        if (v1 > arg4) {
            *0x2::table::borrow_mut<address, u64>(&mut arg2.amounts, v0) = v1 - arg4;
        } else {
            0x2::table::remove<address, u64>(&mut arg2.amounts, v0);
        };
        0x2::balance::join<T1>(&mut arg0.pending_redeem_rcusdp, 0x2::balance::split<T1>(&mut arg0.rcusdp_custody, arg4));
        let v2 = &mut arg1.amounts;
        let v3 = &mut arg1.users;
        upsert_add(v2, v3, v0, arg4);
        arg0.total_shares = arg0.total_shares - arg4;
        add_user_record(arg3, v0, 1, arg4, 0, arg4, 0, 0x2::clock::timestamp_ms(arg5), 0);
        let v4 = RedeemQueued{
            user            : v0,
            shares          : arg4,
            rcusdp_estimate : arg4,
        };
        0x2::event::emit<RedeemQueued>(v4);
    }

    public fun set_cancel_deposit_enabled<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        only_admin<T0, T1>(arg0, arg2);
        arg0.cancel_deposit_enabled = arg1;
    }

    public fun set_cancel_deposit_fee<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        only_admin<T0, T1>(arg0, arg2);
        arg0.cancel_deposit_fee_bps = arg1;
    }

    public fun set_fee_recipient<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        only_admin<T0, T1>(arg0, arg2);
        arg0.fee_recipient = arg1;
    }

    public fun set_fees<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: u64, arg2: u64, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        only_admin<T0, T1>(arg0, arg4);
        arg0.deposit_fee_bps = arg1;
        arg0.mgmt_fee_bps = arg2;
        arg0.redeem_fee_bps = arg3;
        let v0 = FeesUpdated{
            deposit_fee_bps : arg1,
            mgmt_fee_bps    : arg2,
            redeem_fee_bps  : arg3,
        };
        0x2::event::emit<FeesUpdated>(v0);
    }

    public fun set_instant_redeem_enabled<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        only_admin<T0, T1>(arg0, arg2);
        arg0.instant_redeem_enabled = arg1;
    }

    public fun set_instant_redeem_fee<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        only_admin<T0, T1>(arg0, arg2);
        arg0.instant_redeem_fee_bps = arg1;
    }

    public fun set_operator<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        only_admin<T0, T1>(arg0, arg2);
        arg0.operator = arg1;
        arg0.pending_operator = @0x0;
        arg0.pending_operator_effective_ms = 0;
        let v0 = OperatorChangeCompleted{
            old_operator : arg0.operator,
            new_operator : arg1,
        };
        0x2::event::emit<OperatorChangeCompleted>(v0);
    }

    public fun set_pause<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        only_admin<T0, T1>(arg0, arg2);
        arg0.paused = arg1;
        let v0 = Paused{state: arg1};
        0x2::event::emit<Paused>(v0);
    }

    public fun set_role_change_delay<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        only_admin<T0, T1>(arg0, arg2);
        assert!(arg1 >= 3600000, 13);
        arg0.role_change_delay_ms = arg1;
        let v0 = RoleChangeDelayUpdated{
            old_delay_ms : arg0.role_change_delay_ms,
            new_delay_ms : arg1,
        };
        0x2::event::emit<RoleChangeDelayUpdated>(v0);
    }

    public fun set_settle_interval<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        only_admin<T0, T1>(arg0, arg2);
        arg0.settle_interval_ms = arg1;
    }

    public fun set_withdraw_fee<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        only_admin<T0, T1>(arg0, arg2);
        arg0.withdraw_fee_bps = arg1;
    }

    public fun set_withdraw_rcusdp_enabled<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        only_admin<T0, T1>(arg0, arg2);
        arg0.withdraw_rcusdp_enabled = arg1;
    }

    public fun settle_deposits<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &mut PendingDeposits<T0>, arg2: &mut UserRecords, arg3: &mut Balances<T1>, arg4: 0x2::coin::Coin<T1>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        verify_pending_deposits<T0, T1>(arg0, arg1);
        verify_user_records<T0, T1>(arg0, arg2);
        verify_balances<T0, T1>(arg0, arg3);
        assert!(!arg0.paused, 0);
        only_operator<T0, T1>(arg0, arg6);
        let v0 = 0x2::clock::timestamp_ms(arg5);
        assert!(v0 >= arg0.last_deposit_settle_ms + arg0.settle_interval_ms, 1);
        0x2::balance::join<T1>(&mut arg0.rcusdp_custody, 0x2::coin::into_balance<T1>(arg4));
        let v1 = 0;
        let v2 = 0;
        let v3 = sum_pending_values(&arg1.amounts, &arg1.users);
        while (!0x1::vector::is_empty<address>(&arg1.users)) {
            let v4 = 0x1::vector::pop_back<address>(&mut arg1.users);
            let v5 = 0x2::table::remove<address, u64>(&mut arg1.amounts, v4);
            v2 = v2 + v5;
            let v6 = if (v3 == 0) {
                0
            } else {
                (((0x2::coin::value<T1>(&arg4) as u128) * (v5 as u128) / (v3 as u128)) as u64)
            };
            v1 = v1 + v6;
            if (0x2::table::contains<address, u64>(&arg3.amounts, v4)) {
                let v7 = 0x2::table::borrow_mut<address, u64>(&mut arg3.amounts, v4);
                *v7 = *v7 + v6;
            } else {
                0x2::table::add<address, u64>(&mut arg3.amounts, v4, v6);
            };
            settle_user_deposit_records(arg2, v4, v5, v6, v0);
        };
        let v8 = arg0.total_shares + v1;
        arg0.total_shares = v8;
        let v9 = if (v8 == 0) {
            1000000000000000000
        } else {
            (((0x2::balance::value<T1>(&arg0.rcusdp_custody) as u128) * (1000000000000000000 as u128) / (v8 as u128)) as u64)
        };
        arg0.share_price = v9;
        arg0.last_deposit_settle_ms = v0;
        let v10 = DepositSettled{
            total_usdc    : v2,
            minted_shares : v1,
        };
        0x2::event::emit<DepositSettled>(v10);
        let v11 = SharePriceSynced{
            share_price  : arg0.share_price,
            total_shares : arg0.total_shares,
        };
        0x2::event::emit<SharePriceSynced>(v11);
    }

    public fun settle_redeems<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 0);
        only_operator<T0, T1>(arg0, arg2);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(v0 >= arg0.last_redeem_settle_ms + arg0.settle_interval_ms, 1);
        let v1 = 0x2::balance::value<T1>(&arg0.pending_redeem_rcusdp);
        assert!(v1 > 0, 3);
        arg0.last_redeem_settle_ms = v0;
        let v2 = RedeemSettled{total_rcusdp: v1};
        0x2::event::emit<RedeemSettled>(v2);
    }

    fun settle_user_deposit_records(arg0: &mut UserRecords, arg1: address, arg2: u64, arg3: u64, arg4: u64) {
        if (!0x2::table::contains<address, vector<UserRecord>>(&arg0.records, arg1)) {
            return
        };
        let v0 = 0x2::table::borrow_mut<address, vector<UserRecord>>(&mut arg0.records, arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<UserRecord>(v0) && arg2 > 0) {
            let v2 = 0x1::vector::borrow_mut<UserRecord>(v0, v1);
            if (v2.action == 0 && v2.status == 0) {
                if (v2.amount <= arg2) {
                    let v3 = if (arg2 == 0) {
                        0
                    } else {
                        (((v2.amount as u128) * (arg3 as u128) / (arg2 as u128)) as u64)
                    };
                    v2.shares = v3;
                    v2.status = 1;
                    v2.settled_at = arg4;
                    arg2 = arg2 - v2.amount;
                    let v4 = DepositRecordSettled{
                        user        : arg1,
                        deposit_id  : v2.record_id,
                        shares      : v3,
                        settle_time : arg4,
                    };
                    0x2::event::emit<DepositRecordSettled>(v4);
                };
            };
            v1 = v1 + 1;
        };
    }

    fun sum_pending_values(arg0: &0x2::table::Table<address, u64>, arg1: &vector<address>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(arg1)) {
            v0 = v0 + *0x2::table::borrow<address, u64>(arg0, *0x1::vector::borrow<address>(arg1, v1));
            v1 = v1 + 1;
        };
        v0
    }

    public fun sync_price<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x2::tx_context::TxContext) {
        only_operator<T0, T1>(arg0, arg1);
        let v0 = if (arg0.total_shares == 0) {
            1000000000000000000
        } else {
            (((0x2::balance::value<T1>(&arg0.rcusdp_custody) as u128) * (1000000000000000000 as u128) / (arg0.total_shares as u128)) as u64)
        };
        arg0.share_price = v0;
        let v1 = SharePriceSynced{
            share_price  : arg0.share_price,
            total_shares : arg0.total_shares,
        };
        0x2::event::emit<SharePriceSynced>(v1);
    }

    public fun take_pending_rcusdp<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        only_operator<T0, T1>(arg0, arg1);
        let v0 = PendingRcusdpTaken{
            operator : 0x2::tx_context::sender(arg1),
            amount   : 0x2::balance::value<T1>(&arg0.pending_redeem_rcusdp),
        };
        0x2::event::emit<PendingRcusdpTaken>(v0);
        0x2::coin::from_balance<T1>(0x2::balance::withdraw_all<T1>(&mut arg0.pending_redeem_rcusdp), arg1)
    }

    public fun take_pending_usdc<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        only_operator<T0, T1>(arg0, arg1);
        let v0 = PendingUsdcTaken{
            operator : 0x2::tx_context::sender(arg1),
            amount   : 0x2::balance::value<T0>(&arg0.pending_deposit),
        };
        0x2::event::emit<PendingUsdcTaken>(v0);
        0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.pending_deposit), arg1)
    }

    fun upsert_add(arg0: &mut 0x2::table::Table<address, u64>, arg1: &mut vector<address>, arg2: address, arg3: u64) {
        if (0x2::table::contains<address, u64>(arg0, arg2)) {
            let v0 = 0x2::table::borrow_mut<address, u64>(arg0, arg2);
            *v0 = *v0 + arg3;
        } else {
            0x2::table::add<address, u64>(arg0, arg2, arg3);
            0x1::vector::push_back<address>(arg1, arg2);
        };
    }

    fun verify_balances<T0, T1>(arg0: &Vault<T0, T1>, arg1: &Balances<T1>) {
        assert!(arg1.vault_id == 0x2::object::id<Vault<T0, T1>>(arg0), 14);
    }

    fun verify_claims<T0, T1>(arg0: &Vault<T0, T1>, arg1: &Claims<T0>) {
        assert!(arg1.vault_id == 0x2::object::id<Vault<T0, T1>>(arg0), 14);
    }

    fun verify_pending_deposits<T0, T1>(arg0: &Vault<T0, T1>, arg1: &PendingDeposits<T0>) {
        assert!(arg1.vault_id == 0x2::object::id<Vault<T0, T1>>(arg0), 14);
    }

    fun verify_pending_redeems<T0, T1>(arg0: &Vault<T0, T1>, arg1: &PendingRedeems<T1>) {
        assert!(arg1.vault_id == 0x2::object::id<Vault<T0, T1>>(arg0), 14);
    }

    fun verify_user_records<T0, T1>(arg0: &Vault<T0, T1>, arg1: &UserRecords) {
        assert!(arg1.vault_id == 0x2::object::id<Vault<T0, T1>>(arg0), 14);
    }

    public fun withdraw_rcusdp<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &mut Balances<T1>, arg2: &mut UserRecords, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        verify_balances<T0, T1>(arg0, arg1);
        verify_user_records<T0, T1>(arg0, arg2);
        assert!(!arg0.paused, 0);
        assert!(arg0.withdraw_rcusdp_enabled, 15);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = if (0x2::table::contains<address, u64>(&arg1.amounts, v0)) {
            *0x2::table::borrow<address, u64>(&arg1.amounts, v0)
        } else {
            0
        };
        assert!(v1 >= arg3, 2);
        if (v1 > arg3) {
            *0x2::table::borrow_mut<address, u64>(&mut arg1.amounts, v0) = v1 - arg3;
        } else {
            0x2::table::remove<address, u64>(&mut arg1.amounts, v0);
        };
        let v2 = arg3 * arg0.withdraw_fee_bps / 10000;
        let v3 = arg3 - v2;
        let v4 = 0x2::balance::split<T1>(&mut arg0.rcusdp_custody, arg3);
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v4, v2), arg5), arg0.fee_recipient);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v4, arg5), v0);
        arg0.total_shares = arg0.total_shares - arg3;
        add_user_record(arg2, v0, 4, v3, v2, arg3, 1, 0x2::clock::timestamp_ms(arg4), 0);
        let v5 = RcusdpWithdrawn{
            user         : v0,
            shares       : arg3,
            rcusdp_gross : arg3,
            rcusdp_net   : v3,
            fee          : v2,
        };
        0x2::event::emit<RcusdpWithdrawn>(v5);
    }

    public fun withdraw_reserve<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        only_admin<T0, T1>(arg0, arg2);
        assert!(0x2::balance::value<T0>(&arg0.reserve_fund) >= arg1, 8);
        let v0 = ReserveFundWithdrawn{
            amount      : arg1,
            new_balance : 0x2::balance::value<T0>(&arg0.reserve_fund),
        };
        0x2::event::emit<ReserveFundWithdrawn>(v0);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.reserve_fund, arg1), arg2)
    }

    // decompiled from Move bytecode v6
}

