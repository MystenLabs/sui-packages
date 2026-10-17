module 0x33152abfb7925562297021fc1fadb08a9bdcf7376af0fec65769fb0a61d18f65::navi_vault {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct KeeperCap has store, key {
        id: 0x2::object::UID,
        vault: 0x2::object::ID,
    }

    struct GuardianCap has store, key {
        id: 0x2::object::UID,
        vault: 0x2::object::ID,
    }

    struct Params has copy, drop, store {
        tvl_cap: u64,
        entry_fee_bps: u64,
        exit_fee_bps: u64,
        perf_fee_bps: u64,
        max_ltv_bps: u64,
        borrow_fee_bps: u64,
        op_dust: u64,
        max_daily_loss_bps: u64,
    }

    struct NaviVault<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        version: u64,
        shares: 0x2::coin::TreasuryCap<T1>,
        dead_shares: 0x2::balance::Balance<T1>,
        cap: 0x1::option::Option<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>,
        cap_id: 0x2::object::ID,
        owner: address,
        asset: u8,
        decimals: u8,
        pending: 0x2::balance::Balance<T0>,
        buffer: 0x2::balance::Balance<T0>,
        claim_pool: 0x2::balance::Balance<T0>,
        queued_total: u64,
        funded_total: u64,
        hwm_price: u128,
        fee_recipient: address,
        params: Params,
        derisk: bool,
        paused: bool,
        op_open: bool,
        loss_window_start_ms: u64,
        loss_window_spent: u64,
    }

    struct OpReceipt {
        vault: 0x2::object::ID,
        nav_before: u64,
        collateral_before: u64,
        debt_before: u64,
    }

    struct WithdrawTicket has store, key {
        id: 0x2::object::UID,
        vault: 0x2::object::ID,
        amount: u64,
        cum_end: u64,
    }

    struct VaultCreated has copy, drop {
        vault: 0x2::object::ID,
        owner: address,
        asset: u8,
    }

    struct Deposited has copy, drop {
        vault: 0x2::object::ID,
        user: address,
        amount: u64,
        shares: u64,
        nav: u64,
    }

    struct Withdrawn has copy, drop {
        vault: 0x2::object::ID,
        user: address,
        shares: u64,
        amount: u64,
        nav: u64,
    }

    struct WithdrawQueued has copy, drop {
        vault: 0x2::object::ID,
        user: address,
        shares: u64,
        amount: u64,
        cum_end: u64,
    }

    struct TicketClaimed has copy, drop {
        vault: 0x2::object::ID,
        amount: u64,
        cum_end: u64,
    }

    struct QueueFunded has copy, drop {
        vault: 0x2::object::ID,
        amount: u64,
        funded_total: u64,
    }

    struct OpCompleted has copy, drop {
        vault: 0x2::object::ID,
        nav_before: u64,
        nav_after: u64,
        collateral: u64,
        debt: u64,
        ltv_bps: u64,
    }

    struct PerfFeeMinted has copy, drop {
        vault: 0x2::object::ID,
        shares: u64,
        price: u128,
    }

    struct ParamsChanged has copy, drop {
        vault: 0x2::object::ID,
    }

    struct GuardianPaused has copy, drop {
        vault: 0x2::object::ID,
    }

    fun assert_live<T0, T1>(arg0: &NaviVault<T0, T1>) {
        assert!(!arg0.paused, 1);
        assert!(arg0.version == 1, 14);
        assert!(!arg0.op_open, 15);
    }

    public fun asset<T0, T1>(arg0: &NaviVault<T0, T1>) : u8 {
        arg0.asset
    }

    fun begin_at<T0, T1>(arg0: &mut NaviVault<T0, T1>, arg1: u64, arg2: u64) : (0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap, OpReceipt) {
        assert!(arg0.version == 1, 14);
        assert!(!arg0.op_open, 15);
        arg0.op_open = true;
        let v0 = OpReceipt{
            vault             : 0x2::object::id<NaviVault<T0, T1>>(arg0),
            nav_before        : nav_with<T0, T1>(arg0, arg1, arg2),
            collateral_before : arg1,
            debt_before       : arg2,
        };
        (0x1::option::extract<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(&mut arg0.cap), v0)
    }

    public fun begin_op<T0, T1>(arg0: &mut NaviVault<T0, T1>, arg1: &KeeperCap, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &0x2::clock::Clock) : (0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap, OpReceipt) {
        assert!(arg1.vault == 0x2::object::id<NaviVault<T0, T1>>(arg0), 6);
        let (v0, v1) = position<T0, T1>(arg0, arg2, arg3);
        begin_at<T0, T1>(arg0, v0, v1)
    }

    public fun begin_op_admin<T0, T1>(arg0: &mut NaviVault<T0, T1>, arg1: &AdminCap, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &0x2::clock::Clock) : (0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap, OpReceipt) {
        let (v0, v1) = position<T0, T1>(arg0, arg2, arg3);
        begin_at<T0, T1>(arg0, v0, v1)
    }

    public fun buffer_value<T0, T1>(arg0: &NaviVault<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.buffer)
    }

    fun burn_for_value<T0, T1>(arg0: &mut NaviVault<T0, T1>, arg1: u64, arg2: u64, arg3: 0x2::coin::Coin<T1>) : (u64, u64) {
        let v0 = 0x2::coin::value<T1>(&arg3);
        assert!(v0 > 0, 2);
        0x2::coin::burn<T1>(&mut arg0.shares, arg3);
        (v0, mul_div(v0, nav_with<T0, T1>(arg0, arg1, arg2), 0x2::coin::total_supply<T1>(&arg0.shares)))
    }

    fun check_params(arg0: &Params) {
        assert!(arg0.entry_fee_bps <= 100, 9);
        assert!(arg0.exit_fee_bps <= 100, 9);
        assert!(arg0.perf_fee_bps <= 2000, 9);
        assert!(arg0.max_ltv_bps <= 9000, 9);
        assert!(arg0.borrow_fee_bps <= 100, 9);
        assert!(arg0.op_dust <= 100000, 9);
        assert!(arg0.max_daily_loss_bps <= 200, 9);
    }

    public fun claim<T0, T1>(arg0: &mut NaviVault<T0, T1>, arg1: WithdrawTicket, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let WithdrawTicket {
            id      : v0,
            vault   : v1,
            amount  : v2,
            cum_end : v3,
        } = arg1;
        assert!(v1 == 0x2::object::id<NaviVault<T0, T1>>(arg0), 6);
        assert!(arg0.funded_total >= v3, 7);
        0x2::object::delete(v0);
        let v4 = TicketClaimed{
            vault   : v1,
            amount  : v2,
            cum_end : v3,
        };
        0x2::event::emit<TicketClaimed>(v4);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.claim_pool, v2), arg2)
    }

    public fun claim_pool_value<T0, T1>(arg0: &NaviVault<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.claim_pool)
    }

    public fun clear_derisk<T0, T1>(arg0: &mut NaviVault<T0, T1>, arg1: &AdminCap) {
        arg0.derisk = false;
    }

    public fun create<T0, T1>(arg0: &AdminCap, arg1: 0x2::coin::TreasuryCap<T1>, arg2: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap, arg3: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: u8, arg5: u8, arg6: Params, arg7: address, arg8: &mut 0x2::tx_context::TxContext) : KeeperCap {
        assert!(0x2::coin::total_supply<T1>(&arg1) == 0, 10);
        assert!(arg5 <= 18, 20);
        check_params(&arg6);
        let v0 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&arg2);
        let (v1, v2) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_assets(arg3, v0);
        let v3 = v2;
        let v4 = v1;
        assert!(0x1::vector::is_empty<u8>(&v4) && 0x1::vector::is_empty<u8>(&v3), 19);
        new_vault<T0, T1>(arg1, arg2, v0, arg4, arg5, arg6, arg7, arg8)
    }

    fun crystallize_fee<T0, T1>(arg0: &mut NaviVault<T0, T1>, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::total_supply<T1>(&arg0.shares);
        if (v0 == 0 || arg0.params.perf_fee_bps == 0) {
            return
        };
        let v1 = nav_with<T0, T1>(arg0, arg1, arg2);
        let v2 = (v1 as u128) * 1000000000 / (v0 as u128);
        if (v2 <= arg0.hwm_price) {
            return
        };
        let v3 = (v2 - arg0.hwm_price) * (v0 as u128) / 1000000000 * (arg0.params.perf_fee_bps as u128) / (10000 as u128);
        if (v3 == 0 || v3 >= (v1 as u128)) {
            return
        };
        let v4 = ((v3 * (v0 as u128) / ((v1 as u128) - v3)) as u64);
        if (v4 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::mint<T1>(&mut arg0.shares, v4, arg3), arg0.fee_recipient);
        };
        arg0.hwm_price = (v1 as u128) * 1000000000 / (0x2::coin::total_supply<T1>(&arg0.shares) as u128);
        let v5 = PerfFeeMinted{
            vault  : 0x2::object::id<NaviVault<T0, T1>>(arg0),
            shares : v4,
            price  : arg0.hwm_price,
        };
        0x2::event::emit<PerfFeeMinted>(v5);
    }

    public fun deposit<T0, T1>(arg0: &mut NaviVault<T0, T1>, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let (v0, v1) = position<T0, T1>(arg0, arg1, arg2);
        deposit_at<T0, T1>(arg0, v0, v1, arg3, arg4)
    }

    fun deposit_at<T0, T1>(arg0: &mut NaviVault<T0, T1>, arg1: u64, arg2: u64, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert_live<T0, T1>(arg0);
        let v0 = 0x2::coin::value<T0>(&arg3);
        assert!(v0 > 0, 2);
        crystallize_fee<T0, T1>(arg0, arg1, arg2, arg4);
        let v1 = nav_with<T0, T1>(arg0, arg1, arg2);
        let v2 = mint_for_value<T0, T1>(arg0, v0, v1);
        0x2::balance::join<T0>(&mut arg0.pending, 0x2::coin::into_balance<T0>(arg3));
        let v3 = Deposited{
            vault  : 0x2::object::id<NaviVault<T0, T1>>(arg0),
            user   : 0x2::tx_context::sender(arg4),
            amount : v0,
            shares : v2,
            nav    : v1 + v0,
        };
        0x2::event::emit<Deposited>(v3);
        0x2::coin::mint<T1>(&mut arg0.shares, v2, arg4)
    }

    fun div_up(arg0: u256, arg1: u256) : u256 {
        if (arg0 == 0) {
            0
        } else {
            (arg0 - 1) / arg1 + 1
        }
    }

    fun end_at<T0, T1>(arg0: &mut NaviVault<T0, T1>, arg1: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap, arg2: OpReceipt, arg3: vector<u8>, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let OpReceipt {
            vault             : v0,
            nav_before        : v1,
            collateral_before : v2,
            debt_before       : v3,
        } = arg2;
        assert!(v0 == 0x2::object::id<NaviVault<T0, T1>>(arg0), 6);
        assert!(0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(&arg1) == arg0.cap_id, 16);
        let v4 = 0;
        while (v4 < 0x1::vector::length<u8>(&arg3)) {
            assert!(*0x1::vector::borrow<u8>(&arg3, v4) == arg0.asset, 17);
            v4 = v4 + 1;
        };
        let v5 = nav_with<T0, T1>(arg0, arg4, arg5);
        let v6 = if (arg5 > v3) {
            arg5 - v3
        } else {
            0
        };
        assert!((v5 as u128) + ((mul_div_up(v6, arg0.params.borrow_fee_bps, 10000 + arg0.params.borrow_fee_bps) + arg0.params.op_dust) as u128) >= (v1 as u128), 18);
        if (v5 < v1) {
            if (arg6 >= arg0.loss_window_start_ms + 86400000) {
                arg0.loss_window_start_ms = arg6;
                arg0.loss_window_spent = 0;
            };
            arg0.loss_window_spent = arg0.loss_window_spent + v1 - v5;
            assert!(arg0.loss_window_spent <= mul_div(v1, arg0.params.max_daily_loss_bps, 10000) + arg0.params.op_dust, 21);
        };
        if (v6 > 0) {
            assert!(!arg0.paused && !arg0.derisk, 11);
        };
        let v7 = ltv_bps(arg4, arg5);
        assert!(v7 <= arg0.params.max_ltv_bps || v7 <= ltv_bps(v2, v3), 8);
        0x1::option::fill<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(&mut arg0.cap, arg1);
        arg0.op_open = false;
        crystallize_fee<T0, T1>(arg0, arg4, arg5, arg7);
        let v8 = OpCompleted{
            vault      : v0,
            nav_before : v1,
            nav_after  : v5,
            collateral : arg4,
            debt       : arg5,
            ltv_bps    : v7,
        };
        0x2::event::emit<OpCompleted>(v8);
    }

    public fun end_op<T0, T1>(arg0: &mut NaviVault<T0, T1>, arg1: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap, arg2: OpReceipt, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let (_, v1) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_assets(arg3, arg0.owner);
        let (v2, v3) = position<T0, T1>(arg0, arg3, arg4);
        end_at<T0, T1>(arg0, arg1, arg2, v1, v2, v3, 0x2::clock::timestamp_ms(arg4), arg5);
    }

    public fun entry_fee_bps<T0, T1>(arg0: &NaviVault<T0, T1>) : u64 {
        arg0.params.entry_fee_bps
    }

    public fun exit_fee_bps<T0, T1>(arg0: &NaviVault<T0, T1>) : u64 {
        arg0.params.exit_fee_bps
    }

    fun free_idle<T0, T1>(arg0: &NaviVault<T0, T1>) : u64 {
        let v0 = 0x2::balance::value<T0>(&arg0.pending) + 0x2::balance::value<T0>(&arg0.buffer);
        let v1 = arg0.queued_total - arg0.funded_total;
        if (v0 > v1) {
            v0 - v1
        } else {
            0
        }
    }

    fun from_navi(arg0: u256, arg1: u8, arg2: bool) : u64 {
        let v0 = if (arg1 == 9) {
            arg0
        } else if (arg1 < 9) {
            if (arg2) {
                div_up(arg0, pow10(9 - arg1))
            } else {
                arg0 / pow10(9 - arg1)
            }
        } else {
            arg0 * pow10(arg1 - 9)
        };
        (v0 as u64)
    }

    public fun fund_queue<T0, T1>(arg0: &mut NaviVault<T0, T1>) {
        let v0 = min(arg0.queued_total - arg0.funded_total, 0x2::balance::value<T0>(&arg0.pending) + 0x2::balance::value<T0>(&arg0.buffer));
        if (v0 == 0) {
            return
        };
        let v1 = min(v0, 0x2::balance::value<T0>(&arg0.pending));
        let v2 = 0x2::balance::split<T0>(&mut arg0.pending, v1);
        0x2::balance::join<T0>(&mut v2, 0x2::balance::split<T0>(&mut arg0.buffer, v0 - v1));
        0x2::balance::join<T0>(&mut arg0.claim_pool, v2);
        arg0.funded_total = arg0.funded_total + v0;
        let v3 = QueueFunded{
            vault        : 0x2::object::id<NaviVault<T0, T1>>(arg0),
            amount       : v0,
            funded_total : arg0.funded_total,
        };
        0x2::event::emit<QueueFunded>(v3);
    }

    public fun funded_total<T0, T1>(arg0: &NaviVault<T0, T1>) : u64 {
        arg0.funded_total
    }

    public fun guardian_derisk<T0, T1>(arg0: &mut NaviVault<T0, T1>, arg1: &GuardianCap) {
        assert!(arg1.vault == 0x2::object::id<NaviVault<T0, T1>>(arg0), 6);
        arg0.derisk = true;
    }

    public fun guardian_pause<T0, T1>(arg0: &mut NaviVault<T0, T1>, arg1: &GuardianCap) {
        assert!(arg1.vault == 0x2::object::id<NaviVault<T0, T1>>(arg0), 6);
        arg0.paused = true;
        arg0.derisk = true;
        let v0 = GuardianPaused{vault: 0x2::object::id<NaviVault<T0, T1>>(arg0)};
        0x2::event::emit<GuardianPaused>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun is_derisk<T0, T1>(arg0: &NaviVault<T0, T1>) : bool {
        arg0.derisk
    }

    public fun is_op_open<T0, T1>(arg0: &NaviVault<T0, T1>) : bool {
        arg0.op_open
    }

    public fun is_paused<T0, T1>(arg0: &NaviVault<T0, T1>) : bool {
        arg0.paused
    }

    public fun loss_window_spent<T0, T1>(arg0: &NaviVault<T0, T1>) : u64 {
        arg0.loss_window_spent
    }

    public fun ltv<T0, T1>(arg0: &NaviVault<T0, T1>, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: &0x2::clock::Clock) : u64 {
        let (v0, v1) = position<T0, T1>(arg0, arg1, arg2);
        ltv_bps(v0, v1)
    }

    fun ltv_bps(arg0: u64, arg1: u64) : u64 {
        if (arg1 == 0) {
            return 0
        };
        if (arg0 == 0) {
            return 10000 * 100
        };
        mul_div_up(arg1, 10000, arg0)
    }

    public fun max_ltv_bps<T0, T1>(arg0: &NaviVault<T0, T1>) : u64 {
        arg0.params.max_ltv_bps
    }

    public fun migrate<T0, T1>(arg0: &mut NaviVault<T0, T1>, arg1: &AdminCap) {
        assert!(arg0.version < 1, 14);
        arg0.version = 1;
    }

    fun min(arg0: u64, arg1: u64) : u64 {
        if (arg0 < arg1) {
            arg0
        } else {
            arg1
        }
    }

    fun mint_for_value<T0, T1>(arg0: &mut NaviVault<T0, T1>, arg1: u64, arg2: u64) : u64 {
        assert!((arg2 as u128) + (arg1 as u128) <= (arg0.params.tvl_cap as u128), 3);
        let v0 = 0x2::coin::total_supply<T1>(&arg0.shares);
        let v1 = if (v0 == 0) {
            assert!(arg1 >= 1000000, 12);
            0x2::balance::join<T1>(&mut arg0.dead_shares, 0x2::coin::mint_balance<T1>(&mut arg0.shares, 1000));
            arg1 - 1000
        } else {
            assert!(arg2 > 0, 13);
            mul_div(mul_div(arg1, 10000 - arg0.params.entry_fee_bps, 10000), v0, arg2)
        };
        assert!(v1 > 0, 2);
        v1
    }

    fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    fun mul_div_up(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = (arg0 as u128) * (arg1 as u128);
        if (v0 == 0) {
            0
        } else {
            (((v0 - 1) / (arg2 as u128) + 1) as u64)
        }
    }

    public fun nav<T0, T1>(arg0: &NaviVault<T0, T1>, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: &0x2::clock::Clock) : u64 {
        let (v0, v1) = position<T0, T1>(arg0, arg1, arg2);
        nav_with<T0, T1>(arg0, v0, v1)
    }

    fun nav_with<T0, T1>(arg0: &NaviVault<T0, T1>, arg1: u64, arg2: u64) : u64 {
        let v0 = (arg1 as u128) + (0x2::balance::value<T0>(&arg0.pending) as u128) + (0x2::balance::value<T0>(&arg0.buffer) as u128);
        let v1 = (arg2 as u128) + ((arg0.queued_total - arg0.funded_total) as u128);
        if (v0 > v1) {
            ((v0 - v1) as u64)
        } else {
            0
        }
    }

    public fun new_guardian<T0, T1>(arg0: &NaviVault<T0, T1>, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) : GuardianCap {
        GuardianCap{
            id    : 0x2::object::new(arg2),
            vault : 0x2::object::id<NaviVault<T0, T1>>(arg0),
        }
    }

    public fun new_keeper<T0, T1>(arg0: &NaviVault<T0, T1>, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) : KeeperCap {
        KeeperCap{
            id    : 0x2::object::new(arg2),
            vault : 0x2::object::id<NaviVault<T0, T1>>(arg0),
        }
    }

    public fun new_params(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64) : Params {
        let v0 = Params{
            tvl_cap            : arg0,
            entry_fee_bps      : arg1,
            exit_fee_bps       : arg2,
            perf_fee_bps       : arg3,
            max_ltv_bps        : arg4,
            borrow_fee_bps     : arg5,
            op_dust            : arg6,
            max_daily_loss_bps : arg7,
        };
        check_params(&v0);
        v0
    }

    fun new_vault<T0, T1>(arg0: 0x2::coin::TreasuryCap<T1>, arg1: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap, arg2: address, arg3: u8, arg4: u8, arg5: Params, arg6: address, arg7: &mut 0x2::tx_context::TxContext) : KeeperCap {
        let v0 = NaviVault<T0, T1>{
            id                   : 0x2::object::new(arg7),
            version              : 1,
            shares               : arg0,
            dead_shares          : 0x2::balance::zero<T1>(),
            cap                  : 0x1::option::some<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(arg1),
            cap_id               : 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(&arg1),
            owner                : arg2,
            asset                : arg3,
            decimals             : arg4,
            pending              : 0x2::balance::zero<T0>(),
            buffer               : 0x2::balance::zero<T0>(),
            claim_pool           : 0x2::balance::zero<T0>(),
            queued_total         : 0,
            funded_total         : 0,
            hwm_price            : 1000000000,
            fee_recipient        : arg6,
            params               : arg5,
            derisk               : false,
            paused               : false,
            op_open              : false,
            loss_window_start_ms : 0,
            loss_window_spent    : 0,
        };
        let v1 = 0x2::object::id<NaviVault<T0, T1>>(&v0);
        let v2 = VaultCreated{
            vault : v1,
            owner : arg2,
            asset : arg3,
        };
        0x2::event::emit<VaultCreated>(v2);
        0x2::transfer::share_object<NaviVault<T0, T1>>(v0);
        KeeperCap{
            id    : 0x2::object::new(arg7),
            vault : v1,
        }
    }

    public fun owner<T0, T1>(arg0: &NaviVault<T0, T1>) : address {
        arg0.owner
    }

    public fun pending_value<T0, T1>(arg0: &NaviVault<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.pending)
    }

    public fun perf_fee_bps<T0, T1>(arg0: &NaviVault<T0, T1>) : u64 {
        arg0.params.perf_fee_bps
    }

    public fun position<T0, T1>(arg0: &NaviVault<T0, T1>, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: &0x2::clock::Clock) : (u64, u64) {
        let (v0, v1) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_balance(arg1, arg0.asset, arg0.owner);
        let (v2, v3) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::dynamic_calculator::calculate_current_index(arg2, arg1, arg0.asset);
        (from_navi(v0 * v2 / 1000000000000000000000000000, arg0.decimals, false), from_navi(div_up(v1 * v3, 1000000000000000000000000000), arg0.decimals, true))
    }

    fun pow10(arg0: u8) : u256 {
        let v0 = 1;
        let v1 = 0;
        while (v1 < arg0) {
            v0 = v0 * 10;
            v1 = v1 + 1;
        };
        v0
    }

    public fun put_buffer<T0, T1>(arg0: &mut NaviVault<T0, T1>, arg1: 0x2::balance::Balance<T0>) {
        0x2::balance::join<T0>(&mut arg0.buffer, arg1);
    }

    fun request_at<T0, T1>(arg0: &mut NaviVault<T0, T1>, arg1: u64, arg2: u64, arg3: 0x2::coin::Coin<T1>, arg4: &mut 0x2::tx_context::TxContext) : WithdrawTicket {
        assert_live<T0, T1>(arg0);
        crystallize_fee<T0, T1>(arg0, arg1, arg2, arg4);
        let (v0, v1) = burn_for_value<T0, T1>(arg0, arg1, arg2, arg3);
        let v2 = mul_div(v1, 10000 - arg0.params.exit_fee_bps, 10000);
        assert!(v2 > 0, 2);
        arg0.queued_total = arg0.queued_total + v2;
        let v3 = arg0.queued_total;
        let v4 = WithdrawQueued{
            vault   : 0x2::object::id<NaviVault<T0, T1>>(arg0),
            user    : 0x2::tx_context::sender(arg4),
            shares  : v0,
            amount  : v2,
            cum_end : v3,
        };
        0x2::event::emit<WithdrawQueued>(v4);
        WithdrawTicket{
            id      : 0x2::object::new(arg4),
            vault   : 0x2::object::id<NaviVault<T0, T1>>(arg0),
            amount  : v2,
            cum_end : v3,
        }
    }

    public fun request_withdraw<T0, T1>(arg0: &mut NaviVault<T0, T1>, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<T1>, arg4: &mut 0x2::tx_context::TxContext) : WithdrawTicket {
        let (v0, v1) = position<T0, T1>(arg0, arg1, arg2);
        request_at<T0, T1>(arg0, v0, v1, arg3, arg4)
    }

    public fun set_fee_recipient<T0, T1>(arg0: &mut NaviVault<T0, T1>, arg1: &AdminCap, arg2: address) {
        arg0.fee_recipient = arg2;
    }

    public fun set_params<T0, T1>(arg0: &mut NaviVault<T0, T1>, arg1: &AdminCap, arg2: Params) {
        check_params(&arg2);
        arg0.params = arg2;
        let v0 = ParamsChanged{vault: 0x2::object::id<NaviVault<T0, T1>>(arg0)};
        0x2::event::emit<ParamsChanged>(v0);
    }

    public fun set_paused<T0, T1>(arg0: &mut NaviVault<T0, T1>, arg1: &AdminCap, arg2: bool) {
        arg0.paused = arg2;
    }

    public fun share_price<T0, T1>(arg0: &NaviVault<T0, T1>, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: &0x2::clock::Clock) : u128 {
        let v0 = 0x2::coin::total_supply<T1>(&arg0.shares);
        if (v0 == 0) {
            return 1000000000
        };
        (nav<T0, T1>(arg0, arg1, arg2) as u128) * 1000000000 / (v0 as u128)
    }

    public fun take_idle<T0, T1>(arg0: &mut NaviVault<T0, T1>, arg1: &OpReceipt, arg2: u64) : 0x2::balance::Balance<T0> {
        assert!(arg1.vault == 0x2::object::id<NaviVault<T0, T1>>(arg0), 6);
        assert!(arg2 <= 0x2::balance::value<T0>(&arg0.pending) + 0x2::balance::value<T0>(&arg0.buffer), 5);
        let v0 = min(arg2, 0x2::balance::value<T0>(&arg0.pending));
        let v1 = 0x2::balance::split<T0>(&mut arg0.pending, v0);
        0x2::balance::join<T0>(&mut v1, 0x2::balance::split<T0>(&mut arg0.buffer, arg2 - v0));
        v1
    }

    public fun ticket_amount(arg0: &WithdrawTicket) : u64 {
        arg0.amount
    }

    public fun ticket_cum_end(arg0: &WithdrawTicket) : u64 {
        arg0.cum_end
    }

    public fun total_shares<T0, T1>(arg0: &NaviVault<T0, T1>) : u64 {
        0x2::coin::total_supply<T1>(&arg0.shares)
    }

    public fun tvl_cap<T0, T1>(arg0: &NaviVault<T0, T1>) : u64 {
        arg0.params.tvl_cap
    }

    public fun unfunded<T0, T1>(arg0: &NaviVault<T0, T1>) : u64 {
        arg0.queued_total - arg0.funded_total
    }

    public fun withdraw<T0, T1>(arg0: &mut NaviVault<T0, T1>, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1) = position<T0, T1>(arg0, arg1, arg2);
        withdraw_at<T0, T1>(arg0, v0, v1, arg3, arg4, arg5)
    }

    fun withdraw_at<T0, T1>(arg0: &mut NaviVault<T0, T1>, arg1: u64, arg2: u64, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_live<T0, T1>(arg0);
        crystallize_fee<T0, T1>(arg0, arg1, arg2, arg5);
        let (v0, v1) = burn_for_value<T0, T1>(arg0, arg1, arg2, arg3);
        let v2 = mul_div(v1, 10000 - arg0.params.exit_fee_bps, 10000);
        assert!(v2 > 0, 2);
        assert!(v2 >= arg4, 4);
        assert!(v2 <= free_idle<T0, T1>(arg0), 5);
        let v3 = min(v2, 0x2::balance::value<T0>(&arg0.pending));
        let v4 = 0x2::balance::split<T0>(&mut arg0.pending, v3);
        0x2::balance::join<T0>(&mut v4, 0x2::balance::split<T0>(&mut arg0.buffer, v2 - v3));
        let v5 = Withdrawn{
            vault  : 0x2::object::id<NaviVault<T0, T1>>(arg0),
            user   : 0x2::tx_context::sender(arg5),
            shares : v0,
            amount : v2,
            nav    : nav_with<T0, T1>(arg0, arg1, arg2),
        };
        0x2::event::emit<Withdrawn>(v5);
        0x2::coin::from_balance<T0>(v4, arg5)
    }

    // decompiled from Move bytecode v7
}

