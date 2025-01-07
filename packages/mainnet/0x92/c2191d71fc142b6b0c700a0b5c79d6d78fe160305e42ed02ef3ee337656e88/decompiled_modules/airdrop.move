module 0x92c2191d71fc142b6b0c700a0b5c79d6d78fe160305e42ed02ef3ee337656e88::airdrop {
    public fun send<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: vector<address>, arg2: vector<u64>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (0x1::vector::length<address>(&arg1) > v0) {
            0x2::pay::split_and_transfer<T0>(arg0, *0x1::vector::borrow<u64>(&arg2, v0), *0x1::vector::borrow<address>(&arg1, v0), arg3);
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

