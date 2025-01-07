module 0x9a0189083ec664ad42847163f97c2fe340d4aff43086de006c000da3d8621b6::blue_move_protocol {
    public(friend) fun swap_exact_input<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::router::swap_exact_input_<T0, T1>(0x2::coin::value<T0>(&arg0), arg0, arg1, arg2, arg3)
    }

    // decompiled from Move bytecode v6
}

