module 0x16e51f1dd07710bdb9a99939464d733c137925eb92533f9703d9108abe6148ce::order_query {
    struct QueryResult has drop {
        orders: vector<0x16e51f1dd07710bdb9a99939464d733c137925eb92533f9703d9108abe6148ce::order::Order>,
        cursor: 0x1::option::Option<u64>,
        total: u64,
    }

    public fun orders(arg0: &QueryResult) : &vector<0x16e51f1dd07710bdb9a99939464d733c137925eb92533f9703d9108abe6148ce::order::Order> {
        &arg0.orders
    }

    public fun query_orders(arg0: &0x16e51f1dd07710bdb9a99939464d733c137925eb92533f9703d9108abe6148ce::orderbook::Orderbook, arg1: address, arg2: 0x1::option::Option<u64>, arg3: 0x1::option::Option<u64>, arg4: 0x1::option::Option<bool>) : QueryResult {
        let v0 = 0x1::option::destroy_with_default<bool>(arg4, true);
        let v1 = 0x1::option::destroy_with_default<u64>(arg3, 100);
        assert!(v1 <= 100, 0);
        let v2 = 0x16e51f1dd07710bdb9a99939464d733c137925eb92533f9703d9108abe6148ce::orderbook::get_user_open_orders(arg0, arg1);
        let v3 = QueryResult{
            orders : 0x1::vector::empty<0x16e51f1dd07710bdb9a99939464d733c137925eb92533f9703d9108abe6148ce::order::Order>(),
            cursor : 0x1::option::none<u64>(),
            total  : 0x2::linked_table::length<u64, bool>(v2),
        };
        if (v3.total > 0) {
            let (v4, v5) = if (0x1::option::is_some<u64>(&arg2)) {
                (0, 0x1::option::destroy_some<u64>(arg2))
            } else {
                let v6 = if (v0) {
                    *0x1::option::borrow<u64>(0x2::linked_table::back<u64, bool>(v2))
                } else {
                    *0x1::option::borrow<u64>(0x2::linked_table::front<u64, bool>(v2))
                };
                0x1::vector::push_back<0x16e51f1dd07710bdb9a99939464d733c137925eb92533f9703d9108abe6148ce::order::Order>(&mut v3.orders, 0x16e51f1dd07710bdb9a99939464d733c137925eb92533f9703d9108abe6148ce::order::clone(0x16e51f1dd07710bdb9a99939464d733c137925eb92533f9703d9108abe6148ce::orderbook::get_order(arg0, v6)));
                (1, v6)
            };
            let v7 = v5;
            let v8 = v4;
            while (v8 < v1) {
                let v9 = if (v0) {
                    0x2::linked_table::prev<u64, bool>(v2, v7)
                } else {
                    0x2::linked_table::next<u64, bool>(v2, v7)
                };
                if (0x1::option::is_some<u64>(v9)) {
                    let v10 = *0x1::option::borrow<u64>(v9);
                    v7 = v10;
                    0x1::vector::push_back<0x16e51f1dd07710bdb9a99939464d733c137925eb92533f9703d9108abe6148ce::order::Order>(&mut v3.orders, 0x16e51f1dd07710bdb9a99939464d733c137925eb92533f9703d9108abe6148ce::order::clone(0x16e51f1dd07710bdb9a99939464d733c137925eb92533f9703d9108abe6148ce::orderbook::get_order(arg0, v10)));
                };
                v8 = v8 + 1;
            };
            0x1::option::fill<u64>(&mut v3.cursor, v7);
        };
        v3
    }

    public fun total(arg0: &QueryResult) : u64 {
        arg0.total
    }

    // decompiled from Move bytecode v6
}

