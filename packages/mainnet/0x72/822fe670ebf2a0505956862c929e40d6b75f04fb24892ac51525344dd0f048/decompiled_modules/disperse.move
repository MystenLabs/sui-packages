module 0x72822fe670ebf2a0505956862c929e40d6b75f04fb24892ac51525344dd0f048::disperse {
    public entry fun disperse<T0>(arg0: 0x2::coin::Coin<T0>, arg1: vector<u64>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u64>(&arg1) == 0x1::vector::length<address>(&arg2), 1);
        let v0 = 0;
        0x1::vector::reverse<u64>(&mut arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&arg1)) {
            v0 = v0 + 0x1::vector::pop_back<u64>(&mut arg1);
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<u64>(arg1);
        assert!(v0 == 0x2::coin::value<T0>(&arg0), 2);
        0x1::vector::reverse<address>(&mut arg2);
        assert!(0x1::vector::length<u64>(&arg1) == 0x1::vector::length<address>(&arg2), 9223372122754121727);
        0x1::vector::reverse<u64>(&mut arg1);
        let v2 = 0;
        while (v2 < 0x1::vector::length<u64>(&arg1)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0, 0x1::vector::pop_back<u64>(&mut arg1), arg3), 0x1::vector::pop_back<address>(&mut arg2));
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<u64>(arg1);
        0x1::vector::destroy_empty<address>(arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

