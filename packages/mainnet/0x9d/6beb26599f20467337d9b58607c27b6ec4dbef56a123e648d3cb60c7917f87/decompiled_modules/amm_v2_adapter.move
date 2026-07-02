module 0x9d6beb26599f20467337d9b58607c27b6ec4dbef56a123e648d3cb60c7917f87::amm_v2_adapter {
    public fun swap_exact_in_a_to_b<T0, T1>(arg0: &mut 0x9d6beb26599f20467337d9b58607c27b6ec4dbef56a123e648d3cb60c7917f87::amm_v2::Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x9d6beb26599f20467337d9b58607c27b6ec4dbef56a123e648d3cb60c7917f87::amm_v2::swap_a_to_b<T0, T1>(arg0, arg1, arg2, arg3)
    }

    public fun swap_exact_in_b_to_a<T0, T1>(arg0: &mut 0x9d6beb26599f20467337d9b58607c27b6ec4dbef56a123e648d3cb60c7917f87::amm_v2::Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x9d6beb26599f20467337d9b58607c27b6ec4dbef56a123e648d3cb60c7917f87::amm_v2::swap_b_to_a<T0, T1>(arg0, arg1, arg2, arg3)
    }

    // decompiled from Move bytecode v7
}

