module 0xac1086682b1957876b1db62c95902a726902aa03cb277ae76b1320ece94e77ed::airdrop {
    entry fun batchDifferent<T0>(arg0: 0x2::coin::Coin<T0>, arg1: vector<address>, arg2: vector<u64>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<address>(&arg1);
        let v1 = 0x1::vector::length<u64>(&arg2);
        assert!(v0 > 0 && v1 > 0 && v0 == v1, 1);
        let v2 = 0x2::coin::value<T0>(&arg0);
        assert!(v2 > 0, 2);
        let v3 = 0;
        let v4 = 0;
        while (v3 < v0) {
            let v5 = 0x1::vector::borrow<u64>(&mut arg2, v3);
            assert!(*v5 > 0, 3);
            v4 = v4 + *v5;
            v3 = v3 + 1;
        };
        assert!(v4 == v2, 4);
        let v6 = 0;
        while (v6 < v0) {
            0x2::pay::split_and_transfer<T0>(&mut arg0, *0x1::vector::borrow<u64>(&mut arg2, v6), *0x1::vector::borrow<address>(&mut arg1, v6), arg3);
            v6 = v6 + 1;
        };
        if (0x2::coin::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<T0>(arg0);
        };
    }

    entry fun batchSame<T0>(arg0: 0x2::coin::Coin<T0>, arg1: vector<address>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 1);
        let v0 = 0x1::vector::length<address>(&arg1);
        assert!(v0 > 0, 2);
        let v1 = 0x2::coin::value<T0>(&arg0);
        assert!(v1 > 0 && v1 == v0 * arg2, 3);
        let v2 = 0;
        while (v2 < v0) {
            0x2::pay::split_and_transfer<T0>(&mut arg0, arg2, *0x1::vector::borrow<address>(&mut arg1, v2), arg3);
            v2 = v2 + 1;
        };
        if (0x2::coin::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<T0>(arg0);
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    // decompiled from Move bytecode v6
}

