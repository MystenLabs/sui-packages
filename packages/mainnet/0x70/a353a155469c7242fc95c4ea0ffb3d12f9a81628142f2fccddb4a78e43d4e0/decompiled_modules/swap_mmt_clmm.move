module 0x70a353a155469c7242fc95c4ea0ffb3d12f9a81628142f2fccddb4a78e43d4e0::swap_mmt_clmm {
    public fun swap_a2b<T0, T1, T2, T3>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &0x2::clock::Clock, arg4: &0x1a830340e1caed73881c51f13fd3c1409153879493b56688118012c25b658512::swap_transaction::SwapTransaction<T2, T3>, arg5: &0x1a830340e1caed73881c51f13fd3c1409153879493b56688118012c25b658512::state::State, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        abort 0
    }

    // decompiled from Move bytecode v6
}

