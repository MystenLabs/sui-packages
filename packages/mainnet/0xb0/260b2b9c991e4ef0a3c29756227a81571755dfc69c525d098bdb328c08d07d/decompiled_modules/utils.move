module 0xb84e63d22ea4822a0a333c250e790f69bf5c2ef0c63f4e120e05a6415991368f::utils {
    entry fun min_pass<T0>(arg0: u64, arg1: &0x2::coin::Coin<T0>, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(arg1);
        if (v0 < arg0) {
            abort v0
        };
    }

    // decompiled from Move bytecode v6
}

