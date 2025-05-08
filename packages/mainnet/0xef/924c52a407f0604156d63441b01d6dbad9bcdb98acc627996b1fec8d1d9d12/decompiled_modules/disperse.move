module 0xef924c52a407f0604156d63441b01d6dbad9bcdb98acc627996b1fec8d1d9d12::disperse {
    public entry fun disperse_from_vec<T0>(arg0: vector<0x2::coin::Coin<T0>>, arg1: vector<address>, arg2: vector<u64>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<address>(&arg1);
        assert!(v0 > 0, 2);
        assert!(v0 == 0x1::vector::length<u64>(&arg2), 0);
        let v1 = 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg0);
        0x2::pay::join_vec<T0>(&mut v1, arg0);
        let v2 = 0;
        let v3 = 0;
        while (v3 < v0) {
            v2 = v2 + *0x1::vector::borrow<u64>(&arg2, v3);
            v3 = v3 + 1;
        };
        assert!(0x2::coin::value<T0>(&v1) >= v2, 1);
        v3 = 0;
        while (v3 < v0) {
            let v4 = *0x1::vector::borrow<u64>(&arg2, v3);
            if (v4 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v1, v4, arg3), *0x1::vector::borrow<address>(&arg1, v3));
            };
            v3 = v3 + 1;
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg3));
    }

    public entry fun disperse_multi<T0, T1>(arg0: &mut 0x2::coin::Coin<T0>, arg1: &mut 0x2::coin::Coin<T1>, arg2: vector<address>, arg3: vector<u64>, arg4: vector<u64>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<address>(&arg2);
        assert!(v0 > 0, 2);
        assert!(v0 == 0x1::vector::length<u64>(&arg3), 0);
        assert!(v0 == 0x1::vector::length<u64>(&arg4), 0);
        let v1 = 0;
        let v2 = 0;
        let v3 = 0;
        while (v3 < v0) {
            v1 = v1 + *0x1::vector::borrow<u64>(&arg3, v3);
            v2 = v2 + *0x1::vector::borrow<u64>(&arg4, v3);
            v3 = v3 + 1;
        };
        assert!(0x2::coin::value<T0>(arg0) >= v1, 1);
        assert!(0x2::coin::value<T1>(arg1) >= v2, 1);
        v3 = 0;
        while (v3 < v0) {
            let v4 = *0x1::vector::borrow<address>(&arg2, v3);
            let v5 = *0x1::vector::borrow<u64>(&arg3, v3);
            let v6 = *0x1::vector::borrow<u64>(&arg4, v3);
            if (v5 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(arg0, v5, arg5), v4);
            };
            if (v6 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(arg1, v6, arg5), v4);
            };
            v3 = v3 + 1;
        };
    }

    public entry fun disperse_sui(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: vector<address>, arg2: vector<u64>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<address>(&arg1);
        assert!(v0 > 0, 2);
        assert!(v0 == 0x1::vector::length<u64>(&arg2), 0);
        let v1 = 0;
        let v2 = 0;
        while (v2 < v0) {
            v1 = v1 + *0x1::vector::borrow<u64>(&arg2, v2);
            v2 = v2 + 1;
        };
        assert!(0x2::coin::value<0x2::sui::SUI>(arg0) >= v1, 1);
        v2 = 0;
        while (v2 < v0) {
            let v3 = *0x1::vector::borrow<u64>(&arg2, v2);
            if (v3 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg0, v3, arg3), *0x1::vector::borrow<address>(&arg1, v2));
            };
            v2 = v2 + 1;
        };
    }

    public entry fun disperse_sui_equal(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: vector<address>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<address>(&arg1);
        assert!(v0 > 0, 2);
        assert!(0x2::coin::value<0x2::sui::SUI>(arg0) >= arg2 * v0, 1);
        let v1 = 0;
        while (v1 < v0) {
            if (arg2 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg0, arg2, arg3), *0x1::vector::borrow<address>(&arg1, v1));
            };
            v1 = v1 + 1;
        };
    }

    public entry fun disperse_token<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: vector<address>, arg2: vector<u64>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<address>(&arg1);
        assert!(v0 > 0, 2);
        assert!(v0 == 0x1::vector::length<u64>(&arg2), 0);
        let v1 = 0;
        let v2 = 0;
        while (v2 < v0) {
            v1 = v1 + *0x1::vector::borrow<u64>(&arg2, v2);
            v2 = v2 + 1;
        };
        assert!(0x2::coin::value<T0>(arg0) >= v1, 1);
        v2 = 0;
        while (v2 < v0) {
            let v3 = *0x1::vector::borrow<u64>(&arg2, v2);
            if (v3 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(arg0, v3, arg3), *0x1::vector::borrow<address>(&arg1, v2));
            };
            v2 = v2 + 1;
        };
    }

    public entry fun disperse_token_equal<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: vector<address>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<address>(&arg1);
        assert!(v0 > 0, 2);
        assert!(0x2::coin::value<T0>(arg0) >= arg2 * v0, 1);
        let v1 = 0;
        while (v1 < v0) {
            if (arg2 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(arg0, arg2, arg3), *0x1::vector::borrow<address>(&arg1, v1));
            };
            v1 = v1 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

