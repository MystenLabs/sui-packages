module 0x7294d012d99753954acb64f5d939485402938d7d343e500f10cc5400e39ee36c::order_query {
    struct OrderPage has drop {
        orders: vector<0x7294d012d99753954acb64f5d939485402938d7d343e500f10cc5400e39ee36c::order::Order>,
        has_next_page: bool,
    }

    public fun has_next_page(arg0: &OrderPage) : bool {
        arg0.has_next_page
    }

    public fun iter_orders<T0, T1>(arg0: &0x7294d012d99753954acb64f5d939485402938d7d343e500f10cc5400e39ee36c::pool::Pool<T0, T1>, arg1: 0x1::option::Option<u128>, arg2: 0x1::option::Option<u128>, arg3: 0x1::option::Option<u64>, arg4: u64, arg5: bool) : OrderPage {
        let v0 = if (arg5) {
            170141183460469231731687303715884105728
        } else {
            170141183460469231731687303715884105728
        };
        let v1 = if (arg5) {
            0
        } else {
            0x7294d012d99753954acb64f5d939485402938d7d343e500f10cc5400e39ee36c::constants::max_u128()
        };
        let v2 = 0x1::option::get_with_default<u128>(&arg2, v1);
        let v3 = if (arg5) {
            0x7294d012d99753954acb64f5d939485402938d7d343e500f10cc5400e39ee36c::pool::bids<T0, T1>(0x7294d012d99753954acb64f5d939485402938d7d343e500f10cc5400e39ee36c::pool::load_inner<T0, T1>(arg0))
        } else {
            0x7294d012d99753954acb64f5d939485402938d7d343e500f10cc5400e39ee36c::pool::asks<T0, T1>(0x7294d012d99753954acb64f5d939485402938d7d343e500f10cc5400e39ee36c::pool::load_inner<T0, T1>(arg0))
        };
        let v4 = 0x1::vector::empty<0x7294d012d99753954acb64f5d939485402938d7d343e500f10cc5400e39ee36c::order::Order>();
        let (v5, v6) = if (arg5) {
            0x7294d012d99753954acb64f5d939485402938d7d343e500f10cc5400e39ee36c::big_vector::slice_before<0x7294d012d99753954acb64f5d939485402938d7d343e500f10cc5400e39ee36c::order::Order>(v3, 0x1::option::get_with_default<u128>(&arg1, v0))
        } else {
            0x7294d012d99753954acb64f5d939485402938d7d343e500f10cc5400e39ee36c::big_vector::slice_following<0x7294d012d99753954acb64f5d939485402938d7d343e500f10cc5400e39ee36c::order::Order>(v3, 0x1::option::get_with_default<u128>(&arg1, v0))
        };
        let v7 = v6;
        let v8 = v5;
        while (!0x7294d012d99753954acb64f5d939485402938d7d343e500f10cc5400e39ee36c::big_vector::slice_is_null(&v8) && 0x1::vector::length<0x7294d012d99753954acb64f5d939485402938d7d343e500f10cc5400e39ee36c::order::Order>(&v4) < arg4) {
            let v9 = 0x7294d012d99753954acb64f5d939485402938d7d343e500f10cc5400e39ee36c::big_vector::slice_borrow<0x7294d012d99753954acb64f5d939485402938d7d343e500f10cc5400e39ee36c::order::Order>(0x7294d012d99753954acb64f5d939485402938d7d343e500f10cc5400e39ee36c::big_vector::borrow_slice<0x7294d012d99753954acb64f5d939485402938d7d343e500f10cc5400e39ee36c::order::Order>(v3, v8), v7);
            if (arg5 && 0x7294d012d99753954acb64f5d939485402938d7d343e500f10cc5400e39ee36c::order::order_id(v9) < v2) {
                break
            };
            if (!arg5 && 0x7294d012d99753954acb64f5d939485402938d7d343e500f10cc5400e39ee36c::order::order_id(v9) > v2) {
                break
            };
            if (0x7294d012d99753954acb64f5d939485402938d7d343e500f10cc5400e39ee36c::order::expire_timestamp(v9) >= 0x1::option::get_with_default<u64>(&arg3, 0)) {
                0x1::vector::push_back<0x7294d012d99753954acb64f5d939485402938d7d343e500f10cc5400e39ee36c::order::Order>(&mut v4, 0x7294d012d99753954acb64f5d939485402938d7d343e500f10cc5400e39ee36c::order::copy_order(v9));
            };
            let (v10, v11) = if (arg5) {
                0x7294d012d99753954acb64f5d939485402938d7d343e500f10cc5400e39ee36c::big_vector::prev_slice<0x7294d012d99753954acb64f5d939485402938d7d343e500f10cc5400e39ee36c::order::Order>(v3, v8, v7)
            } else {
                0x7294d012d99753954acb64f5d939485402938d7d343e500f10cc5400e39ee36c::big_vector::next_slice<0x7294d012d99753954acb64f5d939485402938d7d343e500f10cc5400e39ee36c::order::Order>(v3, v8, v7)
            };
            v7 = v11;
            v8 = v10;
        };
        OrderPage{
            orders        : v4,
            has_next_page : !0x7294d012d99753954acb64f5d939485402938d7d343e500f10cc5400e39ee36c::big_vector::slice_is_null(&v8),
        }
    }

    public fun orders(arg0: &OrderPage) : &vector<0x7294d012d99753954acb64f5d939485402938d7d343e500f10cc5400e39ee36c::order::Order> {
        &arg0.orders
    }

    // decompiled from Move bytecode v6
}

