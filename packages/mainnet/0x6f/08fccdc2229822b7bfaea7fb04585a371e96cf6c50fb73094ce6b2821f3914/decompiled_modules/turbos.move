module 0x6f08fccdc2229822b7bfaea7fb04585a371e96cf6c50fb73094ce6b2821f3914::turbos {
    public fun turbos_swap_a_b_buy<T0, T1, T2>(arg0: &mut 0x6f08fccdc2229822b7bfaea7fb04585a371e96cf6c50fb73094ce6b2821f3914::bot::KongBot<T0>, arg1: &mut 0x6f08fccdc2229822b7bfaea7fb04585a371e96cf6c50fb73094ce6b2821f3914::bot::Banana<T0>, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg3: vector<0x2::coin::Coin<T0>>, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x6f08fccdc2229822b7bfaea7fb04585a371e96cf6c50fb73094ce6b2821f3914::bot::transfer_bananas<T0>(arg0, arg1, 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg3), arg8);
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut arg3, v1);
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_a_b<T0, T1, T2>(arg2, arg3, v0, arg5, 4295048016, true, 0x2::tx_context::sender(arg8), 0x2::clock::timestamp_ms(arg6), arg6, arg7, arg8);
    }

    public fun turbos_swap_a_b_buy_sell<T0, T1, T2>(arg0: &mut 0x6f08fccdc2229822b7bfaea7fb04585a371e96cf6c50fb73094ce6b2821f3914::bot::KongBot<T1>, arg1: &mut 0x6f08fccdc2229822b7bfaea7fb04585a371e96cf6c50fb73094ce6b2821f3914::bot::Banana<T1>, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg3: vector<0x2::coin::Coin<T0>>, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_a_b_with_return_<T0, T1, T2>(arg2, arg3, arg4, arg5, 4295048016, true, 0x2::tx_context::sender(arg8), 0x2::clock::timestamp_ms(arg6), arg6, arg7, arg8);
        let (_, v3) = 0x6f08fccdc2229822b7bfaea7fb04585a371e96cf6c50fb73094ce6b2821f3914::bot::transfer_bananas<T1>(arg0, arg1, v0, arg8);
        0x6f08fccdc2229822b7bfaea7fb04585a371e96cf6c50fb73094ce6b2821f3914::bot::transfer_or_destroy_coin<T1>(v3, arg8);
        0x6f08fccdc2229822b7bfaea7fb04585a371e96cf6c50fb73094ce6b2821f3914::bot::transfer_or_destroy_coin<T0>(v1, arg8);
    }

    public fun turbos_swap_b_a_buy<T0, T1, T2>(arg0: &mut 0x6f08fccdc2229822b7bfaea7fb04585a371e96cf6c50fb73094ce6b2821f3914::bot::KongBot<T1>, arg1: &mut 0x6f08fccdc2229822b7bfaea7fb04585a371e96cf6c50fb73094ce6b2821f3914::bot::Banana<T1>, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg3: vector<0x2::coin::Coin<T1>>, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x6f08fccdc2229822b7bfaea7fb04585a371e96cf6c50fb73094ce6b2821f3914::bot::transfer_bananas<T1>(arg0, arg1, 0x1::vector::pop_back<0x2::coin::Coin<T1>>(&mut arg3), arg8);
        0x1::vector::push_back<0x2::coin::Coin<T1>>(&mut arg3, v1);
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_b_a<T0, T1, T2>(arg2, arg3, v0, arg5, 79226673515401279992447579055, true, 0x2::tx_context::sender(arg8), 0x2::clock::timestamp_ms(arg6), arg6, arg7, arg8);
    }

    public fun turbos_swap_b_a_sell<T0, T1, T2>(arg0: &mut 0x6f08fccdc2229822b7bfaea7fb04585a371e96cf6c50fb73094ce6b2821f3914::bot::KongBot<T0>, arg1: &mut 0x6f08fccdc2229822b7bfaea7fb04585a371e96cf6c50fb73094ce6b2821f3914::bot::Banana<T0>, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg3: vector<0x2::coin::Coin<T1>>, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_b_a_with_return_<T0, T1, T2>(arg2, arg3, arg4, arg5, 79226673515401279992447579055, true, 0x2::tx_context::sender(arg8), 0x2::clock::timestamp_ms(arg6), arg6, arg7, arg8);
        let (_, v3) = 0x6f08fccdc2229822b7bfaea7fb04585a371e96cf6c50fb73094ce6b2821f3914::bot::transfer_bananas<T0>(arg0, arg1, v0, arg8);
        0x6f08fccdc2229822b7bfaea7fb04585a371e96cf6c50fb73094ce6b2821f3914::bot::transfer_or_destroy_coin<T0>(v3, arg8);
        0x6f08fccdc2229822b7bfaea7fb04585a371e96cf6c50fb73094ce6b2821f3914::bot::transfer_or_destroy_coin<T1>(v1, arg8);
    }

    // decompiled from Move bytecode v6
}

