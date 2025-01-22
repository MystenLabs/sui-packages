module 0x576c448d95dec548c759171fbbed93881ad04b08fbb67777ea901b10e4aab17d::router {
    public fun flowx_amm_swap_a2b<T0, T1>(arg0: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg1: 0x576c448d95dec548c759171fbbed93881ad04b08fbb67777ea901b10e4aab17d::utils::DAOCoin<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x576c448d95dec548c759171fbbed93881ad04b08fbb67777ea901b10e4aab17d::utils::DAOCoin<T1> {
        abort 0
    }

    public fun flowx_amm_swap_b2a<T0, T1>(arg0: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg1: 0x576c448d95dec548c759171fbbed93881ad04b08fbb67777ea901b10e4aab17d::utils::DAOCoin<T1>, arg2: &mut 0x2::tx_context::TxContext) : 0x576c448d95dec548c759171fbbed93881ad04b08fbb67777ea901b10e4aab17d::utils::DAOCoin<T0> {
        abort 0
    }

    fun unwrap_and_return_coin<T0>(arg0: 0x576c448d95dec548c759171fbbed93881ad04b08fbb67777ea901b10e4aab17d::utils::DAOCoin<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(0x576c448d95dec548c759171fbbed93881ad04b08fbb67777ea901b10e4aab17d::utils::unwrap_coin<T0>(arg0), arg1)
    }

    fun wrap_and_return<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x576c448d95dec548c759171fbbed93881ad04b08fbb67777ea901b10e4aab17d::utils::DAOCoin<T0> {
        0x576c448d95dec548c759171fbbed93881ad04b08fbb67777ea901b10e4aab17d::utils::wrap_coin<T0>(0x2::coin::into_balance<T0>(arg0), arg1)
    }

    // decompiled from Move bytecode v6
}

