module 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::market {
    struct MarketParams has copy, drop, store {
        core_params: CoreParams,
        fees_params: FeesParams,
        twap_params: TwapParams,
        limits_params: LimitsParams,
    }

    struct CoreParams has copy, drop, store {
        base_pfs_id: 0x2::object::ID,
        collateral_pfs_id: 0x2::object::ID,
        base_pfs_source_id: 0x2::object::ID,
        collateral_pfs_source_id: 0x2::object::ID,
        base_pfs_tolerance: u64,
        collateral_pfs_tolerance: u64,
        lot_size: u64,
        tick_size: u64,
        scaling_factor: u256,
        collateral_haircut: u256,
        margin_ratio_initial: u256,
        margin_ratio_maintenance: u256,
    }

    struct FeesParams has copy, drop, store {
        maker_fee: u256,
        taker_fee: u256,
        liquidation_fee: u256,
        force_cancel_fee: u256,
        insurance_fund_fee: u256,
        gas_price_taker_fee: u256,
    }

    struct TwapParams has copy, drop, store {
        funding_frequency_ms: u64,
        funding_period_ms: u64,
        premium_twap_frequency_ms: u64,
        premium_twap_period_ms: u64,
        spread_twap_frequency_ms: u64,
        spread_twap_period_ms: u64,
        gas_price_twap_period_ms: u64,
    }

    struct LimitsParams has copy, drop, store {
        min_order_usd_value: u256,
        max_pending_orders: u64,
        max_open_interest: u256,
        max_open_interest_threshold: u256,
        max_open_interest_position_percent: u256,
        max_bad_debt: u256,
        max_socialize_losses_mr_decrease: u256,
        z_score_threshold: u256,
    }

    struct MarketState has store {
        cum_funding_rate_long: u256,
        cum_funding_rate_short: u256,
        funding_last_upd_ms: u64,
        premium_twap: u256,
        premium_twap_last_upd_ms: u64,
        spread_twap: u256,
        spread_twap_last_upd_ms: u64,
        gas_price_mean: u256,
        gas_price_variance: u256,
        gas_price_last_upd_ms: u64,
        open_interest: u256,
        fees_accrued: u256,
    }

    public(friend) fun add_bad_debt_to_market(arg0: &mut MarketState, arg1: &0x2::object::ID, arg2: bool, arg3: u256, arg4: u256) {
        if (arg2) {
            arg0.cum_funding_rate_long = 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::add(arg0.cum_funding_rate_long, arg4);
        } else {
            arg0.cum_funding_rate_short = 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::sub(arg0.cum_funding_rate_short, arg4);
        };
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::events::emit_socialized_bad_debt(*arg1, arg3, arg4, arg2, arg0.cum_funding_rate_long, arg0.cum_funding_rate_short);
    }

    public(friend) fun add_fees_accrued_usd(arg0: &mut MarketState, arg1: u256, arg2: u256) {
        arg0.fees_accrued = 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::add(arg0.fees_accrued, 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::div(arg1, arg2));
    }

    public(friend) fun add_to_open_interest(arg0: &mut MarketState, arg1: u256) {
        arg0.open_interest = 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::add(arg0.open_interest, arg1);
    }

    public(friend) fun calculate_funding_price(arg0: &MarketState, arg1: &MarketParams, arg2: u256, arg3: u64) : u256 {
        0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::add(arg2, 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::mul(arg0.premium_twap, 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_u64fraction(0x1::u64::max(arg3, next_funding_update_time(arg0.funding_last_upd_ms, arg1.twap_params.funding_frequency_ms)) - arg3, arg1.twap_params.funding_period_ms)))
    }

    fun calculate_std(arg0: u256, arg1: u256) : u256 {
        0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_u128balance(0x1::u128::sqrt((arg0 as u128)), arg1)
    }

    public fun calculate_z_score(arg0: &MarketState, arg1: u256) : u256 {
        if (arg0.gas_price_variance == 0) {
            return 0
        };
        let v0 = if (arg1 > arg0.gas_price_mean) {
            arg1 - arg0.gas_price_mean
        } else {
            arg0.gas_price_mean - arg1
        };
        0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::div(v0, calculate_std(arg0.gas_price_variance, 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::constants::b9_scaling()))
    }

    fun check_funding_parameters(arg0: u64, arg1: u64, arg2: u64, arg3: u64) {
        let v0 = if (arg1 >= 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::constants::min_funding_period_ms()) {
            if (arg1 <= 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::constants::max_funding_period_ms()) {
                if (arg0 >= 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::constants::min_funding_frequency_ms()) {
                    if (arg1 > arg0) {
                        arg1 % arg0 == 0
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
        assert!(v0, 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::errors::invalid_market_parameters());
        check_twap_parameters(arg2, arg3, 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::constants::min_premium_twap_frequency_ms(), 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::constants::min_premium_twap_period_ms());
    }

    fun check_gas_price_twap_parameters(arg0: u64, arg1: u256, arg2: u256) {
        assert!(arg0 >= 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::constants::min_gas_price_twap_period_ms(), 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::errors::invalid_market_parameters());
        assert!(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::greater_than_eq(arg1, 0), 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::errors::invalid_market_parameters());
        assert!(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::less_than_eq(arg2, 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::constants::max_abs_taker_fee()) && 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::greater_than_eq(arg2, 0), 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::errors::invalid_market_parameters());
    }

    fun check_liquidation_fees(arg0: u256, arg1: u256, arg2: u256) {
        let v0 = if (!0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::is_neg(arg0)) {
            if (0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::less_than_eq(arg0, 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::constants::max_liquidation_fee())) {
                if (!0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::is_neg(arg1)) {
                    if (0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::less_than_eq(arg1, 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::constants::max_force_cancel_fee())) {
                        if (!0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::is_neg(arg2)) {
                            0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::less_than_eq(arg2, 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::constants::max_insurance_fund_fee())
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
            }
        } else {
            false
        };
        assert!(v0, 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::errors::invalid_market_parameters());
    }

    fun check_lot_and_tick_sizes(arg0: u64, arg1: u64) {
        assert!(arg0 <= 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::constants::one_b9() && arg1 <= 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::constants::one_b9(), 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::errors::invalid_market_parameters());
    }

    public(friend) fun check_margin_ratios(arg0: u256, arg1: u256) {
        let v0 = if (0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::less_than_eq(arg0, 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::constants::one_fixed())) {
            if (0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::less_than(arg1, arg0)) {
                0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::greater_than(arg1, 0)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::errors::invalid_market_parameters());
    }

    public(friend) fun check_market_fees(arg0: u256, arg1: u256) {
        assert!(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::less_than_eq(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::abs(arg0), 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::constants::max_abs_maker_fee()) && 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::less_than_eq(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::abs(arg1), 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::constants::max_abs_taker_fee()), 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::errors::invalid_market_parameters());
        assert!(!0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::is_neg(arg0) || !0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::is_neg(arg1) && 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::less_than_eq(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::abs(arg0), arg1), 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::errors::invalid_market_parameters());
        assert!(!0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::is_neg(arg1) || !0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::is_neg(arg0) && 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::less_than_eq(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::abs(arg1), arg0), 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::errors::invalid_market_parameters());
    }

    fun check_market_parameters(arg0: u256, arg1: u256, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u256, arg10: u256, arg11: u256, arg12: u256, arg13: u256, arg14: u64, arg15: u64) {
        check_margin_ratios(arg0, arg1);
        check_funding_parameters(arg2, arg3, arg4, arg5);
        check_spread_twap_parameters(arg6, arg7);
        check_gas_price_twap_parameters(arg8, 0, 0);
        check_market_fees(arg9, arg10);
        check_liquidation_fees(arg11, arg12, arg13);
        check_lot_and_tick_sizes(arg14, arg15);
    }

    fun check_oracle_tolerance(arg0: u64) {
        assert!(arg0 >= 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::constants::min_oracle_tolerance(), 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::errors::invalid_market_parameters());
    }

    fun check_spread_twap_parameters(arg0: u64, arg1: u64) {
        check_twap_parameters(arg0, arg1, 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::constants::min_spread_twap_frequency_ms(), 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::constants::min_spread_twap_period_ms());
    }

    fun check_twap_parameters(arg0: u64, arg1: u64, arg2: u64, arg3: u64) {
        let v0 = if (arg0 >= arg2) {
            if (arg1 >= arg3) {
                arg1 > arg0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::errors::invalid_market_parameters());
    }

    fun clip_max_book_index_spread(arg0: u256, arg1: u256) : u256 {
        assert!(arg1 != 0, 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::errors::bad_index_price());
        let v0 = 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::mul(arg1, 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_u64fraction(0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::constants::max_book_index_spread_percent(), 100));
        let v1 = 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::add(arg1, v0);
        let v2 = 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::sub(arg1, v0);
        if (0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::greater_than(arg0, v1)) {
            v1
        } else if (0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::less_than(arg0, v2)) {
            v2
        } else {
            arg0
        }
    }

    fun compute_period_adjustment(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u256 {
        0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::div(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::mul(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_u64(arg0 / arg2 - arg1 / arg2), 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_u64(arg2)), 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_u64(arg3))
    }

    public(friend) fun create_market_objects(arg0: &0x2::clock::Clock, arg1: u256, arg2: u256, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: 0x2::object::ID, arg6: 0x2::object::ID, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u256, arg15: u256, arg16: u256, arg17: u256, arg18: u256, arg19: u64, arg20: u64, arg21: u256, arg22: u64) : (MarketParams, MarketState) {
        check_market_parameters(arg1, arg2, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20);
        (create_market_params(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20, arg21), create_market_state(0x2::clock::timestamp_ms(arg0), arg22))
    }

    fun create_market_params(arg0: u256, arg1: u256, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: 0x2::object::ID, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u256, arg14: u256, arg15: u256, arg16: u256, arg17: u256, arg18: u64, arg19: u64, arg20: u256) : MarketParams {
        let v0 = CoreParams{
            base_pfs_id              : arg2,
            collateral_pfs_id        : arg3,
            base_pfs_source_id       : arg4,
            collateral_pfs_source_id : arg5,
            base_pfs_tolerance       : 18446744073709551615,
            collateral_pfs_tolerance : 18446744073709551615,
            lot_size                 : arg18,
            tick_size                : arg19,
            scaling_factor           : arg20,
            collateral_haircut       : 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::constants::one_fixed(),
            margin_ratio_initial     : arg0,
            margin_ratio_maintenance : arg1,
        };
        let v1 = FeesParams{
            maker_fee           : arg13,
            taker_fee           : arg14,
            liquidation_fee     : arg15,
            force_cancel_fee    : arg16,
            insurance_fund_fee  : arg17,
            gas_price_taker_fee : 1000000000000000,
        };
        let v2 = TwapParams{
            funding_frequency_ms      : arg6,
            funding_period_ms         : arg7,
            premium_twap_frequency_ms : arg8,
            premium_twap_period_ms    : arg9,
            spread_twap_frequency_ms  : arg10,
            spread_twap_period_ms     : arg11,
            gas_price_twap_period_ms  : arg12,
        };
        let v3 = LimitsParams{
            min_order_usd_value                : 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::constants::one_fixed(),
            max_pending_orders                 : 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::constants::up_max_pending_orders(),
            max_open_interest                  : 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_u64(18446744073709551615),
            max_open_interest_threshold        : 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_u64(18446744073709551615),
            max_open_interest_position_percent : 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::constants::one_fixed(),
            max_bad_debt                       : 0,
            max_socialize_losses_mr_decrease   : 0,
            z_score_threshold                  : 3000000000000000000,
        };
        MarketParams{
            core_params   : v0,
            fees_params   : v1,
            twap_params   : v2,
            limits_params : v3,
        }
    }

    fun create_market_state(arg0: u64, arg1: u64) : MarketState {
        MarketState{
            cum_funding_rate_long    : 0,
            cum_funding_rate_short   : 0,
            funding_last_upd_ms      : arg0,
            premium_twap             : 0,
            premium_twap_last_upd_ms : arg0,
            spread_twap              : 0,
            spread_twap_last_upd_ms  : arg0,
            gas_price_mean           : 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_u64(arg1),
            gas_price_variance       : 0,
            gas_price_last_upd_ms    : arg0,
            open_interest            : 0,
            fees_accrued             : 0,
        }
    }

    public(friend) fun get_additional_gas_price_taker_fee(arg0: &MarketState, arg1: &MarketParams, arg2: u256) : u256 {
        if (0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::less_than_eq(arg2, arg0.gas_price_mean)) {
            return 0
        };
        if (0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::greater_than(calculate_z_score(arg0, arg2), arg1.limits_params.z_score_threshold)) {
            arg1.fees_params.gas_price_taker_fee
        } else {
            0
        }
    }

    public fun get_base_oracle_price(arg0: &MarketParams, arg1: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::PriceFeedStorage, arg2: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::config::Config, arg3: &0x2::clock::Clock) : u256 {
        assert!(0x2::object::id<0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::PriceFeedStorage>(arg1) == arg0.core_params.base_pfs_id, 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::errors::invalid_base_price_feed_storage());
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::oracle::get_price(arg1, arg2, arg3, arg0.core_params.base_pfs_source_id, arg0.core_params.base_pfs_tolerance)
    }

    public fun get_base_pfs_id(arg0: &MarketParams) : 0x2::object::ID {
        arg0.core_params.base_pfs_id
    }

    public fun get_base_pfs_source_id(arg0: &MarketParams) : 0x2::object::ID {
        arg0.core_params.base_pfs_source_id
    }

    public fun get_base_pfs_tolerance(arg0: &MarketParams) : u64 {
        arg0.core_params.base_pfs_tolerance
    }

    public fun get_collateral_haircut(arg0: &MarketParams) : u256 {
        arg0.core_params.collateral_haircut
    }

    public fun get_collateral_oracle_price(arg0: &MarketParams, arg1: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::PriceFeedStorage, arg2: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::config::Config, arg3: &0x2::clock::Clock) : u256 {
        assert!(0x2::object::id<0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::PriceFeedStorage>(arg1) == arg0.core_params.collateral_pfs_id, 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::errors::invalid_collateral_price_feed_storage());
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::oracle::get_price(arg1, arg2, arg3, arg0.core_params.collateral_pfs_source_id, arg0.core_params.collateral_pfs_tolerance)
    }

    public fun get_collateral_pfs_id(arg0: &MarketParams) : 0x2::object::ID {
        arg0.core_params.collateral_pfs_id
    }

    public fun get_collateral_pfs_source_id(arg0: &MarketParams) : 0x2::object::ID {
        arg0.core_params.collateral_pfs_source_id
    }

    public fun get_collateral_pfs_tolerance(arg0: &MarketParams) : u64 {
        arg0.core_params.collateral_pfs_tolerance
    }

    public fun get_cum_funding_rates(arg0: &MarketState) : (u256, u256) {
        (arg0.cum_funding_rate_long, arg0.cum_funding_rate_short)
    }

    public fun get_fees_accrued(arg0: &MarketState) : u256 {
        arg0.fees_accrued
    }

    public fun get_funding_last_upd_ms(arg0: &MarketState) : u64 {
        arg0.funding_last_upd_ms
    }

    public fun get_funding_params(arg0: &MarketParams) : (u64, u64) {
        (arg0.twap_params.funding_frequency_ms, arg0.twap_params.funding_period_ms)
    }

    public fun get_gas_price_twap_params(arg0: &MarketParams) : (u64, u256, u256) {
        (arg0.twap_params.gas_price_twap_period_ms, arg0.fees_params.gas_price_taker_fee, arg0.limits_params.z_score_threshold)
    }

    public fun get_liquidation_fee_rates(arg0: &MarketParams) : (u256, u256, u256) {
        (arg0.fees_params.force_cancel_fee, arg0.fees_params.liquidation_fee, arg0.fees_params.insurance_fund_fee)
    }

    public fun get_lot_size(arg0: &MarketParams) : u64 {
        arg0.core_params.lot_size
    }

    public fun get_maker_taker_fees(arg0: &MarketParams) : (u256, u256) {
        (arg0.fees_params.maker_fee, arg0.fees_params.taker_fee)
    }

    public fun get_margin_ratio_initial(arg0: &MarketParams) : u256 {
        arg0.core_params.margin_ratio_initial
    }

    public fun get_margin_ratio_maintenance(arg0: &MarketParams) : u256 {
        arg0.core_params.margin_ratio_maintenance
    }

    public fun get_max_bad_debt_thresholds(arg0: &MarketParams) : (u256, u256) {
        (arg0.limits_params.max_bad_debt, arg0.limits_params.max_socialize_losses_mr_decrease)
    }

    public fun get_max_open_interest(arg0: &MarketParams) : u256 {
        arg0.limits_params.max_open_interest
    }

    public fun get_max_open_interest_position_params(arg0: &MarketParams) : (u256, u256) {
        (arg0.limits_params.max_open_interest_threshold, arg0.limits_params.max_open_interest_position_percent)
    }

    public fun get_max_pending_orders(arg0: &MarketParams) : u64 {
        arg0.limits_params.max_pending_orders
    }

    public fun get_min_order_usd_value(arg0: &MarketParams) : u256 {
        arg0.limits_params.min_order_usd_value
    }

    public fun get_open_interest(arg0: &MarketState) : u256 {
        arg0.open_interest
    }

    public fun get_premium_twap(arg0: &MarketState) : u256 {
        arg0.premium_twap
    }

    public fun get_premium_twap_params(arg0: &MarketParams) : (u64, u64) {
        (arg0.twap_params.premium_twap_frequency_ms, arg0.twap_params.premium_twap_period_ms)
    }

    public fun get_scaling_factor(arg0: &MarketParams) : u256 {
        arg0.core_params.scaling_factor
    }

    public fun get_spread_twap(arg0: &MarketState) : u256 {
        arg0.spread_twap
    }

    public fun get_spread_twap_params(arg0: &MarketParams) : (u64, u64) {
        (arg0.twap_params.spread_twap_frequency_ms, arg0.twap_params.spread_twap_period_ms)
    }

    public fun get_tick_size(arg0: &MarketParams) : u64 {
        arg0.core_params.tick_size
    }

    fun is_time_to_update(arg0: u64, arg1: u64, arg2: u64) : bool {
        arg0 >= next_funding_update_time(arg1, arg2)
    }

    fun next_funding_update_time(arg0: u64, arg1: u64) : u64 {
        arg0 - arg0 % arg1 + arg1
    }

    public(friend) fun reset_fees_accrued(arg0: &mut MarketState) : u256 {
        arg0.fees_accrued = 0;
        arg0.fees_accrued
    }

    public(friend) fun set_base_pfs_id(arg0: &mut MarketParams, arg1: &0x2::object::ID, arg2: 0x2::object::ID) {
        arg0.core_params.base_pfs_id = arg2;
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::events::emit_updated_base_pfs_id(*arg1, arg2);
    }

    public(friend) fun set_base_pfs_source_id(arg0: &mut MarketParams, arg1: &0x2::object::ID, arg2: 0x2::object::ID) {
        arg0.core_params.base_pfs_source_id = arg2;
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::events::emit_updated_base_oracle_source_id(*arg1, arg2);
    }

    public(friend) fun set_base_pfs_tolerance(arg0: &mut MarketParams, arg1: &0x2::object::ID, arg2: u64) {
        check_oracle_tolerance(arg2);
        arg0.core_params.base_pfs_tolerance = arg2;
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::events::emit_updated_base_pfs_tolerance(*arg1, arg2);
    }

    public(friend) fun set_collateral_haircut(arg0: &mut MarketParams, arg1: &0x2::object::ID, arg2: u256) {
        assert!(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::greater_than_eq(arg2, 0) && 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::less_than_eq(arg2, 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::constants::one_fixed()), 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::errors::invalid_market_parameters());
        arg0.core_params.collateral_haircut = arg2;
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::events::emit_updated_collateral_haircut(*arg1, arg2);
    }

    public(friend) fun set_collateral_pfs_id(arg0: &mut MarketParams, arg1: &0x2::object::ID, arg2: 0x2::object::ID) {
        arg0.core_params.collateral_pfs_id = arg2;
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::events::emit_updated_collateral_pfs_id(*arg1, arg2);
    }

    public(friend) fun set_collateral_pfs_source_id(arg0: &mut MarketParams, arg1: &0x2::object::ID, arg2: 0x2::object::ID) {
        arg0.core_params.collateral_pfs_source_id = arg2;
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::events::emit_updated_collateral_oracle_source_id(*arg1, arg2);
    }

    public(friend) fun set_collateral_pfs_tolerance(arg0: &mut MarketParams, arg1: &0x2::object::ID, arg2: u64) {
        check_oracle_tolerance(arg2);
        arg0.core_params.collateral_pfs_tolerance = arg2;
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::events::emit_updated_collateral_pfs_tolerance(*arg1, arg2);
    }

    public(friend) fun set_max_bad_debt(arg0: &mut MarketParams, arg1: &0x2::object::ID, arg2: u256) {
        assert!(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::greater_than_eq(arg2, 0), 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::errors::invalid_market_parameters());
        arg0.limits_params.max_bad_debt = arg2;
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::events::emit_updated_max_bad_debt(*arg1, arg2);
    }

    public(friend) fun set_max_open_interest(arg0: &mut MarketParams, arg1: &0x2::object::ID, arg2: u256) {
        assert!(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::greater_than(arg2, 0), 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::errors::invalid_market_parameters());
        arg0.limits_params.max_open_interest = arg2;
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::events::emit_updated_max_open_interest(*arg1, arg2);
    }

    public(friend) fun set_max_open_interest_position_params(arg0: &mut MarketParams, arg1: &0x2::object::ID, arg2: u256, arg3: u256) {
        assert!(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::greater_than(arg3, 0) && 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::less_than_eq(arg3, 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::constants::one_fixed()), 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::errors::invalid_market_parameters());
        assert!(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::greater_than(arg2, 0) && 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::less_than_eq(arg2, arg0.limits_params.max_open_interest), 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::errors::invalid_market_parameters());
        arg0.limits_params.max_open_interest_position_percent = arg3;
        arg0.limits_params.max_open_interest_threshold = arg2;
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::events::emit_updated_max_open_interest_position_params(*arg1, arg3, arg2);
    }

    public(friend) fun set_max_pending_orders(arg0: &mut MarketParams, arg1: &0x2::object::ID, arg2: u64) {
        assert!(arg2 > 0 && arg2 < 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::constants::up_max_pending_orders(), 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::errors::invalid_market_parameters());
        arg0.limits_params.max_pending_orders = arg2;
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::events::emit_updated_max_pending_orders(*arg1, arg2);
    }

    public(friend) fun set_max_socialize_losses_mr_decrease(arg0: &mut MarketParams, arg1: &0x2::object::ID, arg2: u256) {
        assert!(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::greater_than_eq(arg2, 0) && 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::less_than_eq(arg2, 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::constants::one_fixed()), 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::errors::invalid_market_parameters());
        arg0.limits_params.max_socialize_losses_mr_decrease = arg2;
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::events::emit_updated_max_socialize_losses_mr_decrease(*arg1, arg2);
    }

    public(friend) fun set_min_order_usd_value(arg0: &mut MarketParams, arg1: &0x2::object::ID, arg2: u256) {
        assert!(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::less_than_eq(arg2, 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::constants::up_min_order_usd_value()) && 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::greater_than_eq(arg2, 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::constants::low_min_order_usd_value()), 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::errors::invalid_market_parameters());
        arg0.limits_params.min_order_usd_value = arg2;
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::events::emit_updated_min_order_usd_value(*arg1, arg2);
    }

    public(friend) fun try_update_funding(arg0: &MarketParams, arg1: &mut MarketState, arg2: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::PriceFeedStorage, arg3: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::config::Config, arg4: &0x2::clock::Clock, arg5: &0x2::object::ID, arg6: 0x1::option::Option<u256>) {
        let v0 = get_base_oracle_price(arg0, arg2, arg3, arg4);
        let v1 = if (0x1::option::is_none<u256>(&arg6)) {
            v0
        } else {
            clip_max_book_index_spread(0x1::option::destroy_some<u256>(arg6), v0)
        };
        let v2 = 0x2::clock::timestamp_ms(arg4);
        assert!(is_time_to_update(v2, arg1.funding_last_upd_ms, arg0.twap_params.funding_frequency_ms), 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::errors::updating_funding_too_early());
        if (v2 >= arg1.premium_twap_last_upd_ms + arg0.twap_params.premium_twap_frequency_ms) {
            update_premium_twap(arg1, arg0, v0, v1, v2, arg5);
        };
        update_fundings(arg1, arg0, v2, arg5);
    }

    public(friend) fun try_update_fundings_and_twaps(arg0: &MarketParams, arg1: &mut MarketState, arg2: u64, arg3: u256, arg4: u256, arg5: u256, arg6: &0x2::object::ID) {
        let v0 = clip_max_book_index_spread(arg4, arg3);
        if (arg2 >= arg1.premium_twap_last_upd_ms + arg0.twap_params.premium_twap_frequency_ms) {
            update_premium_twap(arg1, arg0, arg3, v0, arg2, arg6);
        };
        if (arg2 >= arg1.spread_twap_last_upd_ms + arg0.twap_params.spread_twap_frequency_ms) {
            update_spread_twap(arg1, arg0, arg3, v0, arg2, arg6);
        };
        if (arg2 > arg1.gas_price_last_upd_ms) {
            update_gas_price_twap(arg1, arg5, arg2, arg0.twap_params.gas_price_twap_period_ms, arg6);
        };
        if (is_time_to_update(arg2, arg1.funding_last_upd_ms, arg0.twap_params.funding_frequency_ms)) {
            update_fundings(arg1, arg0, arg2, arg6);
        };
    }

    public(friend) fun try_update_twaps(arg0: &MarketParams, arg1: &mut MarketState, arg2: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::PriceFeedStorage, arg3: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::config::Config, arg4: &0x2::clock::Clock, arg5: &0x2::object::ID, arg6: 0x1::option::Option<u256>) {
        let v0 = get_base_oracle_price(arg0, arg2, arg3, arg4);
        let v1 = if (0x1::option::is_none<u256>(&arg6)) {
            v0
        } else {
            clip_max_book_index_spread(0x1::option::destroy_some<u256>(arg6), v0)
        };
        let v2 = 0x2::clock::timestamp_ms(arg4);
        if (v2 >= arg1.premium_twap_last_upd_ms + arg0.twap_params.premium_twap_frequency_ms) {
            update_premium_twap(arg1, arg0, v0, v1, v2, arg5);
        };
        if (v2 >= arg1.spread_twap_last_upd_ms + arg0.twap_params.spread_twap_frequency_ms) {
            update_spread_twap(arg1, arg0, v0, v1, v2, arg5);
        };
    }

    public(friend) fun update_fees(arg0: &mut MarketParams, arg1: &0x2::object::ID, arg2: u256, arg3: u256, arg4: u256, arg5: u256, arg6: u256) {
        check_market_fees(arg2, arg3);
        check_liquidation_fees(arg4, arg5, arg6);
        arg0.fees_params.maker_fee = arg2;
        arg0.fees_params.taker_fee = arg3;
        arg0.fees_params.liquidation_fee = arg4;
        arg0.fees_params.force_cancel_fee = arg5;
        arg0.fees_params.insurance_fund_fee = arg6;
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::events::emit_updated_fees(*arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public(friend) fun update_funding_parameters(arg0: &mut MarketParams, arg1: &0x2::object::ID, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        check_funding_parameters(arg2, arg3, arg4, arg5);
        arg0.twap_params.funding_frequency_ms = arg2;
        arg0.twap_params.funding_period_ms = arg3;
        arg0.twap_params.premium_twap_frequency_ms = arg4;
        arg0.twap_params.premium_twap_period_ms = arg5;
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::events::emit_updated_funding_parameters(*arg1, arg2, arg3, arg4, arg5);
    }

    fun update_fundings(arg0: &mut MarketState, arg1: &MarketParams, arg2: u64, arg3: &0x2::object::ID) {
        let v0 = 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::mul(arg0.premium_twap, compute_period_adjustment(arg2, arg0.funding_last_upd_ms, arg1.twap_params.funding_frequency_ms, arg1.twap_params.funding_period_ms));
        arg0.cum_funding_rate_long = 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::add(arg0.cum_funding_rate_long, v0);
        arg0.cum_funding_rate_short = 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::add(arg0.cum_funding_rate_short, v0);
        arg0.funding_last_upd_ms = arg2;
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::events::emit_updated_funding(*arg3, arg0.cum_funding_rate_long, arg0.cum_funding_rate_short, arg0.funding_last_upd_ms);
    }

    fun update_gas_price_twap(arg0: &mut MarketState, arg1: u256, arg2: u64, arg3: u64, arg4: &0x2::object::ID) {
        let v0 = 0x1::u64::max(arg2 - arg0.gas_price_last_upd_ms, 1);
        let v1 = if (v0 >= arg3) {
            1
        } else {
            arg3 - v0
        };
        let v2 = 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_u64(v0);
        let v3 = 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_u64(v1);
        let v4 = 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::add(v2, v3);
        let v5 = 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::div(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::add(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::mul(arg1, v2), 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::mul(arg0.gas_price_mean, v3)), v4);
        let v6 = if (arg1 > v5) {
            arg1 - v5
        } else {
            v5 - arg1
        };
        let v7 = if (arg0.gas_price_variance == 0) {
            0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::mul(v6, v6)
        } else {
            0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::div(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::add(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::mul(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::mul(v6, v6), v2), 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::mul(arg0.gas_price_variance, v3)), v4)
        };
        arg0.gas_price_last_upd_ms = arg2;
        arg0.gas_price_mean = v5;
        arg0.gas_price_variance = v7;
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::events::emit_updated_gas_price_twap(*arg4, arg1, v5, v7, arg2);
    }

    public(friend) fun update_gas_price_twap_parameters(arg0: &mut MarketParams, arg1: &0x2::object::ID, arg2: u64, arg3: u256, arg4: u256) {
        check_gas_price_twap_parameters(arg2, arg4, arg3);
        arg0.limits_params.z_score_threshold = arg4;
        arg0.fees_params.gas_price_taker_fee = arg3;
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::events::emit_updated_gas_price_twap_parameters(*arg1, arg2, arg3, arg4);
    }

    public(friend) fun update_margin_ratios(arg0: &mut MarketParams, arg1: u256, arg2: u256) {
        arg0.core_params.margin_ratio_initial = arg1;
        arg0.core_params.margin_ratio_maintenance = arg2;
    }

    public(friend) fun update_market_lot_and_tick(arg0: &0x2::object::ID, arg1: &mut MarketParams, arg2: u64, arg3: u64) {
        check_lot_and_tick_sizes(arg2, arg3);
        arg1.core_params.lot_size = arg2;
        arg1.core_params.tick_size = arg3;
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::events::emit_updated_market_lot_and_tick(*arg0, arg2, arg3);
    }

    fun update_premium_twap(arg0: &mut MarketState, arg1: &MarketParams, arg2: u256, arg3: u256, arg4: u64, arg5: &0x2::object::ID) {
        arg0.premium_twap = update_twap(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::sub(arg3, arg2), arg0.premium_twap, arg4, arg0.premium_twap_last_upd_ms, arg1.twap_params.premium_twap_period_ms);
        arg0.premium_twap_last_upd_ms = arg4;
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::events::emit_updated_premium_twap(*arg5, arg3, arg2, arg0.premium_twap, arg0.premium_twap_last_upd_ms);
    }

    fun update_spread_twap(arg0: &mut MarketState, arg1: &MarketParams, arg2: u256, arg3: u256, arg4: u64, arg5: &0x2::object::ID) {
        arg0.spread_twap = update_twap(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::sub(arg3, arg2), arg0.spread_twap, arg4, arg0.spread_twap_last_upd_ms, arg1.twap_params.spread_twap_period_ms);
        arg0.spread_twap_last_upd_ms = arg4;
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::events::emit_updated_spread_twap(*arg5, arg3, arg2, arg0.spread_twap, arg0.spread_twap_last_upd_ms);
    }

    public(friend) fun update_spread_twap_parameters(arg0: &mut MarketParams, arg1: &0x2::object::ID, arg2: u64, arg3: u64) {
        check_spread_twap_parameters(arg2, arg3);
        arg0.twap_params.spread_twap_frequency_ms = arg2;
        arg0.twap_params.spread_twap_period_ms = arg3;
        0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::events::emit_updated_spread_twap_parameters(*arg1, arg2, arg3);
    }

    fun update_twap(arg0: u256, arg1: u256, arg2: u64, arg3: u64, arg4: u64) : u256 {
        let v0 = 0x1::u64::max(arg2 - arg3, 1);
        let v1 = if (v0 >= arg4) {
            1
        } else {
            arg4 - v0
        };
        0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::div(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::add(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::mul(arg0, 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_u64(v0)), 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::mul(arg1, 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_u64(v1))), 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_u64(v0 + v1))
    }

    // decompiled from Move bytecode v6
}

