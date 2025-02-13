module 0x9e7fdfa642bb62797512099626a03159fb4b349f07e7fab371312ad5d7320e14::send_tokens {
    public fun transfer_sui_batch<T0>(arg0: vector<address>, arg1: &mut 0x2::coin::Coin<T0>, arg2: vector<u64>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<address>(&arg0) == 0x1::vector::length<u64>(&arg2), 0);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg0)) {
            0x2::pay::split_and_transfer<T0>(arg1, *0x1::vector::borrow<u64>(&arg2, v0), *0x1::vector::borrow<address>(&arg0, v0), arg3);
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

