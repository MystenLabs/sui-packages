module 0x913188180e04b6291c9621b62b893565274c798bb9d07e67c81417d27cf15a6d::orders {
    struct Orders has key {
        id: 0x2::object::UID,
        account: 0x2::object::ID,
        market: 0x2::object::ID,
        bid: 0x1::option::Option<u128>,
        ask: 0x1::option::Option<u128>,
    }

    struct Placement has copy, drop, store {
        size: u64,
        price: u64,
        order_type: u64,
        client_order_id: 0x1::option::Option<u64>,
        reduce_only: bool,
        expiration_timestamp_ms: 0x1::option::Option<u64>,
    }

    fun assert_no_orders<T0>(arg0: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg1: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>) {
        assert!(0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::pending_order_count(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::position<T0>(arg0, 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::account_id<T0>(arg1))) == 0, 2);
    }

    public fun create<T0>(arg0: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg1: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_no_orders<T0>(arg0, arg1);
        let v0 = Orders{
            id      : 0x2::object::new(arg2),
            account : 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>>(arg1),
            market  : 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>>(arg0),
            bid     : 0x1::option::none<u128>(),
            ask     : 0x1::option::none<u128>(),
        };
        0x2::transfer::share_object<Orders>(v0);
    }

    fun eligible(arg0: u256, arg1: bool, arg2: &Placement) : bool {
        !arg2.reduce_only || arg0 != 0 && 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::is_neg(arg0) != arg1
    }

    fun expired(arg0: &0x1::option::Option<Placement>, arg1: u64) : bool {
        if (0x1::option::is_some<Placement>(arg0)) {
            if (0x1::option::is_some<u64>(&0x1::option::borrow<Placement>(arg0).expiration_timestamp_ms)) {
                *0x1::option::borrow<u64>(&0x1::option::borrow<Placement>(arg0).expiration_timestamp_ms) <= arg1
            } else {
                false
            }
        } else {
            false
        }
    }

    fun place<T0>(arg0: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::SessionHotPotato<T0>, arg1: u256, arg2: bool, arg3: Placement) : 0x1::option::Option<u128> {
        if (arg3.reduce_only) {
            let v0 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::summary<T0>(arg0);
            if (!eligible(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::add(arg1, 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::sub(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::base_filled_bid(v0), 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::base_filled_ask(v0))), arg2, &arg3)) {
                return 0x1::option::none<u128>()
            };
        };
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::place_limit_order<T0>(arg0, arg2, arg3.size, arg3.price, arg3.order_type, arg3.client_order_id, arg3.reduce_only, arg3.expiration_timestamp_ms)
    }

    public fun placement(arg0: u64, arg1: u64, arg2: u64, arg3: 0x1::option::Option<u64>, arg4: bool, arg5: 0x1::option::Option<u64>) : Placement {
        Placement{
            size                    : arg0,
            price                   : arg1,
            order_type              : arg2,
            client_order_id         : arg3,
            reduce_only             : arg4,
            expiration_timestamp_ms : arg5,
        }
    }

    fun prepare<T0, T1>(arg0: &mut Orders, arg1: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg2: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::authority::ACCOUNT, T1>, arg3: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>, arg4: &0x1::option::Option<Placement>, arg5: &0x1::option::Option<Placement>, arg6: &0x2::clock::Clock) : bool {
        assert!(arg0.account == 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>>(arg3), 0);
        assert!(arg0.market == 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>>(arg1), 1);
        let v0 = 0x2::clock::timestamp_ms(arg6);
        if (expired(arg4, v0) || expired(arg5, v0)) {
            let v1 = vector[];
            0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::try_cancel_orders<T0, T1>(arg1, arg2, arg3, &v1);
            return false
        };
        let v2 = vector[];
        if (0x1::option::is_some<u128>(&arg0.bid)) {
            0x1::vector::push_back<u128>(&mut v2, *0x1::option::borrow<u128>(&arg0.bid));
        };
        if (0x1::option::is_some<u128>(&arg0.ask)) {
            0x1::vector::push_back<u128>(&mut v2, *0x1::option::borrow<u128>(&arg0.ask));
        };
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::try_cancel_orders<T0, T1>(arg1, arg2, arg3, &v2);
        assert_no_orders<T0>(arg1, arg3);
        arg0.bid = 0x1::option::none<u128>();
        arg0.ask = 0x1::option::none<u128>();
        let (v3, _) = 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::base_and_quote_amounts(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::position<T0>(arg1, 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::account_id<T0>(arg3)));
        0x1::option::is_some<Placement>(arg4) && eligible(v3, false, 0x1::option::borrow<Placement>(arg4)) || 0x1::option::is_some<Placement>(arg5) && eligible(v3, true, 0x1::option::borrow<Placement>(arg5))
    }

    public fun replace<T0, T1>(arg0: &mut Orders, arg1: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg2: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::authority::ACCOUNT, T1>, arg3: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>, arg4: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg5: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg6: u256, arg7: 0x1::option::Option<Placement>, arg8: 0x1::option::Option<Placement>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0> {
        let v0 = &mut arg1;
        let v1 = prepare<T0, T1>(arg0, v0, arg2, arg3, &arg7, &arg8, arg9);
        if (!v1) {
            return arg1
        };
        replace_prepared<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10)
    }

    fun replace_prepared<T0, T1>(arg0: &mut Orders, arg1: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg2: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::authority::ACCOUNT, T1>, arg3: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>, arg4: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg5: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg6: u256, arg7: 0x1::option::Option<Placement>, arg8: 0x1::option::Option<Placement>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0> {
        let (v0, _) = 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::base_and_quote_amounts(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::position<T0>(&arg1, 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::account_id<T0>(arg3)));
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::set_position_initial_margin_ratio<T0, T1>(&mut arg1, arg2, arg3, arg6);
        let v2 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::start_session<T0, T1>(arg1, arg2, arg3, arg4, arg5, 0x1::option::none<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::IntegratorInfo>(), arg9, arg10);
        if (0x1::option::is_some<Placement>(&arg7)) {
            let v3 = &mut v2;
            arg0.bid = place<T0>(v3, v0, false, 0x1::option::destroy_some<Placement>(arg7));
        };
        if (0x1::option::is_some<Placement>(&arg8)) {
            let v4 = &mut v2;
            arg0.ask = place<T0>(v4, v0, true, 0x1::option::destroy_some<Placement>(arg8));
        };
        let (v5, _) = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::end_session<T0, T1>(v2, arg2, arg3, true, true);
        let v7 = v5;
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::set_position_initial_margin_ratio<T0, T1>(&mut v7, arg2, arg3, 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::margin_ratio_initial(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::market_params<T0>(&arg1)));
        v7
    }

    public fun replace_with_oracle<T0, T1>(arg0: &mut Orders, arg1: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg2: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::authority::ACCOUNT, T1>, arg3: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>, arg4: &mut 0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg5: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg6: u256, arg7: 0x1::option::Option<Placement>, arg8: 0x1::option::Option<Placement>, arg9: &0x2::clock::Clock, arg10: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::source::Source<0xa5428da682b4fad53e40f73dc07b547e33be078ec1c5d4a4378d6a316f0d9104::source::PYTH_LAZER>, arg11: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::config::Config, arg12: &mut 0xa5428da682b4fad53e40f73dc07b547e33be078ec1c5d4a4378d6a316f0d9104::feed_info_object::FeedInfoObject, arg13: &0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::state::State, arg14: vector<u8>, arg15: &mut 0x2::tx_context::TxContext) : 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0> {
        let v0 = &mut arg1;
        let v1 = prepare<T0, T1>(arg0, v0, arg2, arg3, &arg7, &arg8, arg9);
        if (!v1) {
            return arg1
        };
        let (v2, _) = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::twap_last_upd_ms(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::market_state<T0>(&arg1));
        let v4 = 0x2::clock::timestamp_ms(arg9);
        if (v4 >= v2 && v4 - v2 >= 57000) {
            0xa5428da682b4fad53e40f73dc07b547e33be078ec1c5d4a4378d6a316f0d9104::price_feed_storage::update_price_feed(arg10, arg11, arg4, arg12, arg13, arg14, arg9);
        };
        replace_prepared<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg15)
    }

    // decompiled from Move bytecode v7
}

