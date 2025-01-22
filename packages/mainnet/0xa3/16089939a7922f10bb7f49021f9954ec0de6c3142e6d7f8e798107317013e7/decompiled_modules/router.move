module 0xa316089939a7922f10bb7f49021f9954ec0de6c3142e6d7f8e798107317013e7::router {
    fun unwrap_and_return_coin<T0>(arg0: 0xa316089939a7922f10bb7f49021f9954ec0de6c3142e6d7f8e798107317013e7::utils::DAOCoin<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(0xa316089939a7922f10bb7f49021f9954ec0de6c3142e6d7f8e798107317013e7::utils::unwrap_coin<T0>(arg0), arg1)
    }

    fun wrap_and_return<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0xa316089939a7922f10bb7f49021f9954ec0de6c3142e6d7f8e798107317013e7::utils::DAOCoin<T0> {
        0xa316089939a7922f10bb7f49021f9954ec0de6c3142e6d7f8e798107317013e7::utils::wrap_coin<T0>(0x2::coin::into_balance<T0>(arg0), arg1)
    }

    // decompiled from Move bytecode v6
}

