module 0x4f46747d8cb5ea590953ff1847301dfe5a287519d32c1610b35810aab082e50::orders {
    struct OrderTerms has copy, drop {
        is_ask: bool,
        reduce_only: bool,
        max_order_base: u64,
        lot_size: u64,
        base_price: u64,
        collateral_price: u64,
    }

    struct Fill has drop {
        filled: u64,
        filled_quote: u256,
    }

    fun active_fill(arg0: bool, arg1: u64, arg2: u64, arg3: u256, arg4: u256, arg5: u64, arg6: u64, arg7: u256) : u64 {
        assert!(arg5 == 0, 25);
        assert!(arg6 == 0 && arg7 == 0, 26);
        let (v0, v1) = if (arg0) {
            (arg3, arg4)
        } else {
            (arg4, arg3)
        };
        let v2 = if (v1 == 0) {
            if (v0 > 0) {
                if (v0 <= (arg1 as u256) * 1000000000) {
                    if (arg2 > 0) {
                        v0 % (arg2 as u256) * 1000000000 == 0
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
        assert!(v2, 24);
        ((v0 / 1000000000) as u64)
    }

    fun active_order_size(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        assert!(arg3 < 16, 27);
        let v0 = if (arg1 > 0) {
            if (arg0 > 0) {
                if (arg2 > 0) {
                    arg0 % arg2 == 0
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 24);
        0x1::u64::min(arg0, arg1)
    }

    fun active_terms<T0, T1>(arg0: &0x4f46747d8cb5ea590953ff1847301dfe5a287519d32c1610b35810aab082e50::vault::Vault<T0, T1>, arg1: bool, arg2: 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::state::ActivePosition) : OrderTerms {
        let v0 = arg1 && !opens_with_ask(0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::state::side<T0>(0x4f46747d8cb5ea590953ff1847301dfe5a287519d32c1610b35810aab082e50::vault::state<T0, T1>(arg0))) || opens_with_ask(0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::state::side<T0>(0x4f46747d8cb5ea590953ff1847301dfe5a287519d32c1610b35810aab082e50::vault::state<T0, T1>(arg0)));
        OrderTerms{
            is_ask           : v0,
            reduce_only      : arg1,
            max_order_base   : 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::state::max_order_base<T0>(0x4f46747d8cb5ea590953ff1847301dfe5a287519d32c1610b35810aab082e50::vault::state<T0, T1>(arg0), &arg2),
            lot_size         : 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::state::lot_size(&arg2),
            base_price       : 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::state::base_price(&arg2),
            collateral_price : 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::state::collateral_price(&arg2),
        }
    }

    fun actual_fill_notional(arg0: u256, arg1: u64) : u64 {
        assert!(arg1 > 0, 12);
        let v0 = 0x1::u256::checked_mul((arg1 as u256), 1000);
        if (0x1::option::is_some<u256>(&v0)) {
            let v1 = 0x1::u256::div_ceil(arg0, 0x1::option::destroy_some<u256>(v0));
            assert!(v1 <= 18446744073709551615, 12);
            return (v1 as u64)
        } else {
            0x1::option::destroy_none<u256>(v0);
            abort 12
        };
    }

    fun assert_checkpoint(arg0: &Fill, arg1: &OrderTerms, arg2: &0x4f46747d8cb5ea590953ff1847301dfe5a287519d32c1610b35810aab082e50::checkpoint::Checkpoint, arg3: &0x4f46747d8cb5ea590953ff1847301dfe5a287519d32c1610b35810aab082e50::checkpoint::Checkpoint) {
        if (arg1.reduce_only) {
            0x4f46747d8cb5ea590953ff1847301dfe5a287519d32c1610b35810aab082e50::checkpoint::assert_reduction_checkpoint(arg2, arg3, filled_after(arg1.is_ask, 0x4f46747d8cb5ea590953ff1847301dfe5a287519d32c1610b35810aab082e50::checkpoint::signed_base(arg2), (arg0.filled as u256) * 1000000000));
        } else {
            0x4f46747d8cb5ea590953ff1847301dfe5a287519d32c1610b35810aab082e50::checkpoint::assert_trade_checkpoint(arg2, arg3, filled_after(arg1.is_ask, 0x4f46747d8cb5ea590953ff1847301dfe5a287519d32c1610b35810aab082e50::checkpoint::signed_base(arg2), (arg0.filled as u256) * 1000000000), filled_after(arg1.is_ask, 0x4f46747d8cb5ea590953ff1847301dfe5a287519d32c1610b35810aab082e50::checkpoint::signed_quote_notional(arg2), arg0.filled_quote));
        };
    }

    fun assert_seed_fill(arg0: bool, arg1: u64, arg2: u64, arg3: u256, arg4: u256, arg5: u64, arg6: u64, arg7: u256) {
        assert!(active_fill(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7) == arg1, 17);
    }

    public(friend) fun close_orders<T0, T1>(arg0: &0x4f46747d8cb5ea590953ff1847301dfe5a287519d32c1610b35810aab082e50::vault::Vault<T0, T1>, arg1: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg2: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg3: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg4: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg5: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg6: &0x4f46747d8cb5ea590953ff1847301dfe5a287519d32c1610b35810aab082e50::venue_account::Binding, arg7: &OrderTerms, arg8: 0x4f46747d8cb5ea590953ff1847301dfe5a287519d32c1610b35810aab082e50::checkpoint::Checkpoint, arg9: u64, arg10: &0x2::clock::Clock, arg11: &0x2::tx_context::TxContext) : (0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, 0x4f46747d8cb5ea590953ff1847301dfe5a287519d32c1610b35810aab082e50::checkpoint::Checkpoint, u64, u256) {
        let v0 = 0;
        let v1 = 0;
        while (v0 < 16 && arg9 > 0) {
            let (v2, v3) = place_order<T0, T1>(arg0, arg1, arg3, arg4, arg5, arg7, next_order_size(arg7, arg9, v0), true, arg10, arg11);
            let v4 = v3;
            arg3 = v2;
            let v5 = 0x4f46747d8cb5ea590953ff1847301dfe5a287519d32c1610b35810aab082e50::snapshot::capture_checkpoint<T1>(arg6, arg1, arg2, &arg3, arg4, arg5);
            assert_checkpoint(&v4, arg7, &arg8, &v5);
            arg8 = v5;
            arg9 = arg9 - v4.filled;
            let v6 = 0x1::u256::checked_add(v1, v4.filled_quote);
            if (0x1::option::is_some<u256>(&v6)) {
                v1 = 0x1::option::destroy_some<u256>(v6);
                v0 = v0 + 1;
            } else {
                0x1::option::destroy_none<u256>(v6);
                abort 12
            };
        };
        (arg3, arg8, v0, v1)
    }

    fun execution_price(arg0: u256, arg1: bool) : u64 {
        normalize_execution_price(arg0, arg1, 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::is_neg(arg0))
    }

    public(friend) fun fill_orders<T0, T1>(arg0: &0x4f46747d8cb5ea590953ff1847301dfe5a287519d32c1610b35810aab082e50::vault::Vault<T0, T1>, arg1: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg2: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg3: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg4: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg5: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg6: &0x4f46747d8cb5ea590953ff1847301dfe5a287519d32c1610b35810aab082e50::venue_account::Binding, arg7: 0x4f46747d8cb5ea590953ff1847301dfe5a287519d32c1610b35810aab082e50::checkpoint::Checkpoint, arg8: OrderTerms, arg9: u64, arg10: &0x2::clock::Clock, arg11: &0x2::tx_context::TxContext) : 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1> {
        let v0 = 0;
        while (arg9 > 0) {
            let (v1, v2) = place_order<T0, T1>(arg0, arg1, arg3, arg4, arg5, &arg8, next_order_size(&arg8, arg9, v0), false, arg10, arg11);
            let v3 = v2;
            arg3 = v1;
            arg7 = 0x4f46747d8cb5ea590953ff1847301dfe5a287519d32c1610b35810aab082e50::snapshot::capture_checkpoint<T1>(arg6, arg1, arg2, &arg3, arg4, arg5);
            assert_checkpoint(&v3, &arg8, &arg7, &arg7);
            arg9 = arg9 - v3.filled;
            v0 = v0 + 1;
        };
        arg3
    }

    fun filled_after(arg0: bool, arg1: u256, arg2: u256) : u256 {
        if (arg0) {
            0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::sub(arg1, arg2)
        } else {
            0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::add(arg1, arg2)
        }
    }

    public(friend) fun increasing_terms<T0, T1>(arg0: &0x4f46747d8cb5ea590953ff1847301dfe5a287519d32c1610b35810aab082e50::vault::Vault<T0, T1>, arg1: 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::state::ActivePosition) : OrderTerms {
        active_terms<T0, T1>(arg0, false, arg1)
    }

    fun initialization_order_count(arg0: u64, arg1: u64) : u64 {
        assert!(arg1 > 0, 16);
        let v0 = 0x1::u64::div_ceil(arg0, arg1);
        assert!(v0 <= 16, 20);
        v0
    }

    public(friend) fun live_venue_fee_bps<T0>(arg0: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>) : u64 {
        let v0 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::market_params<T0>(arg0);
        venue_fee_bound(0x4f46747d8cb5ea590953ff1847301dfe5a287519d32c1610b35810aab082e50::ifixed_math::nonnegative_rate(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::taker_fee(v0)), 0x4f46747d8cb5ea590953ff1847301dfe5a287519d32c1610b35810aab082e50::ifixed_math::nonnegative_rate(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::resolve_priority_taker_fee(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::priority_taker_fee(v0))))
    }

    fun next_order_size(arg0: &OrderTerms, arg1: u64, arg2: u64) : u64 {
        active_order_size(arg1, arg0.max_order_base, arg0.lot_size, arg2)
    }

    fun normalize_execution_price(arg0: u256, arg1: bool, arg2: bool) : u64 {
        assert!(!arg2, 12);
        let (v0, v1) = if (arg1) {
            0x4f46747d8cb5ea590953ff1847301dfe5a287519d32c1610b35810aab082e50::ifixed_math::fixed_to_u64_up(arg0, 9)
        } else {
            0x4f46747d8cb5ea590953ff1847301dfe5a287519d32c1610b35810aab082e50::ifixed_math::fixed_to_u64_down(arg0, 9)
        };
        assert!(v1, 12);
        v0
    }

    fun open_seed_position<T0, T1>(arg0: &0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::state::Issuance<T0>, arg1: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg2: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::authority::ACCOUNT, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>, arg3: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg4: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg5: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg6: vector<u64>, arg7: u64, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock, arg11: &0x2::tx_context::TxContext) : 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1> {
        let v0 = 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::state::seed_side<T0>(arg0) == 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::policy::long();
        let v1 = opens_with_ask(0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::state::seed_side<T0>(arg0));
        while (!0x1::vector::is_empty<u64>(&arg6)) {
            let v2 = 0x1::vector::pop_back<u64>(&mut arg6);
            let (v3, v4) = 0x4f46747d8cb5ea590953ff1847301dfe5a287519d32c1610b35810aab082e50::venue_account::execute_order_with_cap<T1>(arg2, arg1, arg3, arg4, arg5, v1, v2, false, arg10, arg11);
            let v5 = v4;
            arg3 = v3;
            assert_seed_fill(v0, v2, arg7, 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::base_filled_bid(&v5), 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::base_filled_ask(&v5), 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::posted_orders(&v5), 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::liquidated_size(&v5), 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::liquidation_bad_debt(&v5));
            let v6 = execution_price(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::execution_price(&v5, v1), v0);
            0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::state::assert_seed_execution<T0>(arg0, arg8, v6);
            let (_, v8) = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::filled_base_and_quote(&v5, v1);
            0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::state::assert_seed_order_notional_allowed<T0>(arg0, actual_fill_notional(v8, arg9));
            0x4f46747d8cb5ea590953ff1847301dfe5a287519d32c1610b35810aab082e50::events::order_filled<T0>(0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>>(arg1), v1, false, false, v2, v2, v8, arg8, v6);
        };
        arg3
    }

    fun opens_with_ask(arg0: 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::policy::PositionSide) : bool {
        arg0 == 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::policy::short()
    }

    fun order_sizes(arg0: u64, arg1: u64) : vector<u64> {
        assert!(arg0 > 0 && arg1 > 0, 16);
        let v0 = vector[];
        while (0x1::vector::length<u64>(&v0) < initialization_order_count(arg0, arg1)) {
            let v1 = 0x1::u64::min(arg0, arg1);
            0x1::vector::push_back<u64>(&mut v0, v1);
            arg0 = arg0 - v1;
        };
        v0
    }

    fun place_order<T0, T1>(arg0: &0x4f46747d8cb5ea590953ff1847301dfe5a287519d32c1610b35810aab082e50::vault::Vault<T0, T1>, arg1: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg2: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg3: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg4: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg5: &OrderTerms, arg6: u64, arg7: bool, arg8: &0x2::clock::Clock, arg9: &0x2::tx_context::TxContext) : (0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, Fill) {
        let OrderTerms {
            is_ask           : v0,
            reduce_only      : v1,
            max_order_base   : _,
            lot_size         : v3,
            base_price       : v4,
            collateral_price : v5,
        } = *arg5;
        let (v6, v7) = 0x4f46747d8cb5ea590953ff1847301dfe5a287519d32c1610b35810aab082e50::venue_account::execute_order<T1>(0x4f46747d8cb5ea590953ff1847301dfe5a287519d32c1610b35810aab082e50::vault::venue<T0, T1>(arg0), arg1, arg2, arg3, arg4, v0, arg6, v1, arg8, arg9);
        let v8 = v7;
        let v9 = active_fill(!v0, arg6, v3, 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::base_filled_bid(&v8), 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::base_filled_ask(&v8), 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::posted_orders(&v8), 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::liquidated_size(&v8), 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::liquidation_bad_debt(&v8));
        let (_, v11) = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::filled_base_and_quote(&v8, v0);
        let v12 = execution_price(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::execution_price(&v8, v0), !v0);
        0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::state::assert_order_notional_allowed<T0>(0x4f46747d8cb5ea590953ff1847301dfe5a287519d32c1610b35810aab082e50::vault::state<T0, T1>(arg0), actual_fill_notional(v11, v5));
        0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::state::assert_execution<T0>(0x4f46747d8cb5ea590953ff1847301dfe5a287519d32c1610b35810aab082e50::vault::state<T0, T1>(arg0), arg7, v4, v12);
        0x4f46747d8cb5ea590953ff1847301dfe5a287519d32c1610b35810aab082e50::events::order_filled<T0>(0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>>(arg1), v0, v1, arg7, arg6, v9, v11, v4, v12);
        let v13 = Fill{
            filled       : v9,
            filled_quote : v11,
        };
        (v6, v13)
    }

    public(friend) fun rebalance_orders<T0, T1>(arg0: &0x4f46747d8cb5ea590953ff1847301dfe5a287519d32c1610b35810aab082e50::vault::Vault<T0, T1>, arg1: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg2: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg3: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg4: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg5: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg6: &0x4f46747d8cb5ea590953ff1847301dfe5a287519d32c1610b35810aab082e50::venue_account::Binding, arg7: &OrderTerms, arg8: &mut 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::state::RebalancePlan<T0>, arg9: 0x4f46747d8cb5ea590953ff1847301dfe5a287519d32c1610b35810aab082e50::checkpoint::Checkpoint, arg10: &0x2::clock::Clock, arg11: &0x2::tx_context::TxContext) : (0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, 0x4f46747d8cb5ea590953ff1847301dfe5a287519d32c1610b35810aab082e50::checkpoint::Checkpoint) {
        let v0 = 0;
        while (v0 < 16) {
            let v1 = 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::state::next_rebalance_order<T0>(0x4f46747d8cb5ea590953ff1847301dfe5a287519d32c1610b35810aab082e50::vault::state<T0, T1>(arg0), arg8);
            if (0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::state::order_base(&v1) == 0) {
                break
            };
            let (v2, v3) = place_order<T0, T1>(arg0, arg1, arg3, arg4, arg5, arg7, 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::state::order_base(&v1), 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::state::is_emergency(&v1), arg10, arg11);
            let v4 = v3;
            arg3 = v2;
            let (v5, v6) = 0x4f46747d8cb5ea590953ff1847301dfe5a287519d32c1610b35810aab082e50::snapshot::into_observation(0x4f46747d8cb5ea590953ff1847301dfe5a287519d32c1610b35810aab082e50::snapshot::capture<T1>(arg6, arg1, arg2, &arg3, arg4, arg5, arg10));
            let v7 = v6;
            assert_checkpoint(&v4, arg7, &arg9, &v7);
            0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::state::accept_rebalance_fill<T0>(0x4f46747d8cb5ea590953ff1847301dfe5a287519d32c1610b35810aab082e50::vault::state<T0, T1>(arg0), arg8, v1, v5, v4.filled, 0x2::clock::timestamp_ms(arg10));
            arg9 = v7;
            v0 = v0 + 1;
        };
        (arg3, arg9)
    }

    public(friend) fun reducing_terms<T0, T1>(arg0: &0x4f46747d8cb5ea590953ff1847301dfe5a287519d32c1610b35810aab082e50::vault::Vault<T0, T1>, arg1: 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::state::ActivePosition) : OrderTerms {
        active_terms<T0, T1>(arg0, true, arg1)
    }

    public(friend) fun seed_position<T0, T1>(arg0: &0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::state::Issuance<T0>, arg1: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg2: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::authority::ACCOUNT, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>, arg3: &0x4f46747d8cb5ea590953ff1847301dfe5a287519d32c1610b35810aab082e50::venue_account::Binding, arg4: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg5: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg6: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg7: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg8: u64, arg9: &0x2::clock::Clock, arg10: &0x2::tx_context::TxContext) : 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1> {
        0x4f46747d8cb5ea590953ff1847301dfe5a287519d32c1610b35810aab082e50::venue_account::update_funding_when_due<T1>(arg3, &mut arg5, arg6, arg9);
        let (v0, _) = 0x4f46747d8cb5ea590953ff1847301dfe5a287519d32c1610b35810aab082e50::snapshot::into_observation(0x4f46747d8cb5ea590953ff1847301dfe5a287519d32c1610b35810aab082e50::snapshot::capture<T1>(arg3, arg1, arg4, &arg5, arg6, arg7, arg9));
        let (v2, v3, v4) = 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::state::seed_terms<T0>(arg0, v0, arg8);
        let v5 = v4;
        open_seed_position<T0, T1>(arg0, arg1, arg2, arg5, arg6, arg7, order_sizes(v2, v3), 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::state::lot_size(&v5), 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::state::base_price(&v5), 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::state::collateral_price(&v5), arg9, arg10)
    }

    fun unwind_base_decoded(arg0: u256, arg1: bool, arg2: u64, arg3: 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::policy::PositionSide) : u64 {
        let v0 = if (arg2 > 0) {
            if (arg0 > 0) {
                if (arg0 <= 18446744073709551615000000000) {
                    if (arg0 % (arg2 as u256) * 1000000000 == 0) {
                        arg1 == arg3 == 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::policy::long()
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
        assert!(v0, 34);
        ((arg0 / 1000000000) as u64)
    }

    public(friend) fun unwind_terms<T0, T1>(arg0: &0x4f46747d8cb5ea590953ff1847301dfe5a287519d32c1610b35810aab082e50::vault::Vault<T0, T1>, arg1: &0x4f46747d8cb5ea590953ff1847301dfe5a287519d32c1610b35810aab082e50::snapshot::CapturedSnapshot, arg2: u64) : (OrderTerms, u64, 0x4f46747d8cb5ea590953ff1847301dfe5a287519d32c1610b35810aab082e50::checkpoint::Checkpoint) {
        let v0 = 0x4f46747d8cb5ea590953ff1847301dfe5a287519d32c1610b35810aab082e50::snapshot::checkpoint(arg1);
        let (v1, v2, v3, v4) = 0xac10e88ff25bd98a841f60cfcdc4006b4ad3d3afb577b5024043798ff7f4cafe::state::unwind_constraints<T0>(0x4f46747d8cb5ea590953ff1847301dfe5a287519d32c1610b35810aab082e50::vault::state<T0, T1>(arg0), 0x4f46747d8cb5ea590953ff1847301dfe5a287519d32c1610b35810aab082e50::snapshot::base_price_observation(arg1), 0x4f46747d8cb5ea590953ff1847301dfe5a287519d32c1610b35810aab082e50::snapshot::collateral_price_observation(arg1), 0x4f46747d8cb5ea590953ff1847301dfe5a287519d32c1610b35810aab082e50::checkpoint::lot_size(&v0), arg2);
        0x4f46747d8cb5ea590953ff1847301dfe5a287519d32c1610b35810aab082e50::checkpoint::assert_no_orders(&v0);
        let v5 = OrderTerms{
            is_ask           : !opens_with_ask(v1),
            reduce_only      : true,
            max_order_base   : v2,
            lot_size         : 0x4f46747d8cb5ea590953ff1847301dfe5a287519d32c1610b35810aab082e50::checkpoint::lot_size(&v0),
            base_price       : v3,
            collateral_price : v4,
        };
        let v6 = 0x4f46747d8cb5ea590953ff1847301dfe5a287519d32c1610b35810aab082e50::checkpoint::signed_base(&v0);
        (v5, unwind_base_decoded(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::abs(v6), !0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::is_neg(v6), 0x4f46747d8cb5ea590953ff1847301dfe5a287519d32c1610b35810aab082e50::checkpoint::lot_size(&v0), v1), v0)
    }

    fun venue_fee_bound(arg0: u256, arg1: u256) : u64 {
        let v0 = 1000000000000000000;
        let v1 = if (arg0 <= v0) {
            if (arg1 <= v0) {
                arg0 <= v0 - arg1
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 31);
        (0x1::u256::div_ceil(arg0 + arg1, 100000000000000) as u64)
    }

    // decompiled from Move bytecode v7
}

