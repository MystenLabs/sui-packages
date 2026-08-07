module 0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::rebalance {
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
        timestamp_ms: u64,
    }

    fun assert_constituent(arg0: &0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::vault::SuiX5Vault, arg1: 0x1::type_name::TypeName) {
        assert!(0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::composition::contains(0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::vault::composition_ref(arg0), arg1), 601);
    }

    fun assert_orphan(arg0: &0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::vault::SuiX5Vault, arg1: 0x1::type_name::TypeName) {
        assert!(!0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::composition::contains(0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::vault::composition_ref(arg0), arg1), 607);
    }

    public fun current_value_of<T0>(arg0: &0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::vault::SuiX5Vault) : u64 {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::vault::balance_of<T0>(arg0);
        if (v1 == 0) {
            return 0
        };
        let v2 = 0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::vault::oracle_ref(arg0);
        let v3 = 0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::oracle::get_last_price(v2, v0);
        if (v3 == 0) {
            return 0
        };
        (((v1 as u128) * (v3 as u128) / (pow10((0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::oracle::decimals_of(v2, v0) as u64)) as u128)) as u64)
    }

    public fun drift_of(arg0: &0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::vault::SuiX5Vault, arg1: 0x1::type_name::TypeName, arg2: u64) : (u64, bool) {
        let v0 = target_value_for(arg0, arg1);
        if (v0 == 0) {
            if (arg2 == 0) {
                return (0, false)
            };
            return (10000, true)
        };
        if (arg2 >= v0) {
            (((((arg2 - v0) as u128) * (10000 as u128) / (v0 as u128)) as u64), true)
        } else {
            (((((v0 - arg2) as u128) * (10000 as u128) / (v0 as u128)) as u64), false)
        }
    }

    public fun drift_tolerance_bps() : u64 {
        200
    }

    public fun finalize<T0, T1, T2, T3, T4>(arg0: &mut 0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::vault::SuiX5Vault, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::vault::assert_not_paused(arg0);
        0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::vault::assert_can_crank(arg0, arg1, arg2);
        0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::vault::assert_nav_fresh(arg0, arg1);
        let v0 = 0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::composition::token_count(0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::vault::composition_ref(arg0));
        assert!(v0 > 0, 600);
        assert!(v0 == 5, 606);
        let v1 = leg_drift<T0>(arg0);
        let v2 = leg_drift<T1>(arg0);
        let v3 = leg_drift<T2>(arg0);
        let v4 = leg_drift<T3>(arg0);
        let v5 = leg_drift<T4>(arg0);
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
        assert!(v6 <= 200, 602);
        let v7 = 0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::vault::orphans(arg0);
        assert!(0x1::vector::is_empty<0x1::type_name::TypeName>(&v7), 607);
        let v8 = 0x2::clock::timestamp_ms(arg1);
        0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::vault::mark_rebalanced(arg0, v8);
        let v9 = RebalanceFinalized{
            caller         : 0x2::tx_context::sender(arg2),
            portfolio_usdc : 0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::vault::cached_portfolio(arg0),
            nav_per_suix5  : 0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::vault::cached_nav(arg0),
            max_drift_bps  : v6,
            timestamp_ms   : v8,
        };
        0x2::event::emit<RebalanceFinalized>(v9);
    }

    fun leg_drift<T0>(arg0: &0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::vault::SuiX5Vault) : u64 {
        let v0 = 0x1::type_name::get<T0>();
        assert_constituent(arg0, v0);
        let (v1, _) = drift_of(arg0, v0, current_value_of<T0>(arg0));
        v1
    }

    public fun leg_exit_a<T0, T1>(arg0: &mut 0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::vault::SuiX5Vault, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock) {
        0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::vault::assert_not_paused(arg0);
        0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::vault::assert_nav_fresh(arg0, arg3);
        let v0 = 0x1::type_name::get<T0>();
        assert_orphan(arg0, v0);
        let v1 = 0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::vault::balance_of<T0>(arg0);
        let v2 = 0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::trading::sell_a_for_b<T0, T1>(0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::vault::trading_ref(arg0), arg1, arg2, 0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::vault::split_balance<T0>(arg0, v1), units_for_value<T1>(arg0, current_value_of<T0>(arg0)), arg3);
        0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::vault::join_balance<T1>(arg0, v2);
        let v3 = ExitLeg{
            token        : v0,
            amount_sold  : v1,
            received     : 0x2::balance::value<T1>(&v2),
            timestamp_ms : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<ExitLeg>(v3);
    }

    public fun leg_exit_b<T0, T1>(arg0: &mut 0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::vault::SuiX5Vault, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock) {
        0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::vault::assert_not_paused(arg0);
        0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::vault::assert_nav_fresh(arg0, arg3);
        let v0 = 0x1::type_name::get<T1>();
        assert_orphan(arg0, v0);
        let v1 = 0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::vault::balance_of<T1>(arg0);
        let v2 = 0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::trading::sell_b_for_a<T0, T1>(0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::vault::trading_ref(arg0), arg1, arg2, 0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::vault::split_balance<T1>(arg0, v1), units_for_value<T0>(arg0, current_value_of<T1>(arg0)), arg3);
        0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::vault::join_balance<T0>(arg0, v2);
        let v3 = ExitLeg{
            token        : v0,
            amount_sold  : v1,
            received     : 0x2::balance::value<T0>(&v2),
            timestamp_ms : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<ExitLeg>(v3);
    }

    public fun leg_sell_a<T0, T1>(arg0: &mut 0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::vault::SuiX5Vault, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock) {
        0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::vault::assert_not_paused(arg0);
        0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::vault::assert_nav_fresh(arg0, arg3);
        let v0 = 0x1::type_name::get<T0>();
        assert_constituent(arg0, v0);
        let v1 = current_value_of<T0>(arg0);
        let (v2, v3) = drift_of(arg0, v0, v1);
        assert!(v3, 603);
        let v4 = target_value_for(arg0, v0);
        let v5 = v1 - v4;
        assert!(v5 >= 50000, 604);
        let v6 = units_for_value<T0>(arg0, v5);
        assert!(v6 > 0, 604);
        0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::vault::join_balance<T1>(arg0, 0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::trading::sell_a_for_b<T0, T1>(0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::vault::trading_ref(arg0), arg1, arg2, 0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::vault::split_balance<T0>(arg0, v6), units_for_value<T1>(arg0, v5), arg3));
        let v7 = RebalanceLeg{
            token_sold         : v0,
            token_bought       : 0x1::type_name::get<T1>(),
            current_value_usdc : v1,
            target_value_usdc  : v4,
            drift_bps          : v2,
            amount_sold        : v6,
            timestamp_ms       : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<RebalanceLeg>(v7);
    }

    public fun leg_sell_b<T0, T1>(arg0: &mut 0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::vault::SuiX5Vault, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock) {
        0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::vault::assert_not_paused(arg0);
        0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::vault::assert_nav_fresh(arg0, arg3);
        let v0 = 0x1::type_name::get<T1>();
        assert_constituent(arg0, v0);
        let v1 = current_value_of<T1>(arg0);
        let (v2, v3) = drift_of(arg0, v0, v1);
        assert!(v3, 603);
        let v4 = target_value_for(arg0, v0);
        let v5 = v1 - v4;
        assert!(v5 >= 50000, 604);
        let v6 = units_for_value<T1>(arg0, v5);
        assert!(v6 > 0, 604);
        0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::vault::join_balance<T0>(arg0, 0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::trading::sell_b_for_a<T0, T1>(0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::vault::trading_ref(arg0), arg1, arg2, 0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::vault::split_balance<T1>(arg0, v6), units_for_value<T0>(arg0, v5), arg3));
        let v7 = RebalanceLeg{
            token_sold         : v0,
            token_bought       : 0x1::type_name::get<T0>(),
            current_value_usdc : v1,
            target_value_usdc  : v4,
            drift_bps          : v2,
            amount_sold        : v6,
            timestamp_ms       : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<RebalanceLeg>(v7);
    }

    public fun min_trade_value_usdc() : u64 {
        50000
    }

    public fun needs_leg<T0>(arg0: &0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::vault::SuiX5Vault) : bool {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = current_value_of<T0>(arg0);
        let (v2, v3) = drift_of(arg0, v0, v1);
        if (!v3) {
            return false
        };
        if (v2 <= 200) {
            return false
        };
        v1 - target_value_for(arg0, v0) >= 50000
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

    public fun preview<T0>(arg0: &0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::vault::SuiX5Vault) : (u64, u64, u64, bool) {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = current_value_of<T0>(arg0);
        let (v2, v3) = drift_of(arg0, v0, v1);
        (v1, target_value_for(arg0, v0), v2, v3)
    }

    public fun skip<T0, T1, T2, T3, T4>(arg0: &mut 0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::vault::SuiX5Vault, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::vault::assert_not_paused(arg0);
        0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::vault::assert_can_crank(arg0, arg1, arg2);
        0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::vault::assert_nav_fresh(arg0, arg1);
        let v0 = leg_drift<T0>(arg0);
        let v1 = leg_drift<T1>(arg0);
        let v2 = leg_drift<T2>(arg0);
        let v3 = leg_drift<T3>(arg0);
        let v4 = leg_drift<T4>(arg0);
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
        assert!(v5 <= 200, 602);
        let v6 = 0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::vault::orphans(arg0);
        assert!(0x1::vector::is_empty<0x1::type_name::TypeName>(&v6), 607);
        let v7 = 0x2::clock::timestamp_ms(arg1);
        0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::vault::mark_rebalanced(arg0, v7);
        let v8 = RebalanceSkipped{
            caller        : 0x2::tx_context::sender(arg2),
            max_drift_bps : v5,
            timestamp_ms  : v7,
        };
        0x2::event::emit<RebalanceSkipped>(v8);
    }

    public fun target_value_for(arg0: &0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::vault::SuiX5Vault, arg1: 0x1::type_name::TypeName) : u64 {
        let v0 = 0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::vault::cached_portfolio(arg0);
        if (v0 == 0) {
            return 0
        };
        v0 * 0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::composition::weight_of(0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::vault::composition_ref(arg0), arg1) / 10000
    }

    fun units_for_value<T0>(arg0: &0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::vault::SuiX5Vault, arg1: u64) : u64 {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::vault::oracle_ref(arg0);
        let v2 = 0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::oracle::get_last_price(v1, v0);
        assert!(v2 > 0, 605);
        (((arg1 as u128) * (pow10((0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::oracle::decimals_of(v1, v0) as u64)) as u128) / (v2 as u128)) as u64)
    }

    // decompiled from Move bytecode v7
}

