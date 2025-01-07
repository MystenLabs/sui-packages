module 0x8bd272a53ed81d42c0e325546ecaac3a90dbb0c048a0da1ccd99ef2d607a0898::airdrop {
    public fun send<T0>(arg0: 0x2::coin::Coin<T0>, arg1: vector<address>, arg2: vector<u64>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (0x1::vector::length<address>(&arg1) > v0) {
            0x2::pay::split_and_transfer<T0>(&mut arg0, *0x1::vector::borrow<u64>(&arg2, v0), *0x1::vector::borrow<address>(&arg1, v0), arg3);
            v0 = v0 + 1;
        };
        if (0x2::coin::value<T0>(&arg0) == 0) {
            0x2::coin::destroy_zero<T0>(arg0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg3));
        };
    }

    // decompiled from Move bytecode v6
}

