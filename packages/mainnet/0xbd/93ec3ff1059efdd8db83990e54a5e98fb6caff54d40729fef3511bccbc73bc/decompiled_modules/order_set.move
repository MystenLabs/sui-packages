module 0x5d26bc31305eade7160a23c2b8e63cd27680177550d7a794634953c6fc56ec7c::order_set {
    struct OrderSet has key {
        id: 0x2::object::UID,
        account: 0x2::object::ID,
        market: 0x2::object::ID,
        order_ids: vector<u128>,
    }

    fun assert_no_orders(arg0: &0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::Position) {
        assert!(0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::pending_order_count(arg0) == 0, 2);
    }

    fun can_reduce(arg0: u256, arg1: bool) : bool {
        arg0 != 0 && 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::is_neg(arg0) != arg1
    }

    public fun create<T0>(arg0: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg1: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_no_orders(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::position<T0>(arg0, 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::account_id<T0>(arg1)));
        let v0 = OrderSet{
            id        : 0x2::object::new(arg2),
            account   : 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>>(arg1),
            market    : 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>>(arg0),
            order_ids : vector[],
        };
        0x2::transfer::share_object<OrderSet>(v0);
    }

    fun crosses(arg0: bool, arg1: u64, arg2: u64) : bool {
        arg0 && arg1 <= arg2 || arg1 >= arg2
    }

    fun place_levels<T0>(arg0: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::SessionHotPotato<T0>, arg1: &mut vector<u128>, arg2: u256, arg3: bool, arg4: &vector<u64>, arg5: &vector<u64>, arg6: u64, arg7: bool, arg8: u64) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(arg4)) {
            let v1 = *0x1::vector::borrow<u64>(arg4, v0);
            let v2 = *0x1::vector::borrow<u64>(arg5, v0);
            v0 = v0 + 1;
            if (arg7) {
                let v3 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::summary<T0>(arg0);
                if (!can_reduce(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::add(arg2, 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::sub(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::base_filled_bid(v3), 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::base_filled_ask(v3))), arg3)) {
                    return
                };
            };
            if (arg6 == 3 || arg6 == 2) {
                let v4 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::best_price_u64<T0>(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::clearing_house<T0>(arg0), !arg3);
                if (!price_eligible(arg3, v1, &v4, arg6)) {
                    continue
                };
            };
            let v5 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::place_limit_order<T0>(arg0, arg3, v2, v1, arg6, 0x1::option::none<u64>(), arg7, 0x1::option::some<u64>(arg8));
            if (0x1::option::is_some<u128>(&v5)) {
                0x1::vector::push_back<u128>(arg1, 0x1::option::destroy_some<u128>(v5));
            };
        };
    }

    fun place_prepared<T0, T1>(arg0: &mut vector<u128>, arg1: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg2: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::authority::ACCOUNT, T1>, arg3: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>, arg4: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg5: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg6: u256, arg7: u256, arg8: &vector<u64>, arg9: &vector<u64>, arg10: &vector<u64>, arg11: &vector<u64>, arg12: u64, arg13: bool, arg14: bool, arg15: u64, arg16: &0x2::clock::Clock, arg17: &mut 0x2::tx_context::TxContext) : 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0> {
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::set_position_initial_margin_ratio<T0, T1>(&mut arg1, arg2, arg3, arg6);
        let v0 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::start_session<T0, T1>(arg1, arg2, arg3, arg4, arg5, 0x1::option::none<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::IntegratorInfo>(), arg16, arg17);
        let v1 = &mut v0;
        place_levels<T0>(v1, arg0, arg7, false, arg8, arg9, arg12, arg13, arg15);
        let v2 = &mut v0;
        place_levels<T0>(v2, arg0, arg7, true, arg10, arg11, arg12, arg14, arg15);
        let (v3, _) = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::end_session<T0, T1>(v0, arg2, arg3, true, true);
        let v5 = v3;
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::set_position_initial_margin_ratio<T0, T1>(&mut v5, arg2, arg3, 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::margin_ratio_initial(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::market_params<T0>(&arg1)));
        v5
    }

    fun prepare<T0, T1>(arg0: &mut OrderSet, arg1: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg2: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::authority::ACCOUNT, T1>, arg3: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>, arg4: &vector<u64>, arg5: &vector<u64>, arg6: &vector<u64>, arg7: &vector<u64>, arg8: u64, arg9: bool, arg10: bool, arg11: u64, arg12: &0x2::clock::Clock) : 0x1::option::Option<u256> {
        assert!(arg0.account == 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>>(arg3), 0);
        assert!(arg0.market == 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>>(arg1), 1);
        validate_levels(arg4, arg5, arg6, arg7);
        if (arg11 <= 0x2::clock::timestamp_ms(arg12)) {
            let v0 = vector[];
            0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::try_cancel_orders<T0, T1>(arg1, arg2, arg3, &v0);
            return 0x1::option::none<u256>()
        };
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::try_cancel_orders<T0, T1>(arg1, arg2, arg3, &arg0.order_ids);
        let v1 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::position<T0>(arg1, 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::account_id<T0>(arg3));
        assert_no_orders(v1);
        let (v2, _) = 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::base_and_quote_amounts(v1);
        arg0.order_ids = vector[];
        if (side_eligible<T0>(arg1, v2, false, arg4, arg8, arg9) || side_eligible<T0>(arg1, v2, true, arg6, arg8, arg10)) {
            0x1::option::some<u256>(v2)
        } else {
            0x1::option::none<u256>()
        }
    }

    fun prepare_take<T0, T1>(arg0: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::authority::ACCOUNT, T1>, arg2: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>, arg3: &vector<u64>, arg4: &vector<u64>, arg5: &vector<u64>, arg6: &vector<u64>, arg7: bool, arg8: bool, arg9: u64, arg10: &0x2::clock::Clock) : 0x1::option::Option<u256> {
        validate_levels(arg3, arg4, arg5, arg6);
        let v0 = vector[];
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::try_cancel_orders<T0, T1>(arg0, arg1, arg2, &v0);
        if (arg9 <= 0x2::clock::timestamp_ms(arg10)) {
            return 0x1::option::none<u256>()
        };
        let (v1, _) = 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::base_and_quote_amounts(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::position<T0>(arg0, 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::account_id<T0>(arg2)));
        if (side_eligible<T0>(arg0, v1, false, arg3, 3, arg7) || side_eligible<T0>(arg0, v1, true, arg5, 3, arg8)) {
            0x1::option::some<u256>(v1)
        } else {
            0x1::option::none<u256>()
        }
    }

    fun price_eligible(arg0: bool, arg1: u64, arg2: &0x1::option::Option<u64>, arg3: u64) : bool {
        if (0x1::option::is_none<u64>(arg2)) {
            return arg3 == 2
        };
        arg3 == 2 && !crosses(arg0, arg1, *0x1::option::borrow<u64>(arg2)) || crosses(arg0, arg1, *0x1::option::borrow<u64>(arg2))
    }

    public fun replace<T0, T1>(arg0: &mut OrderSet, arg1: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg2: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::authority::ACCOUNT, T1>, arg3: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>, arg4: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg5: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg6: u256, arg7: vector<u64>, arg8: vector<u64>, arg9: vector<u64>, arg10: vector<u64>, arg11: u64, arg12: bool, arg13: bool, arg14: u64, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) : 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0> {
        let v0 = &mut arg1;
        let v1 = prepare<T0, T1>(arg0, v0, arg2, arg3, &arg7, &arg8, &arg9, &arg10, arg11, arg12, arg13, arg14, arg15);
        if (0x1::option::is_none<u256>(&v1)) {
            return arg1
        };
        let v2 = &mut arg0.order_ids;
        place_prepared<T0, T1>(v2, arg1, arg2, arg3, arg4, arg5, arg6, 0x1::option::destroy_some<u256>(v1), &arg7, &arg8, &arg9, &arg10, arg11, arg12, arg13, arg14, arg15, arg16)
    }

    public fun replace_with_oracle<T0, T1>(arg0: &mut OrderSet, arg1: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg2: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::authority::ACCOUNT, T1>, arg3: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>, arg4: &mut 0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg5: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg6: u256, arg7: vector<u64>, arg8: vector<u64>, arg9: vector<u64>, arg10: vector<u64>, arg11: u64, arg12: bool, arg13: bool, arg14: u64, arg15: &0x2::clock::Clock, arg16: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::source::Source<0xa5428da682b4fad53e40f73dc07b547e33be078ec1c5d4a4378d6a316f0d9104::source::PYTH_LAZER>, arg17: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::config::Config, arg18: &mut 0xa5428da682b4fad53e40f73dc07b547e33be078ec1c5d4a4378d6a316f0d9104::feed_info_object::FeedInfoObject, arg19: &0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::state::State, arg20: vector<u8>, arg21: &mut 0x2::tx_context::TxContext) : 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0> {
        let v0 = &mut arg1;
        let v1 = prepare<T0, T1>(arg0, v0, arg2, arg3, &arg7, &arg8, &arg9, &arg10, arg11, arg12, arg13, arg14, arg15);
        if (0x1::option::is_none<u256>(&v1)) {
            return arg1
        };
        update_oracle_if_due<T0>(&arg1, arg4, arg16, arg17, arg18, arg19, arg20, arg15);
        let v2 = &mut arg0.order_ids;
        place_prepared<T0, T1>(v2, arg1, arg2, arg3, arg4, arg5, arg6, 0x1::option::destroy_some<u256>(v1), &arg7, &arg8, &arg9, &arg10, arg11, arg12, arg13, arg14, arg15, arg21)
    }

    fun side_eligible<T0>(arg0: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg1: u256, arg2: bool, arg3: &vector<u64>, arg4: u64, arg5: bool) : bool {
        if (0x1::vector::is_empty<u64>(arg3) || arg5 && !can_reduce(arg1, arg2)) {
            return false
        };
        if (arg4 != 3 && arg4 != 2) {
            return true
        };
        let v0 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::best_price_u64<T0>(arg0, !arg2);
        if (0x1::option::is_none<u64>(&v0)) {
            return arg4 == 2
        };
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(arg3)) {
            if (price_eligible(arg2, *0x1::vector::borrow<u64>(arg3, v1), &v0, arg4)) {
                return true
            };
            v1 = v1 + 1;
        };
        false
    }

    public fun take<T0, T1>(arg0: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::authority::ACCOUNT, T1>, arg2: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>, arg3: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg4: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg5: u256, arg6: vector<u64>, arg7: vector<u64>, arg8: vector<u64>, arg9: vector<u64>, arg10: bool, arg11: bool, arg12: u64, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) : 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0> {
        let v0 = &mut arg0;
        let v1 = prepare_take<T0, T1>(v0, arg1, arg2, &arg6, &arg7, &arg8, &arg9, arg10, arg11, arg12, arg13);
        if (0x1::option::is_none<u256>(&v1)) {
            return arg0
        };
        let v2 = vector[];
        let v3 = &mut v2;
        place_prepared<T0, T1>(v3, arg0, arg1, arg2, arg3, arg4, arg5, 0x1::option::destroy_some<u256>(v1), &arg6, &arg7, &arg8, &arg9, 3, arg10, arg11, arg12, arg13, arg14)
    }

    public fun take_with_oracle<T0, T1>(arg0: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::authority::ACCOUNT, T1>, arg2: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>, arg3: &mut 0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg4: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg5: u256, arg6: vector<u64>, arg7: vector<u64>, arg8: vector<u64>, arg9: vector<u64>, arg10: bool, arg11: bool, arg12: u64, arg13: &0x2::clock::Clock, arg14: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::source::Source<0xa5428da682b4fad53e40f73dc07b547e33be078ec1c5d4a4378d6a316f0d9104::source::PYTH_LAZER>, arg15: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::config::Config, arg16: &mut 0xa5428da682b4fad53e40f73dc07b547e33be078ec1c5d4a4378d6a316f0d9104::feed_info_object::FeedInfoObject, arg17: &0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::state::State, arg18: vector<u8>, arg19: &mut 0x2::tx_context::TxContext) : 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0> {
        let v0 = &mut arg0;
        let v1 = prepare_take<T0, T1>(v0, arg1, arg2, &arg6, &arg7, &arg8, &arg9, arg10, arg11, arg12, arg13);
        if (0x1::option::is_none<u256>(&v1)) {
            return arg0
        };
        update_oracle_if_due<T0>(&arg0, arg3, arg14, arg15, arg16, arg17, arg18, arg13);
        let v2 = vector[];
        let v3 = &mut v2;
        place_prepared<T0, T1>(v3, arg0, arg1, arg2, arg3, arg4, arg5, 0x1::option::destroy_some<u256>(v1), &arg6, &arg7, &arg8, &arg9, 3, arg10, arg11, arg12, arg13, arg19)
    }

    fun update_oracle_if_due<T0>(arg0: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg1: &mut 0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg2: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::source::Source<0xa5428da682b4fad53e40f73dc07b547e33be078ec1c5d4a4378d6a316f0d9104::source::PYTH_LAZER>, arg3: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::config::Config, arg4: &mut 0xa5428da682b4fad53e40f73dc07b547e33be078ec1c5d4a4378d6a316f0d9104::feed_info_object::FeedInfoObject, arg5: &0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::state::State, arg6: vector<u8>, arg7: &0x2::clock::Clock) {
        let (v0, _) = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::twap_last_upd_ms(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::market_state<T0>(arg0));
        let v2 = 0x2::clock::timestamp_ms(arg7);
        if (v2 >= v0 && v2 - v0 >= 57000) {
            0xa5428da682b4fad53e40f73dc07b547e33be078ec1c5d4a4378d6a316f0d9104::price_feed_storage::update_price_feed(arg2, arg3, arg1, arg4, arg5, arg6, arg7);
        };
    }

    fun validate_levels(arg0: &vector<u64>, arg1: &vector<u64>, arg2: &vector<u64>, arg3: &vector<u64>) {
        assert!(0x1::vector::length<u64>(arg0) == 0x1::vector::length<u64>(arg1) && 0x1::vector::length<u64>(arg2) == 0x1::vector::length<u64>(arg3), 3);
    }

    // decompiled from Move bytecode v7
}

