module 0x3473a1ea34d5108bce48fa88011602745ca52d0f8e3b99ab42d789098a5a34::swapper {
    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public fun myswap<T0, T1>(arg0: u64, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::router::swap_exact_input_<T0, T1>(arg0, arg1, arg2, arg3, arg4)
    }

    public fun test_random() {
        0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::random::new(0);
        0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i128::zero();
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_sqrt_price();
    }

    // decompiled from Move bytecode v6
}

