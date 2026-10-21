module 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market {
    struct MarketParams has copy, drop, store {
        core_params: CoreParams,
        fees_params: FeesParams,
        twap_params: TwapParams,
        limits_params: LimitsParams,
    }

    struct CoreParams has copy, drop, store {
        base_storage_id: u32,
        collateral_storage_id: u32,
        base_source_id: u16,
        collateral_source_id: u16,
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
        insurance_fund_fee: u256,
        priority_taker_fee: 0x1::option::Option<u256>,
    }

    struct TwapParams has copy, drop, store {
        funding_frequency_ms: u64,
        funding_period_ms: u64,
        premium_twap_frequency_ms: u64,
        premium_twap_period_ms: u64,
        spread_twap_frequency_ms: u64,
        spread_twap_period_ms: u64,
    }

    struct LimitsParams has copy, drop, store {
        min_order_usd_value: u256,
        max_pending_orders: u64,
        max_open_interest: u256,
        max_open_interest_threshold: u256,
        max_open_interest_position_percent: u256,
        max_book_index_spread: u256,
        max_index_twap_divergence: u256,
        max_bad_debt: u256,
        max_socialize_losses_mr_decrease: u256,
        max_funding_rate: u256,
    }

    struct MarketCreationParams has copy, drop {
        margin_ratio_initial: u256,
        margin_ratio_maintenance: u256,
        lot_size: u64,
        tick_size: u64,
        max_bad_debt: u256,
        max_socialize_losses_mr_decrease: u256,
        maker_fee: u256,
        taker_fee: u256,
        liquidation_fee: u256,
        insurance_fund_fee: u256,
        funding_frequency_ms: u64,
        funding_period_ms: u64,
        premium_twap_frequency_ms: u64,
        premium_twap_period_ms: u64,
        spread_twap_frequency_ms: u64,
        spread_twap_period_ms: u64,
        priority_taker_fee: 0x1::option::Option<u256>,
    }

    struct MarketState has store {
        cum_funding_rate_long: u256,
        cum_funding_rate_short: u256,
        funding_last_upd_ms: u64,
        premium_twap: u256,
        premium_twap_last_upd_ms: u64,
        spread_twap: u256,
        spread_twap_last_upd_ms: u64,
        open_interest: u256,
        fees_accrued: u256,
    }

    public(friend) fun set_base_oracle_params(arg0: &mut MarketParams, arg1: &0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::Config, arg2: &0x2::object::ID, arg3: u32, arg4: 0x1::option::Option<u16>, arg5: 0x1::option::Option<u64>) {
        let v0 = option_u16_or(&arg4, arg0.core_params.base_source_id);
        let v1 = option_u64_or(&arg5, arg0.core_params.base_pfs_tolerance);
        assert!(v1 >= 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::min_oracle_tolerance(arg1), 1025);
        arg0.core_params.base_storage_id = arg3;
        arg0.core_params.base_source_id = v0;
        arg0.core_params.base_pfs_tolerance = v1;
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::events::set_base_oracle_params(*arg2, arg3, v0, v1);
    }

    public(friend) fun set_collateral_oracle_params(arg0: &mut MarketParams, arg1: &0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::Config, arg2: &0x2::object::ID, arg3: u32, arg4: 0x1::option::Option<u16>, arg5: 0x1::option::Option<u64>) {
        let v0 = option_u16_or(&arg4, arg0.core_params.collateral_source_id);
        let v1 = option_u64_or(&arg5, arg0.core_params.collateral_pfs_tolerance);
        assert!(v1 >= 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::min_oracle_tolerance(arg1), 1025);
        arg0.core_params.collateral_storage_id = arg3;
        arg0.core_params.collateral_source_id = v0;
        arg0.core_params.collateral_pfs_tolerance = v1;
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::events::set_collateral_oracle_params(*arg2, arg3, v0, v1);
    }

    public(friend) fun set_core_params(arg0: &mut MarketParams, arg1: &0x2::object::ID, arg2: 0x1::option::Option<u64>, arg3: 0x1::option::Option<u64>, arg4: 0x1::option::Option<u256>) {
        let v0 = option_u64_or(&arg2, arg0.core_params.lot_size);
        let v1 = option_u64_or(&arg3, arg0.core_params.tick_size);
        let v2 = option_u256_or(&arg4, arg0.core_params.collateral_haircut);
        assert_lot_and_tick_sizes(v0, v1);
        assert!(arg0.core_params.lot_size % v0 == 0 && arg0.core_params.tick_size % v1 == 0, 1007);
        assert!(0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::greater_than_eq(v2, 0) && 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::less_than(v2, 1000000000000000000), 1015);
        arg0.core_params.lot_size = v0;
        arg0.core_params.tick_size = v1;
        arg0.core_params.collateral_haircut = v2;
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::events::set_core_params(*arg1, v0, v1, v2);
    }

    public(friend) fun set_fee_params(arg0: &mut MarketParams, arg1: &0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::Config, arg2: &0x2::object::ID, arg3: 0x1::option::Option<u256>, arg4: 0x1::option::Option<u256>, arg5: 0x1::option::Option<u256>, arg6: 0x1::option::Option<u256>, arg7: 0x1::option::Option<0x1::option::Option<u256>>) {
        let v0 = option_u256_or(&arg3, arg0.fees_params.maker_fee);
        let v1 = option_u256_or(&arg4, arg0.fees_params.taker_fee);
        let v2 = option_u256_or(&arg5, arg0.fees_params.liquidation_fee);
        let v3 = option_u256_or(&arg6, arg0.fees_params.insurance_fund_fee);
        let v4 = if (0x1::option::is_some<0x1::option::Option<u256>>(&arg7)) {
            0x1::option::destroy_some<0x1::option::Option<u256>>(arg7)
        } else {
            arg0.fees_params.priority_taker_fee
        };
        assert_market_fees(arg1, v0, v1);
        assert_priority_taker_fee(arg1, v4);
        assert_liquidation_fees(arg1, v2, v3);
        assert_liquidation_fees_against_mmr(arg0.core_params.margin_ratio_maintenance, v2, v3);
        arg0.fees_params.maker_fee = v0;
        arg0.fees_params.taker_fee = v1;
        arg0.fees_params.liquidation_fee = v2;
        arg0.fees_params.insurance_fund_fee = v3;
        arg0.fees_params.priority_taker_fee = v4;
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::events::set_fee_params(*arg2, v0, v1, v2, v3, v4);
    }

    public(friend) fun set_risk_limit_params(arg0: &mut MarketParams, arg1: &0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::Config, arg2: &0x2::object::ID, arg3: 0x1::option::Option<u256>, arg4: 0x1::option::Option<u64>, arg5: 0x1::option::Option<u256>, arg6: 0x1::option::Option<u256>, arg7: 0x1::option::Option<u256>, arg8: 0x1::option::Option<u256>, arg9: 0x1::option::Option<u256>, arg10: 0x1::option::Option<u256>, arg11: 0x1::option::Option<u256>, arg12: 0x1::option::Option<u256>) {
        let v0 = option_u256_or(&arg3, arg0.limits_params.min_order_usd_value);
        let v1 = option_u64_or(&arg4, arg0.limits_params.max_pending_orders);
        let v2 = option_u256_or(&arg5, arg0.limits_params.max_open_interest);
        let v3 = arg0.limits_params.max_open_interest_threshold;
        let v4 = if (v3 == arg0.limits_params.max_open_interest && !0x1::option::is_some<u256>(&arg6)) {
            v2
        } else {
            option_u256_or(&arg6, v3)
        };
        let v5 = option_u256_or(&arg7, arg0.limits_params.max_open_interest_position_percent);
        let v6 = option_u256_or(&arg8, arg0.limits_params.max_book_index_spread);
        let v7 = option_u256_or(&arg9, arg0.limits_params.max_index_twap_divergence);
        let v8 = option_u256_or(&arg10, arg0.limits_params.max_bad_debt);
        let v9 = option_u256_or(&arg11, arg0.limits_params.max_socialize_losses_mr_decrease);
        let v10 = option_u256_or(&arg12, arg0.limits_params.max_funding_rate);
        assert!(0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::less_than_eq(v0, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::up_min_order_usd_value(arg1)) && 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::greater_than_eq(v0, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::low_min_order_usd_value(arg1)), 1008);
        assert!(v1 > 0 && v1 <= 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::up_max_pending_orders(arg1), 1009);
        assert!(0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::greater_than(v2, 0) && 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::less_than_eq(v4, v2), 1010);
        assert!(0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::greater_than_eq(v6, 0) && 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::less_than_eq(v6, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::max_book_index_spread(arg1)), 1027);
        assert!(0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::greater_than_eq(v7, 0) && 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::less_than_eq(v7, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::max_index_twap_divergence(arg1)), 1028);
        assert!(0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::greater_than(v5, 0) && 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::less_than_eq(v5, 1000000000000000000), 1011);
        assert!(0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::greater_than(v4, 0), 1012);
        assert_bad_debt_limits(v8, v9);
        assert!(0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::greater_than(v10, 0) && 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::less_than_eq(v10, 1000000000000000000), 1029);
        arg0.limits_params.min_order_usd_value = v0;
        arg0.limits_params.max_pending_orders = v1;
        arg0.limits_params.max_open_interest = v2;
        arg0.limits_params.max_open_interest_threshold = v4;
        arg0.limits_params.max_open_interest_position_percent = v5;
        arg0.limits_params.max_book_index_spread = v6;
        arg0.limits_params.max_index_twap_divergence = v7;
        arg0.limits_params.max_bad_debt = v8;
        arg0.limits_params.max_socialize_losses_mr_decrease = v9;
        arg0.limits_params.max_funding_rate = v10;
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::events::set_risk_limit_params(*arg2, v0, v1, v2, v4, v5, v6, v7, v8, v9, v10);
    }

    public(friend) fun set_twap_params(arg0: &mut MarketParams, arg1: &0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::Config, arg2: &0x2::object::ID, arg3: 0x1::option::Option<u64>, arg4: 0x1::option::Option<u64>, arg5: 0x1::option::Option<u64>, arg6: 0x1::option::Option<u64>, arg7: 0x1::option::Option<u64>, arg8: 0x1::option::Option<u64>) {
        let v0 = option_u64_or(&arg3, arg0.twap_params.funding_frequency_ms);
        let v1 = option_u64_or(&arg4, arg0.twap_params.funding_period_ms);
        let v2 = option_u64_or(&arg5, arg0.twap_params.premium_twap_frequency_ms);
        let v3 = option_u64_or(&arg6, arg0.twap_params.premium_twap_period_ms);
        let v4 = option_u64_or(&arg7, arg0.twap_params.spread_twap_frequency_ms);
        let v5 = option_u64_or(&arg8, arg0.twap_params.spread_twap_period_ms);
        assert_funding_parameters(arg1, v0, v1, v2, v3);
        assert_spread_twap_parameters(arg1, v4, v5);
        arg0.twap_params.funding_frequency_ms = v0;
        arg0.twap_params.funding_period_ms = v1;
        arg0.twap_params.premium_twap_frequency_ms = v2;
        arg0.twap_params.premium_twap_period_ms = v3;
        arg0.twap_params.spread_twap_frequency_ms = v4;
        arg0.twap_params.spread_twap_period_ms = v5;
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::events::set_twap_params(*arg2, v0, v1, v2, v3, v4, v5);
    }

    public(friend) fun add_bad_debt_to_market(arg0: &mut MarketState, arg1: &0x2::object::ID, arg2: bool, arg3: u256, arg4: u256) {
        if (arg2) {
            arg0.cum_funding_rate_long = 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::add(arg0.cum_funding_rate_long, arg4);
        } else {
            arg0.cum_funding_rate_short = 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::sub(arg0.cum_funding_rate_short, arg4);
        };
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::events::socialized_bad_debt(*arg1, arg3, arg4, arg2, arg0.cum_funding_rate_long, arg0.cum_funding_rate_short);
    }

    public(friend) fun add_fees_accrued_usd(arg0: &mut MarketState, arg1: u256, arg2: u256) {
        arg0.fees_accrued = 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::add(arg0.fees_accrued, 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::div(arg1, arg2));
    }

    public(friend) fun add_to_open_interest(arg0: &mut MarketState, arg1: u256) {
        arg0.open_interest = 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::add(arg0.open_interest, arg1);
    }

    fun assert_bad_debt_limits(arg0: u256, arg1: u256) {
        assert!(0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::greater_than_eq(arg0, 0), 1013);
        assert!(0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::greater_than_eq(arg1, 0) && 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::less_than_eq(arg1, 1000000000000000000), 1014);
    }

    fun assert_funding_parameters(arg0: &0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::Config, arg1: u64, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = if (arg2 >= 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::min_funding_period_ms(arg0)) {
            if (arg2 <= 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::max_funding_period_ms(arg0)) {
                if (arg1 >= 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::min_funding_frequency_ms(arg0)) {
                    if (arg2 > arg1) {
                        arg2 % arg1 == 0
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
        assert!(v0, 1017);
        let v1 = if (arg3 >= 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::min_premium_twap_frequency_ms(arg0)) {
            if (arg4 >= 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::min_premium_twap_period_ms(arg0)) {
                arg4 > arg3
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 1019);
    }

    public fun assert_index_twap_divergence_within_limit(arg0: &MarketParams, arg1: u256, arg2: u256) {
        assert!(0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::less_than_eq(0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::abs(0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::sub(arg1, arg2)), 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::mul(arg2, arg0.limits_params.max_index_twap_divergence)), 1003);
    }

    fun assert_liquidation_fees(arg0: &0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::Config, arg1: u256, arg2: u256) {
        let v0 = if (!0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::is_neg(arg1)) {
            if (0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::less_than_eq(arg1, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::max_liquidation_fee(arg0))) {
                if (!0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::is_neg(arg2)) {
                    0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::less_than_eq(arg2, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::max_insurance_fund_fee(arg0))
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 1023);
    }

    public(friend) fun assert_liquidation_fees_against_mmr(arg0: u256, arg1: u256, arg2: u256) {
        assert!(0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::less_than(0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::add(arg1, arg2), arg0), 1024);
    }

    fun assert_lot_and_tick_sizes(arg0: u64, arg1: u64) {
        let v0 = if (arg0 > 0) {
            if (arg0 <= 1000000000) {
                if (arg1 > 0) {
                    arg1 <= 1000000000
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 1026);
    }

    public(friend) fun assert_margin_ratios(arg0: u256, arg1: u256) {
        let v0 = if (0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::less_than_eq(arg0, 1000000000000000000)) {
            if (0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::less_than(arg1, arg0)) {
                0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::greater_than(arg1, 0)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 1016);
    }

    fun assert_market_fees(arg0: &0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::Config, arg1: u256, arg2: u256) {
        assert!(0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::less_than_eq(0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::abs(arg1), 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::max_abs_maker_fee(arg0)) && 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::less_than_eq(0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::abs(arg2), 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::max_abs_taker_fee(arg0)), 1020);
        assert!(!0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::is_neg(arg1) || !0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::is_neg(arg2) && 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::less_than_eq(0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::abs(arg1), arg2), 1021);
        assert!(!0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::is_neg(arg2) || !0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::is_neg(arg1) && 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::less_than_eq(0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::abs(arg2), arg1), 1022);
    }

    fun assert_priority_taker_fee(arg0: &0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::Config, arg1: 0x1::option::Option<u256>) {
        if (0x1::option::is_none<u256>(&arg1)) {
            return
        };
        let v0 = *0x1::option::borrow<u256>(&arg1);
        assert!(0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::greater_than_eq(v0, 0) && 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::less_than_eq(v0, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::max_abs_taker_fee(arg0)), 1018);
    }

    fun assert_spread_twap_parameters(arg0: &0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::Config, arg1: u64, arg2: u64) {
        let v0 = if (arg1 >= 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::min_spread_twap_frequency_ms(arg0)) {
            if (arg2 >= 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::min_spread_twap_period_ms(arg0)) {
                arg2 > arg1
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 1019);
    }

    public fun base_oracle_price_and_twap_price(arg0: &MarketParams, arg1: &0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed_storage::PriceFeedStorage, arg2: &0x2::clock::Clock) : (u256, u256) {
        assert!(0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed_storage::storage_id(arg1) == arg0.core_params.base_storage_id, 1001);
        let v0 = 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed_storage::price_feed(arg1, arg0.core_params.base_source_id);
        let (v1, v2) = 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed::price_and_timestamp_ms(v0);
        let v3 = 0x2::clock::timestamp_ms(arg2);
        if (v3 - 0x1::u64::min(v3, arg0.core_params.base_pfs_tolerance) > v2) {
            abort 1000
        };
        ((v1 as u256), (0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed::twap_price(v0) as u256))
    }

    public fun base_source_id(arg0: &MarketParams) : u16 {
        arg0.core_params.base_source_id
    }

    public fun base_storage_id(arg0: &MarketParams) : u32 {
        arg0.core_params.base_storage_id
    }

    public fun calculate_funding_price(arg0: &MarketState, arg1: &MarketParams, arg2: u256, arg3: u64) : u256 {
        0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::add(arg2, 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::mul(arg0.premium_twap, 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::from_u64fraction(0x1::u64::max(arg3, next_funding_update_time(arg0.funding_last_upd_ms, arg1.twap_params.funding_frequency_ms)) - arg3, arg1.twap_params.funding_period_ms)))
    }

    public fun calculate_mark_price(arg0: &MarketState, arg1: &MarketParams, arg2: u256, arg3: u256, arg4: u64) : u256 {
        let v0 = calculate_funding_price(arg0, arg1, arg2, arg4);
        let v1 = 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::add(arg2, spread_twap(arg0));
        0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::max(0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::min(v1, v0), 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::min(0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::max(v1, v0), arg3))
    }

    public fun clip_max_book_index_spread(arg0: &MarketParams, arg1: u256, arg2: u256) : u256 {
        assert!(arg2 != 0, 1000);
        let v0 = 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::mul(arg2, arg0.limits_params.max_book_index_spread);
        let v1 = 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::add(arg2, v0);
        let v2 = 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::sub(arg2, v0);
        if (0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::greater_than(arg1, v1)) {
            v1
        } else if (0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::less_than(arg1, v2)) {
            v2
        } else {
            arg1
        }
    }

    public fun clip_max_funding_premium(arg0: &MarketParams, arg1: u256, arg2: u256) : u256 {
        let v0 = 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::mul(arg2, arg0.limits_params.max_funding_rate);
        if (0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::greater_than(arg1, v0)) {
            v0
        } else if (0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::less_than(arg1, 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::neg(v0))) {
            0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::neg(v0)
        } else {
            arg1
        }
    }

    public fun collateral_haircut(arg0: &MarketParams) : u256 {
        arg0.core_params.collateral_haircut
    }

    public fun collateral_oracle_price(arg0: &MarketParams, arg1: &0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed_storage::PriceFeedStorage, arg2: &0x2::clock::Clock) : u256 {
        assert!(0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed_storage::storage_id(arg1) == arg0.core_params.collateral_storage_id, 1002);
        let v0 = 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed_storage::price_feed(arg1, arg0.core_params.collateral_source_id);
        let (v1, v2) = 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed::price_and_timestamp_ms(v0);
        let v3 = 0x2::clock::timestamp_ms(arg2);
        if (v3 - 0x1::u64::min(v3, arg0.core_params.collateral_pfs_tolerance) > v2) {
            abort 1000
        };
        let v4 = (v1 as u256);
        assert_index_twap_divergence_within_limit(arg0, v4, (0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed::twap_price(v0) as u256));
        v4
    }

    public fun collateral_source_id(arg0: &MarketParams) : u16 {
        arg0.core_params.collateral_source_id
    }

    public fun collateral_storage_id(arg0: &MarketParams) : u32 {
        arg0.core_params.collateral_storage_id
    }

    public(friend) fun create_market_objects(arg0: &0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::Config, arg1: &0x2::clock::Clock, arg2: u32, arg3: u32, arg4: u16, arg5: u16, arg6: &MarketCreationParams, arg7: u256) : (MarketParams, MarketState) {
        assert_margin_ratios(arg6.margin_ratio_initial, arg6.margin_ratio_maintenance);
        assert_funding_parameters(arg0, arg6.funding_frequency_ms, arg6.funding_period_ms, arg6.premium_twap_frequency_ms, arg6.premium_twap_period_ms);
        assert_spread_twap_parameters(arg0, arg6.spread_twap_frequency_ms, arg6.spread_twap_period_ms);
        assert_market_fees(arg0, arg6.maker_fee, arg6.taker_fee);
        assert_priority_taker_fee(arg0, arg6.priority_taker_fee);
        assert_bad_debt_limits(arg6.max_bad_debt, arg6.max_socialize_losses_mr_decrease);
        assert_liquidation_fees(arg0, arg6.liquidation_fee, arg6.insurance_fund_fee);
        assert_liquidation_fees_against_mmr(arg6.margin_ratio_maintenance, arg6.liquidation_fee, arg6.insurance_fund_fee);
        assert_lot_and_tick_sizes(arg6.lot_size, arg6.tick_size);
        (create_market_params(arg0, arg2, arg3, arg4, arg5, arg6, arg7), create_market_state(0x2::clock::timestamp_ms(arg1)))
    }

    fun create_market_params(arg0: &0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::Config, arg1: u32, arg2: u32, arg3: u16, arg4: u16, arg5: &MarketCreationParams, arg6: u256) : MarketParams {
        let v0 = CoreParams{
            base_storage_id          : arg1,
            collateral_storage_id    : arg2,
            base_source_id           : arg3,
            collateral_source_id     : arg4,
            base_pfs_tolerance       : 10000,
            collateral_pfs_tolerance : 30000,
            lot_size                 : arg5.lot_size,
            tick_size                : arg5.tick_size,
            scaling_factor           : arg6,
            collateral_haircut       : 0,
            margin_ratio_initial     : arg5.margin_ratio_initial,
            margin_ratio_maintenance : arg5.margin_ratio_maintenance,
        };
        let v1 = FeesParams{
            maker_fee          : arg5.maker_fee,
            taker_fee          : arg5.taker_fee,
            liquidation_fee    : arg5.liquidation_fee,
            insurance_fund_fee : arg5.insurance_fund_fee,
            priority_taker_fee : arg5.priority_taker_fee,
        };
        let v2 = TwapParams{
            funding_frequency_ms      : arg5.funding_frequency_ms,
            funding_period_ms         : arg5.funding_period_ms,
            premium_twap_frequency_ms : arg5.premium_twap_frequency_ms,
            premium_twap_period_ms    : arg5.premium_twap_period_ms,
            spread_twap_frequency_ms  : arg5.spread_twap_frequency_ms,
            spread_twap_period_ms     : arg5.spread_twap_period_ms,
        };
        let v3 = LimitsParams{
            min_order_usd_value                : 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::low_min_order_usd_value(arg0),
            max_pending_orders                 : 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::up_max_pending_orders(arg0),
            max_open_interest                  : 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::from_u64(18446744073709551615),
            max_open_interest_threshold        : 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::from_u64(18446744073709551615),
            max_open_interest_position_percent : 200000000000000000,
            max_book_index_spread              : 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::from_u64fraction(5, 100),
            max_index_twap_divergence          : 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::from_u64fraction(5, 100),
            max_bad_debt                       : arg5.max_bad_debt,
            max_socialize_losses_mr_decrease   : arg5.max_socialize_losses_mr_decrease,
            max_funding_rate                   : 5000000000000000,
        };
        MarketParams{
            core_params   : v0,
            fees_params   : v1,
            twap_params   : v2,
            limits_params : v3,
        }
    }

    fun create_market_state(arg0: u64) : MarketState {
        MarketState{
            cum_funding_rate_long    : 0,
            cum_funding_rate_short   : 0,
            funding_last_upd_ms      : arg0,
            premium_twap             : 0,
            premium_twap_last_upd_ms : arg0,
            spread_twap              : 0,
            spread_twap_last_upd_ms  : arg0,
            open_interest            : 0,
            fees_accrued             : 0,
        }
    }

    public fun cum_funding_rates(arg0: &MarketState) : (u256, u256) {
        (arg0.cum_funding_rate_long, arg0.cum_funding_rate_short)
    }

    public fun fees_accrued(arg0: &MarketState) : u256 {
        arg0.fees_accrued
    }

    public fun funding_last_upd_ms(arg0: &MarketState) : u64 {
        arg0.funding_last_upd_ms
    }

    public fun funding_params(arg0: &MarketParams) : (u64, u64) {
        (arg0.twap_params.funding_frequency_ms, arg0.twap_params.funding_period_ms)
    }

    public fun funding_period_adjustment(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u256 {
        let v0 = arg0 / arg2 - arg1 / arg2;
        let v1 = if (v0 > 3) {
            3
        } else {
            v0
        };
        0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::div(0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::mul(0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::from_u64(v1), 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::from_u64(arg2)), 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::from_u64(arg3))
    }

    public fun is_time_to_update(arg0: u64, arg1: u64, arg2: u64) : bool {
        arg0 >= next_funding_update_time(arg1, arg2)
    }

    public fun liquidation_fee_rates(arg0: &MarketParams) : (u256, u256) {
        (arg0.fees_params.liquidation_fee, arg0.fees_params.insurance_fund_fee)
    }

    public fun lot_size(arg0: &MarketParams) : u64 {
        arg0.core_params.lot_size
    }

    public fun maker_fee(arg0: &MarketParams) : u256 {
        arg0.fees_params.maker_fee
    }

    public fun maker_taker_fees(arg0: &MarketParams) : (u256, u256) {
        (arg0.fees_params.maker_fee, arg0.fees_params.taker_fee)
    }

    public fun margin_ratio_initial(arg0: &MarketParams) : u256 {
        arg0.core_params.margin_ratio_initial
    }

    public fun margin_ratio_maintenance(arg0: &MarketParams) : u256 {
        arg0.core_params.margin_ratio_maintenance
    }

    public fun max_bad_debt_thresholds(arg0: &MarketParams) : (u256, u256) {
        (arg0.limits_params.max_bad_debt, arg0.limits_params.max_socialize_losses_mr_decrease)
    }

    public fun max_book_index_spread(arg0: &MarketParams) : u256 {
        arg0.limits_params.max_book_index_spread
    }

    public fun max_funding_rate(arg0: &MarketParams) : u256 {
        arg0.limits_params.max_funding_rate
    }

    public fun max_index_twap_divergence(arg0: &MarketParams) : u256 {
        arg0.limits_params.max_index_twap_divergence
    }

    public fun max_open_interest(arg0: &MarketParams) : u256 {
        arg0.limits_params.max_open_interest
    }

    public fun max_open_interest_position_params(arg0: &MarketParams) : (u256, u256) {
        (arg0.limits_params.max_open_interest_threshold, arg0.limits_params.max_open_interest_position_percent)
    }

    public fun max_pending_orders(arg0: &MarketParams) : u64 {
        arg0.limits_params.max_pending_orders
    }

    public fun min_order_usd_value(arg0: &MarketParams) : u256 {
        arg0.limits_params.min_order_usd_value
    }

    public fun new_creation_params(arg0: u256, arg1: u256, arg2: u64, arg3: u64, arg4: u256, arg5: u256) : MarketCreationParams {
        MarketCreationParams{
            margin_ratio_initial             : arg0,
            margin_ratio_maintenance         : arg1,
            lot_size                         : arg2,
            tick_size                        : arg3,
            max_bad_debt                     : arg4,
            max_socialize_losses_mr_decrease : arg5,
            maker_fee                        : 0,
            taker_fee                        : 0,
            liquidation_fee                  : 0,
            insurance_fund_fee               : 0,
            funding_frequency_ms             : 60000,
            funding_period_ms                : 21600000,
            premium_twap_frequency_ms        : 1000,
            premium_twap_period_ms           : 60000,
            spread_twap_frequency_ms         : 1000,
            spread_twap_period_ms            : 60000,
            priority_taker_fee               : 0x1::option::none<u256>(),
        }
    }

    public fun next_funding_update_time(arg0: u64, arg1: u64) : u64 {
        arg0 - arg0 % arg1 + arg1
    }

    public fun open_interest(arg0: &MarketState) : u256 {
        arg0.open_interest
    }

    fun option_u16_or(arg0: &0x1::option::Option<u16>, arg1: u16) : u16 {
        if (0x1::option::is_some<u16>(arg0)) {
            *0x1::option::borrow<u16>(arg0)
        } else {
            arg1
        }
    }

    fun option_u256_or(arg0: &0x1::option::Option<u256>, arg1: u256) : u256 {
        if (0x1::option::is_some<u256>(arg0)) {
            *0x1::option::borrow<u256>(arg0)
        } else {
            arg1
        }
    }

    fun option_u64_or(arg0: &0x1::option::Option<u64>, arg1: u64) : u64 {
        if (0x1::option::is_some<u64>(arg0)) {
            *0x1::option::borrow<u64>(arg0)
        } else {
            arg1
        }
    }

    public fun premium_twap(arg0: &MarketState) : u256 {
        arg0.premium_twap
    }

    public fun premium_twap_params(arg0: &MarketParams) : (u64, u64) {
        (arg0.twap_params.premium_twap_frequency_ms, arg0.twap_params.premium_twap_period_ms)
    }

    public fun priority_taker_fee(arg0: &MarketParams) : 0x1::option::Option<u256> {
        arg0.fees_params.priority_taker_fee
    }

    public fun resolve_priority_taker_fee(arg0: 0x1::option::Option<u256>) : u256 {
        assert!(0x1::option::is_some<u256>(&arg0), 1004);
        *0x1::option::borrow<u256>(&arg0)
    }

    public fun scaling_factor(arg0: &MarketParams) : u256 {
        arg0.core_params.scaling_factor
    }

    public fun set_fees(arg0: &mut MarketCreationParams, arg1: u256, arg2: u256, arg3: u256, arg4: u256) {
        arg0.maker_fee = arg1;
        arg0.taker_fee = arg2;
        arg0.liquidation_fee = arg3;
        arg0.insurance_fund_fee = arg4;
    }

    public fun set_funding(arg0: &mut MarketCreationParams, arg1: u64, arg2: u64) {
        arg0.funding_frequency_ms = arg1;
        arg0.funding_period_ms = arg2;
    }

    public fun set_premium_twap(arg0: &mut MarketCreationParams, arg1: u64, arg2: u64) {
        arg0.premium_twap_frequency_ms = arg1;
        arg0.premium_twap_period_ms = arg2;
    }

    public fun set_priority_taker_fee(arg0: &mut MarketCreationParams, arg1: 0x1::option::Option<u256>) {
        arg0.priority_taker_fee = arg1;
    }

    public fun set_spread_twap(arg0: &mut MarketCreationParams, arg1: u64, arg2: u64) {
        arg0.spread_twap_frequency_ms = arg1;
        arg0.spread_twap_period_ms = arg2;
    }

    public fun spread_twap(arg0: &MarketState) : u256 {
        arg0.spread_twap
    }

    public fun spread_twap_params(arg0: &MarketParams) : (u64, u64) {
        (arg0.twap_params.spread_twap_frequency_ms, arg0.twap_params.spread_twap_period_ms)
    }

    public(friend) fun sub_fees_accrued(arg0: &mut MarketState, arg1: u256) {
        arg0.fees_accrued = 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::sub(arg0.fees_accrued, arg1);
    }

    public fun taker_fee(arg0: &MarketParams) : u256 {
        arg0.fees_params.taker_fee
    }

    public fun tick_size(arg0: &MarketParams) : u64 {
        arg0.core_params.tick_size
    }

    public(friend) fun try_update_funding(arg0: &MarketParams, arg1: &mut MarketState, arg2: &0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed_storage::PriceFeedStorage, arg3: &0x2::clock::Clock, arg4: &0x2::object::ID, arg5: 0x1::option::Option<u256>) {
        let (v0, v1) = base_oracle_price_and_twap_price(arg0, arg2, arg3);
        assert_index_twap_divergence_within_limit(arg0, v0, v1);
        let v2 = 0x2::clock::timestamp_ms(arg3);
        update_twaps(arg0, arg1, v0, arg5, v2, arg4);
        try_update_fundings(arg0, arg1, v2, arg4);
    }

    public(friend) fun try_update_fundings(arg0: &MarketParams, arg1: &mut MarketState, arg2: u64, arg3: &0x2::object::ID) {
        if (!is_time_to_update(arg2, arg1.funding_last_upd_ms, arg0.twap_params.funding_frequency_ms)) {
            return
        };
        let v0 = 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::mul(arg1.premium_twap, funding_period_adjustment(arg2, arg1.funding_last_upd_ms, arg0.twap_params.funding_frequency_ms, arg0.twap_params.funding_period_ms));
        arg1.cum_funding_rate_long = 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::add(arg1.cum_funding_rate_long, v0);
        arg1.cum_funding_rate_short = 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::add(arg1.cum_funding_rate_short, v0);
        arg1.funding_last_upd_ms = arg2;
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::events::updated_funding(*arg3, arg1.cum_funding_rate_long, arg1.cum_funding_rate_short, arg1.funding_last_upd_ms);
    }

    public(friend) fun try_update_fundings_and_twaps(arg0: &MarketParams, arg1: &mut MarketState, arg2: u64, arg3: u256, arg4: u256, arg5: &0x2::object::ID) {
        update_twaps(arg0, arg1, arg3, 0x1::option::some<u256>(arg4), arg2, arg5);
        try_update_fundings(arg0, arg1, arg2, arg5);
    }

    public(friend) fun try_update_twaps(arg0: &MarketParams, arg1: &mut MarketState, arg2: &0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed_storage::PriceFeedStorage, arg3: &0x2::clock::Clock, arg4: &0x2::object::ID, arg5: 0x1::option::Option<u256>) {
        let (v0, v1) = base_oracle_price_and_twap_price(arg0, arg2, arg3);
        assert_index_twap_divergence_within_limit(arg0, v0, v1);
        update_twaps(arg0, arg1, v0, arg5, 0x2::clock::timestamp_ms(arg3), arg4);
    }

    public(friend) fun update_margin_ratios(arg0: &mut MarketParams, arg1: u256, arg2: u256) {
        assert_margin_ratios(arg1, arg2);
        assert_liquidation_fees_against_mmr(arg2, arg0.fees_params.liquidation_fee, arg0.fees_params.insurance_fund_fee);
        arg0.core_params.margin_ratio_initial = arg1;
        arg0.core_params.margin_ratio_maintenance = arg2;
    }

    fun update_premium_twap(arg0: &mut MarketState, arg1: &MarketParams, arg2: u256, arg3: u256, arg4: u256, arg5: u64, arg6: &0x2::object::ID) {
        arg0.premium_twap = update_twap(clip_max_funding_premium(arg1, 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::sub(arg4, arg2), arg2), arg0.premium_twap, arg5, arg0.premium_twap_last_upd_ms, arg1.twap_params.premium_twap_period_ms);
        arg0.premium_twap_last_upd_ms = arg5;
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::events::updated_premium_twap(*arg6, arg3, arg4, arg2, arg0.premium_twap, arg0.premium_twap_last_upd_ms);
    }

    fun update_spread_twap(arg0: &mut MarketState, arg1: &MarketParams, arg2: u256, arg3: u256, arg4: u256, arg5: u64, arg6: &0x2::object::ID) {
        arg0.spread_twap = update_twap(0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::sub(arg4, arg2), arg0.spread_twap, arg5, arg0.spread_twap_last_upd_ms, arg1.twap_params.spread_twap_period_ms);
        arg0.spread_twap_last_upd_ms = arg5;
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::events::updated_spread_twap(*arg6, arg3, arg4, arg2, arg0.spread_twap, arg0.spread_twap_last_upd_ms);
    }

    public fun update_twap(arg0: u256, arg1: u256, arg2: u64, arg3: u64, arg4: u64) : u256 {
        let v0 = if (arg2 <= arg3) {
            1
        } else {
            arg2 - arg3
        };
        let v1 = if (v0 >= arg4) {
            1
        } else {
            arg4 - v0
        };
        let v2 = 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::add(0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::mul_i256(arg0, (v0 as u256)), 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::mul_i256(arg1, (v1 as u256)));
        if (0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::is_neg(v2)) {
            0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::neg(0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::abs(v2) / ((v0 + v1) as u256))
        } else {
            0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::abs(v2) / ((v0 + v1) as u256)
        }
    }

    fun update_twaps(arg0: &MarketParams, arg1: &mut MarketState, arg2: u256, arg3: 0x1::option::Option<u256>, arg4: u64, arg5: &0x2::object::ID) {
        let (v0, v1) = if (0x1::option::is_none<u256>(&arg3)) {
            (arg2, arg2)
        } else {
            let v2 = *0x1::option::borrow<u256>(&arg3);
            (v2, clip_max_book_index_spread(arg0, v2, arg2))
        };
        if (arg4 >= arg1.premium_twap_last_upd_ms + arg0.twap_params.premium_twap_frequency_ms) {
            update_premium_twap(arg1, arg0, arg2, v0, v1, arg4, arg5);
        };
        if (arg4 >= arg1.spread_twap_last_upd_ms + arg0.twap_params.spread_twap_frequency_ms) {
            update_spread_twap(arg1, arg0, arg2, v0, v1, arg4, arg5);
        };
    }

    // decompiled from Move bytecode v7
}

