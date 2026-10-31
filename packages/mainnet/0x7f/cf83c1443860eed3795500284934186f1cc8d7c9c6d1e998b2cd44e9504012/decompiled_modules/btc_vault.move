module 0x7fcf83c1443860eed3795500284934186f1cc8d7c9c6d1e998b2cd44e9504012::btc_vault {
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
        target_ltv_bps: u64,
        max_ltv_bps: u64,
        min_health_bps: u64,
        borrow_fee_bps: u64,
        swap_slippage_bps: u64,
        breaker_slippage_bps: u64,
        max_depeg_bps: u64,
        debt_cap: u64,
        op_dust: u64,
        max_daily_loss_bps: u64,
    }

    struct BtcVault<phantom T0, phantom T1, phantom T2> has key {
        id: 0x2::object::UID,
        version: u64,
        shares: 0x2::coin::TreasuryCap<T2>,
        dead_shares: 0x2::balance::Balance<T2>,
        cap: 0x1::option::Option<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>,
        cap_id: 0x2::object::ID,
        owner: address,
        storage: 0x2::object::ID,
        asset_a: u8,
        asset_d: u8,
        decimals_a: u8,
        decimals_d: u8,
        pending: 0x2::balance::Balance<T0>,
        buffer: 0x2::balance::Balance<T0>,
        claim_pool: 0x2::balance::Balance<T0>,
        queued_total: u64,
        funded_total: u64,
        hwm_price: u128,
        fee_recipient: address,
        params: Params,
        debt_price: u64,
        derisk: bool,
        paused: bool,
        breaker: bool,
        op_open: bool,
        loss_window_start_ms: u64,
        loss_window_base: u64,
        loss_window_spent: u64,
    }

    struct OpReceipt {
        vault: 0x2::object::ID,
        nav_before: u64,
        collateral_before: u64,
        debt_before: u64,
        ltv_before: u64,
        harvested: u64,
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
        asset_a: u8,
        asset_d: u8,
        seed: u64,
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
        leverage_bps: u64,
        harvested: u64,
    }

    struct Harvested has copy, drop {
        vault: 0x2::object::ID,
        amount: u64,
    }

    struct PerfFeeMinted has copy, drop {
        vault: 0x2::object::ID,
        shares: u64,
        price: u128,
    }

    struct ParamsChanged has copy, drop {
        vault: 0x2::object::ID,
    }

    struct DebtPriceSet has copy, drop {
        vault: 0x2::object::ID,
        old: u64,
        new: u64,
        breaker: bool,
    }

    struct BreakerTripped has copy, drop {
        vault: 0x2::object::ID,
        by_keeper: bool,
    }

    struct GuardianPaused has copy, drop {
        vault: 0x2::object::ID,
    }

    struct Resumed has copy, drop {
        vault: 0x2::object::ID,
    }

    fun assert_live<T0, T1, T2>(arg0: &BtcVault<T0, T1, T2>) {
        assert!(!arg0.paused, 1);
        assert!(arg0.version == 1, 14);
        assert!(!arg0.op_open, 15);
    }

    public fun assets<T0, T1, T2>(arg0: &BtcVault<T0, T1, T2>) : (u8, u8) {
        (arg0.asset_a, arg0.asset_d)
    }

    fun begin<T0, T1, T2>(arg0: &mut BtcVault<T0, T1, T2>, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: &0x2::clock::Clock) : (0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap, OpReceipt) {
        assert!(arg0.version == 1, 14);
        assert!(!arg0.op_open, 15);
        let (v0, v1) = position<T0, T1, T2>(arg0, arg1, arg2);
        let v2 = OpReceipt{
            vault             : 0x2::object::id<BtcVault<T0, T1, T2>>(arg0),
            nav_before        : nav_with<T0, T1, T2>(arg0, v0, v1),
            collateral_before : v0,
            debt_before       : v1,
            ltv_before        : ltv_with<T0, T1, T2>(arg0, v0, v1),
            harvested         : 0,
        };
        arg0.op_open = true;
        (0x1::option::extract<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(&mut arg0.cap), v2)
    }

    public fun begin_op<T0, T1, T2>(arg0: &mut BtcVault<T0, T1, T2>, arg1: &KeeperCap, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &0x2::clock::Clock) : (0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap, OpReceipt) {
        assert!(arg1.vault == 0x2::object::id<BtcVault<T0, T1, T2>>(arg0), 6);
        begin<T0, T1, T2>(arg0, arg2, arg3)
    }

    public fun begin_op_admin<T0, T1, T2>(arg0: &mut BtcVault<T0, T1, T2>, arg1: &AdminCap, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &0x2::clock::Clock) : (0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap, OpReceipt) {
        begin<T0, T1, T2>(arg0, arg2, arg3)
    }

    public fun buffer_value<T0, T1, T2>(arg0: &BtcVault<T0, T1, T2>) : u64 {
        0x2::balance::value<T0>(&arg0.buffer)
    }

    fun burn_for_value<T0, T1, T2>(arg0: &mut BtcVault<T0, T1, T2>, arg1: u64, arg2: u64, arg3: 0x2::coin::Coin<T2>) : (u64, u64) {
        let v0 = 0x2::coin::value<T2>(&arg3);
        assert!(v0 > 0, 2);
        0x2::coin::burn<T2>(&mut arg0.shares, arg3);
        (v0, mul_div(v0, nav_with<T0, T1, T2>(arg0, arg1, arg2), 0x2::coin::total_supply<T2>(&arg0.shares)))
    }

    fun check_params(arg0: &Params) {
        assert!(arg0.entry_fee_bps <= 100, 9);
        assert!(arg0.exit_fee_bps <= 100, 9);
        assert!(arg0.perf_fee_bps <= 2000, 9);
        assert!(arg0.max_ltv_bps <= 6000, 9);
        assert!(arg0.target_ltv_bps <= arg0.max_ltv_bps, 9);
        assert!(arg0.min_health_bps >= 11000 && arg0.min_health_bps <= 30000, 9);
        assert!(arg0.borrow_fee_bps <= 100, 9);
        assert!(arg0.swap_slippage_bps <= 100, 9);
        assert!(arg0.breaker_slippage_bps <= 1000, 9);
        assert!(arg0.max_depeg_bps > 0 && arg0.max_depeg_bps <= 1000, 9);
        assert!(arg0.op_dust <= 10000, 9);
        assert!(arg0.max_daily_loss_bps <= 200, 9);
    }

    public fun claim<T0, T1, T2>(arg0: &mut BtcVault<T0, T1, T2>, arg1: WithdrawTicket, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let WithdrawTicket {
            id      : v0,
            vault   : v1,
            amount  : v2,
            cum_end : v3,
        } = arg1;
        assert!(v1 == 0x2::object::id<BtcVault<T0, T1, T2>>(arg0), 6);
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

    public fun claim_pool_value<T0, T1, T2>(arg0: &BtcVault<T0, T1, T2>) : u64 {
        0x2::balance::value<T0>(&arg0.claim_pool)
    }

    public fun clear_derisk<T0, T1, T2>(arg0: &mut BtcVault<T0, T1, T2>, arg1: &AdminCap) {
        arg0.derisk = false;
    }

    public fun create<T0, T1, T2>(arg0: &AdminCap, arg1: 0x2::coin::TreasuryCap<T2>, arg2: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap, arg3: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: u8, arg5: u8, arg6: u8, arg7: u8, arg8: Params, arg9: address, arg10: 0x2::coin::Coin<T0>, arg11: &mut 0x2::tx_context::TxContext) : KeeperCap {
        assert!(0x2::coin::total_supply<T2>(&arg1) == 0, 10);
        let v0 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&arg2);
        let (v1, v2) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_assets(arg3, v0);
        let v3 = v2;
        let v4 = v1;
        assert!(0x1::vector::is_empty<u8>(&v4) && 0x1::vector::is_empty<u8>(&v3), 19);
        new_vault<T0, T1, T2>(arg1, arg2, v0, 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage>(arg3), arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11)
    }

    fun crystallize_fee<T0, T1, T2>(arg0: &mut BtcVault<T0, T1, T2>, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::total_supply<T2>(&arg0.shares);
        if (v0 == 0 || arg0.params.perf_fee_bps == 0) {
            return
        };
        let v1 = nav_with<T0, T1, T2>(arg0, arg1, arg2);
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
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::mint<T2>(&mut arg0.shares, v4, arg3), arg0.fee_recipient);
        };
        arg0.hwm_price = (v1 as u128) * 1000000000 / (0x2::coin::total_supply<T2>(&arg0.shares) as u128);
        let v5 = PerfFeeMinted{
            vault  : 0x2::object::id<BtcVault<T0, T1, T2>>(arg0),
            shares : v4,
            price  : arg0.hwm_price,
        };
        0x2::event::emit<PerfFeeMinted>(v5);
    }

    public fun debt_cap<T0, T1, T2>(arg0: &BtcVault<T0, T1, T2>) : u64 {
        arg0.params.debt_cap
    }

    public fun debt_price<T0, T1, T2>(arg0: &BtcVault<T0, T1, T2>) : u64 {
        arg0.debt_price
    }

    fun debt_value<T0, T1, T2>(arg0: &BtcVault<T0, T1, T2>, arg1: u64) : u64 {
        if (arg1 == 0) {
            return 0
        };
        (div_up((arg1 as u256) * (arg0.debt_price as u256) * pow10(arg0.decimals_a), (1000000000 as u256) * pow10(arg0.decimals_d)) as u64)
    }

    public fun deposit<T0, T1, T2>(arg0: &mut BtcVault<T0, T1, T2>, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        assert_live<T0, T1, T2>(arg0);
        let (v0, v1) = position<T0, T1, T2>(arg0, arg1, arg2);
        let v2 = 0x2::coin::value<T0>(&arg3);
        assert!(v2 > 0, 2);
        crystallize_fee<T0, T1, T2>(arg0, v0, v1, arg4);
        let v3 = nav_with<T0, T1, T2>(arg0, v0, v1);
        assert!((v3 as u128) + (v2 as u128) <= (arg0.params.tvl_cap as u128), 3);
        assert!(v3 > 0, 13);
        let v4 = mul_div(mul_div(v2, 10000 - arg0.params.entry_fee_bps, 10000), 0x2::coin::total_supply<T2>(&arg0.shares), v3);
        assert!(v4 > 0, 2);
        0x2::balance::join<T0>(&mut arg0.pending, 0x2::coin::into_balance<T0>(arg3));
        let v5 = 0x2::coin::mint<T2>(&mut arg0.shares, v4, arg4);
        lift_hwm<T0, T1, T2>(arg0, v0, v1);
        let v6 = Deposited{
            vault  : 0x2::object::id<BtcVault<T0, T1, T2>>(arg0),
            user   : 0x2::tx_context::sender(arg4),
            amount : v2,
            shares : v4,
            nav    : v3 + v2,
        };
        0x2::event::emit<Deposited>(v6);
        v5
    }

    fun div_up(arg0: u256, arg1: u256) : u256 {
        if (arg0 == 0) {
            0
        } else {
            (arg0 - 1) / arg1 + 1
        }
    }

    public fun end_op<T0, T1, T2>(arg0: &mut BtcVault<T0, T1, T2>, arg1: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap, arg2: OpReceipt, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let OpReceipt {
            vault             : v0,
            nav_before        : v1,
            collateral_before : v2,
            debt_before       : v3,
            ltv_before        : v4,
            harvested         : v5,
        } = arg2;
        assert!(v0 == 0x2::object::id<BtcVault<T0, T1, T2>>(arg0), 6);
        assert!(0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(&arg1) == arg0.cap_id, 16);
        0x1::option::fill<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(&mut arg0.cap, arg1);
        arg0.op_open = false;
        let (_, v7) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_assets(arg3, arg0.owner);
        let v8 = v7;
        let v9 = &v8;
        let v10 = 0;
        while (v10 < 0x1::vector::length<u8>(v9)) {
            assert!(*0x1::vector::borrow<u8>(v9, v10) == arg0.asset_d, 17);
            v10 = v10 + 1;
        };
        let (v11, v12) = position<T0, T1, T2>(arg0, arg3, arg5);
        let v13 = nav_with<T0, T1, T2>(arg0, v11, v12);
        let v14 = v12 > v3;
        let v15 = if (v14) {
            debt_value<T0, T1, T2>(arg0, v12 - v3)
        } else {
            0
        };
        let v16 = if (v12 < v3) {
            debt_value<T0, T1, T2>(arg0, v3 - v12)
        } else {
            0
        };
        let v17 = arg0.breaker && !v14;
        let v18 = if (v17) {
            arg0.params.breaker_slippage_bps
        } else {
            arg0.params.swap_slippage_bps
        };
        assert!((v13 as u128) + (mul_div_up(v15, arg0.params.borrow_fee_bps, 10000) as u128) + (mul_div_up(v15 + v16, v18, 10000) as u128) + (arg0.params.op_dust as u128) >= (v1 as u128), 18);
        if (v14) {
            let v19 = if (v13 > v5) {
                v13 - v5
            } else {
                0
            };
            assert!((v19 as u128) <= (v1 as u128) + (mul_div(v15, arg0.params.max_depeg_bps, 10000) as u128) + (arg0.params.op_dust as u128), 22);
        };
        if (v13 < v1 && !v17) {
            spend_loss_budget<T0, T1, T2>(arg0, v1, v1 - v13, 0x2::clock::timestamp_ms(arg5));
        };
        if (v14) {
            let v20 = if (!arg0.paused) {
                if (!arg0.derisk) {
                    !arg0.breaker
                } else {
                    false
                }
            } else {
                false
            };
            assert!(v20, 11);
            assert!(peg_ok<T0, T1, T2>(arg0), 22);
            assert!(v12 <= arg0.params.debt_cap, 23);
        };
        let v21 = ltv_with<T0, T1, T2>(arg0, v11, v12);
        assert!(v21 <= arg0.params.max_ltv_bps || v21 <= v4, 8);
        if (v12 > 0 && (v14 || v11 < v2)) {
            assert!(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_health_factor(arg5, arg3, arg4, arg0.owner) >= (arg0.params.min_health_bps as u256) * 1000000000000000000000000000 / (10000 as u256), 24);
        };
        crystallize_fee<T0, T1, T2>(arg0, v11, v12, arg6);
        let v22 = OpCompleted{
            vault        : v0,
            nav_before   : v1,
            nav_after    : v13,
            collateral   : v11,
            debt         : v12,
            ltv_bps      : v21,
            leverage_bps : leverage_with<T0, T1, T2>(arg0, v11, v12),
            harvested    : v5,
        };
        0x2::event::emit<OpCompleted>(v22);
    }

    public fun fee_recipient<T0, T1, T2>(arg0: &BtcVault<T0, T1, T2>) : address {
        arg0.fee_recipient
    }

    public fun fees<T0, T1, T2>(arg0: &BtcVault<T0, T1, T2>) : (u64, u64, u64) {
        (arg0.params.entry_fee_bps, arg0.params.exit_fee_bps, arg0.params.perf_fee_bps)
    }

    fun free_idle<T0, T1, T2>(arg0: &BtcVault<T0, T1, T2>) : u64 {
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

    public fun fund_queue<T0, T1, T2>(arg0: &mut BtcVault<T0, T1, T2>) {
        assert!(!arg0.op_open, 15);
        let v0 = min(arg0.queued_total - arg0.funded_total, 0x2::balance::value<T0>(&arg0.pending) + 0x2::balance::value<T0>(&arg0.buffer));
        if (v0 == 0) {
            return
        };
        let v1 = take_idle_inner<T0, T1, T2>(arg0, v0);
        0x2::balance::join<T0>(&mut arg0.claim_pool, v1);
        arg0.funded_total = arg0.funded_total + v0;
        let v2 = QueueFunded{
            vault        : 0x2::object::id<BtcVault<T0, T1, T2>>(arg0),
            amount       : v0,
            funded_total : arg0.funded_total,
        };
        0x2::event::emit<QueueFunded>(v2);
    }

    public fun funded_total<T0, T1, T2>(arg0: &BtcVault<T0, T1, T2>) : u64 {
        arg0.funded_total
    }

    public fun guardian_pause<T0, T1, T2>(arg0: &mut BtcVault<T0, T1, T2>, arg1: &GuardianCap) {
        assert!(arg1.vault == 0x2::object::id<BtcVault<T0, T1, T2>>(arg0), 6);
        arg0.paused = true;
        arg0.derisk = true;
        let v0 = GuardianPaused{vault: 0x2::object::id<BtcVault<T0, T1, T2>>(arg0)};
        0x2::event::emit<GuardianPaused>(v0);
    }

    public fun guardian_trip_breaker<T0, T1, T2>(arg0: &mut BtcVault<T0, T1, T2>, arg1: &GuardianCap) {
        assert!(arg1.vault == 0x2::object::id<BtcVault<T0, T1, T2>>(arg0), 6);
        trip<T0, T1, T2>(arg0);
        let v0 = BreakerTripped{
            vault     : 0x2::object::id<BtcVault<T0, T1, T2>>(arg0),
            by_keeper : false,
        };
        0x2::event::emit<BreakerTripped>(v0);
    }

    public fun harvest<T0, T1, T2>(arg0: &mut BtcVault<T0, T1, T2>, arg1: &KeeperCap, arg2: 0x2::coin::Coin<T0>) {
        assert!(arg1.vault == 0x2::object::id<BtcVault<T0, T1, T2>>(arg0), 6);
        assert!(!arg0.op_open, 15);
        0x2::balance::join<T0>(&mut arg0.pending, 0x2::coin::into_balance<T0>(arg2));
        let v0 = Harvested{
            vault  : 0x2::object::id<BtcVault<T0, T1, T2>>(arg0),
            amount : 0x2::coin::value<T0>(&arg2),
        };
        0x2::event::emit<Harvested>(v0);
    }

    public fun hwm_price<T0, T1, T2>(arg0: &BtcVault<T0, T1, T2>) : u128 {
        arg0.hwm_price
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun is_breaker<T0, T1, T2>(arg0: &BtcVault<T0, T1, T2>) : bool {
        arg0.breaker
    }

    public fun is_derisk<T0, T1, T2>(arg0: &BtcVault<T0, T1, T2>) : bool {
        arg0.derisk
    }

    public fun is_op_open<T0, T1, T2>(arg0: &BtcVault<T0, T1, T2>) : bool {
        arg0.op_open
    }

    public fun is_paused<T0, T1, T2>(arg0: &BtcVault<T0, T1, T2>) : bool {
        arg0.paused
    }

    public fun keeper_trip_breaker<T0, T1, T2>(arg0: &mut BtcVault<T0, T1, T2>, arg1: &KeeperCap) {
        assert!(arg1.vault == 0x2::object::id<BtcVault<T0, T1, T2>>(arg0), 6);
        trip<T0, T1, T2>(arg0);
        let v0 = BreakerTripped{
            vault     : 0x2::object::id<BtcVault<T0, T1, T2>>(arg0),
            by_keeper : true,
        };
        0x2::event::emit<BreakerTripped>(v0);
    }

    fun leverage_with<T0, T1, T2>(arg0: &BtcVault<T0, T1, T2>, arg1: u64, arg2: u64) : u64 {
        if (arg1 == 0) {
            return 0
        };
        let v0 = debt_value<T0, T1, T2>(arg0, arg2);
        if (v0 >= arg1) {
            return 0
        };
        mul_div(arg1, 10000, arg1 - v0)
    }

    fun lift_hwm<T0, T1, T2>(arg0: &mut BtcVault<T0, T1, T2>, arg1: u64, arg2: u64) {
        let v0 = 0x2::coin::total_supply<T2>(&arg0.shares);
        if (v0 == 0) {
            return
        };
        let v1 = (nav_with<T0, T1, T2>(arg0, arg1, arg2) as u128) * 1000000000 / (v0 as u128);
        if (v1 > arg0.hwm_price) {
            arg0.hwm_price = v1;
        };
    }

    public fun loss_window_spent<T0, T1, T2>(arg0: &BtcVault<T0, T1, T2>) : u64 {
        arg0.loss_window_spent
    }

    fun ltv_with<T0, T1, T2>(arg0: &BtcVault<T0, T1, T2>, arg1: u64, arg2: u64) : u64 {
        if (arg2 == 0) {
            return 0
        };
        if (arg1 == 0) {
            return 10000 * 100
        };
        mul_div_up(debt_value<T0, T1, T2>(arg0, arg2), 10000, arg1)
    }

    public fun max_ltv_bps<T0, T1, T2>(arg0: &BtcVault<T0, T1, T2>) : u64 {
        arg0.params.max_ltv_bps
    }

    public fun migrate<T0, T1, T2>(arg0: &mut BtcVault<T0, T1, T2>, arg1: &AdminCap) {
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

    public fun nav<T0, T1, T2>(arg0: &BtcVault<T0, T1, T2>, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: &0x2::clock::Clock) : u64 {
        let (v0, v1) = position<T0, T1, T2>(arg0, arg1, arg2);
        nav_with<T0, T1, T2>(arg0, v0, v1)
    }

    fun nav_with<T0, T1, T2>(arg0: &BtcVault<T0, T1, T2>, arg1: u64, arg2: u64) : u64 {
        let v0 = (arg1 as u128) + (0x2::balance::value<T0>(&arg0.pending) as u128) + (0x2::balance::value<T0>(&arg0.buffer) as u128);
        let v1 = (debt_value<T0, T1, T2>(arg0, arg2) as u128) + ((arg0.queued_total - arg0.funded_total) as u128);
        if (v0 > v1) {
            ((v0 - v1) as u64)
        } else {
            0
        }
    }

    public fun new_guardian<T0, T1, T2>(arg0: &BtcVault<T0, T1, T2>, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) : GuardianCap {
        GuardianCap{
            id    : 0x2::object::new(arg2),
            vault : 0x2::object::id<BtcVault<T0, T1, T2>>(arg0),
        }
    }

    public fun new_keeper<T0, T1, T2>(arg0: &BtcVault<T0, T1, T2>, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) : KeeperCap {
        KeeperCap{
            id    : 0x2::object::new(arg2),
            vault : 0x2::object::id<BtcVault<T0, T1, T2>>(arg0),
        }
    }

    public fun new_params(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64) : Params {
        let v0 = Params{
            tvl_cap              : arg0,
            entry_fee_bps        : arg1,
            exit_fee_bps         : arg2,
            perf_fee_bps         : arg3,
            target_ltv_bps       : arg4,
            max_ltv_bps          : arg5,
            min_health_bps       : arg6,
            borrow_fee_bps       : arg7,
            swap_slippage_bps    : arg8,
            breaker_slippage_bps : arg9,
            max_depeg_bps        : arg10,
            debt_cap             : arg11,
            op_dust              : arg12,
            max_daily_loss_bps   : arg13,
        };
        check_params(&v0);
        v0
    }

    fun new_vault<T0, T1, T2>(arg0: 0x2::coin::TreasuryCap<T2>, arg1: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap, arg2: address, arg3: 0x2::object::ID, arg4: u8, arg5: u8, arg6: u8, arg7: u8, arg8: Params, arg9: address, arg10: 0x2::coin::Coin<T0>, arg11: &mut 0x2::tx_context::TxContext) : KeeperCap {
        assert!(arg4 != arg5, 26);
        assert!(arg6 <= 18 && arg7 <= 18, 20);
        check_params(&arg8);
        let v0 = 0x2::coin::value<T0>(&arg10);
        assert!(v0 >= 3000, 12);
        let v1 = BtcVault<T0, T1, T2>{
            id                   : 0x2::object::new(arg11),
            version              : 1,
            shares               : arg0,
            dead_shares          : 0x2::balance::zero<T2>(),
            cap                  : 0x1::option::some<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(arg1),
            cap_id               : 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(&arg1),
            owner                : arg2,
            storage              : arg3,
            asset_a              : arg4,
            asset_d              : arg5,
            decimals_a           : arg6,
            decimals_d           : arg7,
            pending              : 0x2::coin::into_balance<T0>(arg10),
            buffer               : 0x2::balance::zero<T0>(),
            claim_pool           : 0x2::balance::zero<T0>(),
            queued_total         : 0,
            funded_total         : 0,
            hwm_price            : 1000000000,
            fee_recipient        : arg9,
            params               : arg8,
            debt_price           : 1000000000,
            derisk               : false,
            paused               : false,
            breaker              : false,
            op_open              : false,
            loss_window_start_ms : 0,
            loss_window_base     : 0,
            loss_window_spent    : 0,
        };
        0x2::balance::join<T2>(&mut v1.dead_shares, 0x2::coin::mint_balance<T2>(&mut v1.shares, 1000));
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::mint<T2>(&mut v1.shares, v0 - 1000, arg11), arg9);
        let v2 = 0x2::object::id<BtcVault<T0, T1, T2>>(&v1);
        let v3 = VaultCreated{
            vault   : v2,
            owner   : arg2,
            asset_a : arg4,
            asset_d : arg5,
            seed    : v0,
        };
        0x2::event::emit<VaultCreated>(v3);
        0x2::transfer::share_object<BtcVault<T0, T1, T2>>(v1);
        KeeperCap{
            id    : 0x2::object::new(arg11),
            vault : v2,
        }
    }

    public fun owner<T0, T1, T2>(arg0: &BtcVault<T0, T1, T2>) : address {
        arg0.owner
    }

    public fun params<T0, T1, T2>(arg0: &BtcVault<T0, T1, T2>) : Params {
        arg0.params
    }

    fun peg_ok<T0, T1, T2>(arg0: &BtcVault<T0, T1, T2>) : bool {
        let v0 = mul_div(1000000000, arg0.params.max_depeg_bps, 10000);
        arg0.debt_price <= 1000000000 + v0 && arg0.debt_price + v0 >= 1000000000
    }

    public fun pending_value<T0, T1, T2>(arg0: &BtcVault<T0, T1, T2>) : u64 {
        0x2::balance::value<T0>(&arg0.pending)
    }

    public fun position<T0, T1, T2>(arg0: &BtcVault<T0, T1, T2>, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: &0x2::clock::Clock) : (u64, u64) {
        assert!(0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage>(arg1) == arg0.storage, 25);
        let (v0, _) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_balance(arg1, arg0.asset_a, arg0.owner);
        let (_, v3) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_balance(arg1, arg0.asset_d, arg0.owner);
        let (v4, _) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::dynamic_calculator::calculate_current_index(arg2, arg1, arg0.asset_a);
        let (_, v7) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::dynamic_calculator::calculate_current_index(arg2, arg1, arg0.asset_d);
        (from_navi(v0 * v4 / 1000000000000000000000000000, arg0.decimals_a, false), from_navi(div_up(v3 * v7, 1000000000000000000000000000), arg0.decimals_d, true))
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

    public fun put_harvest<T0, T1, T2>(arg0: &mut BtcVault<T0, T1, T2>, arg1: &mut OpReceipt, arg2: 0x2::balance::Balance<T0>) {
        assert!(arg1.vault == 0x2::object::id<BtcVault<T0, T1, T2>>(arg0), 6);
        let v0 = 0x2::balance::value<T0>(&arg2);
        arg1.harvested = arg1.harvested + v0;
        0x2::balance::join<T0>(&mut arg0.pending, arg2);
        let v1 = Harvested{
            vault  : 0x2::object::id<BtcVault<T0, T1, T2>>(arg0),
            amount : v0,
        };
        0x2::event::emit<Harvested>(v1);
    }

    public fun put_idle<T0, T1, T2>(arg0: &mut BtcVault<T0, T1, T2>, arg1: &OpReceipt, arg2: 0x2::balance::Balance<T0>) {
        assert!(arg1.vault == 0x2::object::id<BtcVault<T0, T1, T2>>(arg0), 6);
        0x2::balance::join<T0>(&mut arg0.buffer, arg2);
    }

    public fun receipt_nav_before(arg0: &OpReceipt) : u64 {
        arg0.nav_before
    }

    public fun request_withdraw<T0, T1, T2>(arg0: &mut BtcVault<T0, T1, T2>, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<T2>, arg4: &mut 0x2::tx_context::TxContext) : WithdrawTicket {
        assert_live<T0, T1, T2>(arg0);
        let (v0, v1) = position<T0, T1, T2>(arg0, arg1, arg2);
        crystallize_fee<T0, T1, T2>(arg0, v0, v1, arg4);
        let (v2, v3) = burn_for_value<T0, T1, T2>(arg0, v0, v1, arg3);
        let v4 = mul_div(v3, 10000 - arg0.params.exit_fee_bps, 10000);
        assert!(v4 > 0, 2);
        arg0.queued_total = arg0.queued_total + v4;
        let v5 = arg0.queued_total;
        lift_hwm<T0, T1, T2>(arg0, v0, v1);
        let v6 = WithdrawQueued{
            vault   : 0x2::object::id<BtcVault<T0, T1, T2>>(arg0),
            user    : 0x2::tx_context::sender(arg4),
            shares  : v2,
            amount  : v4,
            cum_end : v5,
        };
        0x2::event::emit<WithdrawQueued>(v6);
        WithdrawTicket{
            id      : 0x2::object::new(arg4),
            vault   : 0x2::object::id<BtcVault<T0, T1, T2>>(arg0),
            amount  : v4,
            cum_end : v5,
        }
    }

    public fun resume<T0, T1, T2>(arg0: &mut BtcVault<T0, T1, T2>, arg1: &AdminCap) {
        arg0.breaker = false;
        arg0.derisk = false;
        arg0.paused = false;
        let v0 = Resumed{vault: 0x2::object::id<BtcVault<T0, T1, T2>>(arg0)};
        0x2::event::emit<Resumed>(v0);
    }

    public fun set_debt_price<T0, T1, T2>(arg0: &mut BtcVault<T0, T1, T2>, arg1: &AdminCap, arg2: u64) {
        assert!(arg2 >= 500000000 && arg2 <= 2000000000, 9);
        let v0 = arg0.debt_price;
        arg0.debt_price = arg2;
        let v1 = !peg_ok<T0, T1, T2>(arg0);
        if (v1) {
            trip<T0, T1, T2>(arg0);
        };
        let v2 = DebtPriceSet{
            vault   : 0x2::object::id<BtcVault<T0, T1, T2>>(arg0),
            old     : v0,
            new     : arg2,
            breaker : v1,
        };
        0x2::event::emit<DebtPriceSet>(v2);
    }

    public fun set_fee_recipient<T0, T1, T2>(arg0: &mut BtcVault<T0, T1, T2>, arg1: &AdminCap, arg2: address) {
        arg0.fee_recipient = arg2;
    }

    public fun set_params<T0, T1, T2>(arg0: &mut BtcVault<T0, T1, T2>, arg1: &AdminCap, arg2: Params) {
        check_params(&arg2);
        arg0.params = arg2;
        let v0 = ParamsChanged{vault: 0x2::object::id<BtcVault<T0, T1, T2>>(arg0)};
        0x2::event::emit<ParamsChanged>(v0);
    }

    public fun set_paused<T0, T1, T2>(arg0: &mut BtcVault<T0, T1, T2>, arg1: &AdminCap, arg2: bool) {
        arg0.paused = arg2;
    }

    public fun share_price<T0, T1, T2>(arg0: &BtcVault<T0, T1, T2>, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: &0x2::clock::Clock) : u128 {
        let v0 = 0x2::coin::total_supply<T2>(&arg0.shares);
        if (v0 == 0) {
            return 1000000000
        };
        (nav<T0, T1, T2>(arg0, arg1, arg2) as u128) * 1000000000 / (v0 as u128)
    }

    fun spend_loss_budget<T0, T1, T2>(arg0: &mut BtcVault<T0, T1, T2>, arg1: u64, arg2: u64, arg3: u64) {
        if (arg0.loss_window_base == 0 || arg3 >= arg0.loss_window_start_ms + 86400000) {
            arg0.loss_window_start_ms = arg3;
            arg0.loss_window_base = arg1;
            arg0.loss_window_spent = 0;
        } else if (arg1 > arg0.loss_window_base) {
            arg0.loss_window_base = arg1;
        };
        arg0.loss_window_spent = arg0.loss_window_spent + arg2;
        assert!(arg0.loss_window_spent <= mul_div(arg0.loss_window_base, arg0.params.max_daily_loss_bps, 10000) + arg0.params.op_dust, 21);
    }

    public fun stats<T0, T1, T2>(arg0: &BtcVault<T0, T1, T2>, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: &0x2::clock::Clock) : (u64, u64, u64, u64, u64, u64, u64, u64, u64, u64) {
        let (v0, v1) = position<T0, T1, T2>(arg0, arg1, arg2);
        let (_, v3) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_current_rate(arg1, arg0.asset_d);
        (nav_with<T0, T1, T2>(arg0, v0, v1), 0x2::coin::total_supply<T2>(&arg0.shares), v0, v1, ltv_with<T0, T1, T2>(arg0, v0, v1), leverage_with<T0, T1, T2>(arg0, v0, v1), ((v3 * (10000 as u256) / 1000000000000000000000000000) as u64), 0x2::balance::value<T0>(&arg0.pending), 0x2::balance::value<T0>(&arg0.buffer), arg0.queued_total - arg0.funded_total)
    }

    public fun take_idle<T0, T1, T2>(arg0: &mut BtcVault<T0, T1, T2>, arg1: &OpReceipt, arg2: u64) : 0x2::balance::Balance<T0> {
        assert!(arg1.vault == 0x2::object::id<BtcVault<T0, T1, T2>>(arg0), 6);
        assert!(arg2 <= free_idle<T0, T1, T2>(arg0), 5);
        take_idle_inner<T0, T1, T2>(arg0, arg2)
    }

    fun take_idle_inner<T0, T1, T2>(arg0: &mut BtcVault<T0, T1, T2>, arg1: u64) : 0x2::balance::Balance<T0> {
        let v0 = min(arg1, 0x2::balance::value<T0>(&arg0.pending));
        let v1 = 0x2::balance::split<T0>(&mut arg0.pending, v0);
        0x2::balance::join<T0>(&mut v1, 0x2::balance::split<T0>(&mut arg0.buffer, arg1 - v0));
        v1
    }

    public fun target_ltv_bps<T0, T1, T2>(arg0: &BtcVault<T0, T1, T2>) : u64 {
        arg0.params.target_ltv_bps
    }

    public fun ticket_amount(arg0: &WithdrawTicket) : u64 {
        arg0.amount
    }

    public fun ticket_cum_end(arg0: &WithdrawTicket) : u64 {
        arg0.cum_end
    }

    public fun total_shares<T0, T1, T2>(arg0: &BtcVault<T0, T1, T2>) : u64 {
        0x2::coin::total_supply<T2>(&arg0.shares)
    }

    fun trip<T0, T1, T2>(arg0: &mut BtcVault<T0, T1, T2>) {
        arg0.breaker = true;
        arg0.derisk = true;
        arg0.paused = true;
    }

    public fun tvl_cap<T0, T1, T2>(arg0: &BtcVault<T0, T1, T2>) : u64 {
        arg0.params.tvl_cap
    }

    public fun unfunded<T0, T1, T2>(arg0: &BtcVault<T0, T1, T2>) : u64 {
        arg0.queued_total - arg0.funded_total
    }

    public fun withdraw<T0, T1, T2>(arg0: &mut BtcVault<T0, T1, T2>, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<T2>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_live<T0, T1, T2>(arg0);
        let (v0, v1) = position<T0, T1, T2>(arg0, arg1, arg2);
        crystallize_fee<T0, T1, T2>(arg0, v0, v1, arg5);
        let (v2, v3) = burn_for_value<T0, T1, T2>(arg0, v0, v1, arg3);
        let v4 = mul_div(v3, 10000 - arg0.params.exit_fee_bps, 10000);
        assert!(v4 > 0, 2);
        assert!(v4 >= arg4, 4);
        assert!(v4 <= free_idle<T0, T1, T2>(arg0), 5);
        let v5 = take_idle_inner<T0, T1, T2>(arg0, v4);
        lift_hwm<T0, T1, T2>(arg0, v0, v1);
        let v6 = Withdrawn{
            vault  : 0x2::object::id<BtcVault<T0, T1, T2>>(arg0),
            user   : 0x2::tx_context::sender(arg5),
            shares : v2,
            amount : v4,
            nav    : nav_with<T0, T1, T2>(arg0, v0, v1),
        };
        0x2::event::emit<Withdrawn>(v6);
        0x2::coin::from_balance<T0>(v5, arg5)
    }

    // decompiled from Move bytecode v7
}

