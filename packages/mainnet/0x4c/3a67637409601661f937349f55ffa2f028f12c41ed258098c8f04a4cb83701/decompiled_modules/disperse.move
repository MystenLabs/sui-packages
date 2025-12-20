module 0x4c3a67637409601661f937349f55ffa2f028f12c41ed258098c8f04a4cb83701::disperse {
    public entry fun disperse_coin<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: vector<address>, arg2: vector<u64>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<address>(&arg1);
        assert!(v0 == 0x1::vector::length<u64>(&arg2), 1);
        let v1 = 0;
        while (v1 < v0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(arg0, *0x1::vector::borrow<u64>(&arg2, v1), arg3), *0x1::vector::borrow<address>(&arg1, v1));
            v1 = v1 + 1;
        };
    }

    public entry fun disperse_sui(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: vector<address>, arg2: vector<u64>, arg3: &mut 0x2::tx_context::TxContext) {
        disperse_coin<0x2::sui::SUI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

