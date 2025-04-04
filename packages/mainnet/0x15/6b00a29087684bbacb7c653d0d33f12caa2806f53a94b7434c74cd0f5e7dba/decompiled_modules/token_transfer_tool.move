module 0x156b00a29087684bbacb7c653d0d33f12caa2806f53a94b7434c74cd0f5e7dba::token_transfer_tool {
    public entry fun transfer<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(arg0, arg2, arg3), arg1);
    }

    public entry fun batch_transfer<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: vector<address>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<address>(&arg1);
        assert!(0x2::coin::value<T0>(arg0) >= v0 * arg2, 0);
        let v1 = 0;
        while (v1 < v0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(arg0, arg2, arg3), 0x1::vector::pop_back<address>(&mut arg1));
            v1 = v1 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

