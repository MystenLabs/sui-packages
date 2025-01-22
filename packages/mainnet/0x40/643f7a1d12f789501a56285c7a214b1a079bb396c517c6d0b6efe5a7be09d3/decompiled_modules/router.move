module 0x40643f7a1d12f789501a56285c7a214b1a079bb396c517c6d0b6efe5a7be09d3::router {
    fun unwrap_and_return_coin<T0>(arg0: 0x40643f7a1d12f789501a56285c7a214b1a079bb396c517c6d0b6efe5a7be09d3::utils::DAOCoin<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(0x40643f7a1d12f789501a56285c7a214b1a079bb396c517c6d0b6efe5a7be09d3::utils::unwrap_coin<T0>(arg0), arg1)
    }

    fun wrap_and_return<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x40643f7a1d12f789501a56285c7a214b1a079bb396c517c6d0b6efe5a7be09d3::utils::DAOCoin<T0> {
        0x40643f7a1d12f789501a56285c7a214b1a079bb396c517c6d0b6efe5a7be09d3::utils::wrap_coin<T0>(0x2::coin::into_balance<T0>(arg0), arg1)
    }

    // decompiled from Move bytecode v6
}

