module 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::state {
    struct Issuance<phantom T0> {
        vault_policy: 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::policy::VaultPolicy,
        max_order_notional: u64,
        nav_cap: u64,
        base_unit: u64,
        collateral_unit: u64,
    }

    struct State<phantom T0> has store {
        vault_policy: 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::policy::VaultPolicy,
        max_order_notional: u64,
        maintenance_reserve: u64,
        uncovered_deficit: u64,
        base_unit: u64,
        collateral_unit: u64,
        lifecycle: 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::lifecycle::Lifecycle,
        mint_fee_bps: u64,
        redeem_fee_bps: u64,
        admin_share_bps: u64,
        nav_cap: u64,
    }

    struct ActivePosition has copy, drop {
        equity: u64,
        base: u64,
        notional: u64,
        lot_size: u64,
        base_price: u64,
        collateral_price: u64,
    }

    struct MintPlan<phantom T0> {
        before: ActivePosition,
        expected_contribution: u64,
        reserve_fee: u64,
        admin_fee: u64,
        total_share_supply: u64,
        minimum_shares: u64,
        base_to_buy: u64,
    }

    struct RedemptionPlan<phantom T0> {
        before: ActivePosition,
        shares_to_redeem: u64,
        total_share_supply: u64,
        minimum_collateral_out: u64,
        fee_bps: u64,
        admin_share_bps: u64,
        base_to_sell: u64,
    }

    struct RebalancePlan<phantom T0> {
        before: ActivePosition,
        current: ActivePosition,
        reserve_priced: u64,
        increase: bool,
        emergency: bool,
        venue_fee_bps: u64,
        steps: u64,
    }

    struct RebalanceOrder has drop {
        base: u64,
        increase: bool,
        emergency: bool,
    }

    fun fee_allocation<T0>(arg0: &State<T0>, arg1: u64, arg2: bool) : (u64, u64, u64) {
        0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::accounting_math::fee_allocation(arg1, live_fee_bps<T0>(arg0, arg2), arg0.admin_share_bps)
    }

    public fun assert_active<T0>(arg0: &State<T0>) {
        0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::lifecycle::assert_active(&arg0.lifecycle);
    }

    public fun assert_can_sync<T0>(arg0: &State<T0>) {
        0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::lifecycle::assert_can_sync(&arg0.lifecycle);
    }

    public fun assert_settled<T0>(arg0: &State<T0>) {
        0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::lifecycle::assert_settled(&arg0.lifecycle);
    }

    public fun assert_unwinding<T0>(arg0: &State<T0>) {
        0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::lifecycle::assert_unwinding(&arg0.lifecycle);
    }

    public fun begin_shutdown<T0>(arg0: &mut State<T0>) {
        0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::lifecycle::begin_shutdown(&mut arg0.lifecycle);
    }

    public fun finalize_shutdown<T0>(arg0: &mut State<T0>, arg1: u64, arg2: u64) : u64 {
        assert!(arg1 >= arg2, 3);
        0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::lifecycle::finalize_shutdown(&mut arg0.lifecycle);
        arg0.maintenance_reserve = 0;
        arg1 - arg2
    }

    public fun lot_size(arg0: &ActivePosition) : u64 {
        arg0.lot_size
    }

    public fun side<T0>(arg0: &State<T0>) : 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::policy::PositionSide {
        0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::policy::side(&arg0.vault_policy)
    }

    public fun accept_rebalance_fill<T0>(arg0: &State<T0>, arg1: &mut RebalancePlan<T0>, arg2: RebalanceOrder, arg3: 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::observation::PositionObservation, arg4: u64, arg5: u64) {
        let RebalanceOrder {
            base      : v0,
            increase  : v1,
            emergency : _,
        } = arg2;
        let v3 = if (arg4 > 0) {
            if (arg4 <= v0) {
                arg4 % arg1.current.lot_size == 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v3, 51);
        let v4 = validated_active_position<T0>(arg0, arg3, arg5);
        assert!(is_same_checkpoint(&arg1.before, &v4), 50);
        let v5 = if (v1) {
            let v6 = 0x1::u64::checked_add(arg1.current.base, arg4);
            if (0x1::option::is_some<u64>(&v6)) {
                0x1::option::destroy_some<u64>(v6)
            } else {
                0x1::option::destroy_none<u64>(v6);
                abort 15
            }
        } else {
            arg1.current.base - arg4
        };
        assert!(v4.base == v5, 51);
        if (v1) {
            let v7 = 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::accounting_math::shareholder_nav(v4.equity, arg1.reserve_priced);
            let v8 = 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::policy::rebalance_policy(&arg0.vault_policy);
            assert!(0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::policy::is_leverage_at_most_target(&v8, v4.notional, v7) && 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::policy::is_leverage_below_max(&v8, v4.notional, v7), 52);
        };
        arg1.current = v4;
        arg1.steps = arg1.steps + 1;
    }

    public fun activate<T0>(arg0: Issuance<T0>, arg1: 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::observation::PositionObservation, arg2: u64, arg3: u64) : (State<T0>, u64, ActivePosition) {
        let Issuance {
            vault_policy       : v0,
            max_order_notional : v1,
            nav_cap            : v2,
            base_unit          : v3,
            collateral_unit    : v4,
        } = arg0;
        let v5 = v0;
        let v6 = State<T0>{
            vault_policy        : v5,
            max_order_notional  : v1,
            maintenance_reserve : arg2,
            uncovered_deficit   : 0,
            base_unit           : v3,
            collateral_unit     : v4,
            lifecycle           : 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::lifecycle::active(),
            mint_fee_bps        : 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::policy::initial_mint_fee_bps(&v5),
            redeem_fee_bps      : 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::policy::initial_redeem_fee_bps(&v5),
            admin_share_bps     : 0,
            nav_cap             : v2,
        };
        let v7 = 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::observation::venue_equity(&arg1);
        assert!(0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::accounting_math::is_shareholder_nav_positive(v7, arg2), 2);
        assert_observation_priced(&v6.vault_policy, &arg1, arg3);
        assert!(0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::observation::observed_side(&arg1) == 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::policy::side(&v6.vault_policy), 44);
        let v8 = 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::accounting_math::shareholder_nav(v7, arg2);
        assert_within_nav_cap<T0>(&v6, v8);
        let v9 = priced_position<T0>(&v6, arg1);
        let v10 = 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::policy::rebalance_policy(&v6.vault_policy);
        assert!(0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::policy::is_leverage_within_band(&v10, v9.notional, v8), 45);
        assert!(arg2 <= 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::policy::reserve_cap(&v6.vault_policy, v9.notional), 60);
        assert!(0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::accounting_math::is_base_above_min_order(v9.base, v9.lot_size, 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::policy::min_order_lots(&v6.vault_policy)), 46);
        (v6, v8, v9)
    }

    public fun admin_fee<T0>(arg0: &MintPlan<T0>) : u64 {
        arg0.admin_fee
    }

    fun admitted_reserve<T0>(arg0: &State<T0>, arg1: &ActivePosition) : u64 {
        reserve_within_cap<T0>(arg0, arg0.maintenance_reserve, arg1)
    }

    public fun assert_execution<T0>(arg0: &State<T0>, arg1: bool, arg2: u64, arg3: u64) {
        assert_execution_within(&arg0.vault_policy, arg1, arg2, arg3);
    }

    fun assert_execution_within(arg0: &0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::policy::VaultPolicy, arg1: bool, arg2: u64, arg3: u64) {
        let v0 = 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::policy::rebalance_policy(arg0);
        if (arg1) {
            0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::policy::assert_execution_within_emergency_max_slippage(&v0, arg2, arg3);
        } else {
            0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::policy::assert_execution_within_max_slippage(&v0, arg2, arg3);
        };
    }

    fun assert_holders_not_diluted(arg0: u64, arg1: u64, arg2: u64, arg3: u64) {
        assert_invariant((arg2 as u128) * (arg1 as u128) >= (arg0 as u128) * (arg3 as u128));
    }

    fun assert_invariant(arg0: bool) {
        assert!(arg0, 61);
    }

    fun assert_observation_priced(arg0: &0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::policy::VaultPolicy, arg1: &0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::observation::PositionObservation, arg2: u64) {
        let v0 = 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::policy::price_policy(arg0);
        assert_oracle_admitted(&v0, 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::observation::base_oracle(arg1), arg2);
        assert_oracle_admitted(&v0, 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::observation::collateral_oracle(arg1), arg2);
        0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::policy::assert_mark_within_oracle_divergence(&v0, 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::observation::mark_price(arg1), 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::observation::price(0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::observation::base_oracle(arg1)));
    }

    fun assert_oracle_admitted(arg0: &0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::policy::PricePolicy, arg1: &0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::observation::PriceObservation, arg2: u64) {
        0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::policy::assert_price_fresh(arg0, 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::observation::publish_time_ms(arg1), arg2);
        0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::policy::assert_confidence_within_bound(arg0, 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::observation::confidence(arg1), 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::observation::price(arg1));
    }

    public fun assert_order_notional_allowed<T0>(arg0: &State<T0>, arg1: u64) {
        assert_order_notional_within(arg0.max_order_notional, arg1);
    }

    fun assert_order_notional_within(arg0: u64, arg1: u64) {
        assert!(arg1 <= arg0, 43);
    }

    public fun assert_seed_execution<T0>(arg0: &Issuance<T0>, arg1: u64, arg2: u64) {
        assert_execution_within(&arg0.vault_policy, false, arg1, arg2);
    }

    public fun assert_seed_order_notional_allowed<T0>(arg0: &Issuance<T0>, arg1: u64) {
        assert_order_notional_within(arg0.max_order_notional, arg1);
    }

    fun assert_within_nav_cap<T0>(arg0: &State<T0>, arg1: u64) {
        assert!(arg1 <= arg0.nav_cap, 36);
    }

    public fun base(arg0: &ActivePosition) : u64 {
        arg0.base
    }

    fun base_for_notional(arg0: u64, arg1: &ActivePosition, arg2: u64, arg3: u64) : u64 {
        0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::rebalance_math::base_for_notional_down(arg0, arg1.base_price, arg1.collateral_price, arg1.lot_size, arg2, arg3)
    }

    public fun base_price(arg0: &ActivePosition) : u64 {
        arg0.base_price
    }

    public fun base_to_buy<T0>(arg0: &MintPlan<T0>) : u64 {
        arg0.base_to_buy
    }

    public fun base_to_sell<T0>(arg0: &RedemptionPlan<T0>) : u64 {
        arg0.base_to_sell
    }

    public fun collateral_price(arg0: &ActivePosition) : u64 {
        arg0.collateral_price
    }

    public fun complete_mint<T0>(arg0: &mut State<T0>, arg1: MintPlan<T0>, arg2: 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::observation::PositionObservation, arg3: u64) : (u64, u64, u64, u64, u64) {
        0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::lifecycle::assert_active(&arg0.lifecycle);
        let MintPlan {
            before                : v0,
            expected_contribution : v1,
            reserve_fee           : v2,
            admin_fee             : v3,
            total_share_supply    : v4,
            minimum_shares        : v5,
            base_to_buy           : v6,
        } = arg1;
        let v7 = v0;
        let v8 = validated_active_position<T0>(arg0, arg2, arg3);
        assert!(is_same_checkpoint(&v7, &v8), 50);
        assert!(v8.base >= v7.base && v8.base - v7.base == v6, 51);
        let v9 = admitted_reserve<T0>(arg0, &v7);
        let v10 = arg0;
        let v11 = 0x1::u64::checked_add(v9, v2);
        if (0x1::option::is_some<u64>(&v11)) {
            let v12 = reserve_within_cap<T0>(v10, 0x1::option::destroy_some<u64>(v11), &v8);
            let v13 = 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::accounting_math::shareholder_nav(v7.equity, v9);
            let (v14, v15, v16) = 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::accounting_math::allocated_mint_quote(v7.equity, v8.equity, v9, v12, v1, v4, v5);
            0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::accounting_math::assert_mint_base_within_bounds(v8.base, v1, v15, v7.base, v13, v7.lot_size, 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::policy::min_order_lots(&arg0.vault_policy));
            assert_within_nav_cap<T0>(arg0, v14);
            let v17 = 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::policy::rebalance_policy(&arg0.vault_policy);
            assert!(0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::accounting_math::is_accounting_leverage_below_limit(v8.notional, v8.equity, v12, 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::policy::max_leverage_bps(&v17)), 52);
            arg0.maintenance_reserve = v12;
            assert_holders_not_diluted(v13, v4, v14, v4 + v16);
            return (v16, v15, v3 + v2, v3, v2)
        } else {
            0x1::option::destroy_none<u64>(v11);
            abort 15
        };
    }

    public fun complete_rebalance<T0>(arg0: &State<T0>, arg1: RebalancePlan<T0>) : (u64, u64, u64, u64, bool) {
        0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::lifecycle::assert_active(&arg0.lifecycle);
        let RebalancePlan {
            before         : v0,
            current        : v1,
            reserve_priced : v2,
            increase       : v3,
            emergency      : _,
            venue_fee_bps  : _,
            steps          : v6,
        } = arg1;
        let v7 = v1;
        let v8 = v0;
        assert!(v6 > 0, 55);
        let v9 = 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::policy::rebalance_policy(&arg0.vault_policy);
        assert!(v3 && v7.base > v8.base && 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::rebalance_math::leverage_rose(v8.notional, 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::accounting_math::shareholder_nav(v8.equity, v2), v7.notional, 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::accounting_math::shareholder_nav(v7.equity, v2)) || v7.base < v8.base && 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::rebalance_math::reduction_is_sufficient(v8.notional, 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::accounting_math::shareholder_nav(v8.equity, v2), v7.notional, 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::accounting_math::shareholder_nav(v7.equity, v2), 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::policy::target_leverage_bps(&v9), 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::policy::min_leverage_improvement_bps(&v9), 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::rebalance_math::oracle_notional_up(v7.lot_size, v7.base_price, v7.collateral_price, arg0.base_unit, arg0.collateral_unit)), 55);
        (v8.equity, v7.equity, v8.base, v7.base, v3)
    }

    public fun complete_redemption<T0>(arg0: &mut State<T0>, arg1: RedemptionPlan<T0>, arg2: 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::observation::PositionObservation, arg3: u64) : (u64, u64, u64, u64) {
        0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::lifecycle::assert_active(&arg0.lifecycle);
        let RedemptionPlan {
            before                 : v0,
            shares_to_redeem       : v1,
            total_share_supply     : v2,
            minimum_collateral_out : v3,
            fee_bps                : v4,
            admin_share_bps        : v5,
            base_to_sell           : v6,
        } = arg1;
        let v7 = v0;
        let v8 = validated_active_position<T0>(arg0, arg2, arg3);
        assert!(is_same_checkpoint(&v7, &v8), 50);
        assert!(v7.base >= v8.base && v7.base - v8.base == v6, 51);
        0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::accounting_math::assert_redemption_base_within_bounds(v8.base, v1, v7.base, v2, v7.lot_size, 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::policy::min_order_lots(&arg0.vault_policy));
        let v9 = admitted_reserve<T0>(arg0, &v7);
        let (v10, v11, v12, v13) = 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::accounting_math::redemption_accounting_quote(v1, v7.equity, v8.equity, v9, v2, v4);
        assert!(v13 >= v3, 53);
        let v14 = 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::accounting_math::admin_share_down(v12, v5);
        let v15 = v10 - v14;
        assert!(v11 <= 18446744073709551615 - v15, 15);
        arg0.maintenance_reserve = reserve_within_cap<T0>(arg0, v15, &v8);
        assert_holders_not_diluted(0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::accounting_math::shareholder_nav(v7.equity, v9), v2, v11, v2 - v1);
        (v13, v14, v12, v12 - v14)
    }

    public fun donate<T0>(arg0: &mut State<T0>, arg1: 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::observation::PositionObservation, arg2: u64, arg3: u64) {
        0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::lifecycle::assert_active(&arg0.lifecycle);
        assert!(arg2 > 0, 0);
        let v0 = validated_active_position<T0>(arg0, arg1, arg3);
        let v1 = 0x1::u64::checked_add(arg0.maintenance_reserve, arg2);
        if (0x1::option::is_some<u64>(&v1)) {
            let v2 = 0x1::option::destroy_some<u64>(v1);
            arg0.maintenance_reserve = reserve_within_cap<T0>(arg0, v2, &v0);
            let v3 = arg0.maintenance_reserve <= v2 && arg0.maintenance_reserve <= v0.equity;
            assert_invariant(v3);
            return
        } else {
            0x1::option::destroy_none<u64>(v1);
            abort 15
        };
    }

    public fun equity(arg0: &ActivePosition) : u64 {
        arg0.equity
    }

    fun flat_position(arg0: 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::observation::PositionObservation) : ActivePosition {
        ActivePosition{
            equity           : 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::observation::venue_equity(&arg0),
            base             : 0,
            notional         : 0,
            lot_size         : 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::observation::lot_size(&arg0),
            base_price       : 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::observation::price(0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::observation::base_oracle(&arg0)),
            collateral_price : 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::observation::price(0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::observation::collateral_oracle(&arg0)),
        }
    }

    fun increase_order<T0>(arg0: &State<T0>, arg1: &ActivePosition, arg2: u64, arg3: u64) : u64 {
        let v0 = 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::policy::rebalance_policy(&arg0.vault_policy);
        0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::rebalance_math::increase_base_down(arg2, arg1.notional, 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::policy::target_leverage_bps(&v0), arg1.base_price, arg1.collateral_price, arg1.lot_size, arg0.max_order_notional, arg3, 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::policy::max_slippage_bps(&v0), arg0.base_unit, arg0.collateral_unit)
    }

    public fun is_emergency(arg0: &RebalanceOrder) : bool {
        arg0.emergency
    }

    public fun is_increase(arg0: &RebalanceOrder) : bool {
        arg0.increase
    }

    public fun is_increasing<T0>(arg0: &RebalancePlan<T0>) : bool {
        arg0.increase
    }

    fun is_same_checkpoint(arg0: &ActivePosition, arg1: &ActivePosition) : bool {
        if (arg0.base_price == arg1.base_price) {
            if (arg0.collateral_price == arg1.collateral_price) {
                arg0.lot_size == arg1.lot_size
            } else {
                false
            }
        } else {
            false
        }
    }

    fun is_within_band<T0>(arg0: &State<T0>, arg1: &ActivePosition, arg2: u64) : bool {
        let v0 = 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::policy::rebalance_policy(&arg0.vault_policy);
        0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::policy::is_leverage_within_band(&v0, arg1.notional, 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::accounting_math::shareholder_nav(arg1.equity, arg2))
    }

    public fun issue<T0>(arg0: &0x247b6e2f000a77e82f4afc5c08f95f746e2e132ba2e1ecb3a9082f0c41ab80e2::acl::AdminWitness<0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::blast_boosts_core::BLAST_BOOSTS_CORE>, arg1: 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::policy::VaultPolicy, arg2: u64, arg3: u64, arg4: u8, arg5: u8) : Issuance<T0> {
        0x247b6e2f000a77e82f4afc5c08f95f746e2e132ba2e1ecb3a9082f0c41ab80e2::acl::assert_role<0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::blast_boosts_core::BLAST_BOOSTS_CORE>(arg0, 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::blast_boosts_core::vault_issuer_role());
        assert!(arg2 > 0, 39);
        let v0 = 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::policy::rebalance_policy(&arg1);
        0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::policy::assert_nav_cap_valid(&v0, arg3);
        assert!(arg4 <= 18 && arg5 <= 18, 57);
        Issuance<T0>{
            vault_policy       : arg1,
            max_order_notional : arg2,
            nav_cap            : arg3,
            base_unit          : 0x1::u64::pow(10, arg4),
            collateral_unit    : 0x1::u64::pow(10, arg5),
        }
    }

    fun live_fee_bps<T0>(arg0: &State<T0>, arg1: bool) : u64 {
        if (arg1) {
            arg0.mint_fee_bps
        } else {
            arg0.redeem_fee_bps
        }
    }

    public fun maintenance_reserve<T0>(arg0: &State<T0>) : u64 {
        arg0.maintenance_reserve
    }

    public fun max_order_base<T0>(arg0: &State<T0>, arg1: &ActivePosition) : u64 {
        base_for_notional(arg0.max_order_notional, arg1, arg0.base_unit, arg0.collateral_unit)
    }

    public fun mint_position<T0>(arg0: &MintPlan<T0>) : ActivePosition {
        arg0.before
    }

    public fun needs_rebalance<T0>(arg0: &State<T0>, arg1: 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::observation::PositionObservation, arg2: u64) : bool {
        0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::lifecycle::assert_active(&arg0.lifecycle);
        let v0 = validated_active_position<T0>(arg0, arg1, arg2);
        !is_within_band<T0>(arg0, &v0, admitted_reserve<T0>(arg0, &v0))
    }

    public fun next_rebalance_order<T0>(arg0: &State<T0>, arg1: &RebalancePlan<T0>) : RebalanceOrder {
        let v0 = &arg1.current;
        let v1 = 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::accounting_math::shareholder_nav(v0.equity, arg1.reserve_priced);
        if (arg1.increase) {
            return RebalanceOrder{
                base      : increase_order<T0>(arg0, v0, v1, arg1.venue_fee_bps),
                increase  : true,
                emergency : false,
            }
        };
        let v2 = 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::policy::rebalance_policy(&arg0.vault_policy);
        if (arg1.emergency && !0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::policy::is_leverage_above_max(&v2, v0.notional, v1)) {
            return RebalanceOrder{
                base      : 0,
                increase  : false,
                emergency : false,
            }
        };
        RebalanceOrder{
            base      : reduction_order<T0>(arg0, v0, v1),
            increase  : false,
            emergency : arg1.emergency,
        }
    }

    public fun notional(arg0: &ActivePosition) : u64 {
        arg0.notional
    }

    public fun order_base(arg0: &RebalanceOrder) : u64 {
        arg0.base
    }

    public fun prepare_mint<T0>(arg0: &State<T0>, arg1: 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::observation::PositionObservation, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : MintPlan<T0> {
        0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::lifecycle::assert_active(&arg0.lifecycle);
        assert!(arg3 > 0, 3);
        let v0 = validated_active_position<T0>(arg0, arg1, arg5);
        let v1 = admitted_reserve<T0>(arg0, &v0);
        assert!(is_within_band<T0>(arg0, &v0, v1), 49);
        let (v2, v3, v4) = fee_allocation<T0>(arg0, arg2, true);
        let v5 = arg2 - v2;
        assert!(v5 > 0, 5);
        MintPlan<T0>{
            before                : v0,
            expected_contribution : v5,
            reserve_fee           : v4,
            admin_fee             : v3,
            total_share_supply    : arg3,
            minimum_shares        : arg4,
            base_to_buy           : 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::accounting_math::mint_base_to_buy_down(v5, v0.base, 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::accounting_math::shareholder_nav(v0.equity, v1), v0.lot_size, 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::policy::min_order_lots(&arg0.vault_policy)),
        }
    }

    public fun prepare_rebalance<T0>(arg0: &State<T0>, arg1: 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::observation::PositionObservation, arg2: u64, arg3: u64) : RebalancePlan<T0> {
        0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::lifecycle::assert_active(&arg0.lifecycle);
        assert!(arg2 <= 10000, 56);
        let v0 = validated_active_position<T0>(arg0, arg1, arg3);
        let v1 = admitted_reserve<T0>(arg0, &v0);
        assert!(!is_within_band<T0>(arg0, &v0, v1), 54);
        let v2 = 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::accounting_math::shareholder_nav(v0.equity, v1);
        let v3 = 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::policy::rebalance_policy(&arg0.vault_policy);
        let v4 = 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::policy::is_leverage_below_band(&v3, v0.notional, v2);
        let v5 = !v4 && 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::policy::is_leverage_above_max(&v3, v0.notional, v2);
        RebalancePlan<T0>{
            before         : v0,
            current        : v0,
            reserve_priced : v1,
            increase       : v4,
            emergency      : v5,
            venue_fee_bps  : arg2,
            steps          : 0,
        }
    }

    public fun prepare_redemption<T0>(arg0: &State<T0>, arg1: 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::observation::PositionObservation, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : RedemptionPlan<T0> {
        0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::lifecycle::assert_active(&arg0.lifecycle);
        let v0 = validated_active_position<T0>(arg0, arg1, arg5);
        let (v1, _) = 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::accounting_math::redemption_base_bounds(arg2, v0.base, arg3, v0.lot_size, 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::policy::min_order_lots(&arg0.vault_policy));
        RedemptionPlan<T0>{
            before                 : v0,
            shares_to_redeem       : arg2,
            total_share_supply     : arg3,
            minimum_collateral_out : arg4,
            fee_bps                : arg0.redeem_fee_bps,
            admin_share_bps        : arg0.admin_share_bps,
            base_to_sell           : v0.base - v1,
        }
    }

    fun priced_position<T0>(arg0: &State<T0>, arg1: 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::observation::PositionObservation) : ActivePosition {
        let v0 = 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::observation::price(0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::observation::base_oracle(&arg1));
        let v1 = 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::observation::price(0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::observation::collateral_oracle(&arg1));
        let v2 = 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::observation::position_base(&arg1);
        ActivePosition{
            equity           : 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::observation::venue_equity(&arg1),
            base             : v2,
            notional         : 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::rebalance_math::oracle_notional_up(v2, v0, v1, arg0.base_unit, arg0.collateral_unit),
            lot_size         : 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::observation::lot_size(&arg1),
            base_price       : v0,
            collateral_price : v1,
        }
    }

    public fun rebalance_position<T0>(arg0: &RebalancePlan<T0>) : ActivePosition {
        arg0.before
    }

    public fun redemption_position<T0>(arg0: &RedemptionPlan<T0>) : ActivePosition {
        arg0.before
    }

    public fun redemption_shares<T0>(arg0: &RedemptionPlan<T0>) : u64 {
        arg0.shares_to_redeem
    }

    fun reduction_order<T0>(arg0: &State<T0>, arg1: &ActivePosition, arg2: u64) : u64 {
        let v0 = 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::policy::rebalance_policy(&arg0.vault_policy);
        let v1 = base_for_notional(0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::accounting_math::target_notional_down(arg2, 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::policy::target_leverage_bps(&v0)), arg1, arg0.base_unit, arg0.collateral_unit);
        if (arg1.base <= v1) {
            return 0
        };
        0x1::u64::min(arg1.base - v1, max_order_base<T0>(arg0, arg1)) / arg1.lot_size * arg1.lot_size
    }

    fun reserve_within_cap<T0>(arg0: &State<T0>, arg1: u64, arg2: &ActivePosition) : u64 {
        if (arg2.notional == 0) {
            arg1
        } else {
            0x1::u64::min(arg1, 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::policy::reserve_cap(&arg0.vault_policy, arg2.notional))
        }
    }

    public fun seed_side<T0>(arg0: &Issuance<T0>) : 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::policy::PositionSide {
        0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::policy::side(&arg0.vault_policy)
    }

    public fun seed_terms<T0>(arg0: &Issuance<T0>, arg1: 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::observation::PositionObservation, arg2: u64) : (u64, u64, ActivePosition) {
        let v0 = 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::policy::rebalance_policy(&arg0.vault_policy);
        let v1 = flat_position(arg1);
        (base_for_notional(0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::accounting_math::target_notional_down(0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::accounting_math::shareholder_nav(0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::observation::venue_equity(&arg1), arg2), 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::policy::target_leverage_bps(&v0)), &v1, arg0.base_unit, arg0.collateral_unit), base_for_notional(arg0.max_order_notional, &v1, arg0.base_unit, arg0.collateral_unit), v1)
    }

    public fun set_fees<T0>(arg0: &mut State<T0>, arg1: u64, arg2: u64, arg3: u64) : (u64, u64, u64) {
        0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::lifecycle::assert_active(&arg0.lifecycle);
        0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::policy::assert_fee_limits(&arg0.vault_policy, arg1, arg2, arg3);
        let v0 = arg0.mint_fee_bps;
        let v1 = arg0.redeem_fee_bps;
        let v2 = arg0.admin_share_bps;
        let v3 = if (v0 != arg1) {
            true
        } else if (v1 != arg2) {
            true
        } else {
            v2 != arg3
        };
        assert!(v3, 48);
        arg0.mint_fee_bps = arg1;
        arg0.redeem_fee_bps = arg2;
        arg0.admin_share_bps = arg3;
        (v0, v1, v2)
    }

    public fun set_max_order_notional<T0>(arg0: &mut State<T0>, arg1: u64) : u64 {
        let v0 = arg0.max_order_notional;
        assert!(arg1 != v0, 40);
        assert!(arg1 > 0, 39);
        arg0.max_order_notional = arg1;
        v0
    }

    public fun set_nav_cap<T0>(arg0: &mut State<T0>, arg1: u64) : u64 {
        let v0 = arg0.nav_cap;
        assert!(arg1 != v0, 58);
        let v1 = 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::policy::rebalance_policy(&arg0.vault_policy);
        0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::policy::assert_nav_cap_valid(&v1, arg1);
        arg0.nav_cap = arg1;
        v0
    }

    public fun settle_funding<T0>(arg0: &mut State<T0>, arg1: 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::observation::FundingSettlement) : (u64, u64, u64) {
        0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::lifecycle::assert_can_sync(&arg0.lifecycle);
        let v0 = 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::observation::amount(&arg1);
        let v1 = arg0.maintenance_reserve;
        let (v2, v3, v4) = if (0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::observation::is_cost(&arg1)) {
            let (v5, v6, v7) = 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::accounting_math::absorb_funding_cost(v1, v0);
            arg0.maintenance_reserve = v5;
            let v8 = 0x1::u64::checked_add(arg0.uncovered_deficit, v7);
            if (0x1::option::is_some<u64>(&v8)) {
                arg0.uncovered_deficit = 0x1::option::destroy_some<u64>(v8);
                let v9 = v5 + v6 == v1 && v6 + v7 == v0;
                assert_invariant(v9);
                (0, v6, v7)
            } else {
                0x1::option::destroy_none<u64>(v8);
                abort 15
            }
        } else {
            let v10 = 0x1::u64::min(v0, arg0.uncovered_deficit);
            arg0.uncovered_deficit = arg0.uncovered_deficit - v10;
            let v11 = 0x1::u64::checked_add(v1, v0 - v10);
            if (0x1::option::is_some<u64>(&v11)) {
                arg0.maintenance_reserve = 0x1::option::destroy_some<u64>(v11);
                assert_invariant(arg0.maintenance_reserve + v10 == v1 + v0);
                (v10, 0, 0)
            } else {
                0x1::option::destroy_none<u64>(v11);
                abort 15
            }
        };
        (v3, v4, v2)
    }

    public fun shutdown_claim_quote<T0>(arg0: &State<T0>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : u64 {
        0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::lifecycle::assert_settled(&arg0.lifecycle);
        assert!(arg2 >= arg3, 3);
        let v0 = arg2 - arg3;
        assert!(arg4 > 0 && arg4 <= v0, 4);
        let v1 = 0x1::u64::mul_div(arg1, arg4, v0);
        assert!(arg1 == 0 || v1 > 0, 8);
        assert!(v1 >= arg5, 53);
        v1
    }

    public fun unwind_constraints<T0>(arg0: &State<T0>, arg1: 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::observation::PriceObservation, arg2: 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::observation::PriceObservation, arg3: u64, arg4: u64) : (0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::policy::PositionSide, u64, u64, u64) {
        assert_unwinding<T0>(arg0);
        let v0 = 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::policy::price_policy(&arg0.vault_policy);
        assert_oracle_admitted(&v0, &arg1, arg4);
        assert_oracle_admitted(&v0, &arg2, arg4);
        let v1 = 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::observation::price(&arg1);
        let v2 = 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::observation::price(&arg2);
        (0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::policy::side(&arg0.vault_policy), 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::rebalance_math::base_for_notional_down(arg0.max_order_notional, v1, v2, arg3, arg0.base_unit, arg0.collateral_unit), v1, v2)
    }

    fun validated_active_position<T0>(arg0: &State<T0>, arg1: 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::observation::PositionObservation, arg2: u64) : ActivePosition {
        assert_observation_priced(&arg0.vault_policy, &arg1, arg2);
        assert!(0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::observation::position_base(&arg1) == 0 || 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::observation::observed_side(&arg1) == 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::policy::side(&arg0.vault_policy), 42);
        let v0 = priced_position<T0>(arg0, arg1);
        assert!(0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::accounting_math::is_shareholder_nav_positive(v0.equity, admitted_reserve<T0>(arg0, &v0)), 2);
        v0
    }

    // decompiled from Move bytecode v7
}

