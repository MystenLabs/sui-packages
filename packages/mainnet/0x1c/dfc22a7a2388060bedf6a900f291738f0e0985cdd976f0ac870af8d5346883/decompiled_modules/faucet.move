module 0x1cdfc22a7a2388060bedf6a900f291738f0e0985cdd976f0ac870af8d5346883::faucet {
    public entry fun faucet(arg0: vector<address>, arg1: u64, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<address>(&arg0);
        assert!(v0 > 0, 1);
        assert!(0x2::coin::value<0x2::sui::SUI>(arg2) >= arg1 * v0, 2);
        let v1 = 0;
        while (v1 < v0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg2, arg1, arg3), *0x1::vector::borrow<address>(&arg0, v1));
            v1 = v1 + 1;
        };
    }

    public entry fun batch_faucet(arg0: vector<address>, arg1: vector<u64>, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<address>(&arg0);
        let v1 = 0x1::vector::length<u64>(&arg1);
        assert!(v0 > 0, 1);
        assert!(v0 == v1, 1);
        let v2 = 0;
        let v3 = 0;
        while (v3 < v1) {
            v2 = v2 + *0x1::vector::borrow<u64>(&arg1, v3);
            v3 = v3 + 1;
        };
        assert!(0x2::coin::value<0x2::sui::SUI>(arg2) >= v2, 2);
        v3 = 0;
        while (v3 < v0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg2, *0x1::vector::borrow<u64>(&arg1, v3), arg3), *0x1::vector::borrow<address>(&arg0, v3));
            v3 = v3 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

