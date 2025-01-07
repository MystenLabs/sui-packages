module 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::order_query {
    struct OrderPage has drop {
        orders: vector<0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::clob_v2::Order>,
        has_next_page: bool,
        next_tick_level: 0x1::option::Option<u64>,
        next_order_id: 0x1::option::Option<u64>,
    }

    public fun order_id(arg0: &0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::clob_v2::Order) : u64 {
        0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::clob_v2::order_id(arg0)
    }

    public fun tick_level(arg0: &0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::clob_v2::Order) : u64 {
        0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::clob_v2::tick_level(arg0)
    }

    public fun has_next_page(arg0: &OrderPage) : bool {
        arg0.has_next_page
    }

    public fun iter_asks<T0, T1>(arg0: &0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::clob_v2::Pool<T0, T1>, arg1: 0x1::option::Option<u64>, arg2: 0x1::option::Option<u64>, arg3: 0x1::option::Option<u64>, arg4: 0x1::option::Option<u64>, arg5: bool) : OrderPage {
        let v0 = iter_ticks_internal(0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::clob_v2::asks<T0, T1>(arg0), arg1, arg2, arg3, arg4, arg5);
        let (v0, v1, v2, v3) = if (0x1::vector::length<0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::clob_v2::Order>(&v0) > 100) {
            let v4 = 0x1::vector::pop_back<0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::clob_v2::Order>(&mut v0);
            (v0, true, 0x1::option::some<u64>(0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::clob_v2::tick_level(&v4)), 0x1::option::some<u64>(0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::clob_v2::order_id(&v4)))
        } else {
            (v0, false, 0x1::option::none<u64>(), 0x1::option::none<u64>())
        };
        OrderPage{
            orders          : v0,
            has_next_page   : v1,
            next_tick_level : v2,
            next_order_id   : v3,
        }
    }

    public fun iter_bids<T0, T1>(arg0: &0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::clob_v2::Pool<T0, T1>, arg1: 0x1::option::Option<u64>, arg2: 0x1::option::Option<u64>, arg3: 0x1::option::Option<u64>, arg4: 0x1::option::Option<u64>, arg5: bool) : OrderPage {
        let v0 = iter_ticks_internal(0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::clob_v2::bids<T0, T1>(arg0), arg1, arg2, arg3, arg4, arg5);
        let (v0, v1, v2, v3) = if (0x1::vector::length<0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::clob_v2::Order>(&v0) > 100) {
            let v4 = 0x1::vector::pop_back<0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::clob_v2::Order>(&mut v0);
            (v0, true, 0x1::option::some<u64>(0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::clob_v2::tick_level(&v4)), 0x1::option::some<u64>(0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::clob_v2::order_id(&v4)))
        } else {
            (v0, false, 0x1::option::none<u64>(), 0x1::option::none<u64>())
        };
        OrderPage{
            orders          : v0,
            has_next_page   : v1,
            next_tick_level : v2,
            next_order_id   : v3,
        }
    }

    fun iter_ticks_internal(arg0: &0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::critbit::CritbitTree<0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::clob_v2::TickLevel>, arg1: 0x1::option::Option<u64>, arg2: 0x1::option::Option<u64>, arg3: 0x1::option::Option<u64>, arg4: 0x1::option::Option<u64>, arg5: bool) : vector<0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::clob_v2::Order> {
        let v0 = if (0x1::option::is_some<u64>(&arg1)) {
            0x1::option::destroy_some<u64>(arg1)
        } else if (arg5) {
            let (v1, _) = 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::critbit::min_leaf<0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::clob_v2::TickLevel>(arg0);
            v1
        } else {
            let (v3, _) = 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::critbit::max_leaf<0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::clob_v2::TickLevel>(arg0);
            v3
        };
        let v5 = v0;
        let v6 = 0x1::vector::empty<0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::clob_v2::Order>();
        while (v5 != 0 && 0x1::vector::length<0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::clob_v2::Order>(&v6) < 100 + 1) {
            let v7 = 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::clob_v2::open_orders(0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::critbit::borrow_leaf_by_key<0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::clob_v2::TickLevel>(arg0, v5));
            let v8 = if (0x1::option::is_some<u64>(&arg2)) {
                let v9 = 0x1::option::destroy_some<u64>(arg2);
                if (!0x2::linked_table::contains<u64, 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::clob_v2::Order>(v7, v9)) {
                    let v10 = if (arg5) {
                        let (v11, _) = 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::critbit::next_leaf<0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::clob_v2::TickLevel>(arg0, v5);
                        v11
                    } else {
                        let (v13, _) = 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::critbit::previous_leaf<0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::clob_v2::TickLevel>(arg0, v5);
                        v13
                    };
                    v5 = v10;
                    continue
                };
                arg2 = 0x1::option::none<u64>();
                0x1::option::some<u64>(v9)
            } else {
                *0x2::linked_table::front<u64, 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::clob_v2::Order>(v7)
            };
            let v15 = v8;
            while (0x1::option::is_some<u64>(&v15) && 0x1::vector::length<0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::clob_v2::Order>(&v6) < 100 + 1) {
                let v16 = 0x1::option::destroy_some<u64>(v15);
                let v17 = 0x2::linked_table::borrow<u64, 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::clob_v2::Order>(v7, v16);
                if (0x1::option::is_some<u64>(&arg4) && v16 > 0x1::option::destroy_some<u64>(arg4)) {
                    break
                };
                v15 = *0x2::linked_table::next<u64, 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::clob_v2::Order>(v7, v16);
                if (0x1::option::is_none<u64>(&arg3) || 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::clob_v2::expire_timestamp(v17) > 0x1::option::destroy_some<u64>(arg3)) {
                    0x1::vector::push_back<0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::clob_v2::Order>(&mut v6, 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::clob_v2::clone_order(v17));
                    continue
                };
            };
            let v18 = if (arg5) {
                let (v19, _) = 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::critbit::next_leaf<0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::clob_v2::TickLevel>(arg0, v5);
                v19
            } else {
                let (v21, _) = 0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::critbit::previous_leaf<0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::clob_v2::TickLevel>(arg0, v5);
                v21
            };
            v5 = v18;
        };
        v6
    }

    public fun next_order_id(arg0: &OrderPage) : 0x1::option::Option<u64> {
        arg0.next_order_id
    }

    public fun next_tick_level(arg0: &OrderPage) : 0x1::option::Option<u64> {
        arg0.next_tick_level
    }

    public fun orders(arg0: &OrderPage) : &vector<0x880fe9b78ec5ce391eb99f8c23310e42ade9ce09e3127480abcb7f4b47a0a784::clob_v2::Order> {
        &arg0.orders
    }

    // decompiled from Move bytecode v6
}

