module 0x10424a4a9acc07eed3060adfa19a573aff23a9e7a9064aed56d87cce666c9a60::victory {
    public fun swap_a2b<T0, T1>(arg0: &0xbfac5e1c6bf6ef29b12f7723857695fd2f4da9a11a7d88162c15e9124c243a4a::router::Router, arg1: &0xbfac5e1c6bf6ef29b12f7723857695fd2f4da9a11a7d88162c15e9124c243a4a::factory::Factory, arg2: &mut 0xbfac5e1c6bf6ef29b12f7723857695fd2f4da9a11a7d88162c15e9124c243a4a::pair::Pair<T0, T1>, arg3: &0x2::clock::Clock, arg4: 0x2::balance::Balance<T0>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        0x2::coin::into_balance<T1>(0xbfac5e1c6bf6ef29b12f7723857695fd2f4da9a11a7d88162c15e9124c243a4a::router::swap_exact_tokens0_for_tokens1_composable<T0, T1>(arg0, arg1, arg2, 0x2::coin::from_balance<T0>(arg4, arg5), 1, arg3, arg5))
    }

    public fun swap_b2a<T0, T1>(arg0: &0xbfac5e1c6bf6ef29b12f7723857695fd2f4da9a11a7d88162c15e9124c243a4a::router::Router, arg1: &0xbfac5e1c6bf6ef29b12f7723857695fd2f4da9a11a7d88162c15e9124c243a4a::factory::Factory, arg2: &mut 0xbfac5e1c6bf6ef29b12f7723857695fd2f4da9a11a7d88162c15e9124c243a4a::pair::Pair<T0, T1>, arg3: &0x2::clock::Clock, arg4: 0x2::balance::Balance<T1>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0x2::coin::into_balance<T0>(0xbfac5e1c6bf6ef29b12f7723857695fd2f4da9a11a7d88162c15e9124c243a4a::router::swap_exact_tokens1_for_tokens0_composable<T0, T1>(arg0, arg1, arg2, 0x2::coin::from_balance<T1>(arg4, arg5), 1, arg3, arg5))
    }

    // decompiled from Move bytecode v7
}

