module 0x26b2b422e630c79c961fdb5d63821547ec8fb2ad5b7095189c440e1bdbba9f1::bulksender {
    public fun send<T0>(arg0: 0x2::coin::Coin<T0>, arg1: vector<u64>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u64>(&arg1) == 0x1::vector::length<address>(&arg2), 1000);
        while (0x1::vector::length<u64>(&arg1) > 0) {
            0x2::pay::split_and_transfer<T0>(&mut arg0, 0x1::vector::pop_back<u64>(&mut arg1), 0x1::vector::pop_back<address>(&mut arg2), arg3);
        };
        0x2::coin::destroy_zero<T0>(arg0);
    }

    // decompiled from Move bytecode v6
}

