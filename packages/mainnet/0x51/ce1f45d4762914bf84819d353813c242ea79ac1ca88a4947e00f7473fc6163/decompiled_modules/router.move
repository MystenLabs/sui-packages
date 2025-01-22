module 0x51ce1f45d4762914bf84819d353813c242ea79ac1ca88a4947e00f7473fc6163::router {
    public fun flowx_amm_swap_a2b<T0, T1>(arg0: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg1: 0x51ce1f45d4762914bf84819d353813c242ea79ac1ca88a4947e00f7473fc6163::utils::DAOCoin<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x51ce1f45d4762914bf84819d353813c242ea79ac1ca88a4947e00f7473fc6163::utils::DAOCoin<T1> {
        abort 0
    }

    fun unwrap_and_return_coin<T0>(arg0: 0x51ce1f45d4762914bf84819d353813c242ea79ac1ca88a4947e00f7473fc6163::utils::DAOCoin<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(0x51ce1f45d4762914bf84819d353813c242ea79ac1ca88a4947e00f7473fc6163::utils::unwrap_coin<T0>(arg0), arg1)
    }

    fun wrap_and_return<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x51ce1f45d4762914bf84819d353813c242ea79ac1ca88a4947e00f7473fc6163::utils::DAOCoin<T0> {
        0x51ce1f45d4762914bf84819d353813c242ea79ac1ca88a4947e00f7473fc6163::utils::wrap_coin<T0>(0x2::coin::into_balance<T0>(arg0), arg1)
    }

    // decompiled from Move bytecode v6
}

