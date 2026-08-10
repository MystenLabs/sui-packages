module 0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::rebalance {
    struct RebalanceLeg has copy, drop {
        token_sold: 0x1::type_name::TypeName,
        token_bought: 0x1::type_name::TypeName,
        current_value_usdc: u64,
        target_value_usdc: u64,
        drift_bps: u64,
        amount_sold: u64,
        timestamp_ms: u64,
    }

    struct RebalanceFinalized has copy, drop {
        caller: address,
        portfolio_usdc: u64,
        nav_per_suix5: u64,
        max_drift_bps: u64,
        timestamp_ms: u64,
    }

    struct RebalanceSkipped has copy, drop {
        caller: address,
        max_drift_bps: u64,
        timestamp_ms: u64,
    }

    struct ExitLeg has copy, drop {
        token: 0x1::type_name::TypeName,
        amount_sold: u64,
        received: u64,
    }

    struct SwapReceipt {
        token: 0x1::type_name::TypeName,
        amount_out_min: u64,
        amount_sold: u64,
    }

    fun apply_slippage(arg0: &0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::SuiX5Vault, arg1: u64) : u64 {
        arg1 * (10000 - 0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::max_slippage_bps(arg0)) / 10000
    }

    fun assert_constituent(arg0: &0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::SuiX5Vault, arg1: 0x1::type_name::TypeName) {
        assert!(0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::composition::contains(0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::composition_ref(arg0), arg1), 601);
    }

    fun assert_orphan(arg0: &0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::SuiX5Vault, arg1: 0x1::type_name::TypeName) {
        assert!(!0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::composition::contains(0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::composition_ref(arg0), arg1), 607);
    }

    public fun current_value_of<T0>(arg0: &mut 0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::SuiX5Vault, arg1: &0x5d822921e69a841952ae20490bca998984f430aed4af604d048d2e32f304c92a::adapter::PriceCache, arg2: &0x2::clock::Clock) : u64 {
        0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::assert_adapter(arg0, 0x2::object::id<0x5d822921e69a841952ae20490bca998984f430aed4af604d048d2e32f304c92a::adapter::PriceCache>(arg1));
        let v0 = 0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::balance_of<T0>(arg0);
        if (v0 == 0) {
            return 0
        };
        let v1 = 0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::oracle_mut(arg0);
        (((v0 as u128) * (0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::oracle::get_price_usdc<T0>(v1, arg1, arg2) as u128) / (pow10((0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::oracle::decimals_of(v1, 0x1::type_name::get<T0>()) as u64)) as u128)) as u64)
    }

    public fun drift_of(arg0: &0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::SuiX5Vault, arg1: 0x1::type_name::TypeName, arg2: u64) : (u64, bool) {
        let v0 = 0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::cached_portfolio(arg0);
        if (v0 == 0) {
            return (0, false)
        };
        let v1 = (((arg2 as u128) * (10000 as u128) / (v0 as u128)) as u64);
        let v2 = 0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::composition::weight_of(0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::composition_ref(arg0), arg1);
        if (v1 >= v2) {
            (v1 - v2, true)
        } else {
            (v2 - v1, false)
        }
    }

    public fun drift_tolerance_bps(arg0: &0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::SuiX5Vault) : u64 {
        0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::drift_tolerance_bps(arg0)
    }

    public fun finalize<T0, T1, T2, T3, T4>(arg0: &mut 0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::SuiX5Vault, arg1: &0x5d822921e69a841952ae20490bca998984f430aed4af604d048d2e32f304c92a::adapter::PriceCache, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::assert_not_paused(arg0);
        0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::assert_can_crank(arg0, arg2, arg3);
        0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::assert_nav_fresh(arg0, arg2);
        let v0 = 0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::composition::token_count(0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::composition_ref(arg0));
        assert!(v0 > 0, 600);
        assert!(v0 == 5, 606);
        let v1 = leg_drift<T0>(arg0, arg1, arg2);
        let v2 = leg_drift<T1>(arg0, arg1, arg2);
        let v3 = leg_drift<T2>(arg0, arg1, arg2);
        let v4 = leg_drift<T3>(arg0, arg1, arg2);
        let v5 = leg_drift<T4>(arg0, arg1, arg2);
        let v6 = v1;
        if (v2 > v1) {
            v6 = v2;
        };
        if (v3 > v6) {
            v6 = v3;
        };
        if (v4 > v6) {
            v6 = v4;
        };
        if (v5 > v6) {
            v6 = v5;
        };
        assert!(v6 <= 0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::drift_tolerance_bps(arg0), 602);
        let v7 = 0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::orphans(arg0);
        assert!(0x1::vector::is_empty<0x1::type_name::TypeName>(&v7), 607);
        let v8 = 0x2::clock::timestamp_ms(arg2);
        0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::mark_rebalanced(arg0, v8);
        let v9 = RebalanceFinalized{
            caller         : 0x2::tx_context::sender(arg3),
            portfolio_usdc : 0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::cached_portfolio(arg0),
            nav_per_suix5  : 0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::cached_nav(arg0),
            max_drift_bps  : v6,
            timestamp_ms   : v8,
        };
        0x2::event::emit<RebalanceFinalized>(v9);
    }

    fun leg_drift<T0>(arg0: &mut 0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::SuiX5Vault, arg1: &0x5d822921e69a841952ae20490bca998984f430aed4af604d048d2e32f304c92a::adapter::PriceCache, arg2: &0x2::clock::Clock) : u64 {
        let v0 = 0x1::type_name::get<T0>();
        assert_constituent(arg0, v0);
        let v1 = current_value_of<T0>(arg0, arg1, arg2);
        let v2 = target_value_for(arg0, v0);
        let v3 = if (v1 >= v2) {
            v1 - v2
        } else {
            v2 - v1
        };
        if (v3 < 0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::min_trade_value_usdc(arg0)) {
            return 0
        };
        let (v4, _) = drift_of(arg0, v0, v1);
        v4
    }

    public fun leg_exit_begin<T0, T1>(arg0: &mut 0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::SuiX5Vault, arg1: &0x5d822921e69a841952ae20490bca998984f430aed4af604d048d2e32f304c92a::adapter::PriceCache, arg2: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, SwapReceipt) {
        0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::assert_not_paused(arg0);
        0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::assert_nav_fresh(arg0, arg2);
        let v0 = 0x1::type_name::get<T0>();
        assert_orphan(arg0, v0);
        let v1 = current_value_of<T0>(arg0, arg1, arg2);
        let v2 = 0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::balance_of<T0>(arg0);
        let v3 = units_for_value<T1>(arg0, v1, arg1, arg2);
        let v4 = SwapReceipt{
            token          : v0,
            amount_out_min : apply_slippage(arg0, v3),
            amount_sold    : v2,
        };
        (0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::split_balance<T0>(arg0, v2), v4)
    }

    public fun leg_exit_settle<T0, T1>(arg0: &mut 0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::SuiX5Vault, arg1: 0x2::balance::Balance<T1>, arg2: SwapReceipt) {
        let SwapReceipt {
            token          : v0,
            amount_out_min : v1,
            amount_sold    : v2,
        } = arg2;
        assert!(v0 == 0x1::type_name::get<T0>(), 609);
        let v3 = 0x2::balance::value<T1>(&arg1);
        assert!(v3 >= v1, 608);
        0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::join_balance<T1>(arg0, arg1);
        let v4 = ExitLeg{
            token       : v0,
            amount_sold : v2,
            received    : v3,
        };
        0x2::event::emit<ExitLeg>(v4);
    }

    public fun leg_sell_begin<T0, T1>(arg0: &mut 0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::SuiX5Vault, arg1: &0x5d822921e69a841952ae20490bca998984f430aed4af604d048d2e32f304c92a::adapter::PriceCache, arg2: &0x2::clock::Clock, arg3: u64) : (0x2::balance::Balance<T0>, SwapReceipt) {
        0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::assert_not_paused(arg0);
        0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::assert_nav_fresh(arg0, arg2);
        let v0 = 0x1::type_name::get<T0>();
        assert_constituent(arg0, v0);
        let v1 = current_value_of<T0>(arg0, arg1, arg2);
        let (v2, v3) = drift_of(arg0, v0, v1);
        assert!(v3, 603);
        let v4 = target_value_for(arg0, v0);
        let v5 = v1 - v4;
        assert!(v5 >= 0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::min_trade_value_usdc(arg0), 604);
        let v6 = units_for_value<T0>(arg0, v5, arg1, arg2);
        assert!(arg3 > 0, 604);
        assert!(arg3 <= v6, 610);
        let v7 = units_for_value<T1>(arg0, v5, arg1, arg2);
        let v8 = RebalanceLeg{
            token_sold         : v0,
            token_bought       : 0x1::type_name::get<T1>(),
            current_value_usdc : v1,
            target_value_usdc  : v4,
            drift_bps          : v2,
            amount_sold        : arg3,
            timestamp_ms       : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<RebalanceLeg>(v8);
        let v9 = SwapReceipt{
            token          : v0,
            amount_out_min : apply_slippage(arg0, (((v7 as u128) * (arg3 as u128) / (v6 as u128)) as u64)),
            amount_sold    : arg3,
        };
        (0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::split_balance<T0>(arg0, arg3), v9)
    }

    public fun leg_sell_settle<T0, T1>(arg0: &mut 0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::SuiX5Vault, arg1: 0x2::balance::Balance<T1>, arg2: SwapReceipt) {
        let SwapReceipt {
            token          : v0,
            amount_out_min : v1,
            amount_sold    : _,
        } = arg2;
        assert!(v0 == 0x1::type_name::get<T0>(), 609);
        assert!(0x2::balance::value<T1>(&arg1) >= v1, 608);
        0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::join_balance<T1>(arg0, arg1);
    }

    public fun min_trade_value_usdc(arg0: &0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::SuiX5Vault) : u64 {
        0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::min_trade_value_usdc(arg0)
    }

    public fun needs_leg<T0>(arg0: &mut 0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::SuiX5Vault, arg1: &0x5d822921e69a841952ae20490bca998984f430aed4af604d048d2e32f304c92a::adapter::PriceCache, arg2: &0x2::clock::Clock) : bool {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = current_value_of<T0>(arg0, arg1, arg2);
        let (v2, v3) = drift_of(arg0, v0, v1);
        if (!v3) {
            return false
        };
        if (v2 <= 0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::drift_tolerance_bps(arg0)) {
            return false
        };
        v1 - target_value_for(arg0, v0) >= 0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::min_trade_value_usdc(arg0)
    }

    fun pow10(arg0: u64) : u64 {
        let v0 = 1;
        let v1 = 0;
        while (v1 < arg0) {
            v0 = v0 * 10;
            v1 = v1 + 1;
        };
        v0
    }

    public fun preview<T0>(arg0: &mut 0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::SuiX5Vault, arg1: &0x5d822921e69a841952ae20490bca998984f430aed4af604d048d2e32f304c92a::adapter::PriceCache, arg2: &0x2::clock::Clock) : (u64, u64, u64, bool) {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = current_value_of<T0>(arg0, arg1, arg2);
        let (v2, v3) = drift_of(arg0, v0, v1);
        (v1, target_value_for(arg0, v0), v2, v3)
    }

    public fun skip<T0, T1, T2, T3, T4>(arg0: &mut 0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::SuiX5Vault, arg1: &0x5d822921e69a841952ae20490bca998984f430aed4af604d048d2e32f304c92a::adapter::PriceCache, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::assert_not_paused(arg0);
        0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::assert_can_crank(arg0, arg2, arg3);
        0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::assert_nav_fresh(arg0, arg2);
        let v0 = leg_drift<T0>(arg0, arg1, arg2);
        let v1 = leg_drift<T1>(arg0, arg1, arg2);
        let v2 = leg_drift<T2>(arg0, arg1, arg2);
        let v3 = leg_drift<T3>(arg0, arg1, arg2);
        let v4 = leg_drift<T4>(arg0, arg1, arg2);
        let v5 = v0;
        if (v1 > v0) {
            v5 = v1;
        };
        if (v2 > v5) {
            v5 = v2;
        };
        if (v3 > v5) {
            v5 = v3;
        };
        if (v4 > v5) {
            v5 = v4;
        };
        assert!(v5 <= 0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::drift_tolerance_bps(arg0), 602);
        let v6 = 0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::orphans(arg0);
        assert!(0x1::vector::is_empty<0x1::type_name::TypeName>(&v6), 607);
        let v7 = 0x2::clock::timestamp_ms(arg2);
        0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::mark_rebalanced(arg0, v7);
        let v8 = RebalanceSkipped{
            caller        : 0x2::tx_context::sender(arg3),
            max_drift_bps : v5,
            timestamp_ms  : v7,
        };
        0x2::event::emit<RebalanceSkipped>(v8);
    }

    public fun target_value_for(arg0: &0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::SuiX5Vault, arg1: 0x1::type_name::TypeName) : u64 {
        let v0 = 0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::cached_portfolio(arg0);
        if (v0 == 0) {
            return 0
        };
        v0 * 0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::composition::weight_of(0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::composition_ref(arg0), arg1) / 10000
    }

    fun units_for_value<T0>(arg0: &mut 0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::SuiX5Vault, arg1: u64, arg2: &0x5d822921e69a841952ae20490bca998984f430aed4af604d048d2e32f304c92a::adapter::PriceCache, arg3: &0x2::clock::Clock) : u64 {
        0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::assert_adapter(arg0, 0x2::object::id<0x5d822921e69a841952ae20490bca998984f430aed4af604d048d2e32f304c92a::adapter::PriceCache>(arg2));
        let v0 = 0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::oracle_mut(arg0);
        (((arg1 as u128) * (pow10((0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::oracle::decimals_of(v0, 0x1::type_name::get<T0>()) as u64)) as u128) / (0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::oracle::get_price_usdc<T0>(v0, arg2, arg3) as u128)) as u64)
    }

    // decompiled from Move bytecode v7
}

