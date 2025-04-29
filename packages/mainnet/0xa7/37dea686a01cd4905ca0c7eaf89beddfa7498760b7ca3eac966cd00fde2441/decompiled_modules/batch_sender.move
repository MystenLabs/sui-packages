module 0xa737dea686a01cd4905ca0c7eaf89beddfa7498760b7ca3eac966cd00fde2441::batch_sender {
    public entry fun batch_send_coin<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: vector<address>, arg2: vector<u64>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<address>(&arg1) == 0x1::vector::length<u64>(&arg2), 0);
        assert!(0x1::vector::length<address>(&arg1) > 0, 0);
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&arg2)) {
            let v2 = *0x1::vector::borrow<u64>(&arg2, v1);
            assert!(v2 > 0, 2);
            v0 = v0 + v2;
            v1 = v1 + 1;
        };
        assert!(0x2::coin::value<T0>(arg0) >= v0, 1);
        v1 = 0;
        while (v1 < 0x1::vector::length<address>(&arg1)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(arg0, *0x1::vector::borrow<u64>(&arg2, v1), arg3), *0x1::vector::borrow<address>(&arg1, v1));
            v1 = v1 + 1;
        };
    }

    public entry fun batch_send_sui(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: vector<address>, arg2: vector<u64>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<address>(&arg1) == 0x1::vector::length<u64>(&arg2), 0);
        assert!(0x1::vector::length<address>(&arg1) > 0, 0);
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&arg2)) {
            let v2 = *0x1::vector::borrow<u64>(&arg2, v1);
            assert!(v2 > 0, 2);
            v0 = v0 + v2;
            v1 = v1 + 1;
        };
        assert!(0x2::coin::value<0x2::sui::SUI>(arg0) >= v0, 1);
        v1 = 0;
        while (v1 < 0x1::vector::length<address>(&arg1)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg0, *0x1::vector::borrow<u64>(&arg2, v1), arg3), *0x1::vector::borrow<address>(&arg1, v1));
            v1 = v1 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

