module 0x858e46c918d6478749752fd4df052843689176a506ee06e4c2f1f0eeac6a85e3::swapper {
    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public fun myswap<T0, T1>(arg0: u64, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::router::swap_exact_input_<T0, T1>(arg0, arg1, arg2, arg3, arg4)
    }

    public fun test_random() {
        0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::random::new(0);
    }

    // decompiled from Move bytecode v6
}

