module 0xbb94b3ad2fca50c5d21345d7d99118875521a39551483e7f02370227e462c59f::airdrop {
    public fun send<T0>(arg0: 0x2::coin::Coin<T0>, arg1: vector<address>, arg2: vector<u64>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (0x1::vector::length<address>(&arg1) > v0) {
            0x2::pay::split_and_transfer<T0>(&mut arg0, *0x1::vector::borrow<u64>(&arg2, v0), *0x1::vector::borrow<address>(&arg1, v0), arg3);
            v0 = v0 + 1;
        };
        0x2::coin::destroy_zero<T0>(arg0);
    }

    // decompiled from Move bytecode v6
}

