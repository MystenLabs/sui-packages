module 0x443bc2aaa0147c8a8967eeaf6cb90b3a4b6c2e09a21623e10f3f9d514d4543a4::amm_v2_adapter {
    public fun swap_exact_in_a_to_b<T0, T1>(arg0: &mut 0x443bc2aaa0147c8a8967eeaf6cb90b3a4b6c2e09a21623e10f3f9d514d4543a4::amm_v2::Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x443bc2aaa0147c8a8967eeaf6cb90b3a4b6c2e09a21623e10f3f9d514d4543a4::amm_v2::swap_a_to_b<T0, T1>(arg0, arg1, arg2, arg3)
    }

    public fun swap_exact_in_b_to_a<T0, T1>(arg0: &mut 0x443bc2aaa0147c8a8967eeaf6cb90b3a4b6c2e09a21623e10f3f9d514d4543a4::amm_v2::Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x443bc2aaa0147c8a8967eeaf6cb90b3a4b6c2e09a21623e10f3f9d514d4543a4::amm_v2::swap_b_to_a<T0, T1>(arg0, arg1, arg2, arg3)
    }

    // decompiled from Move bytecode v7
}

