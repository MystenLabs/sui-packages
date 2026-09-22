module 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::snapshot {
    struct CapturedSnapshot has drop {
        venue_equity: u64,
        position_base: u64,
        lot_size: u64,
        side: 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::policy::PositionSide,
        pending_order_count: u64,
        margin_safe: bool,
        venue_operational: bool,
        economics_valid: bool,
        base_price: u64,
        base_timestamp: u64,
        collateral_price: u64,
        collateral_timestamp: u64,
        mark_price: u64,
        checkpoint: 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::checkpoint::Checkpoint,
        collateral_fixed: u256,
    }

    public(friend) fun checkpoint(arg0: &CapturedSnapshot) : 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::checkpoint::Checkpoint {
        arg0.checkpoint
    }

    fun assert_bound_graph<T0>(arg0: &0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::venue_account::Binding, arg1: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>, arg2: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg3: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg4: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg5: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage) {
        let v0 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::market_params<T0>(arg3);
        assert!(0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::storage_id(arg4) == 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::base_storage_id(v0) && 0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::storage_id(arg5) == 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::collateral_storage_id(v0), 9);
        0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::venue_account::assert_object_graph(arg0, 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>>(arg1), 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::account_id<T0>(arg1), 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry>(arg2), 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>>(arg3), 0x2::object::id<0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage>(arg4), 0x2::object::id<0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage>(arg5), 0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed::from(0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::price_feed(arg4, 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::base_source_id(v0))), 0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed::from(0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::price_feed(arg5, 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::collateral_source_id(v0))));
    }

    public(friend) fun base_price_observation(arg0: &CapturedSnapshot) : 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::observation::PriceObservation {
        0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::observation::new_price(arg0.base_price, 0, arg0.base_timestamp)
    }

    public(friend) fun capture<T0>(arg0: &0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::venue_account::Binding, arg1: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>, arg2: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg3: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg4: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg5: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg6: &0x2::clock::Clock) : CapturedSnapshot {
        let v0 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::market_params<T0>(arg3);
        let v1 = 0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::price_feed(arg4, 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::base_source_id(v0));
        let v2 = 0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::price_feed(arg5, 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::collateral_source_id(v0));
        let v3 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::base_oracle_price(v0, arg4, arg6);
        let v4 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::collateral_oracle_price(v0, arg5, arg6);
        let v5 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::mark_price<T0>(arg3, arg4, arg6);
        let (v6, v7, v8) = oracle_leg(v1, v3);
        let (v9, v10, v11) = oracle_leg(v2, v4);
        let (v12, v13) = 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::ifixed_math::fixed_to_u64_down(v5, 9);
        let v14 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::position<T0>(arg3, 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::account_id<T0>(arg1));
        let (v15, v16, v17, v18) = position_economics(v14, v0, 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::collateral_balance<T0>(arg1), v3, v4, v5);
        let v19 = if (0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::is_long_or_flat(v14)) {
            0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::policy::long()
        } else {
            0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::policy::short()
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

    public(friend) fun capture_checkpoint<T0>(arg0: &0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::venue_account::Binding, arg1: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>, arg2: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg3: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg4: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg5: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage) : 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::checkpoint::Checkpoint {
        assert_bound_graph<T0>(arg0, arg1, arg2, arg3, arg4, arg5);
        0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::checkpoint::read_checkpoint<T0>(arg1, arg3)
    }

    public(friend) fun collateral_fixed(arg0: &CapturedSnapshot) : u256 {
        arg0.collateral_fixed
    }

    public(friend) fun collateral_price_observation(arg0: &CapturedSnapshot) : 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::observation::PriceObservation {
        0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::observation::new_price(arg0.collateral_price, 0, arg0.collateral_timestamp)
    }

    public(friend) fun into_observation(arg0: CapturedSnapshot) : (0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::observation::PositionObservation, 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::checkpoint::Checkpoint) {
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
        assert!(v7, 12);
        let v15 = if (v4 == 0) {
            if (v5) {
                v6
            } else {
                false
            }
        } else {
            false
        };
        assert!(v15, 35);
        (0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::observation::new_position(v0, v1, v2, v3, 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::observation::new_price(v8, 0, v9), 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::observation::new_price(v10, 0, v11), v12), v13)
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
        assert!((arg0 as u256) == arg2, 11);
        let (v0, v1) = 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::ifixed_math::fixed_to_u64_down(arg2, 9);
        (v0, arg1, v1)
    }

    fun position_economics(arg0: &0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::Position, arg1: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::MarketParams, arg2: u64, arg3: u256, arg4: u256, arg5: u256) : (u64, u64, bool, bool) {
        let (v0, v1) = 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::base_and_quote_amounts(arg0);
        let (v2, v3) = 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::ifixed_math::fixed_to_u64_up(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::abs(v0), 9);
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

    fun signed_collateral_atoms(arg0: bool, arg1: u256) : (u64, u64, bool) {
        let (v0, v1) = if (arg0) {
            0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::ifixed_math::fixed_to_u64_up(arg1, 6)
        } else {
            0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::ifixed_math::fixed_to_u64_down(arg1, 6)
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
        let (v3, v4) = 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::ifixed_math::usd_fixed_to_collateral_fixed(arg4, arg5, arg3);
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

    // decompiled from Move bytecode v7
}

