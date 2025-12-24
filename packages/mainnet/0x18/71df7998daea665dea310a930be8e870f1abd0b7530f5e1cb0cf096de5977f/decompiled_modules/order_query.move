module 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::order_query {
    struct OrderPage has drop {
        orders: vector<0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::order::Order>,
        has_next_page: bool,
    }

    public fun has_next_page(arg0: &OrderPage) : bool {
        arg0.has_next_page
    }

    public fun iter_orders<T0, T1>(arg0: &0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::pool::Pool<T0, T1>, arg1: 0x1::option::Option<u128>, arg2: 0x1::option::Option<u128>, arg3: 0x1::option::Option<u64>, arg4: u64, arg5: bool) : OrderPage {
        let v0 = if (arg5) {
            170141183460469231731687303715884105728
        } else {
            170141183460469231731687303715884105728
        };
        let v1 = if (arg5) {
            0
        } else {
            0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::constants::max_u128()
        };
        let v2 = 0x1::option::get_with_default<u128>(&arg2, v1);
        let v3 = if (arg5) {
            0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::pool::bids<T0, T1>(0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::pool::load_inner<T0, T1>(arg0))
        } else {
            0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::pool::asks<T0, T1>(0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::pool::load_inner<T0, T1>(arg0))
        };
        let v4 = 0x1::vector::empty<0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::order::Order>();
        let (v5, v6) = if (arg5) {
            0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::big_vector::slice_before<0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::order::Order>(v3, 0x1::option::get_with_default<u128>(&arg1, v0))
        } else {
            0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::big_vector::slice_following<0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::order::Order>(v3, 0x1::option::get_with_default<u128>(&arg1, v0))
        };
        let v7 = v6;
        let v8 = v5;
        while (!0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::big_vector::slice_is_null(&v8) && 0x1::vector::length<0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::order::Order>(&v4) < arg4) {
            let v9 = 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::big_vector::slice_borrow<0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::order::Order>(0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::big_vector::borrow_slice<0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::order::Order>(v3, v8), v7);
            if (arg5 && 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::order::order_id(v9) < v2) {
                break
            };
            if (!arg5 && 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::order::order_id(v9) > v2) {
                break
            };
            if (0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::order::expire_timestamp(v9) >= 0x1::option::get_with_default<u64>(&arg3, 0)) {
                0x1::vector::push_back<0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::order::Order>(&mut v4, 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::order::copy_order(v9));
            };
            let (v10, v11) = if (arg5) {
                0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::big_vector::prev_slice<0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::order::Order>(v3, v8, v7)
            } else {
                0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::big_vector::next_slice<0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::order::Order>(v3, v8, v7)
            };
            v7 = v11;
            v8 = v10;
        };
        OrderPage{
            orders        : v4,
            has_next_page : !0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::big_vector::slice_is_null(&v8),
        }
    }

    public fun orders(arg0: &OrderPage) : &vector<0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::order::Order> {
        &arg0.orders
    }

    // decompiled from Move bytecode v6
}

