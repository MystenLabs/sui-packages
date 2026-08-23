module 0x3ebd191fd348670823f707ed54086e67fabca318a9198a6b6087d046d08b740b::batch_airdrop {
    fun disperse_impl<T0>(arg0: 0x2::coin::Coin<T0>, arg1: vector<address>, arg2: vector<u64>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<address>(&arg1);
        assert!(v0 == 0x1::vector::length<u64>(&arg2), 0);
        assert!(v0 > 0, 1);
        let v1 = 0x2::coin::value<T0>(&arg0);
        let v2 = 0;
        while (v2 < v0) {
            let v3 = *0x1::vector::borrow<u64>(&arg2, v2);
            assert!(v3 > 0, 2);
            assert!(v3 <= v1, 3);
            v1 = v1 - v3;
            v2 = v2 + 1;
        };
        v2 = 0;
        while (v2 < v0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0, *0x1::vector::borrow<u64>(&arg2, v2), arg3), *0x1::vector::borrow<address>(&arg1, v2));
            v2 = v2 + 1;
        };
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<T0>(arg0);
        };
    }

    public entry fun disperse_sui(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: vector<address>, arg2: vector<u64>, arg3: &mut 0x2::tx_context::TxContext) {
        disperse_impl<0x2::sui::SUI>(arg0, arg1, arg2, arg3);
    }

    public entry fun disperse_token<T0>(arg0: 0x2::coin::Coin<T0>, arg1: vector<address>, arg2: vector<u64>, arg3: &mut 0x2::tx_context::TxContext) {
        disperse_impl<T0>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v7
}

