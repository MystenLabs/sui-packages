module 0x910c77ad156bb14bae89a21b266b7a2bc2a6c872cdd489aeb52393d3f05d2427::turbos {
    public(friend) fun swap<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: bool, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = if (arg3) {
            4295048016
        } else {
            79226673515401279992447579055
        };
        if (arg3) {
            let v3 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
            0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v3, arg1);
            let (v4, v5) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_a_b_with_return_<T0, T1, T2>(arg0, v3, arg4, 0, v0, true, 0x2::tx_context::sender(arg7), 18446744073709551615, arg5, arg6, arg7);
            0x2::coin::destroy_zero<T1>(arg2);
            (v5, v4)
        } else {
            let v6 = 0x1::vector::empty<0x2::coin::Coin<T1>>();
            0x1::vector::push_back<0x2::coin::Coin<T1>>(&mut v6, arg2);
            let (v7, v8) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_b_a_with_return_<T0, T1, T2>(arg0, v6, arg4, 0, v0, true, 0x2::tx_context::sender(arg7), 18446744073709551615, arg5, arg6, arg7);
            0x2::coin::destroy_zero<T0>(arg1);
            (v7, v8)
        }
    }

    public(friend) fun add_prices<T0, T1, T2>(arg0: &mut vector<0x910c77ad156bb14bae89a21b266b7a2bc2a6c872cdd489aeb52393d3f05d2427::paths::PriceNode>, arg1: u64, arg2: u64, arg3: u16, arg4: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>) {
        let v0 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<T0, T1, T2>(arg4);
        let v1 = 18446744073709551616 - 0x910c77ad156bb14bae89a21b266b7a2bc2a6c872cdd489aeb52393d3f05d2427::arithmetic::to_128((0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_fee<T0, T1, T2>(arg4) as u64)) / 1000000;
        0x1::vector::push_back<0x910c77ad156bb14bae89a21b266b7a2bc2a6c872cdd489aeb52393d3f05d2427::paths::PriceNode>(arg0, 0x910c77ad156bb14bae89a21b266b7a2bc2a6c872cdd489aeb52393d3f05d2427::paths::new_price_node(arg1, arg2, arg3, 0x910c77ad156bb14bae89a21b266b7a2bc2a6c872cdd489aeb52393d3f05d2427::arithmetic::mul_128(v0, v1)));
        0x1::vector::push_back<0x910c77ad156bb14bae89a21b266b7a2bc2a6c872cdd489aeb52393d3f05d2427::paths::PriceNode>(arg0, 0x910c77ad156bb14bae89a21b266b7a2bc2a6c872cdd489aeb52393d3f05d2427::paths::new_price_node(arg2, arg1, arg3, 0x910c77ad156bb14bae89a21b266b7a2bc2a6c872cdd489aeb52393d3f05d2427::arithmetic::mul_128(0x910c77ad156bb14bae89a21b266b7a2bc2a6c872cdd489aeb52393d3f05d2427::arithmetic::inv_128(v0), v1)));
    }

    public(friend) fun swap_bag<T0, T1, T2>(arg0: &mut 0x2::bag::Bag, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T1, T2, T0>, arg2: u16, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        if (arg2 == 0) {
            0x2::bag::add<vector<u8>, 0x2::coin::Coin<T2>>(arg0, b"", swap_sell<T1, T2, T0>(arg1, 0x2::bag::remove<vector<u8>, 0x2::coin::Coin<T1>>(arg0, b""), arg4, arg3, arg5));
        } else {
            0x2::bag::add<vector<u8>, 0x2::coin::Coin<T1>>(arg0, b"", swap_buy<T2, T1, T0>(arg1, 0x2::bag::remove<vector<u8>, 0x2::coin::Coin<T2>>(arg0, b""), arg4, arg3, arg5));
        };
    }

    public(friend) fun swap_buy<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T1, T0, T2>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v0, arg1);
        let (v1, v2) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_b_a_with_return_<T1, T0, T2>(arg0, v0, 0x2::coin::value<T0>(&arg1), 0, 79226673515401279992447579055, true, 0x2::tx_context::sender(arg4), 18446744073709551615, arg2, arg3, arg4);
        0x2::coin::destroy_zero<T0>(v2);
        v1
    }

    public(friend) fun swap_sell<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v0, arg1);
        let (v1, v2) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_a_b_with_return_<T0, T1, T2>(arg0, v0, 0x2::coin::value<T0>(&arg1), 0, 4295048016, true, 0x2::tx_context::sender(arg4), 18446744073709551615, arg2, arg3, arg4);
        0x2::coin::destroy_zero<T0>(v2);
        v1
    }

    // decompiled from Move bytecode v6
}

