module 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::orderbook {
    struct Order has copy, drop, store {
        account_id: u64,
        size: u64,
        reduce_only: bool,
        expiration_timestamp_ms: 0x1::option::Option<u64>,
        integrator_info: 0x1::option::Option<0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::account::IntegratorInfo>,
        client_order_id: 0x1::option::Option<u64>,
    }

    struct Orderbook has store, key {
        id: 0x2::object::UID,
        counter: u64,
        best_ask_price: 0x1::option::Option<u64>,
        best_bid_price: 0x1::option::Option<u64>,
    }

    public fun as_parts(arg0: &Order) : (u64, u64, bool, 0x1::option::Option<u64>, 0x1::option::Option<u64>, 0x1::option::Option<0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::account::IntegratorInfo>) {
        (arg0.account_id, arg0.size, arg0.reduce_only, arg0.expiration_timestamp_ms, arg0.client_order_id, arg0.integrator_info)
    }

    public(friend) fun asks(arg0: &Orderbook) : &0xf453864f39b7c6122551f665d4fe961b8625853cf89bcae55be4b3b99e848126::ordered_map::Map<Order> {
        0x2::dynamic_object_field::borrow<0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::keys::AsksMapKey, 0xf453864f39b7c6122551f665d4fe961b8625853cf89bcae55be4b3b99e848126::ordered_map::Map<Order>>(&arg0.id, 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::keys::asks_map())
    }

    public fun best_price(arg0: &Orderbook, arg1: bool) : 0x1::option::Option<u64> {
        if (arg1) {
            if (0x1::option::is_none<u64>(&arg0.best_ask_price)) {
                return 0x1::option::none<u64>()
            };
            return arg0.best_ask_price
        };
        if (0x1::option::is_none<u64>(&arg0.best_bid_price)) {
            return 0x1::option::none<u64>()
        };
        arg0.best_bid_price
    }

    public(friend) fun bids(arg0: &Orderbook) : &0xf453864f39b7c6122551f665d4fe961b8625853cf89bcae55be4b3b99e848126::ordered_map::Map<Order> {
        0x2::dynamic_object_field::borrow<0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::keys::BidsMapKey, 0xf453864f39b7c6122551f665d4fe961b8625853cf89bcae55be4b3b99e848126::ordered_map::Map<Order>>(&arg0.id, 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::keys::bids_map())
    }

    public fun book_price(arg0: &Orderbook) : 0x1::option::Option<u64> {
        if (0x1::option::is_none<u64>(&arg0.best_ask_price) || 0x1::option::is_none<u64>(&arg0.best_bid_price)) {
            0x1::option::none<u64>()
        } else {
            0x1::option::some<u64>((*0x1::option::borrow<u64>(&arg0.best_ask_price) + *0x1::option::borrow<u64>(&arg0.best_bid_price)) / 2)
        }
    }

    public fun book_price_or_index(arg0: &Orderbook, arg1: u256) : u256 {
        let v0 = book_price(arg0);
        if (0x1::option::is_none<u64>(&v0)) {
            return arg1
        };
        0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::from_balance(0x1::option::destroy_some<u64>(v0), 1000000000)
    }

    public(friend) fun borrow_mut_asks(arg0: &mut Orderbook) : &mut 0xf453864f39b7c6122551f665d4fe961b8625853cf89bcae55be4b3b99e848126::ordered_map::Map<Order> {
        0x2::dynamic_object_field::borrow_mut<0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::keys::AsksMapKey, 0xf453864f39b7c6122551f665d4fe961b8625853cf89bcae55be4b3b99e848126::ordered_map::Map<Order>>(&mut arg0.id, 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::keys::asks_map())
    }

    public(friend) fun borrow_mut_bids(arg0: &mut Orderbook) : &mut 0xf453864f39b7c6122551f665d4fe961b8625853cf89bcae55be4b3b99e848126::ordered_map::Map<Order> {
        0x2::dynamic_object_field::borrow_mut<0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::keys::BidsMapKey, 0xf453864f39b7c6122551f665d4fe961b8625853cf89bcae55be4b3b99e848126::ordered_map::Map<Order>>(&mut arg0.id, 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::keys::bids_map())
    }

    public(friend) fun cancel_limit_order(arg0: &mut Orderbook, arg1: u64, arg2: u128) : (u64, 0x1::option::Option<u64>) {
        let v0 = arg2 < 170141183460469231731687303715884105728;
        let v1 = if (v0) {
            ((arg2 >> 64) as u64)
        } else {
            ((arg2 >> 64) as u64) ^ 18446744073709551615
        };
        let (v2, v3) = if (v0) {
            let v2 = &mut arg0.best_ask_price;
            let v3 = 0x2::dynamic_object_field::borrow_mut<0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::keys::AsksMapKey, 0xf453864f39b7c6122551f665d4fe961b8625853cf89bcae55be4b3b99e848126::ordered_map::Map<Order>>(&mut arg0.id, 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::keys::asks_map());
            (v2, v3)
        } else {
            let v2 = &mut arg0.best_bid_price;
            let v3 = 0x2::dynamic_object_field::borrow_mut<0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::keys::BidsMapKey, 0xf453864f39b7c6122551f665d4fe961b8625853cf89bcae55be4b3b99e848126::ordered_map::Map<Order>>(&mut arg0.id, 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::keys::bids_map());
            (v2, v3)
        };
        let v4 = 0x1::option::is_some<u64>(v2) && *0x1::option::borrow<u64>(v2) == v1;
        let v5 = 0xf453864f39b7c6122551f665d4fe961b8625853cf89bcae55be4b3b99e848126::ordered_map::remove<Order>(v3, arg2);
        if (arg1 != v5.account_id) {
            abort 3000
        };
        if (v4) {
            if (0xf453864f39b7c6122551f665d4fe961b8625853cf89bcae55be4b3b99e848126::ordered_map::is_empty<Order>(v3)) {
                *v2 = 0x1::option::none<u64>();
            } else {
                let v6 = if (v0) {
                    ((0xf453864f39b7c6122551f665d4fe961b8625853cf89bcae55be4b3b99e848126::ordered_map::min_key<Order>(v3) >> 64) as u64)
                } else {
                    ((0xf453864f39b7c6122551f665d4fe961b8625853cf89bcae55be4b3b99e848126::ordered_map::min_key<Order>(v3) >> 64) as u64) ^ 18446744073709551615
                };
                *v2 = 0x1::option::some<u64>(v6);
            };
        };
        (v5.size, v5.client_order_id)
    }

    public(friend) fun change_maps_params(arg0: &mut Orderbook, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) {
        let v0 = borrow_mut_asks(arg0);
        0xf453864f39b7c6122551f665d4fe961b8625853cf89bcae55be4b3b99e848126::ordered_map::change_params<Order>(v0, arg1, arg2, arg3, arg4, arg5, arg6);
        0xf453864f39b7c6122551f665d4fe961b8625853cf89bcae55be4b3b99e848126::ordered_map::change_params<Order>(borrow_mut_bids(arg0), arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public(friend) fun create_orderbook(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : Orderbook {
        let v0 = Orderbook{
            id             : 0x2::object::new(arg6),
            counter        : 0,
            best_ask_price : 0x1::option::none<u64>(),
            best_bid_price : 0x1::option::none<u64>(),
        };
        0x2::dynamic_object_field::add<0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::keys::AsksMapKey, 0xf453864f39b7c6122551f665d4fe961b8625853cf89bcae55be4b3b99e848126::ordered_map::Map<Order>>(&mut v0.id, 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::keys::asks_map(), 0xf453864f39b7c6122551f665d4fe961b8625853cf89bcae55be4b3b99e848126::ordered_map::empty<Order>(arg0, arg1, arg2, arg3, arg4, arg5, arg6));
        0x2::dynamic_object_field::add<0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::keys::BidsMapKey, 0xf453864f39b7c6122551f665d4fe961b8625853cf89bcae55be4b3b99e848126::ordered_map::Map<Order>>(&mut v0.id, 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::keys::bids_map(), 0xf453864f39b7c6122551f665d4fe961b8625853cf89bcae55be4b3b99e848126::ordered_map::empty<Order>(arg0, arg1, arg2, arg3, arg4, arg5, arg6));
        v0
    }

    public fun get_order(arg0: &Orderbook, arg1: u128) : 0x1::option::Option<Order> {
        let v0 = if (arg1 < 170141183460469231731687303715884105728) {
            asks(arg0)
        } else {
            bids(arg0)
        };
        if (!0xf453864f39b7c6122551f665d4fe961b8625853cf89bcae55be4b3b99e848126::ordered_map::has_key<Order>(v0, arg1)) {
            return 0x1::option::none<Order>()
        };
        0x1::option::some<Order>(*0xf453864f39b7c6122551f665d4fe961b8625853cf89bcae55be4b3b99e848126::ordered_map::borrow<Order>(v0, arg1))
    }

    fun increase_counter(arg0: &mut u64) : u64 {
        *arg0 = *arg0 + 1;
        *arg0
    }

    public fun inspect_orders(arg0: &Orderbook, arg1: bool, arg2: u64, arg3: u64, arg4: u64) : (vector<u128>, vector<Order>) {
        if (arg4 == 0) {
            return (vector[], 0x1::vector::empty<Order>())
        };
        if (arg4 > 50) {
            arg4 = 50;
        };
        let (v0, v1, v2) = if (arg1) {
            let v2 = asks(arg0);
            ((arg2 as u128) << 64 | 0, arg3, v2)
        } else {
            let v2 = bids(arg0);
            (((arg2 ^ 18446744073709551615) as u128) << 64 | 0, arg3 ^ 18446744073709551615, v2)
        };
        let v3 = 0x1::vector::empty<Order>();
        let v4 = vector[];
        let v5 = 0xf453864f39b7c6122551f665d4fe961b8625853cf89bcae55be4b3b99e848126::ordered_map::get_leaf<Order>(v2, 0xf453864f39b7c6122551f665d4fe961b8625853cf89bcae55be4b3b99e848126::ordered_map::find_leaf<Order>(v2, v0));
        let v6 = 0xf453864f39b7c6122551f665d4fe961b8625853cf89bcae55be4b3b99e848126::ordered_map::find_index<Order>(v5, v0);
        loop {
            while (v6 < 0xf453864f39b7c6122551f665d4fe961b8625853cf89bcae55be4b3b99e848126::ordered_map::size<Order>(v5)) {
                let (v7, v8) = 0xf453864f39b7c6122551f665d4fe961b8625853cf89bcae55be4b3b99e848126::ordered_map::elem<Order>(v5, v6);
                if (((v7 >> 64) as u64) >= v1) {
                    return (v4, v3)
                };
                0x1::vector::push_back<u128>(&mut v4, v7);
                0x1::vector::push_back<Order>(&mut v3, *v8);
                if (0x1::vector::length<u128>(&v4) == arg4) {
                    return (v4, v3)
                };
                v6 = v6 + 1;
            };
            let v9 = 0xf453864f39b7c6122551f665d4fe961b8625853cf89bcae55be4b3b99e848126::ordered_map::next<Order>(v5);
            if (v9 == 0) {
                break
            };
            v5 = 0xf453864f39b7c6122551f665d4fe961b8625853cf89bcae55be4b3b99e848126::ordered_map::get_leaf<Order>(v2, v9);
            v6 = 0;
        };
        (v4, v3)
    }

    public fun order_size(arg0: &Orderbook, arg1: u128) : u64 {
        let v0 = if (arg1 < 170141183460469231731687303715884105728 == true) {
            0xf453864f39b7c6122551f665d4fe961b8625853cf89bcae55be4b3b99e848126::ordered_map::borrow<Order>(asks(arg0), arg1)
        } else {
            0xf453864f39b7c6122551f665d4fe961b8625853cf89bcae55be4b3b99e848126::ordered_map::borrow<Order>(bids(arg0), arg1)
        };
        v0.size
    }

    public(friend) fun order_snapshot(arg0: &Order) : (u64, 0x1::option::Option<u64>, u64, bool, 0x1::option::Option<u64>, 0x1::option::Option<0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::account::IntegratorInfo>) {
        (arg0.account_id, arg0.client_order_id, arg0.size, arg0.reduce_only, arg0.expiration_timestamp_ms, arg0.integrator_info)
    }

    public(friend) fun post_order(arg0: &mut Orderbook, arg1: u64, arg2: bool, arg3: u64, arg4: u64, arg5: 0x1::option::Option<u64>, arg6: bool, arg7: 0x1::option::Option<u64>, arg8: 0x1::option::Option<0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::account::IntegratorInfo>) : u128 {
        let v0 = &mut arg0.counter;
        let v1 = if (arg2) {
            (arg4 as u128) << 64 | (increase_counter(v0) as u128)
        } else {
            ((arg4 ^ 18446744073709551615) as u128) << 64 | (increase_counter(v0) as u128)
        };
        if (arg2) {
            if (0x1::option::is_none<u64>(&arg0.best_ask_price) || arg4 < *0x1::option::borrow<u64>(&arg0.best_ask_price)) {
                arg0.best_ask_price = 0x1::option::some<u64>(arg4);
            };
        } else if (0x1::option::is_none<u64>(&arg0.best_bid_price) || arg4 > *0x1::option::borrow<u64>(&arg0.best_bid_price)) {
            arg0.best_bid_price = 0x1::option::some<u64>(arg4);
        };
        let v2 = Order{
            account_id              : arg1,
            size                    : arg3,
            reduce_only             : arg6,
            expiration_timestamp_ms : arg7,
            integrator_info         : arg8,
            client_order_id         : arg5,
        };
        if (arg2) {
            0xf453864f39b7c6122551f665d4fe961b8625853cf89bcae55be4b3b99e848126::ordered_map::insert<Order>(borrow_mut_asks(arg0), v1, v2);
        } else {
            0xf453864f39b7c6122551f665d4fe961b8625853cf89bcae55be4b3b99e848126::ordered_map::insert<Order>(borrow_mut_bids(arg0), v1, v2);
        };
        v1
    }

    public(friend) fun reduce_order_size(arg0: &mut Order, arg1: u64) {
        arg0.size = arg0.size - arg1;
    }

    public(friend) fun set_best_price(arg0: &mut Orderbook, arg1: bool, arg2: 0x1::option::Option<u64>) {
        if (arg1) {
            arg0.best_ask_price = arg2;
        } else {
            arg0.best_bid_price = arg2;
        };
    }

    public(friend) fun try_cancel_limit_order(arg0: &mut Orderbook, arg1: u64, arg2: u128) : (bool, u64, 0x1::option::Option<u64>) {
        let v0 = arg2 < 170141183460469231731687303715884105728;
        let v1 = if (v0) {
            ((arg2 >> 64) as u64)
        } else {
            ((arg2 >> 64) as u64) ^ 18446744073709551615
        };
        let (v2, v3) = if (v0) {
            let v3 = 0x2::dynamic_object_field::borrow_mut<0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::keys::AsksMapKey, 0xf453864f39b7c6122551f665d4fe961b8625853cf89bcae55be4b3b99e848126::ordered_map::Map<Order>>(&mut arg0.id, 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::keys::asks_map());
            let v2 = &mut arg0.best_ask_price;
            (v2, v3)
        } else {
            let v3 = 0x2::dynamic_object_field::borrow_mut<0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::keys::BidsMapKey, 0xf453864f39b7c6122551f665d4fe961b8625853cf89bcae55be4b3b99e848126::ordered_map::Map<Order>>(&mut arg0.id, 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::keys::bids_map());
            let v2 = &mut arg0.best_bid_price;
            (v2, v3)
        };
        let v4 = 0x1::option::is_some<u64>(v2) && *0x1::option::borrow<u64>(v2) == v1;
        let v5 = 0xf453864f39b7c6122551f665d4fe961b8625853cf89bcae55be4b3b99e848126::ordered_map::try_remove<Order>(v3, arg2);
        if (0xf453864f39b7c6122551f665d4fe961b8625853cf89bcae55be4b3b99e848126::enum_option::is_none<Order>(&v5)) {
            return (false, 0, 0x1::option::none<u64>())
        };
        let v6 = 0xf453864f39b7c6122551f665d4fe961b8625853cf89bcae55be4b3b99e848126::enum_option::destroy_some<Order>(v5);
        assert!(arg1 == v6.account_id, 3000);
        if (v4) {
            if (0xf453864f39b7c6122551f665d4fe961b8625853cf89bcae55be4b3b99e848126::ordered_map::is_empty<Order>(v3)) {
                *v2 = 0x1::option::none<u64>();
            } else {
                let v7 = if (v0) {
                    ((0xf453864f39b7c6122551f665d4fe961b8625853cf89bcae55be4b3b99e848126::ordered_map::min_key<Order>(v3) >> 64) as u64)
                } else {
                    ((0xf453864f39b7c6122551f665d4fe961b8625853cf89bcae55be4b3b99e848126::ordered_map::min_key<Order>(v3) >> 64) as u64) ^ 18446744073709551615
                };
                *v2 = 0x1::option::some<u64>(v7);
            };
        };
        (true, v6.size, v6.client_order_id)
    }

    public(friend) fun try_cancel_stale_limit_order(arg0: &mut Orderbook, arg1: u64, arg2: u128, arg3: u64, arg4: u256) : (bool, bool, u64, 0x1::option::Option<u64>) {
        let v0 = get_order(arg0, arg2);
        if (0x1::option::is_none<Order>(&v0)) {
            return (false, false, 0, 0x1::option::none<u64>())
        };
        let v1 = 0x1::option::destroy_some<Order>(v0);
        assert!(arg1 == v1.account_id, 3000);
        let v2 = 0x1::option::is_some<u64>(&v1.expiration_timestamp_ms) && *0x1::option::borrow<u64>(&v1.expiration_timestamp_ms) <= arg3;
        let v3 = arg2 < 170141183460469231731687303715884105728;
        let v4 = arg4 != 0 && (v3 && !0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::is_neg(arg4) || !v3 && 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::is_neg(arg4));
        let v5 = v1.reduce_only && !v4;
        if (!v2 && !v5) {
            return (false, false, 0, 0x1::option::none<u64>())
        };
        let (_, v7, v8) = try_cancel_limit_order(arg0, arg1, arg2);
        (true, v2, v7, v8)
    }

    // decompiled from Move bytecode v7
}

