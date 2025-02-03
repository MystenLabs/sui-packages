module 0x408764241a79a97ce35f8253c23f48eff0e4b68da0b47352424b4e1f3e6640e4::turbos_clmm_protocol {
    public(friend) fun swap_a_to_b<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T0>) {
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_a_b_with_return_<T0, T1, T2>(arg0, 0x1::vector::singleton<0x2::coin::Coin<T0>>(arg1), 0x2::coin::value<T0>(&arg1), 1000, 4295048016, true, 0x2::tx_context::sender(arg4), 9999999999999, arg2, arg3, arg4)
    }

    public(friend) fun swap_b_to_a<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: 0x2::coin::Coin<T1>, arg2: &0x2::clock::Clock, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_b_a_with_return_<T0, T1, T2>(arg0, 0x1::vector::singleton<0x2::coin::Coin<T1>>(arg1), 0x2::coin::value<T1>(&arg1), 1000, 79226673515401279992447579055, true, 0x2::tx_context::sender(arg4), 9999999999999, arg2, arg3, arg4)
    }

    // decompiled from Move bytecode v6
}

