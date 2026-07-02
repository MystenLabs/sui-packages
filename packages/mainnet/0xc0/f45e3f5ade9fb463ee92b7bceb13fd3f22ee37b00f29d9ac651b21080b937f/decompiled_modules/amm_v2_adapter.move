module 0xc0f45e3f5ade9fb463ee92b7bceb13fd3f22ee37b00f29d9ac651b21080b937f::amm_v2_adapter {
    public fun swap_exact_in_a_to_b<T0, T1>(arg0: &mut 0xc0f45e3f5ade9fb463ee92b7bceb13fd3f22ee37b00f29d9ac651b21080b937f::amm_v2::Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xc0f45e3f5ade9fb463ee92b7bceb13fd3f22ee37b00f29d9ac651b21080b937f::amm_v2::swap_a_to_b<T0, T1>(arg0, arg1, arg2, arg3)
    }

    public fun swap_exact_in_b_to_a<T0, T1>(arg0: &mut 0xc0f45e3f5ade9fb463ee92b7bceb13fd3f22ee37b00f29d9ac651b21080b937f::amm_v2::Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xc0f45e3f5ade9fb463ee92b7bceb13fd3f22ee37b00f29d9ac651b21080b937f::amm_v2::swap_b_to_a<T0, T1>(arg0, arg1, arg2, arg3)
    }

    // decompiled from Move bytecode v7
}

