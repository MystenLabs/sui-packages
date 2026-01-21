module 0x558a6be255b3fdc7d453f44cae6fbbba054771dc7ba4e3af63da8023273fe2e8::clmm {
    public fun swap<T0, T1, T2>(arg0: &mut 0x6fc096341925feff031b3b54c2629f251758c171bea294866473d8253db6dfcd::router::SwapContext, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg3: bool, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        if (arg3) {
            swap_a2b<T0, T1, T2>(arg0, arg1, arg2, arg4, arg5, arg6);
        } else {
            swap_b2a<T0, T1, T2>(arg0, arg1, arg2, arg4, arg5, arg6);
        };
    }

    fun swap_a2b<T0, T1, T2>(arg0: &mut 0x6fc096341925feff031b3b54c2629f251758c171bea294866473d8253db6dfcd::router::SwapContext, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x6fc096341925feff031b3b54c2629f251758c171bea294866473d8253db6dfcd::router::take_balance<T0>(arg0, arg3);
        let v1 = 0x2::balance::value<T0>(&v0);
        if (v1 == 0) {
            0x2::balance::destroy_zero<T0>(v0);
            return
        };
        let v2 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v2, 0x2::coin::from_balance<T0>(v0, arg5));
        let (v3, v4) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_a_b_with_return_<T0, T1, T2>(arg1, v2, v1, 0, 4295048017, true, 0x2::tx_context::sender(arg5), 0x2::clock::timestamp_ms(arg4) + 18000, arg4, arg2, arg5);
        if (arg3 == 0x6fc096341925feff031b3b54c2629f251758c171bea294866473d8253db6dfcd::router::max_amount_in()) {
            0x6fc096341925feff031b3b54c2629f251758c171bea294866473d8253db6dfcd::router::transfer_balance<T0>(0x2::coin::into_balance<T0>(v4), 0x2::tx_context::sender(arg5), arg5);
        } else {
            0x6fc096341925feff031b3b54c2629f251758c171bea294866473d8253db6dfcd::router::merge_balance<T0>(arg0, 0x2::coin::into_balance<T0>(v4));
        };
        0x6fc096341925feff031b3b54c2629f251758c171bea294866473d8253db6dfcd::router::merge_balance<T1>(arg0, 0x2::coin::into_balance<T1>(v3));
    }

    fun swap_b2a<T0, T1, T2>(arg0: &mut 0x6fc096341925feff031b3b54c2629f251758c171bea294866473d8253db6dfcd::router::SwapContext, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x6fc096341925feff031b3b54c2629f251758c171bea294866473d8253db6dfcd::router::take_balance<T1>(arg0, arg3);
        let v1 = 0x2::balance::value<T1>(&v0);
        if (v1 == 0) {
            0x2::balance::destroy_zero<T1>(v0);
            return
        };
        let v2 = 0x1::vector::empty<0x2::coin::Coin<T1>>();
        0x1::vector::push_back<0x2::coin::Coin<T1>>(&mut v2, 0x2::coin::from_balance<T1>(v0, arg5));
        let (v3, v4) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_b_a_with_return_<T0, T1, T2>(arg1, v2, v1, 0, 79226673515401279992447579054, true, 0x2::tx_context::sender(arg5), 0x2::clock::timestamp_ms(arg4) + 18000, arg4, arg2, arg5);
        if (arg3 == 0x6fc096341925feff031b3b54c2629f251758c171bea294866473d8253db6dfcd::router::max_amount_in()) {
            0x6fc096341925feff031b3b54c2629f251758c171bea294866473d8253db6dfcd::router::transfer_balance<T1>(0x2::coin::into_balance<T1>(v4), 0x2::tx_context::sender(arg5), arg5);
        } else {
            0x6fc096341925feff031b3b54c2629f251758c171bea294866473d8253db6dfcd::router::merge_balance<T1>(arg0, 0x2::coin::into_balance<T1>(v4));
        };
        0x6fc096341925feff031b3b54c2629f251758c171bea294866473d8253db6dfcd::router::merge_balance<T0>(arg0, 0x2::coin::into_balance<T0>(v3));
    }

    // decompiled from Move bytecode v6
}

