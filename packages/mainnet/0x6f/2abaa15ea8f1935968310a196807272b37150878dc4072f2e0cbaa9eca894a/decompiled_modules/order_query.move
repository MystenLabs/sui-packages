module 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order_query {
    struct OrderPage has drop {
        orders: vector<0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order::Order>,
        has_next_page: bool,
    }

    public fun has_next_page(arg0: &OrderPage) : bool {
        arg0.has_next_page
    }

    public fun iter_orders<T0, T1>(arg0: &0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::pool::Pool<T0, T1>, arg1: 0x1::option::Option<u128>, arg2: 0x1::option::Option<u128>, arg3: 0x1::option::Option<u64>, arg4: u64, arg5: bool) : OrderPage {
        let v0 = if (arg5) {
            170141183460469231731687303715884105728
        } else {
            170141183460469231731687303715884105728
        };
        let v1 = if (arg5) {
            0
        } else {
            0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::constants::max_u128()
        };
        let v2 = 0x1::option::get_with_default<u128>(&arg2, v1);
        let v3 = if (arg5) {
            0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::pool::bids<T0, T1>(0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::pool::load_inner<T0, T1>(arg0))
        } else {
            0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::pool::asks<T0, T1>(0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::pool::load_inner<T0, T1>(arg0))
        };
        let v4 = 0x1::vector::empty<0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order::Order>();
        let (v5, v6) = if (arg5) {
            0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::big_vector::slice_before<0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order::Order>(v3, 0x1::option::get_with_default<u128>(&arg1, v0))
        } else {
            0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::big_vector::slice_following<0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order::Order>(v3, 0x1::option::get_with_default<u128>(&arg1, v0))
        };
        let v7 = v6;
        let v8 = v5;
        while (!0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::big_vector::slice_is_null(&v8) && 0x1::vector::length<0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order::Order>(&v4) < arg4) {
            let v9 = 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::big_vector::slice_borrow<0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order::Order>(0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::big_vector::borrow_slice<0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order::Order>(v3, v8), v7);
            if (arg5 && 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order::order_id(v9) < v2) {
                break
            };
            if (!arg5 && 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order::order_id(v9) > v2) {
                break
            };
            if (0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order::expire_timestamp(v9) >= 0x1::option::get_with_default<u64>(&arg3, 0)) {
                0x1::vector::push_back<0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order::Order>(&mut v4, 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order::copy_order(v9));
            };
            let (v10, v11) = if (arg5) {
                0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::big_vector::prev_slice<0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order::Order>(v3, v8, v7)
            } else {
                0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::big_vector::next_slice<0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order::Order>(v3, v8, v7)
            };
            v7 = v11;
            v8 = v10;
        };
        OrderPage{
            orders        : v4,
            has_next_page : !0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::big_vector::slice_is_null(&v8),
        }
    }

    public fun orders(arg0: &OrderPage) : &vector<0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order::Order> {
        &arg0.orders
    }

    // decompiled from Move bytecode v6
}

