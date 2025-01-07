module 0xa5ea5d7f88fc0a63a1c5872ad515ce1e2934bf6b31bdf656a5ad7f92678179f3::swap {
    public entry fun swap<T0, T1>(arg0: &mut 0x553fdd933bed47f1732d1b94068ac7db664e1f86c884560dfd162302563bca64::amh::MyBalance<T0>, arg1: u64, arg2: u64, arg3: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg4: &mut 0x2::tx_context::TxContext) {
        0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::router::swap_exact_input<T0, T1>(arg1, 0x553fdd933bed47f1732d1b94068ac7db664e1f86c884560dfd162302563bca64::amh::loan<T0>(arg0, arg1, arg4), arg2, arg3, arg4);
    }

    // decompiled from Move bytecode v6
}

