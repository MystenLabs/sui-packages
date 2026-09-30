module 0xa28da7bcfd491f72f9e802909f6520899de246950fa2f637ee37f677cc9a68c9::swap {
    public fun flowx_amm_x_to_y<T0, T1>(arg0: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::router::swap_exact_x_to_y_direct<T0, T1>(0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::borrow_mut_pair<T0, T1>(arg0), arg1, arg2)
    }

    public fun flowx_amm_y_to_x<T0, T1>(arg0: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::router::swap_exact_y_to_x_direct<T0, T1>(0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::borrow_mut_pair<T0, T1>(arg0), arg1, arg2)
    }

    // decompiled from Move bytecode v7
}

