module 0xf261ea0440bf70d2acb6badeb21b76133c7543fa555e3783a6fe646cde2251b8::batch_distribute {
    public entry fun distribute(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: vector<address>, arg2: vector<u64>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<address>(&arg1);
        assert!(v0 == 0x1::vector::length<u64>(&arg2), 0);
        let v1 = 0;
        while (v1 < v0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg0, *0x1::vector::borrow<u64>(&arg2, v1), arg3), *0x1::vector::borrow<address>(&arg1, v1));
            v1 = v1 + 1;
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

