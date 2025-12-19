module 0xd4be63c4ba47f8665bfab24131a7e13961a717e4331eea23229074dc5bbf9523::batch_transfer {
    public fun batch_transfer<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(arg0) >= arg1 * 0x1::vector::length<address>(&arg2), e_in_sufficient());
        while (!0x1::vector::is_empty<address>(&arg2)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(arg0, arg1, arg3), 0x1::vector::pop_back<address>(&mut arg2));
        };
    }

    public fun distribute_by_amounts<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: vector<u64>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<address>(&arg2);
        assert!(v0 == 0x1::vector::length<u64>(&arg1), e_length_mismatch());
        let v1 = 0;
        let v2 = 0;
        while (v1 < v0) {
            v2 = v2 + *0x1::vector::borrow<u64>(&arg1, v1);
            v1 = v1 + 1;
        };
        assert!(0x2::coin::value<T0>(arg0) >= v2, e_in_sufficient());
        while (!0x1::vector::is_empty<address>(&arg2)) {
            let v3 = 0x1::vector::pop_back<u64>(&mut arg1);
            if (v3 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(arg0, v3, arg3), 0x1::vector::pop_back<address>(&mut arg2));
            };
        };
    }

    fun e_in_sufficient() : u64 {
        abort 1
    }

    fun e_length_mismatch() : u64 {
        abort 2
    }

    // decompiled from Move bytecode v6
}

