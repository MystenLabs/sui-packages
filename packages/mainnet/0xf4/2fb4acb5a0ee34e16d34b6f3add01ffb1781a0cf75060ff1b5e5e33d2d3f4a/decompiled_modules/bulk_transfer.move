module 0xf42fb4acb5a0ee34e16d34b6f3add01ffb1781a0cf75060ff1b5e5e33d2d3f4a::bulk_transfer {
    public entry fun bulk_transfer(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: vector<address>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!0x1::vector::is_empty<address>(&arg1), 1);
        let v0 = 0x1::vector::length<address>(&arg1);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) >= 80000000 * v0, 0);
        let v1 = 0;
        while (v1 < v0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg0, 80000000, arg2), *0x1::vector::borrow<address>(&arg1, v1));
            v1 = v1 + 1;
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, 0x2::tx_context::sender(arg2));
    }

    public entry fun bulk_transfer_multi(arg0: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg1: vector<address>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!0x1::vector::is_empty<address>(&arg1), 1);
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x2::coin::Coin<0x2::sui::SUI>>(&arg0)) {
            0x2::coin::join<0x2::sui::SUI>(&mut v0, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0));
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<0x2::sui::SUI>>(arg0);
        bulk_transfer(v0, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

