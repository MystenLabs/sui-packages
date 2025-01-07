module 0x44aedd934966024e2e57d1cd25a4a9912814d8b465f70d4fbf4bf47c1ccebeb5::helper {
    public fun a2b<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::value<T0>(&arg0);
        let v1 = 0xdee9::clob_v2::create_account(arg4);
        let (v2, v3, _) = 0xdee9::clob_v2::swap_exact_base_for_quote<T0, T1>(arg1, 0, &v1, v0 - v0 % arg2, arg0, 0x2::coin::zero<T1>(arg4), arg3, arg4);
        0xdee9::custodian_v2::delete_account_cap(v1);
        return_remaining_coin<T0>(v2, arg4);
        v3
    }

    public fun b2a<T0, T1>(arg0: 0x2::coin::Coin<T1>, arg1: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0xdee9::clob_v2::create_account(arg4);
        let (v1, v2, _) = 0xdee9::clob_v2::swap_exact_quote_for_base<T0, T1>(arg1, 0, &v0, 0x2::coin::value<T1>(&arg0), arg3, arg0, arg4);
        0xdee9::custodian_v2::delete_account_cap(v0);
        return_remaining_coin<T1>(v2, arg4);
        v1
    }

    public fun query_orders<T0, T1>(arg0: &0xdee9::clob_v2::Pool<T0, T1>, arg1: u64) : (0x1::option::Option<0xdee9::order_query::OrderPage>, 0x1::option::Option<0xdee9::order_query::OrderPage>) {
        let (v0, v1) = 0xdee9::clob_v2::get_market_price<T0, T1>(arg0);
        let v2 = v1;
        let v3 = v0;
        let v4 = if (!0x1::option::is_none<u64>(&v3)) {
            0x1::option::some<0xdee9::order_query::OrderPage>(0xdee9::order_query::iter_bids<T0, T1>(arg0, 0x1::option::none<u64>(), 0x1::option::none<u64>(), 0x1::option::some<u64>(arg1), 0x1::option::none<u64>(), false))
        } else {
            0x1::option::none<0xdee9::order_query::OrderPage>()
        };
        let v5 = if (!0x1::option::is_none<u64>(&v2)) {
            0x1::option::some<0xdee9::order_query::OrderPage>(0xdee9::order_query::iter_asks<T0, T1>(arg0, 0x1::option::none<u64>(), 0x1::option::none<u64>(), 0x1::option::some<u64>(arg1), 0x1::option::none<u64>(), true))
        } else {
            0x1::option::none<0xdee9::order_query::OrderPage>()
        };
        (v4, v5)
    }

    public fun query_orders_unlimited<T0, T1>(arg0: &0xdee9::clob_v2::Pool<T0, T1>, arg1: u64, arg2: u64) : (vector<0xdee9::order_query::OrderPage>, vector<0xdee9::order_query::OrderPage>) {
        let v0 = 0x1::vector::empty<0xdee9::order_query::OrderPage>();
        let v1 = 0x1::vector::empty<0xdee9::order_query::OrderPage>();
        let (v2, v3) = 0xdee9::clob_v2::get_market_price<T0, T1>(arg0);
        let v4 = v3;
        let v5 = v2;
        if (0x1::option::is_some<u64>(&v5)) {
            let v6 = true;
            let v7 = 0x1::option::none<u64>();
            let v8 = 0x1::option::none<u64>();
            while (v6) {
                let v9 = 0xdee9::order_query::iter_bids<T0, T1>(arg0, v7, v8, 0x1::option::some<u64>(arg1), 0x1::option::none<u64>(), true);
                v6 = 0xdee9::order_query::has_next_page(&v9);
                v7 = 0xdee9::order_query::next_tick_level(&v9);
                v8 = 0xdee9::order_query::next_order_id(&v9);
                0x1::vector::push_back<0xdee9::order_query::OrderPage>(&mut v0, v9);
                if (0x1::vector::length<0xdee9::order_query::OrderPage>(&v0) >= arg2) {
                    break
                };
            };
        };
        if (0x1::option::is_some<u64>(&v4)) {
            let v10 = true;
            let v11 = 0x1::option::none<u64>();
            let v12 = 0x1::option::none<u64>();
            while (v10) {
                let v13 = 0xdee9::order_query::iter_asks<T0, T1>(arg0, v11, v12, 0x1::option::some<u64>(arg1), 0x1::option::none<u64>(), true);
                v10 = 0xdee9::order_query::has_next_page(&v13);
                v11 = 0xdee9::order_query::next_tick_level(&v13);
                v12 = 0xdee9::order_query::next_order_id(&v13);
                0x1::vector::push_back<0xdee9::order_query::OrderPage>(&mut v1, v13);
                if (0x1::vector::length<0xdee9::order_query::OrderPage>(&v1) >= arg2) {
                    break
                };
            };
        };
        (v0, v1)
    }

    public fun return_remaining_coin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        if (0x2::coin::value<T0>(&arg0) == 0) {
            0x2::coin::destroy_zero<T0>(arg0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg1));
        };
    }

    // decompiled from Move bytecode v6
}

