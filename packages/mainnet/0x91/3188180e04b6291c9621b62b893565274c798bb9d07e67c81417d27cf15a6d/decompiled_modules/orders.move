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

    fun place<T0>(arg0: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::SessionHotPotato<T0>, arg1: bool, arg2: Placement) : 0x1::option::Option<u128> {
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::place_limit_order<T0>(arg0, arg1, arg2.size, arg2.price, arg2.order_type, arg2.client_order_id, arg2.reduce_only, arg2.expiration_timestamp_ms)
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

    public fun replace<T0, T1>(arg0: &mut Orders, arg1: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg2: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::authority::ACCOUNT, T1>, arg3: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>, arg4: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg5: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg6: u256, arg7: 0x1::option::Option<Placement>, arg8: 0x1::option::Option<Placement>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0> {
        assert!(arg0.account == 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>>(arg3), 0);
        assert!(arg0.market == 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>>(&arg1), 1);
        let v0 = vector[];
        if (0x1::option::is_some<u128>(&arg0.bid)) {
            0x1::vector::push_back<u128>(&mut v0, *0x1::option::borrow<u128>(&arg0.bid));
        };
        if (0x1::option::is_some<u128>(&arg0.ask)) {
            0x1::vector::push_back<u128>(&mut v0, *0x1::option::borrow<u128>(&arg0.ask));
        };
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::try_cancel_orders<T0, T1>(&mut arg1, arg2, arg3, &v0);
        assert_no_orders<T0>(&arg1, arg3);
        arg0.bid = 0x1::option::none<u128>();
        arg0.ask = 0x1::option::none<u128>();
        if (0x1::option::is_none<Placement>(&arg7) && 0x1::option::is_none<Placement>(&arg8)) {
            return arg1
        };
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::set_position_initial_margin_ratio<T0, T1>(&mut arg1, arg2, arg3, arg6);
        let v1 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::start_session<T0, T1>(arg1, arg2, arg3, arg4, arg5, 0x1::option::none<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::IntegratorInfo>(), arg9, arg10);
        if (0x1::option::is_some<Placement>(&arg7)) {
            let v2 = &mut v1;
            arg0.bid = place<T0>(v2, false, 0x1::option::destroy_some<Placement>(arg7));
        };
        if (0x1::option::is_some<Placement>(&arg8)) {
            let v3 = &mut v1;
            arg0.ask = place<T0>(v3, true, 0x1::option::destroy_some<Placement>(arg8));
        };
        let (v4, _) = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::end_session<T0, T1>(v1, arg2, arg3, true, true);
        let v6 = v4;
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::set_position_initial_margin_ratio<T0, T1>(&mut v6, arg2, arg3, 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::margin_ratio_initial(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::market_params<T0>(&arg1)));
        v6
    }

    // decompiled from Move bytecode v7
}

