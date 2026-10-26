module 0x18925d13848d526ff14d5226ee8327357471311bef4d8a4a259ef74083d1496e::snapshot {
    struct CapturedSnapshot has drop {
        venue_equity: u64,
        position_base: u64,
        lot_size: u64,
        side: 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::PositionSide,
        pending_order_count: u64,
        margin_safe: bool,
        venue_operational: bool,
        economics_valid: bool,
        base_price: u64,
        base_timestamp: u64,
        collateral_price: u64,
        collateral_timestamp: u64,
        mark_price: u64,
        checkpoint: 0x18925d13848d526ff14d5226ee8327357471311bef4d8a4a259ef74083d1496e::checkpoint::Checkpoint,
        collateral_fixed: u256,
    }

    struct CashLiquidity has copy, drop {
        releasable: u64,
        shortfall: u64,
        unrealized_profit: u64,
    }

    public(friend) fun checkpoint(arg0: &CapturedSnapshot) : 0x18925d13848d526ff14d5226ee8327357471311bef4d8a4a259ef74083d1496e::checkpoint::Checkpoint {
        arg0.checkpoint
    }

    public(friend) fun assert_bound_graph<T0>(arg0: &0x18925d13848d526ff14d5226ee8327357471311bef4d8a4a259ef74083d1496e::venue_account::Binding, arg1: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>, arg2: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg3: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg4: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg5: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage) {
        0x18925d13848d526ff14d5226ee8327357471311bef4d8a4a259ef74083d1496e::venue_account::assert_object_graph(arg0, 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>>(arg1), 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::account_id<T0>(arg1), 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry>(arg2), 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>>(arg3));
        0x18925d13848d526ff14d5226ee8327357471311bef4d8a4a259ef74083d1496e::venue_account::assert_market_oracles<T0>(arg3, arg4, arg5);
    }

    public(friend) fun assert_realization_progress(arg0: &CashLiquidity, arg1: &CashLiquidity, arg2: &0x18925d13848d526ff14d5226ee8327357471311bef4d8a4a259ef74083d1496e::checkpoint::Checkpoint, arg3: &0x18925d13848d526ff14d5226ee8327357471311bef4d8a4a259ef74083d1496e::checkpoint::Checkpoint, arg4: u64) {
        let v0 = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::sub(0x18925d13848d526ff14d5226ee8327357471311bef4d8a4a259ef74083d1496e::checkpoint::allocated_collateral(arg3), 0x18925d13848d526ff14d5226ee8327357471311bef4d8a4a259ef74083d1496e::checkpoint::allocated_collateral(arg2));
        let v1 = if (arg1.shortfall < arg0.shortfall) {
            if (!0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::is_neg(v0)) {
                v0 > (arg4 as u256) * 1000000000000
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 40);
    }

    public(friend) fun assert_releasable(arg0: &CashLiquidity, arg1: u64) {
        assert!(arg1 <= arg0.releasable, 39);
    }

    public(friend) fun base_price_observation(arg0: &CapturedSnapshot) : 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::observation::PriceObservation {
        0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::observation::new_price(arg0.base_price, 0, arg0.base_timestamp)
    }

    public(friend) fun capture<T0>(arg0: &0x18925d13848d526ff14d5226ee8327357471311bef4d8a4a259ef74083d1496e::venue_account::Binding, arg1: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>, arg2: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg3: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg4: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg5: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg6: &0x2::clock::Clock) : CapturedSnapshot {
        let v0 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::market_params<T0>(arg3);
        let v1 = 0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::price_feed(arg4, 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::base_source_id(v0));
        let v2 = 0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::price_feed(arg5, 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::collateral_source_id(v0));
        let v3 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::base_oracle_price(v0, arg4, arg6);
        let v4 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::collateral_oracle_price(v0, arg5, arg6);
        let v5 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::mark_price<T0>(arg3, arg4, arg6);
        let (v6, v7, v8) = oracle_leg(v1, v3);
        let (v9, v10, v11) = oracle_leg(v2, v4);
        let (v12, v13) = 0x18925d13848d526ff14d5226ee8327357471311bef4d8a4a259ef74083d1496e::ifixed_math::fixed_to_u64_down(v5, 9);
        let v14 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::position<T0>(arg3, 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::account_id<T0>(arg1));
        let (v15, v16, v17, v18) = position_economics(v14, v0, 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::collateral_balance<T0>(arg1), v3, v4, v5);
        let v19 = if (0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::is_long_or_flat(v14)) {
            0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::long()
        } else {
            0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::policy::short()
        };
        let v20 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::market_pause_mode<T0>(arg3) == 0 && !0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::is_frozen<T0>(arg3);
        let v21 = if (v18) {
            if (v8) {
                if (v11) {
                    v13
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        CapturedSnapshot{
            venue_equity         : v16,
            position_base        : v15,
            lot_size             : 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::lot_size(v0),
            side                 : v19,
            pending_order_count  : 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::pending_order_count(v14),
            margin_safe          : v17,
            venue_operational    : v20,
            economics_valid      : v21,
            base_price           : v6,
            base_timestamp       : v7,
            collateral_price     : v9,
            collateral_timestamp : v10,
            mark_price           : v12,
            checkpoint           : capture_checkpoint<T0>(arg0, arg1, arg2, arg3, arg4, arg5),
            collateral_fixed     : v4,
        }
    }

    public(friend) fun capture_cash_liquidity<T0>(arg0: &0x18925d13848d526ff14d5226ee8327357471311bef4d8a4a259ef74083d1496e::venue_account::Binding, arg1: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>, arg2: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg3: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg4: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg5: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg6: &0x2::clock::Clock) : CashLiquidity {
        assert_bound_graph<T0>(arg0, arg1, arg2, arg3, arg4, arg5);
        let v0 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::market_params<T0>(arg3);
        let v1 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::position<T0>(arg3, 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::account_id<T0>(arg1));
        let v2 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::collateral_oracle_price(v0, arg5, arg6);
        let v3 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::mark_price<T0>(arg3, arg4, arg6);
        let v4 = 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::effective_initial_margin_ratio(v1, 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::margin_ratio_initial(v0));
        let v5 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::collateral_haircut(v0);
        let (v6, v7) = 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::compute_margin_and_requirement(v1, v2, v3, v4, v5);
        let v8 = 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::unrealized_pnl(v1, v3);
        let v9 = if (0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::is_neg(v8)) {
            v6
        } else {
            0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::sub(v6, v8)
        };
        cash_liquidity(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::collateral_balance<T0>(arg1), 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::compute_free_collateral(v1, v2, v3, v4, v5), 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::sub(v7, v9), 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::unrealized_pnl(v1, 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::base_oracle_price(v0, arg4, arg6)), v2, v5)
    }

    public(friend) fun capture_checkpoint<T0>(arg0: &0x18925d13848d526ff14d5226ee8327357471311bef4d8a4a259ef74083d1496e::venue_account::Binding, arg1: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>, arg2: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg3: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg4: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg5: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage) : 0x18925d13848d526ff14d5226ee8327357471311bef4d8a4a259ef74083d1496e::checkpoint::Checkpoint {
        assert_bound_graph<T0>(arg0, arg1, arg2, arg3, arg4, arg5);
        0x18925d13848d526ff14d5226ee8327357471311bef4d8a4a259ef74083d1496e::checkpoint::read_checkpoint<T0>(arg1, arg3)
    }

    public(friend) fun capture_order_capacity<T0>(arg0: &0x18925d13848d526ff14d5226ee8327357471311bef4d8a4a259ef74083d1496e::venue_account::Binding, arg1: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>, arg2: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg3: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg4: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg5: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg6: &0x2::clock::Clock) : (0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::observation::PriceObservation, 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::observation::PriceObservation, u64) {
        assert_bound_graph<T0>(arg0, arg1, arg2, arg3, arg4, arg5);
        let v0 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::market_params<T0>(arg3);
        let (v1, v2, v3) = oracle_leg(0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::price_feed(arg4, 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::base_source_id(v0)), 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::base_oracle_price(v0, arg4, arg6));
        let (v4, v5, v6) = oracle_leg(0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::price_feed(arg5, 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::collateral_source_id(v0)), 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::collateral_oracle_price(v0, arg5, arg6));
        assert!(v3 && v6, 10);
        (0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::observation::new_price(v1, 0, v2), 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::observation::new_price(v4, 0, v5), 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::lot_size(v0))
    }

    fun cash_liquidity(arg0: u64, arg1: u256, arg2: u256, arg3: u256, arg4: u256, arg5: u256) : CashLiquidity {
        let v0 = if (arg4 > 0) {
            if (!0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::is_neg(arg4)) {
                if (arg5 < 1000000000000000000) {
                    !0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::is_neg(arg1)
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 10);
        let (v1, v2) = 0x18925d13848d526ff14d5226ee8327357471311bef4d8a4a259ef74083d1496e::ifixed_math::fixed_to_u64_down(arg1, 6);
        let v3 = if (0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::is_neg(arg2)) {
            0
        } else {
            arg2
        };
        let (v4, v5) = 0x18925d13848d526ff14d5226ee8327357471311bef4d8a4a259ef74083d1496e::ifixed_math::usd_fixed_to_collateral_fixed(v3, arg4, true);
        let (v6, v7) = 0x18925d13848d526ff14d5226ee8327357471311bef4d8a4a259ef74083d1496e::ifixed_math::usd_fixed_to_collateral_fixed(v4, 1000000000000000000 - arg5, true);
        let (v8, v9) = 0x18925d13848d526ff14d5226ee8327357471311bef4d8a4a259ef74083d1496e::ifixed_math::fixed_to_u64_up(v6, 6);
        let v10 = if (0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::is_neg(arg3)) {
            0
        } else {
            arg3
        };
        let (v11, v12) = 0x18925d13848d526ff14d5226ee8327357471311bef4d8a4a259ef74083d1496e::ifixed_math::usd_fixed_to_collateral_fixed(v10, arg4, false);
        let (v13, v14) = 0x18925d13848d526ff14d5226ee8327357471311bef4d8a4a259ef74083d1496e::ifixed_math::fixed_to_u64_down(v11, 6);
        let v15 = if (v2) {
            if (v5) {
                if (v7) {
                    if (v9) {
                        if (v12) {
                            if (v14) {
                                v1 <= 18446744073709551615 - arg0
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
            }
        } else {
            false
        };
        assert!(v15, 10);
        CashLiquidity{
            releasable        : arg0 + v1,
            shortfall         : v8 - 0x1::u64::min(v8, arg0),
            unrealized_profit : v13,
        }
    }

    public(friend) fun collateral_fixed(arg0: &CapturedSnapshot) : u256 {
        arg0.collateral_fixed
    }

    public(friend) fun collateral_price_observation(arg0: &CapturedSnapshot) : 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::observation::PriceObservation {
        0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::observation::new_price(arg0.collateral_price, 0, arg0.collateral_timestamp)
    }

    public(friend) fun into_observation(arg0: CapturedSnapshot) : (0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::observation::PositionObservation, 0x18925d13848d526ff14d5226ee8327357471311bef4d8a4a259ef74083d1496e::checkpoint::Checkpoint) {
        into_validated_observation(arg0, true)
    }

    public(friend) fun into_rebalance_observation<T0>(arg0: CapturedSnapshot, arg1: &0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::state::RebalancePlan<T0>) : (0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::observation::PositionObservation, 0x18925d13848d526ff14d5226ee8327357471311bef4d8a4a259ef74083d1496e::checkpoint::Checkpoint) {
        into_validated_observation(arg0, 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::state::is_increasing<T0>(arg1))
    }

    public(friend) fun into_rebalance_plan<T0>(arg0: CapturedSnapshot, arg1: &0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::state::State<T0>, arg2: u64, arg3: u64) : (0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::state::RebalancePlan<T0>, 0x18925d13848d526ff14d5226ee8327357471311bef4d8a4a259ef74083d1496e::checkpoint::Checkpoint) {
        let (v0, v1) = into_recovery_observation(arg0);
        let v2 = 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::state::prepare_rebalance<T0>(arg1, v0, arg2, arg3);
        assert!(!0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::state::is_increasing<T0>(&v2) || arg0.margin_safe, 33);
        (v2, v1)
    }

    public(friend) fun into_rebalance_readiness<T0>(arg0: CapturedSnapshot, arg1: &0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::state::State<T0>, arg2: 0x18925d13848d526ff14d5226ee8327357471311bef4d8a4a259ef74083d1496e::checkpoint::CheckpointChange, arg3: u64, arg4: u64) : bool {
        assert!(0x18925d13848d526ff14d5226ee8327357471311bef4d8a4a259ef74083d1496e::checkpoint::is_clean(&arg2), 30);
        let v0 = if (0x18925d13848d526ff14d5226ee8327357471311bef4d8a4a259ef74083d1496e::checkpoint::is_cost(&arg2)) {
            0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::observation::funding_cost(0x18925d13848d526ff14d5226ee8327357471311bef4d8a4a259ef74083d1496e::checkpoint::amount(&arg2))
        } else {
            0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::observation::funding_credit(0x18925d13848d526ff14d5226ee8327357471311bef4d8a4a259ef74083d1496e::checkpoint::amount(&arg2))
        };
        let (v1, _) = into_recovery_observation(arg0);
        0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::state::needs_rebalance<T0>(arg1, v1, v0, arg0.margin_safe, arg3, arg4)
    }

    public(friend) fun into_recovery_observation(arg0: CapturedSnapshot) : (0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::observation::PositionObservation, 0x18925d13848d526ff14d5226ee8327357471311bef4d8a4a259ef74083d1496e::checkpoint::Checkpoint) {
        into_validated_observation(arg0, false)
    }

    fun into_validated_observation(arg0: CapturedSnapshot, arg1: bool) : (0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::observation::PositionObservation, 0x18925d13848d526ff14d5226ee8327357471311bef4d8a4a259ef74083d1496e::checkpoint::Checkpoint) {
        let CapturedSnapshot {
            venue_equity         : v0,
            position_base        : v1,
            lot_size             : v2,
            side                 : v3,
            pending_order_count  : v4,
            margin_safe          : v5,
            venue_operational    : v6,
            economics_valid      : v7,
            base_price           : v8,
            base_timestamp       : v9,
            collateral_price     : v10,
            collateral_timestamp : v11,
            mark_price           : v12,
            checkpoint           : v13,
            collateral_fixed     : _,
        } = arg0;
        assert!(v7, 10);
        let v15 = if (v4 == 0) {
            if (!arg1 || v5) {
                v6
            } else {
                false
            }
        } else {
            false
        };
        assert!(v15, 33);
        (0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::observation::new_position(v0, v1, v2, v3, 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::observation::new_price(v8, 0, v9), 0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::observation::new_price(v10, 0, v11), v12), v13)
    }

    fun margin_safe(arg0: u256, arg1: u256) : bool {
        margin_safe_decoded(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::is_neg(arg0), arg0, arg1)
    }

    fun margin_safe_decoded(arg0: bool, arg1: u256, arg2: u256) : bool {
        !arg0 && arg1 >= arg2
    }

    fun oracle_leg(arg0: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed::PriceFeed, arg1: u256) : (u64, u64, bool) {
        let (v0, v1) = 0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed::price_and_timestamp_ms(arg0);
        oracle_leg_decoded(v0, v1, arg1)
    }

    fun oracle_leg_decoded(arg0: u128, arg1: u64, arg2: u256) : (u64, u64, bool) {
        assert!((arg0 as u256) == arg2, 9);
        let (v0, v1) = 0x18925d13848d526ff14d5226ee8327357471311bef4d8a4a259ef74083d1496e::ifixed_math::fixed_to_u64_down(arg2, 9);
        (v0, arg1, v1)
    }

    fun position_economics(arg0: &0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::Position, arg1: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::MarketParams, arg2: u64, arg3: u256, arg4: u256, arg5: u256) : (u64, u64, bool, bool) {
        let (v0, v1) = 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::base_and_quote_amounts(arg0);
        let (v2, v3) = 0x18925d13848d526ff14d5226ee8327357471311bef4d8a4a259ef74083d1496e::ifixed_math::fixed_to_u64_up(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::abs(v0), 9);
        let (v4, v5) = 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::compute_margin_and_requirement(arg0, arg4, arg5, 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::effective_initial_margin_ratio(arg0, 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::margin_ratio_initial(arg1)), 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::collateral_haircut(arg1));
        let (v6, v7) = signed_equity(arg2, 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::collateral(arg0), 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::unrealized_pnl(arg0, arg3), arg4);
        let v8 = if (v3) {
            if (v7) {
                position_signs_coherent(v0, v1, 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::is_long_or_flat(arg0))
            } else {
                false
            }
        } else {
            false
        };
        (v2, v6, margin_safe(v4, v5), v8)
    }

    fun position_signs_coherent(arg0: u256, arg1: u256, arg2: bool) : bool {
        position_signs_coherent_decoded(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::is_neg(arg0), 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::is_neg(arg1), 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::abs(arg0) == 0, 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::abs(arg1) == 0, arg2)
    }

    fun position_signs_coherent_decoded(arg0: bool, arg1: bool, arg2: bool, arg3: bool, arg4: bool) : bool {
        if (arg2 || arg3) {
            return arg2 && arg3
        };
        arg4 && !arg0 && !arg1 || arg0 && arg1
    }

    public(friend) fun shortfall(arg0: &CashLiquidity) : u64 {
        arg0.shortfall
    }

    fun signed_collateral_atoms(arg0: bool, arg1: u256) : (u64, u64, bool) {
        let (v0, v1) = if (arg0) {
            0x18925d13848d526ff14d5226ee8327357471311bef4d8a4a259ef74083d1496e::ifixed_math::fixed_to_u64_up(arg1, 6)
        } else {
            0x18925d13848d526ff14d5226ee8327357471311bef4d8a4a259ef74083d1496e::ifixed_math::fixed_to_u64_down(arg1, 6)
        };
        let (v2, v3) = if (arg0) {
            (0, v0)
        } else {
            (v0, 0)
        };
        (v2, v3, v1)
    }

    fun signed_equity(arg0: u64, arg1: u256, arg2: u256, arg3: u256) : (u64, bool) {
        signed_equity_decoded(arg0, 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::is_neg(arg1), 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::abs(arg1), 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::is_neg(arg2), 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::abs(arg2), arg3)
    }

    fun signed_equity_decoded(arg0: u64, arg1: bool, arg2: u256, arg3: bool, arg4: u256, arg5: u256) : (u64, bool) {
        if (arg5 == 0) {
            return (0, false)
        };
        let (v0, v1, v2) = signed_collateral_atoms(arg1, arg2);
        let (v3, v4) = 0x18925d13848d526ff14d5226ee8327357471311bef4d8a4a259ef74083d1496e::ifixed_math::usd_fixed_to_collateral_fixed(arg4, arg5, arg3);
        let (v5, v6, v7) = signed_collateral_atoms(arg3, v3);
        let v8 = if (!v2) {
            true
        } else if (!v4) {
            true
        } else {
            !v7
        };
        if (v8) {
            return (0, false)
        };
        let v9 = (arg0 as u128) + (v0 as u128) + (v5 as u128);
        let v10 = (v1 as u128) + (v6 as u128);
        if (v9 < v10) {
            return (0, false)
        };
        let v11 = v9 - v10;
        if (v11 > 18446744073709551615) {
            (0, false)
        } else {
            ((v11 as u64), true)
        }
    }

    public(friend) fun unrealized_profit(arg0: &CashLiquidity) : u64 {
        arg0.unrealized_profit
    }

    // decompiled from Move bytecode v7
}

