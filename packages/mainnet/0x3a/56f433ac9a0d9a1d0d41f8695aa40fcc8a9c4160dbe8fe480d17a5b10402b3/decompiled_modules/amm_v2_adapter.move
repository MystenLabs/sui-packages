module 0x3a56f433ac9a0d9a1d0d41f8695aa40fcc8a9c4160dbe8fe480d17a5b10402b3::amm_v2_adapter {
    public fun swap_exact_in_a_to_b<T0, T1>(arg0: &mut 0x3a56f433ac9a0d9a1d0d41f8695aa40fcc8a9c4160dbe8fe480d17a5b10402b3::amm_v2::Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x3a56f433ac9a0d9a1d0d41f8695aa40fcc8a9c4160dbe8fe480d17a5b10402b3::amm_v2::swap_a_to_b<T0, T1>(arg0, arg1, arg2, arg3)
    }

    public fun swap_exact_in_b_to_a<T0, T1>(arg0: &mut 0x3a56f433ac9a0d9a1d0d41f8695aa40fcc8a9c4160dbe8fe480d17a5b10402b3::amm_v2::Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x3a56f433ac9a0d9a1d0d41f8695aa40fcc8a9c4160dbe8fe480d17a5b10402b3::amm_v2::swap_b_to_a<T0, T1>(arg0, arg1, arg2, arg3)
    }

    // decompiled from Move bytecode v7
}

