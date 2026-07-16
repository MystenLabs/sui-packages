module 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::market {
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

    public(friend) fun add_bad_debt_to_market(arg0: &mut MarketState, arg1: &0x2::object::ID, arg2: bool, arg3: u256, arg4: u256) {
        if (arg2) {
            arg0.cum_funding_rate_long = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::add(arg0.cum_funding_rate_long, arg4);
        } else {
            arg0.cum_funding_rate_short = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::sub(arg0.cum_funding_rate_short, arg4);
        };
        0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::events::e26(*arg1, arg3, arg4, arg2, arg0.cum_funding_rate_long, arg0.cum_funding_rate_short);
    }

    public(friend) fun add_fees_accrued_usd(arg0: &mut MarketState, arg1: u256, arg2: u256) {
        arg0.fees_accrued = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::add(arg0.fees_accrued, 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::div(arg1, arg2));
    }

    public(friend) fun add_to_open_interest(arg0: &mut MarketState, arg1: u256) {
        arg0.open_interest = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::add(arg0.open_interest, arg1);
    }

    fun assert_funding_parameters(arg0: &0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::registry::Config, arg1: u64, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = if (arg2 >= 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::registry::min_funding_period_ms(arg0)) {
            if (arg2 <= 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::registry::max_funding_period_ms(arg0)) {
                if (arg1 >= 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::registry::min_funding_frequency_ms(arg0)) {
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
        let v1 = if (arg3 >= 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::registry::min_premium_twap_frequency_ms(arg0)) {
            if (arg4 >= 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::registry::min_premium_twap_period_ms(arg0)) {
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
        assert!(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::less_than_eq(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::abs(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::sub(arg1, arg2)), 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::mul(arg2, arg0.limits_params.max_index_twap_divergence)), 1003);
    }

    fun assert_liquidation_fees(arg0: &0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::registry::Config, arg1: u256, arg2: u256) {
        let v0 = if (!0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::is_neg(arg1)) {
            if (0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::less_than_eq(arg1, 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::registry::max_liquidation_fee(arg0))) {
                if (!0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::is_neg(arg2)) {
                    0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::less_than_eq(arg2, 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::registry::max_insurance_fund_fee(arg0))
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
        assert!(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::less_than(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::add(arg1, arg2), arg0), 1024);
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
        let v0 = if (0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::less_than_eq(arg0, 1000000000000000000)) {
            if (0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::less_than(arg1, arg0)) {
                0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::greater_than(arg1, 0)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 1016);
    }

    fun assert_market_fees(arg0: &0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::registry::Config, arg1: u256, arg2: u256) {
        assert!(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::less_than_eq(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::abs(arg1), 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::registry::max_abs_maker_fee(arg0)) && 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::less_than_eq(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::abs(arg2), 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::registry::max_abs_taker_fee(arg0)), 1020);
        assert!(!0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::is_neg(arg1) || !0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::is_neg(arg2) && 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::less_than_eq(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::abs(arg1), arg2), 1021);
        assert!(!0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::is_neg(arg2) || !0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::is_neg(arg1) && 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::less_than_eq(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::abs(arg2), arg1), 1022);
    }

    fun assert_priority_taker_fee(arg0: &0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::registry::Config, arg1: 0x1::option::Option<u256>) {
        if (0x1::option::is_none<u256>(&arg1)) {
            return
        };
        let v0 = *0x1::option::borrow<u256>(&arg1);
        assert!(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::greater_than_eq(v0, 0) && 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::less_than_eq(v0, 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::registry::max_abs_taker_fee(arg0)), 1018);
    }

    fun assert_spread_twap_parameters(arg0: &0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::registry::Config, arg1: u64, arg2: u64) {
        let v0 = if (arg1 >= 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::registry::min_spread_twap_frequency_ms(arg0)) {
            if (arg2 >= 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::registry::min_spread_twap_period_ms(arg0)) {
                arg2 > arg1
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 1019);
    }

    public fun base_oracle_price(arg0: &MarketParams, arg1: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::PriceFeedStorage, arg2: &0x2::clock::Clock) : u256 {
        assert!(0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::storage_id(arg1) == arg0.core_params.base_storage_id, 1001);
        let (v0, v1) = 0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed::price_and_timestamp_ms(0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::price_feed(arg1, arg0.core_params.base_source_id));
        let v2 = 0x2::clock::timestamp_ms(arg2);
        if (v2 - 0x1::u64::min(v2, arg0.core_params.base_pfs_tolerance) > v1) {
            abort 1000
        };
        (v0 as u256)
    }

    public fun base_oracle_price_and_twap_price(arg0: &MarketParams, arg1: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::PriceFeedStorage, arg2: &0x2::clock::Clock) : (u256, u256) {
        assert!(0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::storage_id(arg1) == arg0.core_params.base_storage_id, 1001);
        let v0 = 0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::price_feed(arg1, arg0.core_params.base_source_id);
        let (v1, v2) = 0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed::price_and_timestamp_ms(v0);
        let v3 = 0x2::clock::timestamp_ms(arg2);
        if (v3 - 0x1::u64::min(v3, arg0.core_params.base_pfs_tolerance) > v2) {
            abort 1000
        };
        ((v1 as u256), (0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed::twap_price(v0) as u256))
    }

    public fun base_pfs_tolerance(arg0: &MarketParams) : u64 {
        arg0.core_params.base_pfs_tolerance
    }

    public fun base_source_id(arg0: &MarketParams) : u16 {
        arg0.core_params.base_source_id
    }

    public fun base_storage_id(arg0: &MarketParams) : u32 {
        arg0.core_params.base_storage_id
    }

    public fun calculate_funding_price(arg0: &MarketState, arg1: &MarketParams, arg2: u256, arg3: u64) : u256 {
        0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::add(arg2, 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::mul(arg0.premium_twap, 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::from_u64fraction(0x1::u64::max(arg3, next_funding_update_time(arg0.funding_last_upd_ms, arg1.twap_params.funding_frequency_ms)) - arg3, arg1.twap_params.funding_period_ms)))
    }

    public fun calculate_mark_price(arg0: &MarketState, arg1: &MarketParams, arg2: u256, arg3: u256, arg4: u64) : u256 {
        let v0 = calculate_funding_price(arg0, arg1, arg2, arg4);
        let v1 = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::add(arg2, spread_twap(arg0));
        0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::max(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::min(v1, v0), 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::min(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::max(v1, v0), arg3))
    }

    public fun clip_max_book_index_spread(arg0: &MarketParams, arg1: u256, arg2: u256) : u256 {
        assert!(arg2 != 0, 1000);
        let v0 = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::mul(arg2, arg0.limits_params.max_book_index_spread);
        let v1 = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::add(arg2, v0);
        let v2 = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::sub(arg2, v0);
        if (0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::greater_than(arg1, v1)) {
            v1
        } else if (0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::less_than(arg1, v2)) {
            v2
        } else {
            arg1
        }
    }

    public fun collateral_haircut(arg0: &MarketParams) : u256 {
        arg0.core_params.collateral_haircut
    }

    public fun collateral_oracle_price(arg0: &MarketParams, arg1: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::PriceFeedStorage, arg2: &0x2::clock::Clock) : u256 {
        assert!(0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::storage_id(arg1) == arg0.core_params.collateral_storage_id, 1002);
        let v0 = 0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::price_feed(arg1, arg0.core_params.collateral_source_id);
        let (v1, v2) = 0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed::price_and_timestamp_ms(v0);
        let v3 = 0x2::clock::timestamp_ms(arg2);
        if (v3 - 0x1::u64::min(v3, arg0.core_params.collateral_pfs_tolerance) > v2) {
            abort 1000
        };
        let v4 = (v1 as u256);
        assert_index_twap_divergence_within_limit(arg0, v4, (0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed::twap_price(v0) as u256));
        v4
    }

    public fun collateral_pfs_tolerance(arg0: &MarketParams) : u64 {
        arg0.core_params.collateral_pfs_tolerance
    }

    public fun collateral_source_id(arg0: &MarketParams) : u16 {
        arg0.core_params.collateral_source_id
    }

    public fun collateral_storage_id(arg0: &MarketParams) : u32 {
        arg0.core_params.collateral_storage_id
    }

    public(friend) fun create_market_objects(arg0: &0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::registry::Config, arg1: &0x2::clock::Clock, arg2: u256, arg3: u256, arg4: u32, arg5: u32, arg6: u16, arg7: u16, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u256, arg15: u256, arg16: u256, arg17: u256, arg18: u64, arg19: u64, arg20: u256) : (MarketParams, MarketState) {
        assert_margin_ratios(arg2, arg3);
        assert_funding_parameters(arg0, arg8, arg9, arg10, arg11);
        assert_spread_twap_parameters(arg0, arg12, arg13);
        assert_market_fees(arg0, arg14, arg15);
        assert_priority_taker_fee(arg0, 0x1::option::some<u256>(1000000000000000));
        assert_liquidation_fees(arg0, arg16, arg17);
        assert_liquidation_fees_against_mmr(arg3, arg16, arg17);
        assert_lot_and_tick_sizes(arg18, arg19);
        (create_market_params(arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20), create_market_state(0x2::clock::timestamp_ms(arg1)))
    }

    fun create_market_params(arg0: &0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::registry::Config, arg1: u256, arg2: u256, arg3: u32, arg4: u32, arg5: u16, arg6: u16, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u256, arg14: u256, arg15: u256, arg16: u256, arg17: u64, arg18: u64, arg19: u256) : MarketParams {
        let v0 = CoreParams{
            base_storage_id          : arg3,
            collateral_storage_id    : arg4,
            base_source_id           : arg5,
            collateral_source_id     : arg6,
            base_pfs_tolerance       : 10000,
            collateral_pfs_tolerance : 30000,
            lot_size                 : arg17,
            tick_size                : arg18,
            scaling_factor           : arg19,
            collateral_haircut       : 0,
            margin_ratio_initial     : arg1,
            margin_ratio_maintenance : arg2,
        };
        let v1 = FeesParams{
            maker_fee          : arg13,
            taker_fee          : arg14,
            liquidation_fee    : arg15,
            insurance_fund_fee : arg16,
            priority_taker_fee : 0x1::option::some<u256>(1000000000000000),
        };
        let v2 = TwapParams{
            funding_frequency_ms      : arg7,
            funding_period_ms         : arg8,
            premium_twap_frequency_ms : arg9,
            premium_twap_period_ms    : arg10,
            spread_twap_frequency_ms  : arg11,
            spread_twap_period_ms     : arg12,
        };
        let v3 = LimitsParams{
            min_order_usd_value                : 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::registry::low_min_order_usd_value(arg0),
            max_pending_orders                 : 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::registry::up_max_pending_orders(arg0),
            max_open_interest                  : 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::from_u64(18446744073709551615),
            max_open_interest_threshold        : 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::from_u64(18446744073709551615),
            max_open_interest_position_percent : 200000000000000000,
            max_book_index_spread              : 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::from_u64fraction(5, 100),
            max_index_twap_divergence          : 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::from_u64fraction(5, 100),
            max_bad_debt                       : 0,
            max_socialize_losses_mr_decrease   : 0,
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
        0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::div(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::mul(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::from_u64(v1), 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::from_u64(arg2)), 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::from_u64(arg3))
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

    public fun next_funding_update_time(arg0: u64, arg1: u64) : u64 {
        arg0 - arg0 % arg1 + arg1
    }

    public fun open_interest(arg0: &MarketState) : u256 {
        arg0.open_interest
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

    public(friend) fun set_base_oracle_params(arg0: &mut MarketParams, arg1: &0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::registry::Config, arg2: &0x2::object::ID, arg3: u32, arg4: 0x1::option::Option<u16>, arg5: 0x1::option::Option<u64>) {
        let v0 = if (0x1::option::is_some<u16>(&arg4)) {
            *0x1::option::borrow<u16>(&arg4)
        } else {
            arg0.core_params.base_source_id
        };
        let v1 = if (0x1::option::is_some<u64>(&arg5)) {
            *0x1::option::borrow<u64>(&arg5)
        } else {
            arg0.core_params.base_pfs_tolerance
        };
        assert!(v1 >= 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::registry::min_oracle_tolerance(arg1), 1025);
        arg0.core_params.base_storage_id = arg3;
        arg0.core_params.base_source_id = v0;
        arg0.core_params.base_pfs_tolerance = v1;
        0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::events::e47(*arg2, arg3, v0, v1);
    }

    public(friend) fun set_collateral_oracle_params(arg0: &mut MarketParams, arg1: &0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::registry::Config, arg2: &0x2::object::ID, arg3: u32, arg4: 0x1::option::Option<u16>, arg5: 0x1::option::Option<u64>) {
        let v0 = if (0x1::option::is_some<u16>(&arg4)) {
            *0x1::option::borrow<u16>(&arg4)
        } else {
            arg0.core_params.collateral_source_id
        };
        let v1 = if (0x1::option::is_some<u64>(&arg5)) {
            *0x1::option::borrow<u64>(&arg5)
        } else {
            arg0.core_params.collateral_pfs_tolerance
        };
        assert!(v1 >= 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::registry::min_oracle_tolerance(arg1), 1025);
        arg0.core_params.collateral_storage_id = arg3;
        arg0.core_params.collateral_source_id = v0;
        arg0.core_params.collateral_pfs_tolerance = v1;
        0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::events::e48(*arg2, arg3, v0, v1);
    }

    public(friend) fun set_core_params(arg0: &mut MarketParams, arg1: &0x2::object::ID, arg2: 0x1::option::Option<u64>, arg3: 0x1::option::Option<u64>, arg4: 0x1::option::Option<u256>) {
        let v0 = if (0x1::option::is_some<u64>(&arg2)) {
            *0x1::option::borrow<u64>(&arg2)
        } else {
            arg0.core_params.lot_size
        };
        let v1 = if (0x1::option::is_some<u64>(&arg3)) {
            *0x1::option::borrow<u64>(&arg3)
        } else {
            arg0.core_params.tick_size
        };
        let v2 = if (0x1::option::is_some<u256>(&arg4)) {
            *0x1::option::borrow<u256>(&arg4)
        } else {
            arg0.core_params.collateral_haircut
        };
        assert_lot_and_tick_sizes(v0, v1);
        assert!(arg0.core_params.lot_size % v0 == 0 && arg0.core_params.tick_size % v1 == 0, 1007);
        assert!(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::greater_than_eq(v2, 0) && 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::less_than(v2, 1000000000000000000), 1015);
        arg0.core_params.lot_size = v0;
        arg0.core_params.tick_size = v1;
        arg0.core_params.collateral_haircut = v2;
        0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::events::e46(*arg1, v0, v1, v2);
    }

    public(friend) fun set_fee_params(arg0: &mut MarketParams, arg1: &0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::registry::Config, arg2: &0x2::object::ID, arg3: 0x1::option::Option<u256>, arg4: 0x1::option::Option<u256>, arg5: 0x1::option::Option<u256>, arg6: 0x1::option::Option<u256>, arg7: 0x1::option::Option<0x1::option::Option<u256>>) {
        let v0 = if (0x1::option::is_some<u256>(&arg3)) {
            *0x1::option::borrow<u256>(&arg3)
        } else {
            arg0.fees_params.maker_fee
        };
        let v1 = if (0x1::option::is_some<u256>(&arg4)) {
            *0x1::option::borrow<u256>(&arg4)
        } else {
            arg0.fees_params.taker_fee
        };
        let v2 = if (0x1::option::is_some<u256>(&arg5)) {
            *0x1::option::borrow<u256>(&arg5)
        } else {
            arg0.fees_params.liquidation_fee
        };
        let v3 = if (0x1::option::is_some<u256>(&arg6)) {
            *0x1::option::borrow<u256>(&arg6)
        } else {
            arg0.fees_params.insurance_fund_fee
        };
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
        0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::events::e44(*arg2, v0, v1, v2, v3, v4);
    }

    public(friend) fun set_risk_limit_params(arg0: &mut MarketParams, arg1: &0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::registry::Config, arg2: &0x2::object::ID, arg3: 0x1::option::Option<u256>, arg4: 0x1::option::Option<u64>, arg5: 0x1::option::Option<u256>, arg6: 0x1::option::Option<u256>, arg7: 0x1::option::Option<u256>, arg8: 0x1::option::Option<u256>, arg9: 0x1::option::Option<u256>, arg10: 0x1::option::Option<u256>, arg11: 0x1::option::Option<u256>) {
        let v0 = if (0x1::option::is_some<u256>(&arg3)) {
            *0x1::option::borrow<u256>(&arg3)
        } else {
            arg0.limits_params.min_order_usd_value
        };
        let v1 = if (0x1::option::is_some<u64>(&arg4)) {
            *0x1::option::borrow<u64>(&arg4)
        } else {
            arg0.limits_params.max_pending_orders
        };
        let v2 = if (0x1::option::is_some<u256>(&arg5)) {
            *0x1::option::borrow<u256>(&arg5)
        } else {
            arg0.limits_params.max_open_interest
        };
        let v3 = arg0.limits_params.max_open_interest_threshold;
        let v4 = if (v3 == arg0.limits_params.max_open_interest && !0x1::option::is_some<u256>(&arg6)) {
            v2
        } else if (0x1::option::is_some<u256>(&arg6)) {
            *0x1::option::borrow<u256>(&arg6)
        } else {
            v3
        };
        let v5 = if (0x1::option::is_some<u256>(&arg7)) {
            *0x1::option::borrow<u256>(&arg7)
        } else {
            arg0.limits_params.max_open_interest_position_percent
        };
        let v6 = if (0x1::option::is_some<u256>(&arg8)) {
            *0x1::option::borrow<u256>(&arg8)
        } else {
            arg0.limits_params.max_book_index_spread
        };
        let v7 = if (0x1::option::is_some<u256>(&arg9)) {
            *0x1::option::borrow<u256>(&arg9)
        } else {
            arg0.limits_params.max_index_twap_divergence
        };
        let v8 = if (0x1::option::is_some<u256>(&arg10)) {
            *0x1::option::borrow<u256>(&arg10)
        } else {
            arg0.limits_params.max_bad_debt
        };
        let v9 = if (0x1::option::is_some<u256>(&arg11)) {
            *0x1::option::borrow<u256>(&arg11)
        } else {
            arg0.limits_params.max_socialize_losses_mr_decrease
        };
        assert!(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::less_than_eq(v0, 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::registry::up_min_order_usd_value(arg1)) && 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::greater_than_eq(v0, 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::registry::low_min_order_usd_value(arg1)), 1008);
        assert!(v1 > 0 && v1 <= 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::registry::up_max_pending_orders(arg1), 1009);
        assert!(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::greater_than(v2, 0) && 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::less_than_eq(v4, v2), 1010);
        assert!(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::greater_than_eq(v6, 0) && 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::less_than_eq(v6, 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::registry::max_book_index_spread(arg1)), 1027);
        assert!(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::greater_than_eq(v7, 0) && 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::less_than_eq(v7, 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::registry::max_index_twap_divergence(arg1)), 1028);
        assert!(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::greater_than(v5, 0) && 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::less_than_eq(v5, 1000000000000000000), 1011);
        assert!(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::greater_than(v4, 0), 1012);
        assert!(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::greater_than_eq(v8, 0), 1013);
        assert!(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::greater_than_eq(v9, 0) && 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::less_than_eq(v9, 1000000000000000000), 1014);
        arg0.limits_params.min_order_usd_value = v0;
        arg0.limits_params.max_pending_orders = v1;
        arg0.limits_params.max_open_interest = v2;
        arg0.limits_params.max_open_interest_threshold = v4;
        arg0.limits_params.max_open_interest_position_percent = v5;
        arg0.limits_params.max_book_index_spread = v6;
        arg0.limits_params.max_index_twap_divergence = v7;
        arg0.limits_params.max_bad_debt = v8;
        arg0.limits_params.max_socialize_losses_mr_decrease = v9;
        0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::events::e49(*arg2, v0, v1, v2, v4, v5, v6, v7, v8, v9);
    }

    public(friend) fun set_twap_params(arg0: &mut MarketParams, arg1: &0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::registry::Config, arg2: &0x2::object::ID, arg3: 0x1::option::Option<u64>, arg4: 0x1::option::Option<u64>, arg5: 0x1::option::Option<u64>, arg6: 0x1::option::Option<u64>, arg7: 0x1::option::Option<u64>, arg8: 0x1::option::Option<u64>) {
        let v0 = if (0x1::option::is_some<u64>(&arg3)) {
            *0x1::option::borrow<u64>(&arg3)
        } else {
            arg0.twap_params.funding_frequency_ms
        };
        let v1 = if (0x1::option::is_some<u64>(&arg4)) {
            *0x1::option::borrow<u64>(&arg4)
        } else {
            arg0.twap_params.funding_period_ms
        };
        let v2 = if (0x1::option::is_some<u64>(&arg5)) {
            *0x1::option::borrow<u64>(&arg5)
        } else {
            arg0.twap_params.premium_twap_frequency_ms
        };
        let v3 = if (0x1::option::is_some<u64>(&arg6)) {
            *0x1::option::borrow<u64>(&arg6)
        } else {
            arg0.twap_params.premium_twap_period_ms
        };
        let v4 = if (0x1::option::is_some<u64>(&arg7)) {
            *0x1::option::borrow<u64>(&arg7)
        } else {
            arg0.twap_params.spread_twap_frequency_ms
        };
        let v5 = if (0x1::option::is_some<u64>(&arg8)) {
            *0x1::option::borrow<u64>(&arg8)
        } else {
            arg0.twap_params.spread_twap_period_ms
        };
        assert_funding_parameters(arg1, v0, v1, v2, v3);
        assert_spread_twap_parameters(arg1, v4, v5);
        arg0.twap_params.funding_frequency_ms = v0;
        arg0.twap_params.funding_period_ms = v1;
        arg0.twap_params.premium_twap_frequency_ms = v2;
        arg0.twap_params.premium_twap_period_ms = v3;
        arg0.twap_params.spread_twap_frequency_ms = v4;
        arg0.twap_params.spread_twap_period_ms = v5;
        0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::events::e45(*arg2, v0, v1, v2, v3, v4, v5);
    }

    public fun spread_twap(arg0: &MarketState) : u256 {
        arg0.spread_twap
    }

    public fun spread_twap_params(arg0: &MarketParams) : (u64, u64) {
        (arg0.twap_params.spread_twap_frequency_ms, arg0.twap_params.spread_twap_period_ms)
    }

    public(friend) fun sub_fees_accrued(arg0: &mut MarketState, arg1: u256) {
        arg0.fees_accrued = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::sub(arg0.fees_accrued, arg1);
    }

    public fun taker_fee(arg0: &MarketParams) : u256 {
        arg0.fees_params.taker_fee
    }

    public fun tick_size(arg0: &MarketParams) : u64 {
        arg0.core_params.tick_size
    }

    public(friend) fun try_update_funding(arg0: &MarketParams, arg1: &mut MarketState, arg2: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::PriceFeedStorage, arg3: &0x2::clock::Clock, arg4: &0x2::object::ID, arg5: 0x1::option::Option<u256>) {
        let (v0, v1) = base_oracle_price_and_twap_price(arg0, arg2, arg3);
        assert_index_twap_divergence_within_limit(arg0, v0, v1);
        let (v2, v3) = if (0x1::option::is_none<u256>(&arg5)) {
            (v0, v0)
        } else {
            let v4 = *0x1::option::borrow<u256>(&arg5);
            (v4, clip_max_book_index_spread(arg0, v4, v0))
        };
        let v5 = 0x2::clock::timestamp_ms(arg3);
        if (v5 >= arg1.premium_twap_last_upd_ms + arg0.twap_params.premium_twap_frequency_ms) {
            update_premium_twap(arg1, arg0, v0, v2, v3, v5, arg4);
        };
        if (v5 >= arg1.spread_twap_last_upd_ms + arg0.twap_params.spread_twap_frequency_ms) {
            update_spread_twap(arg1, arg0, v0, v2, v3, v5, arg4);
        };
        if (is_time_to_update(v5, arg1.funding_last_upd_ms, arg0.twap_params.funding_frequency_ms)) {
            update_fundings(arg1, arg0, v5, arg4);
        };
    }

    public(friend) fun try_update_fundings_and_twaps(arg0: &MarketParams, arg1: &mut MarketState, arg2: u64, arg3: u256, arg4: u256, arg5: &0x2::object::ID) {
        let v0 = clip_max_book_index_spread(arg0, arg4, arg3);
        if (arg2 >= arg1.premium_twap_last_upd_ms + arg0.twap_params.premium_twap_frequency_ms) {
            update_premium_twap(arg1, arg0, arg3, arg4, v0, arg2, arg5);
        };
        if (arg2 >= arg1.spread_twap_last_upd_ms + arg0.twap_params.spread_twap_frequency_ms) {
            update_spread_twap(arg1, arg0, arg3, arg4, v0, arg2, arg5);
        };
        if (is_time_to_update(arg2, arg1.funding_last_upd_ms, arg0.twap_params.funding_frequency_ms)) {
            update_fundings(arg1, arg0, arg2, arg5);
        };
    }

    public(friend) fun try_update_twaps(arg0: &MarketParams, arg1: &mut MarketState, arg2: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::PriceFeedStorage, arg3: &0x2::clock::Clock, arg4: &0x2::object::ID, arg5: 0x1::option::Option<u256>) {
        let (v0, v1) = base_oracle_price_and_twap_price(arg0, arg2, arg3);
        assert_index_twap_divergence_within_limit(arg0, v0, v1);
        let (v2, v3) = if (0x1::option::is_none<u256>(&arg5)) {
            (v0, v0)
        } else {
            let v4 = *0x1::option::borrow<u256>(&arg5);
            (v4, clip_max_book_index_spread(arg0, v4, v0))
        };
        let v5 = 0x2::clock::timestamp_ms(arg3);
        if (v5 >= arg1.premium_twap_last_upd_ms + arg0.twap_params.premium_twap_frequency_ms) {
            update_premium_twap(arg1, arg0, v0, v2, v3, v5, arg4);
        };
        if (v5 >= arg1.spread_twap_last_upd_ms + arg0.twap_params.spread_twap_frequency_ms) {
            update_spread_twap(arg1, arg0, v0, v2, v3, v5, arg4);
        };
    }

    public fun twap_last_upd_ms(arg0: &MarketState) : (u64, u64) {
        (arg0.premium_twap_last_upd_ms, arg0.spread_twap_last_upd_ms)
    }

    fun update_fundings(arg0: &mut MarketState, arg1: &MarketParams, arg2: u64, arg3: &0x2::object::ID) {
        let v0 = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::mul(arg0.premium_twap, funding_period_adjustment(arg2, arg0.funding_last_upd_ms, arg1.twap_params.funding_frequency_ms, arg1.twap_params.funding_period_ms));
        arg0.cum_funding_rate_long = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::add(arg0.cum_funding_rate_long, v0);
        arg0.cum_funding_rate_short = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::add(arg0.cum_funding_rate_short, v0);
        arg0.funding_last_upd_ms = arg2;
        0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::events::e14(*arg3, arg0.cum_funding_rate_long, arg0.cum_funding_rate_short, arg0.funding_last_upd_ms);
    }

    public(friend) fun update_margin_ratios(arg0: &mut MarketParams, arg1: u256, arg2: u256) {
        assert_margin_ratios(arg1, arg2);
        assert_liquidation_fees_against_mmr(arg2, arg0.fees_params.liquidation_fee, arg0.fees_params.insurance_fund_fee);
        arg0.core_params.margin_ratio_initial = arg1;
        arg0.core_params.margin_ratio_maintenance = arg2;
    }

    fun update_premium_twap(arg0: &mut MarketState, arg1: &MarketParams, arg2: u256, arg3: u256, arg4: u256, arg5: u64, arg6: &0x2::object::ID) {
        arg0.premium_twap = update_twap(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::sub(arg4, arg2), arg0.premium_twap, arg5, arg0.premium_twap_last_upd_ms, arg1.twap_params.premium_twap_period_ms);
        arg0.premium_twap_last_upd_ms = arg5;
        0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::events::e12(*arg6, arg3, arg4, arg2, arg0.premium_twap, arg0.premium_twap_last_upd_ms);
    }

    fun update_spread_twap(arg0: &mut MarketState, arg1: &MarketParams, arg2: u256, arg3: u256, arg4: u256, arg5: u64, arg6: &0x2::object::ID) {
        arg0.spread_twap = update_twap(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::sub(arg4, arg2), arg0.spread_twap, arg5, arg0.spread_twap_last_upd_ms, arg1.twap_params.spread_twap_period_ms);
        arg0.spread_twap_last_upd_ms = arg5;
        0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::events::e13(*arg6, arg3, arg4, arg2, arg0.spread_twap, arg0.spread_twap_last_upd_ms);
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
        let v2 = arg0 >= 57896044618658097711785492504343953926634992332820282019728792003956564819968;
        let v3 = arg1 >= 57896044618658097711785492504343953926634992332820282019728792003956564819968;
        let v4 = if (v2) {
            ((arg0 ^ 115792089237316195423570985008687907853269984665640564039457584007913129639935) + 1) * (v0 as u256)
        } else {
            arg0 * (v0 as u256)
        };
        let v5 = if (v3) {
            ((arg1 ^ 115792089237316195423570985008687907853269984665640564039457584007913129639935) + 1) * (v1 as u256)
        } else {
            arg1 * (v1 as u256)
        };
        if (v2 == v3) {
            if (v2) {
                return ((v4 + v5) / ((v0 + v1) as u256) ^ 57896044618658097711785492504343953926634992332820282019728792003956564819967) + 1 ^ 57896044618658097711785492504343953926634992332820282019728792003956564819968
            };
            return (v4 + v5) / ((v0 + v1) as u256)
        };
        if (v4 >= v5) {
            if (v2) {
                return ((v4 - v5) / ((v0 + v1) as u256) ^ 57896044618658097711785492504343953926634992332820282019728792003956564819967) + 1 ^ 57896044618658097711785492504343953926634992332820282019728792003956564819968
            };
            return (v4 - v5) / ((v0 + v1) as u256)
        };
        if (v3) {
            return ((v5 - v4) / ((v0 + v1) as u256) ^ 57896044618658097711785492504343953926634992332820282019728792003956564819967) + 1 ^ 57896044618658097711785492504343953926634992332820282019728792003956564819968
        };
        (v5 - v4) / ((v0 + v1) as u256)
    }

    // decompiled from Move bytecode v7
}

