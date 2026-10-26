module 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::state {
    struct Issuance<phantom T0> {
        vault_policy: 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::VaultPolicy,
        max_order_notional: u64,
        nav_cap: u64,
        base_unit: u64,
        collateral_unit: u64,
    }

    struct State<phantom T0> has store {
        vault_policy: 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::VaultPolicy,
        max_order_notional: u64,
        maintenance_reserve: u64,
        uncovered_deficit: u64,
        base_unit: u64,
        collateral_unit: u64,
        lifecycle: 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::lifecycle::Lifecycle,
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
        recovery: bool,
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
        full_fills: bool,
        band_landing: bool,
    }

    struct RebalanceOrder has drop {
        base: u64,
        increase: bool,
        emergency: bool,
        bound: 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::ExecutionBound,
        band_landing: bool,
    }

    struct ProfitRealizationPlan<phantom T0> {
        before: ActivePosition,
        base_to_realize: u64,
        max_cost: u64,
        reserve_priced: u64,
    }

    fun fee_allocation<T0>(arg0: &State<T0>, arg1: u64, arg2: bool) : (u64, u64, u64) {
        0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::accounting_math::fee_allocation(arg1, live_fee_bps<T0>(arg0, arg2), arg0.admin_share_bps)
    }

    public fun assert_active<T0>(arg0: &State<T0>) {
        0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::lifecycle::assert_active(&arg0.lifecycle);
    }

    public fun assert_can_sync<T0>(arg0: &State<T0>) {
        0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::lifecycle::assert_can_sync(&arg0.lifecycle);
    }

    public fun assert_settled<T0>(arg0: &State<T0>) {
        0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::lifecycle::assert_settled(&arg0.lifecycle);
    }

    public fun assert_unwinding<T0>(arg0: &State<T0>) {
        0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::lifecycle::assert_unwinding(&arg0.lifecycle);
    }

    public fun begin_protected_shutdown<T0>(arg0: &mut State<T0>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::lifecycle::assert_active(&arg0.lifecycle);
        assert!(0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::accounting_math::is_redemption_size_locked(arg1, arg3, arg4, arg2, 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::min_order_lots(&arg0.vault_policy)), 71);
        0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::lifecycle::begin_protected_shutdown(&mut arg0.lifecycle, arg5);
    }

    public fun begin_shutdown<T0>(arg0: &mut State<T0>, arg1: u64) {
        0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::lifecycle::begin_shutdown(&mut arg0.lifecycle, arg1);
    }

    public fun finalize_shutdown<T0>(arg0: &mut State<T0>, arg1: u64, arg2: u64, arg3: u64) : (u64, u64, u64) {
        assert!(arg1 >= arg2, 3);
        let v0 = arg1 - arg2;
        let (v1, v2) = if (0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::lifecycle::protects_shutdown_balances(&arg0.lifecycle)) {
            assert!(arg2 > 0 && v0 > 0, 3);
            let v3 = 0x1::u64::min(arg0.maintenance_reserve, arg3);
            let v4 = arg3 - v3;
            (v3, v4 - 0x1::u64::mul_div(v4, v0, arg1))
        } else {
            (0, 0)
        };
        0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::lifecycle::finalize_shutdown(&mut arg0.lifecycle);
        arg0.maintenance_reserve = 0;
        (v0, v1, v2)
    }

    public fun lot_size(arg0: &ActivePosition) : u64 {
        arg0.lot_size
    }

    public fun assert_initial_margin_headroom<T0>(arg0: &Issuance<T0>, arg1: u64, arg2: u64, arg3: u64) {
        0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::assert_initial_margin_headroom(&arg0.vault_policy, arg1, arg2, arg3);
    }

    public fun execution_bound<T0>(arg0: &State<T0>) : 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::ExecutionBound {
        let v0 = 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::rebalance_policy(&arg0.vault_policy);
        0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::execution_bound(&v0, false)
    }

    public fun side<T0>(arg0: &State<T0>) : 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::PositionSide {
        0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::side(&arg0.vault_policy)
    }

    fun reduction_matches_capacity<T0>(arg0: &State<T0>, arg1: &ActivePosition, arg2: &ActivePosition, arg3: u64) : bool {
        let v0 = 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::rebalance_policy(&arg0.vault_policy);
        let v1 = *arg1;
        let v2 = 0;
        while (v2 < max_rebalance_orders()) {
            let v3 = reduction_order<T0>(arg0, &v1, arg0.maintenance_reserve, false, arg3);
            if (v3 == 0) {
                break
            };
            let v4 = 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::rebalance_math::execution_cost_up(0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::rebalance_math::oracle_notional_up(v3, arg1.base_price, arg1.collateral_price, arg0.base_unit, arg0.collateral_unit), arg3, 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::max_slippage_bps(&v0));
            if (v4 >= (v1.equity as u128)) {
                return false
            };
            v1.equity = v1.equity - (v4 as u64);
            v1.base = v1.base - v3;
            v1.notional = 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::rebalance_math::oracle_notional_up(v1.base, arg1.base_price, arg1.collateral_price, arg0.base_unit, arg0.collateral_unit);
            if (!0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::accounting_math::is_shareholder_nav_positive(v1.equity, admitted_reserve<T0>(arg0, &v1))) {
                return false
            };
            v2 = v2 + 1;
        };
        0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::rebalance_math::reduction_matches_capacity(arg1.notional, 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::accounting_math::shareholder_nav(arg1.equity, admitted_reserve<T0>(arg0, arg1)), arg2.notional, 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::accounting_math::shareholder_nav(arg2.equity, admitted_reserve<T0>(arg0, arg2)), v1.notional, 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::accounting_math::shareholder_nav(v1.equity, admitted_reserve<T0>(arg0, &v1)), 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::target_leverage_bps(&v0))
    }

    public fun accept_rebalance_fill<T0>(arg0: &State<T0>, arg1: &mut RebalancePlan<T0>, arg2: RebalanceOrder, arg3: 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::observation::PositionObservation, arg4: u64, arg5: u64) {
        let RebalanceOrder {
            base         : v0,
            increase     : v1,
            emergency    : v2,
            bound        : _,
            band_landing : v4,
        } = arg2;
        assert!(arg1.steps < max_rebalance_orders(), 70);
        assert!(v1 == arg1.increase && v2 == arg1.emergency, 72);
        let v5 = if (arg4 > 0) {
            if (arg4 <= v0) {
                arg4 % arg1.current.lot_size == 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v5, 51);
        let v6 = if (arg1.emergency) {
            validated_oracle_position<T0>(arg0, arg3, arg0.maintenance_reserve, arg5)
        } else {
            validated_active_position<T0>(arg0, arg3, arg5)
        };
        let v7 = v6;
        assert!(is_same_checkpoint(&arg1.before, &v7), 50);
        let v8 = if (arg1.increase) {
            let v9 = 0x1::u64::checked_add(arg1.current.base, arg4);
            if (0x1::option::is_some<u64>(&v9)) {
                0x1::option::destroy_some<u64>(v9)
            } else {
                0x1::option::destroy_none<u64>(v9);
                abort 15
            }
        } else {
            arg1.current.base - arg4
        };
        assert!(v7.base == v8, 51);
        if (arg1.increase) {
            assert_increase_leverage<T0>(arg0, &v7, v4);
            arg1.band_landing = v4;
        };
        let v10 = if (!arg1.emergency) {
            if (!arg1.increase) {
                if (arg1.full_fills) {
                    if (arg4 == v0) {
                        let v11 = next_rebalance_order<T0>(arg0, arg1);
                        arg4 == v11.base
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        arg1.full_fills = v10;
        arg1.current = v7;
        arg1.steps = arg1.steps + 1;
    }

    public fun activate<T0>(arg0: Issuance<T0>, arg1: 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::observation::PositionObservation, arg2: u64, arg3: u64) : (State<T0>, u64, ActivePosition) {
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
            lifecycle           : 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::lifecycle::active(),
            mint_fee_bps        : 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::initial_mint_fee_bps(&v5),
            redeem_fee_bps      : 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::initial_redeem_fee_bps(&v5),
            admin_share_bps     : 0,
            nav_cap             : v2,
        };
        let v7 = 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::observation::venue_equity(&arg1);
        assert!(0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::accounting_math::is_shareholder_nav_positive(v7, arg2), 2);
        assert_observation_priced(&v6.vault_policy, &arg1, arg3);
        assert!(0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::observation::observed_side(&arg1) == 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::side(&v6.vault_policy), 44);
        let v8 = 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::accounting_math::shareholder_nav(v7, arg2);
        assert_within_nav_cap<T0>(&v6, v8);
        let v9 = priced_position<T0>(&v6, arg1);
        let v10 = 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::rebalance_policy(&v6.vault_policy);
        assert!(0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::is_leverage_within_band(&v10, v9.notional, v8), 45);
        assert!(arg2 <= 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::reserve_cap(&v6.vault_policy, v9.notional), 60);
        assert!(0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::accounting_math::is_base_above_min_order(v9.base, v9.lot_size, 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::min_order_lots(&v6.vault_policy)), 46);
        (v6, v8, v9)
    }

    fun active_position<T0>(arg0: &State<T0>, arg1: 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::observation::PositionObservation, arg2: u64) : ActivePosition {
        assert!(0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::observation::position_base(&arg1) == 0 || 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::observation::observed_side(&arg1) == 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::side(&arg0.vault_policy), 42);
        let v0 = priced_position<T0>(arg0, arg1);
        assert!(0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::accounting_math::is_shareholder_nav_positive(v0.equity, reserve_within_cap<T0>(arg0, arg2, &v0)), 2);
        v0
    }

    public fun admin_fee<T0>(arg0: &MintPlan<T0>) : u64 {
        arg0.admin_fee
    }

    fun admitted_reserve<T0>(arg0: &State<T0>, arg1: &ActivePosition) : u64 {
        reserve_within_cap<T0>(arg0, arg0.maintenance_reserve, arg1)
    }

    fun assert_holders_not_diluted(arg0: u64, arg1: u64, arg2: u64, arg3: u64) {
        assert_invariant((arg2 as u128) * (arg1 as u128) >= (arg0 as u128) * (arg3 as u128));
    }

    fun assert_increase_leverage<T0>(arg0: &State<T0>, arg1: &ActivePosition, arg2: bool) {
        let v0 = 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::accounting_math::shareholder_nav(arg1.equity, admitted_reserve<T0>(arg0, arg1));
        let v1 = 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::rebalance_policy(&arg0.vault_policy);
        if (arg2) {
            assert!(0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::is_leverage_within_band(&v1, arg1.notional, v0), 68);
        } else {
            assert!(0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::is_leverage_at_most_target(&v1, arg1.notional, v0) && 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::is_leverage_below_max(&v1, arg1.notional, v0), 52);
        };
    }

    fun assert_invariant(arg0: bool) {
        assert!(arg0, 61);
    }

    public fun assert_max_order_notional_update<T0>(arg0: &State<T0>, arg1: u64) {
        assert!(arg1 != arg0.max_order_notional, 40);
        assert!(arg1 > 0, 39);
        let v0 = 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::rebalance_policy(&arg0.vault_policy);
        0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::assert_rebalance_capacity(&v0, arg1, arg0.nav_cap);
    }

    fun assert_minimum_order_capacity(arg0: u64, arg1: u64, arg2: u64) {
        assert!(arg0 / arg1 >= arg2, 63);
    }

    fun assert_observation_oracles(arg0: &0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::PricePolicy, arg1: &0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::observation::PositionObservation, arg2: u64) {
        assert_oracle_admitted(arg0, 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::observation::base_oracle(arg1), arg2);
        assert_oracle_admitted(arg0, 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::observation::collateral_oracle(arg1), arg2);
    }

    fun assert_observation_priced(arg0: &0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::VaultPolicy, arg1: &0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::observation::PositionObservation, arg2: u64) {
        let v0 = 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::price_policy(arg0);
        assert_observation_oracles(&v0, arg1, arg2);
        0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::assert_mark_within_oracle_divergence(&v0, 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::observation::mark_price(arg1), 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::observation::price(0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::observation::base_oracle(arg1)));
    }

    fun assert_oracle_admitted(arg0: &0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::PricePolicy, arg1: &0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::observation::PriceObservation, arg2: u64) {
        0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::assert_price_fresh(arg0, 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::observation::publish_time_ms(arg1), arg2);
        0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::assert_confidence_within_bound(arg0, 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::observation::confidence(arg1), 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::observation::price(arg1));
    }

    public fun assert_order_notional_allowed<T0>(arg0: &State<T0>, arg1: u64, arg2: u64, arg3: u64, arg4: bool) {
        let v0 = if (arg1 <= arg0.max_order_notional) {
            true
        } else if (arg4) {
            if (arg3 > 0) {
                arg2 == arg3
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 43);
    }

    fun assert_order_notional_within(arg0: u64, arg1: u64) {
        assert!(arg1 <= arg0, 43);
    }

    fun assert_realization_leverage<T0>(arg0: &State<T0>, arg1: &ActivePosition, arg2: u64) {
        let v0 = 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::rebalance_policy(&arg0.vault_policy);
        assert!(!0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::is_leverage_above_max(&v0, arg1.notional, 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::accounting_math::shareholder_nav(arg1.equity, arg2)), 52);
    }

    public fun assert_recoverable_position<T0>(arg0: &State<T0>, arg1: 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::observation::PositionObservation, arg2: u64) {
        0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::lifecycle::assert_active(&arg0.lifecycle);
        validated_active_position<T0>(arg0, arg1, arg2);
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
        0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::rebalance_math::base_for_oracle_notional_down(arg0, arg1.base_price, arg1.collateral_price, arg1.lot_size, arg2, arg3)
    }

    public fun base_price(arg0: &ActivePosition) : u64 {
        arg0.base_price
    }

    public fun base_to_buy<T0>(arg0: &MintPlan<T0>) : u64 {
        arg0.base_to_buy
    }

    public fun base_to_realize<T0>(arg0: &ProfitRealizationPlan<T0>) : u64 {
        arg0.base_to_realize
    }

    public fun base_to_sell<T0>(arg0: &RedemptionPlan<T0>) : u64 {
        arg0.base_to_sell
    }

    public fun bound(arg0: &RebalanceOrder) : 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::ExecutionBound {
        arg0.bound
    }

    public fun collateral_price(arg0: &ActivePosition) : u64 {
        arg0.collateral_price
    }

    public fun complete_mint<T0>(arg0: &mut State<T0>, arg1: MintPlan<T0>, arg2: 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::observation::PositionObservation, arg3: u64) : (u64, u64, u64, u64, u64) {
        0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::lifecycle::assert_active(&arg0.lifecycle);
        let MintPlan {
            before                : v0,
            expected_contribution : v1,
            reserve_fee           : v2,
            admin_fee             : v3,
            total_share_supply    : v4,
            minimum_shares        : v5,
            base_to_buy           : v6,
            recovery              : v7,
        } = arg1;
        let v8 = v0;
        let v9 = validated_active_position<T0>(arg0, arg2, arg3);
        assert!(is_same_checkpoint(&v8, &v9), 50);
        assert!(v9.base >= v8.base && v9.base - v8.base == v6, 51);
        let v10 = admitted_reserve<T0>(arg0, &v8);
        let v11 = arg0;
        let v12 = 0x1::u64::checked_add(v10, v2);
        if (0x1::option::is_some<u64>(&v12)) {
            let v13 = reserve_within_cap<T0>(v11, 0x1::option::destroy_some<u64>(v12), &v9);
            let v14 = 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::accounting_math::shareholder_nav(v8.equity, v10);
            let (v15, v16, v17) = 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::accounting_math::allocated_mint_quote(v8.equity, v9.equity, v10, v13, v1, v4, v5);
            if (v7) {
                assert!(v6 >= 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::accounting_math::mint_base_to_buy_down(v16, v8.base, v14, v8.lot_size, 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::min_order_lots(&arg0.vault_policy)), 20);
            } else {
                0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::accounting_math::assert_mint_base_within_bounds(v9.base, v1, v16, v8.base, v14, v8.lot_size, 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::min_order_lots(&arg0.vault_policy));
            };
            assert_within_nav_cap<T0>(arg0, v15);
            assert!(is_within_band<T0>(arg0, &v9, v13), 49);
            arg0.maintenance_reserve = v13;
            assert_holders_not_diluted(v14, v4, v15, v4 + v17);
            return (v17, v16, v3 + v2, v3, v2)
        } else {
            0x1::option::destroy_none<u64>(v12);
            abort 15
        };
    }

    public fun complete_profit_realization<T0>(arg0: &State<T0>, arg1: ProfitRealizationPlan<T0>, arg2: 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::observation::PositionObservation, arg3: u64) : (u64, u64, u64, u64) {
        0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::lifecycle::assert_active(&arg0.lifecycle);
        let ProfitRealizationPlan {
            before          : v0,
            base_to_realize : v1,
            max_cost        : v2,
            reserve_priced  : v3,
        } = arg1;
        let v4 = v0;
        let v5 = validated_active_position<T0>(arg0, arg2, arg3);
        assert!(is_same_checkpoint(&v4, &v5), 50);
        assert!(v4.base == v5.base, 51);
        let v6 = v4.equity - 0x1::u64::min(v4.equity, v5.equity);
        assert!(v6 <= v2, 65);
        assert_realization_leverage<T0>(arg0, &v5, v3);
        (v4.equity, v5.equity, v1, v6)
    }

    public fun complete_rebalance<T0>(arg0: &State<T0>, arg1: RebalancePlan<T0>) : (u64, u64, u64, u64, bool) {
        0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::lifecycle::assert_active(&arg0.lifecycle);
        let RebalancePlan {
            before         : v0,
            current        : v1,
            reserve_priced : v2,
            increase       : v3,
            emergency      : v4,
            venue_fee_bps  : v5,
            steps          : v6,
            full_fills     : v7,
            band_landing   : v8,
        } = arg1;
        let v9 = v1;
        let v10 = v0;
        assert!(v6 > 0, 55);
        let v11 = admitted_reserve<T0>(arg0, &v9);
        assert!(0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::accounting_math::is_shareholder_nav_positive(v9.equity, v11), 2);
        if (v3) {
            assert_increase_leverage<T0>(arg0, &v9, v8);
        };
        let v12 = 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::rebalance_policy(&arg0.vault_policy);
        let v13 = if (v3) {
            v9.base > v10.base && 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::rebalance_math::leverage_rose(v10.notional, 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::accounting_math::shareholder_nav(v10.equity, v2), v9.notional, 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::accounting_math::shareholder_nav(v9.equity, v11))
        } else if (v4) {
            v9.base < v10.base && v9.notional < v10.notional
        } else if (v9.base < v10.base) {
            if (0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::rebalance_math::reduction_is_sufficient(v10.notional, 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::accounting_math::shareholder_nav(v10.equity, v2), v9.notional, 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::accounting_math::shareholder_nav(v9.equity, v11), 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::target_leverage_bps(&v12), 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::min_leverage_improvement_bps(&v12), 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::rebalance_math::oracle_notional_up(v9.lot_size, v9.base_price, v9.collateral_price, arg0.base_unit, arg0.collateral_unit))) {
                true
            } else if (v6 == max_rebalance_orders()) {
                if (v7) {
                    reduction_matches_capacity<T0>(arg0, &v10, &v9, v5)
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v13, 55);
        (v10.equity, v9.equity, v10.base, v9.base, v3)
    }

    public fun complete_redemption<T0>(arg0: &mut State<T0>, arg1: RedemptionPlan<T0>, arg2: 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::observation::PositionObservation, arg3: u64) : (u64, u64, u64, u64) {
        0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::lifecycle::assert_active(&arg0.lifecycle);
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
        0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::accounting_math::assert_redemption_base_within_bounds(v8.base, v1, v7.base, v2, v7.lot_size, 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::min_order_lots(&arg0.vault_policy));
        let v9 = admitted_reserve<T0>(arg0, &v7);
        let (v10, v11, v12, v13) = 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::accounting_math::redemption_accounting_quote(v1, v7.equity, v8.equity, v9, v2, v4);
        assert!(v13 >= v3, 53);
        let v14 = 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::accounting_math::admin_share_down(v12, v5);
        let v15 = v10 - v14;
        assert!(v11 <= 18446744073709551615 - v15, 15);
        arg0.maintenance_reserve = reserve_within_cap<T0>(arg0, v15, &v8);
        assert_holders_not_diluted(0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::accounting_math::shareholder_nav(v7.equity, v9), v2, v11, v2 - v1);
        (v13, v14, v12, v12 - v14)
    }

    public fun donate<T0>(arg0: &mut State<T0>, arg1: 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::observation::PositionObservation, arg2: u64, arg3: u64) {
        0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::lifecycle::assert_active(&arg0.lifecycle);
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

    fun execution_order_base(arg0: u64, arg1: &ActivePosition, arg2: 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::ExecutionBound, arg3: bool, arg4: u64, arg5: u64) : u64 {
        let v0 = 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::rebalance_math::base_for_execution_notional_down(arg0, arg1.base_price, arg1.collateral_price, arg1.lot_size, 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::slippage_bps(&arg2), arg4, arg5);
        if (arg3) {
            return 0x1::u64::max(v0, arg1.lot_size)
        };
        assert!(v0 > 0, 63);
        v0
    }

    fun flat_position(arg0: 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::observation::PositionObservation) : ActivePosition {
        ActivePosition{
            equity           : 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::observation::venue_equity(&arg0),
            base             : 0,
            notional         : 0,
            lot_size         : 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::observation::lot_size(&arg0),
            base_price       : 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::observation::price(0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::observation::base_oracle(&arg0)),
            collateral_price : 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::observation::price(0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::observation::collateral_oracle(&arg0)),
        }
    }

    fun funded_mint_increase_order<T0>(arg0: &State<T0>, arg1: &ActivePosition, arg2: u64, arg3: u64) : u64 {
        let v0 = 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::rebalance_policy(&arg0.vault_policy);
        0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::rebalance_math::increase_base_down(arg2, arg1.notional, 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::target_leverage_bps(&v0), arg1.base_price, arg1.collateral_price, arg1.lot_size, arg0.max_order_notional, arg3, 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::max_slippage_bps(&v0), arg0.base_unit, arg0.collateral_unit)
    }

    fun funding_outcome<T0>(arg0: &State<T0>, arg1: 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::observation::FundingSettlement) : (u64, u64, u64, u64, u64) {
        let v0 = 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::observation::amount(&arg1);
        let v1 = arg0.maintenance_reserve;
        let (v2, v3, v4, v5, v6) = if (0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::observation::is_cost(&arg1)) {
            let (v7, v8, v9) = 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::accounting_math::absorb_funding_cost(v1, v0);
            let v10 = 0x1::u64::checked_add(arg0.uncovered_deficit, v9);
            if (0x1::option::is_some<u64>(&v10)) {
                let v11 = v7 + v8 == v1 && v8 + v9 == v0;
                assert_invariant(v11);
                (v8, v9, 0, v7, 0x1::option::destroy_some<u64>(v10))
            } else {
                0x1::option::destroy_none<u64>(v10);
                abort 15
            }
        } else {
            let v12 = 0x1::u64::min(v0, arg0.uncovered_deficit);
            let v13 = 0x1::u64::checked_add(v1, v0 - v12);
            if (0x1::option::is_some<u64>(&v13)) {
                let v14 = 0x1::option::destroy_some<u64>(v13);
                assert_invariant((v14 as u128) + (v12 as u128) == (v1 as u128) + (v0 as u128));
                (0, 0, v12, v14, arg0.uncovered_deficit - v12)
            } else {
                0x1::option::destroy_none<u64>(v13);
                abort 15
            }
        };
        (v5, v6, v2, v3, v4)
    }

    fun increase_fits<T0>(arg0: &State<T0>, arg1: &ActivePosition, arg2: u64, arg3: u64, arg4: u64, arg5: bool) : bool {
        if (arg3 > 18446744073709551615 - arg1.base) {
            return false
        };
        let v0 = 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::rebalance_math::oracle_notional_up(arg3, arg1.base_price, arg1.collateral_price, arg0.base_unit, arg0.collateral_unit);
        if ((arg1.notional as u128) + (v0 as u128) > 18446744073709551615) {
            return false
        };
        let v1 = 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::rebalance_math::oracle_notional_up(arg1.base + arg3, arg1.base_price, arg1.collateral_price, arg0.base_unit, arg0.collateral_unit);
        let v2 = 0x1::u64::min(arg2, 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::reserve_cap(&arg0.vault_policy, v1));
        let v3 = 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::rebalance_policy(&arg0.vault_policy);
        let v4 = 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::rebalance_math::execution_cost_up(v0, arg4, 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::max_slippage_bps(&v3));
        if (v4 + (v2 as u128) >= (arg1.equity as u128)) {
            return false
        };
        arg5 && 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::is_leverage_within_band(&v3, v1, arg1.equity - v2 - (v4 as u64)) || 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::is_leverage_at_most_target(&v3, v1, arg1.equity - v2 - (v4 as u64))
    }

    fun increase_order<T0>(arg0: &State<T0>, arg1: &ActivePosition, arg2: u64, arg3: u64) : (u64, bool) {
        let v0 = 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::accounting_math::shareholder_nav(arg1.equity, reserve_within_cap<T0>(arg0, arg2, arg1));
        let v1 = 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::rebalance_policy(&arg0.vault_policy);
        if ((arg1.notional as u128) * 10000 >= (v0 as u128) * (0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::target_leverage_bps(&v1) as u128)) {
            return (0, false)
        };
        let v2 = 0x1::u64::min(max_order_base<T0>(arg0, arg1, false) / arg1.lot_size, (18446744073709551615 - arg1.base) / arg1.lot_size);
        let v3 = 0;
        while (v3 < v2) {
            let v4 = v3 + 0x1::u64::div_ceil(v2 - v3, 2);
            if (increase_fits<T0>(arg0, arg1, arg2, v4 * arg1.lot_size, arg3, false)) {
                v3 = v4;
                continue
            };
            v2 = v4 - 1;
        };
        if (v3 > 0) {
            return (v3 * arg1.lot_size, false)
        };
        if (!0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::is_leverage_below_band(&v1, arg1.notional, v0) || !increase_fits<T0>(arg0, arg1, arg2, arg1.lot_size, arg3, true)) {
            return (0, false)
        };
        (arg1.lot_size, true)
    }

    public fun is_emergency(arg0: &RebalanceOrder) : bool {
        arg0.emergency
    }

    public fun is_emergency_rebalance<T0>(arg0: &RebalancePlan<T0>) : bool {
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
        let v0 = 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::rebalance_policy(&arg0.vault_policy);
        0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::is_leverage_within_band(&v0, arg1.notional, 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::accounting_math::shareholder_nav(arg1.equity, arg2))
    }

    public fun issue<T0>(arg0: &0x59f4f4f31d2a3290019f81bd4b794523f5d840659372e1bbda328965be3f5288::blast_acl::AdminWitness<0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::blast_boosts_core::VaultIssuer>, arg1: 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::VaultPolicy, arg2: u64, arg3: u64, arg4: u8, arg5: u8) : Issuance<T0> {
        assert!(arg2 > 0, 39);
        let v0 = 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::rebalance_policy(&arg1);
        0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::assert_nav_cap_valid(&v0, arg3);
        let v1 = 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::rebalance_policy(&arg1);
        0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::assert_rebalance_capacity(&v1, arg2, arg3);
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

    public fun max_order_base<T0>(arg0: &State<T0>, arg1: &ActivePosition, arg2: bool) : u64 {
        execution_order_base(arg0.max_order_notional, arg1, execution_bound<T0>(arg0), arg2, arg0.base_unit, arg0.collateral_unit)
    }

    public fun max_rebalance_orders() : u64 {
        16
    }

    public fun mint_position<T0>(arg0: &MintPlan<T0>) : ActivePosition {
        arg0.before
    }

    public fun needs_rebalance<T0>(arg0: &State<T0>, arg1: 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::observation::PositionObservation, arg2: 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::observation::FundingSettlement, arg3: bool, arg4: u64, arg5: u64) : bool {
        0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::lifecycle::assert_active(&arg0.lifecycle);
        let (v0, _, _, _, _) = funding_outcome<T0>(arg0, arg2);
        let v5 = validated_oracle_position<T0>(arg0, arg1, v0, arg5);
        let v6 = 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::accounting_math::shareholder_nav(v5.equity, reserve_within_cap<T0>(arg0, v0, &v5));
        let v7 = 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::rebalance_policy(&arg0.vault_policy);
        if (!0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::is_leverage_above_max(&v7, v5.notional, v6)) {
            let v8 = 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::price_policy(&arg0.vault_policy);
            0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::assert_mark_within_oracle_divergence(&v8, 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::observation::mark_price(&arg1), v5.base_price);
        };
        if (0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::is_leverage_within_band(&v7, v5.notional, v6)) {
            return false
        };
        if (!0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::is_leverage_below_band(&v7, v5.notional, v6)) {
            return reduction_order<T0>(arg0, &v5, v0, 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::is_leverage_above_max(&v7, v5.notional, v6), arg4) > 0
        };
        if (!arg3) {
            return false
        };
        let (v9, _) = increase_order<T0>(arg0, &v5, v0, arg4);
        v9 > 0
    }

    public fun next_rebalance_order<T0>(arg0: &State<T0>, arg1: &RebalancePlan<T0>) : RebalanceOrder {
        let v0 = &arg1.current;
        let v1 = 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::rebalance_policy(&arg0.vault_policy);
        if (arg1.steps >= max_rebalance_orders()) {
            return RebalanceOrder{
                base         : 0,
                increase     : arg1.increase,
                emergency    : false,
                bound        : 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::execution_bound(&v1, false),
                band_landing : false,
            }
        };
        if (arg1.increase) {
            let (v2, v3) = increase_order<T0>(arg0, v0, arg0.maintenance_reserve, arg1.venue_fee_bps);
            return RebalanceOrder{
                base         : v2,
                increase     : true,
                emergency    : false,
                bound        : 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::execution_bound(&v1, false),
                band_landing : v3,
            }
        };
        if (arg1.emergency) {
            if (!0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::is_leverage_above_max(&v1, v0.notional, 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::accounting_math::shareholder_nav(v0.equity, admitted_reserve<T0>(arg0, v0)))) {
                return RebalanceOrder{
                    base         : 0,
                    increase     : false,
                    emergency    : false,
                    bound        : 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::execution_bound(&v1, false),
                    band_landing : false,
                }
            };
            return RebalanceOrder{
                base         : reduction_order<T0>(arg0, v0, arg0.maintenance_reserve, true, arg1.venue_fee_bps),
                increase     : false,
                emergency    : true,
                bound        : 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::execution_bound(&v1, true),
                band_landing : false,
            }
        };
        RebalanceOrder{
            base         : reduction_order<T0>(arg0, v0, arg0.maintenance_reserve, false, arg1.venue_fee_bps),
            increase     : false,
            emergency    : false,
            bound        : 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::execution_bound(&v1, false),
            band_landing : false,
        }
    }

    public fun notional(arg0: &ActivePosition) : u64 {
        arg0.notional
    }

    public fun order_base(arg0: &RebalanceOrder) : u64 {
        arg0.base
    }

    public fun prepare_mint<T0>(arg0: &State<T0>, arg1: 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::observation::PositionObservation, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) : MintPlan<T0> {
        0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::lifecycle::assert_active(&arg0.lifecycle);
        assert!(arg3 > 0, 3);
        assert!(arg5 <= 10000, 56);
        let v0 = validated_active_position<T0>(arg0, arg1, arg6);
        let v1 = admitted_reserve<T0>(arg0, &v0);
        let v2 = 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::accounting_math::shareholder_nav(v0.equity, v1);
        let v3 = !is_within_band<T0>(arg0, &v0, v1);
        if (v3) {
            let v4 = 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::rebalance_policy(&arg0.vault_policy);
            assert!(0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::is_leverage_below_band(&v4, v0.notional, v2), 49);
            let (v5, _) = increase_order<T0>(arg0, &v0, arg0.maintenance_reserve, arg5);
            assert!(v5 == 0, 49);
        };
        let (v7, v8, v9) = fee_allocation<T0>(arg0, arg2, true);
        let v10 = arg2 - v7;
        assert!(v10 > 0, 5);
        let v11 = if (v3) {
            recovery_mint_base<T0>(arg0, &v0, v2, v10, 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::accounting_math::mint_base_to_buy_down(v10, v0.base, v2, v0.lot_size, 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::min_order_lots(&arg0.vault_policy)), arg5)
        } else {
            0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::accounting_math::mint_base_to_buy_down(v10, v0.base, v2, v0.lot_size, 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::min_order_lots(&arg0.vault_policy))
        };
        MintPlan<T0>{
            before                : v0,
            expected_contribution : v10,
            reserve_fee           : v9,
            admin_fee             : v8,
            total_share_supply    : arg3,
            minimum_shares        : arg4,
            base_to_buy           : v11,
            recovery              : v3,
        }
    }

    public fun prepare_profit_realization<T0>(arg0: &State<T0>, arg1: 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::observation::PositionObservation, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : ProfitRealizationPlan<T0> {
        0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::lifecycle::assert_active(&arg0.lifecycle);
        assert!(arg2 > 0 && arg3 > 0, 64);
        assert!(arg4 <= 10000, 56);
        let v0 = validated_active_position<T0>(arg0, arg1, arg5);
        assert!(v0.base > 0, 64);
        let v1 = admitted_reserve<T0>(arg0, &v0);
        assert_realization_leverage<T0>(arg0, &v0, v1);
        let v2 = 10000;
        let v3 = execution_bound<T0>(arg0);
        let v4 = (0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::slippage_bps(&v3) as u128);
        let v5 = 2 * (v4 + 0x1::u128::div_ceil((arg4 as u128) * (v2 + v4), v2));
        let v6 = 0x1::u128::div_ceil((v0.notional as u128) * v5, v2);
        assert!(2 * v6 < (arg3 as u128), 65);
        assert!((arg2 as u128) + 3 <= (arg3 as u128) - v6, 65);
        let v7 = 0x1::u64::min((0x1::u256::min(0x1::u256::div_ceil(0x1::u256::max(0x1::u256::div_ceil(((arg2 as u256) + 3) * (v0.base as u256), (arg3 as u256) - (v6 as u256)), 0x1::u256::div_ceil(((2 * (2 + 0x1::u128::div_ceil(v5, v2)) + 3) as u256) * (v0.base as u256), (arg3 as u256) - 2 * (v6 as u256))), (v0.lot_size as u256)) * (v0.lot_size as u256), (v0.base as u256)) as u64), max_order_base<T0>(arg0, &v0, false));
        let v8 = 0x1::u128::div_ceil((0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::rebalance_math::oracle_notional_up(v7, v0.base_price, v0.collateral_price, arg0.base_unit, arg0.collateral_unit) as u128) * v5, v2) + 2;
        assert!((arg3 as u128) * (v7 as u128) / (v0.base as u128) > 2 * v8, 65);
        ProfitRealizationPlan<T0>{
            before          : v0,
            base_to_realize : v7,
            max_cost        : (v8 as u64),
            reserve_priced  : v1,
        }
    }

    public fun prepare_rebalance<T0>(arg0: &State<T0>, arg1: 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::observation::PositionObservation, arg2: u64, arg3: u64) : RebalancePlan<T0> {
        0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::lifecycle::assert_active(&arg0.lifecycle);
        assert!(arg2 <= 10000, 56);
        let v0 = validated_oracle_position<T0>(arg0, arg1, arg0.maintenance_reserve, arg3);
        let v1 = admitted_reserve<T0>(arg0, &v0);
        let v2 = 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::accounting_math::shareholder_nav(v0.equity, v1);
        let v3 = 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::rebalance_policy(&arg0.vault_policy);
        let v4 = 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::is_leverage_above_max(&v3, v0.notional, v2);
        if (!v4) {
            let v5 = 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::price_policy(&arg0.vault_policy);
            0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::assert_mark_within_oracle_divergence(&v5, 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::observation::mark_price(&arg1), v0.base_price);
        };
        assert!(!is_within_band<T0>(arg0, &v0, v1), 54);
        let v6 = 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::is_leverage_below_band(&v3, v0.notional, v2);
        if (v6) {
            let (v7, _) = increase_order<T0>(arg0, &v0, arg0.maintenance_reserve, arg2);
            assert!(v7 > 0, 67);
        } else {
            assert!(reduction_order<T0>(arg0, &v0, arg0.maintenance_reserve, v4, arg2) > 0, 67);
        };
        RebalancePlan<T0>{
            before         : v0,
            current        : v0,
            reserve_priced : v1,
            increase       : v6,
            emergency      : v4,
            venue_fee_bps  : arg2,
            steps          : 0,
            full_fills     : true,
            band_landing   : false,
        }
    }

    public fun prepare_redemption<T0>(arg0: &State<T0>, arg1: 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::observation::PositionObservation, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : RedemptionPlan<T0> {
        0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::lifecycle::assert_active(&arg0.lifecycle);
        let v0 = validated_active_position<T0>(arg0, arg1, arg5);
        let (v1, _) = 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::accounting_math::redemption_base_bounds(arg2, v0.base, arg3, v0.lot_size, 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::min_order_lots(&arg0.vault_policy));
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

    fun priced_position<T0>(arg0: &State<T0>, arg1: 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::observation::PositionObservation) : ActivePosition {
        let v0 = 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::observation::price(0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::observation::base_oracle(&arg1));
        let v1 = 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::observation::price(0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::observation::collateral_oracle(&arg1));
        let v2 = 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::observation::position_base(&arg1);
        ActivePosition{
            equity           : 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::observation::venue_equity(&arg1),
            base             : v2,
            notional         : 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::rebalance_math::oracle_notional_up(v2, v0, v1, arg0.base_unit, arg0.collateral_unit),
            lot_size         : 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::observation::lot_size(&arg1),
            base_price       : v0,
            collateral_price : v1,
        }
    }

    public fun realization_position<T0>(arg0: &ProfitRealizationPlan<T0>) : ActivePosition {
        arg0.before
    }

    public fun rebalance_position<T0>(arg0: &RebalancePlan<T0>) : ActivePosition {
        arg0.before
    }

    fun recovery_mint_base<T0>(arg0: &State<T0>, arg1: &ActivePosition, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : u64 {
        let v0 = 0x1::u64::checked_add(arg2, arg3);
        if (0x1::option::is_some<u64>(&v0)) {
            let v1 = 0x1::option::destroy_some<u64>(v0);
            let v2 = funded_mint_increase_order<T0>(arg0, arg1, v1, arg5);
            let v3 = 0x1::u64::checked_add(arg1.base, v2);
            if (0x1::option::is_some<u64>(&v3)) {
                let v4 = if (v2 >= arg4) {
                    let v5 = 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::rebalance_policy(&arg0.vault_policy);
                    0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::is_leverage_within_band(&v5, 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::rebalance_math::oracle_notional_up(0x1::option::destroy_some<u64>(v3), arg1.base_price, arg1.collateral_price, arg0.base_unit, arg0.collateral_unit), v1)
                } else {
                    false
                };
                assert!(v4, 49);
                return v2
            } else {
                0x1::option::destroy_none<u64>(v3);
                abort 15
            };
        } else {
            0x1::option::destroy_none<u64>(v0);
            abort 15
        };
    }

    public fun redemption_position<T0>(arg0: &RedemptionPlan<T0>) : ActivePosition {
        arg0.before
    }

    public fun redemption_shares<T0>(arg0: &RedemptionPlan<T0>) : u64 {
        arg0.shares_to_redeem
    }

    fun reduction_cost_up<T0>(arg0: &State<T0>, arg1: &ActivePosition, arg2: u64, arg3: 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::ExecutionBound, arg4: u64) : u128 {
        let v0 = (0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::rebalance_math::oracle_notional_up(arg2, 1, arg1.collateral_price, arg0.base_unit, arg0.collateral_unit) as u128);
        0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::rebalance_math::execution_cost_up(0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::rebalance_math::oracle_notional_up(arg2, arg1.base_price, arg1.collateral_price, arg0.base_unit, arg0.collateral_unit), arg4, 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::slippage_bps(&arg3)) + v0 + 0x1::u128::div_ceil(v0 * (arg4 as u128), 10000) + 3
    }

    fun reduction_order<T0>(arg0: &State<T0>, arg1: &ActivePosition, arg2: u64, arg3: bool, arg4: u64) : u64 {
        let v0 = 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::rebalance_policy(&arg0.vault_policy);
        let v1 = if (arg3) {
            0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::max_leverage_bps(&v0)
        } else {
            0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::target_leverage_bps(&v0)
        };
        let v2 = 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::accounting_math::shareholder_nav(arg1.equity, reserve_within_cap<T0>(arg0, arg2, arg1));
        if ((arg1.notional as u128) * 10000 <= (v2 as u128) * (v1 as u128)) {
            return 0
        };
        let v3 = 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::execution_bound(&v0, arg3);
        let v4 = 0x1::u64::min((arg1.base / arg1.lot_size - reduction_target_lots<T0>(arg0, arg1, arg2, v1)) * arg1.lot_size, execution_order_base(arg0.max_order_notional, arg1, v3, true, arg0.base_unit, arg0.collateral_unit));
        let v5 = v4;
        if (v4 == 0) {
            return 0
        };
        if (v4 == arg1.base && !reduction_preserves_nav<T0>(arg0, arg1, arg2, v4, v3, arg4)) {
            v5 = v4 - arg1.lot_size;
        };
        if (v5 == 0 || !arg3) {
            return v5
        };
        if (reduction_cost_up<T0>(arg0, arg1, v5, v3, arg4) < (v2 as u128)) {
            return v5
        };
        let v6 = 0;
        let v7 = v5 / arg1.lot_size;
        while (v6 < v7) {
            let v8 = v6 + 0x1::u64::div_ceil(v7 - v6, 2);
            if (reduction_cost_up<T0>(arg0, arg1, v8 * arg1.lot_size, v3, arg4) < (v2 as u128)) {
                v6 = v8;
                continue
            };
            v7 = v8 - 1;
        };
        if (v6 > 0) {
            return v6 * arg1.lot_size
        };
        if (reduction_preserves_nav<T0>(arg0, arg1, arg2, arg1.lot_size, v3, arg4)) {
            return arg1.lot_size
        };
        0
    }

    fun reduction_preserves_nav<T0>(arg0: &State<T0>, arg1: &ActivePosition, arg2: u64, arg3: u64, arg4: 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::ExecutionBound, arg5: u64) : bool {
        let v0 = *arg1;
        v0.base = arg1.base - arg3;
        v0.notional = 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::rebalance_math::oracle_notional_up(v0.base, arg1.base_price, arg1.collateral_price, arg0.base_unit, arg0.collateral_unit);
        reduction_cost_up<T0>(arg0, arg1, arg3, arg4, arg5) + (reserve_within_cap<T0>(arg0, arg2, &v0) as u128) < (arg1.equity as u128)
    }

    fun reduction_target_lots<T0>(arg0: &State<T0>, arg1: &ActivePosition, arg2: u64, arg3: u64) : u64 {
        if (arg2 < arg1.equity) {
            let v0 = 0x1::u64::min(base_for_notional((0x1::u128::min(((arg1.equity - arg2) as u128) * (arg3 as u128) / 10000, (arg1.notional as u128)) as u64), arg1, arg0.base_unit, arg0.collateral_unit), arg1.base);
            if (arg2 <= 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::reserve_cap(&arg0.vault_policy, 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::rebalance_math::oracle_notional_up(v0, arg1.base_price, arg1.collateral_price, arg0.base_unit, arg0.collateral_unit))) {
                return v0 / arg1.lot_size
            };
        };
        let v1 = 0;
        let v2 = arg1.base / arg1.lot_size;
        while (v1 < v2) {
            let v3 = v1 + 0x1::u64::div_ceil(v2 - v1, 2);
            let v4 = 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::rebalance_math::oracle_notional_up(v3 * arg1.lot_size, arg1.base_price, arg1.collateral_price, arg0.base_unit, arg0.collateral_unit);
            if ((v4 as u128) * 10000 <= ((arg1.equity - 0x1::u64::min(arg2, 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::reserve_cap(&arg0.vault_policy, v4))) as u128) * (arg3 as u128)) {
                v1 = v3;
                continue
            };
            v2 = v3 - 1;
        };
        v1
    }

    fun reserve_within_cap<T0>(arg0: &State<T0>, arg1: u64, arg2: &ActivePosition) : u64 {
        if (arg2.notional == 0) {
            arg1
        } else {
            0x1::u64::min(arg1, 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::reserve_cap(&arg0.vault_policy, arg2.notional))
        }
    }

    public fun seed_execution_bound<T0>(arg0: &Issuance<T0>) : 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::ExecutionBound {
        let v0 = 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::rebalance_policy(&arg0.vault_policy);
        0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::execution_bound(&v0, false)
    }

    public fun seed_side<T0>(arg0: &Issuance<T0>) : 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::PositionSide {
        0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::side(&arg0.vault_policy)
    }

    public fun seed_terms<T0>(arg0: &Issuance<T0>, arg1: 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::observation::PositionObservation, arg2: u64) : (u64, u64, ActivePosition) {
        let v0 = 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::rebalance_policy(&arg0.vault_policy);
        let v1 = flat_position(arg1);
        let v2 = execution_order_base(arg0.max_order_notional, &v1, seed_execution_bound<T0>(arg0), false, arg0.base_unit, arg0.collateral_unit);
        assert_minimum_order_capacity(v2, v1.lot_size, 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::min_order_lots(&arg0.vault_policy));
        (base_for_notional(0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::accounting_math::target_notional_down(0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::accounting_math::shareholder_nav(0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::observation::venue_equity(&arg1), arg2), 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::target_leverage_bps(&v0)), &v1, arg0.base_unit, arg0.collateral_unit), v2, v1)
    }

    public fun set_fees<T0>(arg0: &mut State<T0>, arg1: u64, arg2: u64, arg3: u64) : (u64, u64, u64) {
        0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::lifecycle::assert_active(&arg0.lifecycle);
        0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::assert_fee_limits(&arg0.vault_policy, arg1, arg2, arg3);
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

    public fun set_max_order_notional<T0>(arg0: &mut State<T0>, arg1: u64, arg2: 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::observation::PriceObservation, arg3: 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::observation::PriceObservation, arg4: u64, arg5: u64) : u64 {
        assert_max_order_notional_update<T0>(arg0, arg1);
        let v0 = 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::price_policy(&arg0.vault_policy);
        assert_oracle_admitted(&v0, &arg2, arg5);
        assert_oracle_admitted(&v0, &arg3, arg5);
        let v1 = execution_bound<T0>(arg0);
        assert_minimum_order_capacity(0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::rebalance_math::base_for_execution_notional_down(arg1, 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::observation::price(&arg2), 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::observation::price(&arg3), arg4, 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::slippage_bps(&v1), arg0.base_unit, arg0.collateral_unit), arg4, 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::min_order_lots(&arg0.vault_policy));
        arg0.max_order_notional = arg1;
        arg0.max_order_notional
    }

    public fun set_nav_cap<T0>(arg0: &mut State<T0>, arg1: u64) : u64 {
        let v0 = arg0.nav_cap;
        assert!(arg1 != v0, 58);
        let v1 = 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::rebalance_policy(&arg0.vault_policy);
        0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::assert_nav_cap_valid(&v1, arg1);
        let v2 = 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::rebalance_policy(&arg0.vault_policy);
        0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::assert_rebalance_capacity(&v2, arg0.max_order_notional, arg1);
        arg0.nav_cap = arg1;
        v0
    }

    public fun settle_funding<T0>(arg0: &mut State<T0>, arg1: 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::observation::FundingSettlement) : (u64, u64, u64) {
        0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::lifecycle::assert_can_sync(&arg0.lifecycle);
        let (v0, v1, v2, v3, v4) = funding_outcome<T0>(arg0, arg1);
        arg0.maintenance_reserve = v0;
        arg0.uncovered_deficit = v1;
        (v2, v3, v4)
    }

    public fun shutdown_claim_quote<T0>(arg0: &State<T0>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : u64 {
        0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::lifecycle::assert_settled(&arg0.lifecycle);
        assert!(arg2 >= arg3, 3);
        let v0 = arg2 - arg3;
        assert!(arg4 > 0 && arg4 <= v0, 4);
        let v1 = 0x1::u64::mul_div(arg1, arg4, v0);
        assert!(arg1 == 0 || v1 > 0, 8);
        assert!(v1 >= arg5, 53);
        v1
    }

    public fun unwind_constraints<T0>(arg0: &State<T0>, arg1: 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::observation::PriceObservation, arg2: 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::observation::PriceObservation, arg3: u64, arg4: u64) : (0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::PositionSide, u64, u64, u64, 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::ExecutionBound) {
        assert_unwinding<T0>(arg0);
        let v0 = 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::price_policy(&arg0.vault_policy);
        assert_oracle_admitted(&v0, &arg1, arg4);
        assert_oracle_admitted(&v0, &arg2, arg4);
        let v1 = 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::observation::price(&arg1);
        let v2 = 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::observation::price(&arg2);
        let v3 = 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::lifecycle::shutdown_began_at_ms(&arg0.lifecycle);
        let v4 = if (arg4 > v3) {
            arg4 - v3
        } else {
            0
        };
        let v5 = 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::rebalance_policy(&arg0.vault_policy);
        let v6 = 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::unwind_execution_bound(&v5, v4);
        (0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::side(&arg0.vault_policy), 0x1::u64::max(0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::rebalance_math::base_for_execution_notional_down(arg0.max_order_notional, v1, v2, arg3, 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::slippage_bps(&v6), arg0.base_unit, arg0.collateral_unit), arg3), v1, v2, v6)
    }

    fun validated_active_position<T0>(arg0: &State<T0>, arg1: 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::observation::PositionObservation, arg2: u64) : ActivePosition {
        assert_observation_priced(&arg0.vault_policy, &arg1, arg2);
        active_position<T0>(arg0, arg1, arg0.maintenance_reserve)
    }

    fun validated_oracle_position<T0>(arg0: &State<T0>, arg1: 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::observation::PositionObservation, arg2: u64, arg3: u64) : ActivePosition {
        let v0 = 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::price_policy(&arg0.vault_policy);
        assert_observation_oracles(&v0, &arg1, arg3);
        active_position<T0>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v7
}

