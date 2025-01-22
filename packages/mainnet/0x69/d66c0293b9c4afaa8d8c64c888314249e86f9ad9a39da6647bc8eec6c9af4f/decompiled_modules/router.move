module 0x69d66c0293b9c4afaa8d8c64c888314249e86f9ad9a39da6647bc8eec6c9af4f::router {
    public fun flowx_amm_swap_a2b<T0, T1>(arg0: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg1: 0x69d66c0293b9c4afaa8d8c64c888314249e86f9ad9a39da6647bc8eec6c9af4f::utils::DAOCoin<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x69d66c0293b9c4afaa8d8c64c888314249e86f9ad9a39da6647bc8eec6c9af4f::utils::DAOCoin<T1> {
        abort 0
    }

    fun unwrap_and_return_coin<T0>(arg0: 0x69d66c0293b9c4afaa8d8c64c888314249e86f9ad9a39da6647bc8eec6c9af4f::utils::DAOCoin<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(0x69d66c0293b9c4afaa8d8c64c888314249e86f9ad9a39da6647bc8eec6c9af4f::utils::unwrap_coin<T0>(arg0), arg1)
    }

    fun wrap_and_return<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x69d66c0293b9c4afaa8d8c64c888314249e86f9ad9a39da6647bc8eec6c9af4f::utils::DAOCoin<T0> {
        0x69d66c0293b9c4afaa8d8c64c888314249e86f9ad9a39da6647bc8eec6c9af4f::utils::wrap_coin<T0>(0x2::coin::into_balance<T0>(arg0), arg1)
    }

    // decompiled from Move bytecode v6
}

