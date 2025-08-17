module 0x552c8c137b067af043974220166670c3a26d4b6179e74d3016e433334bb0702f::work {
    public fun TT<T0, T1>(arg0: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::swap<T0, T1>(0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::borrow_mut_pair<T0, T1>(arg0), arg1, arg2, arg3, arg4, arg5)
    }

    // decompiled from Move bytecode v6
}

