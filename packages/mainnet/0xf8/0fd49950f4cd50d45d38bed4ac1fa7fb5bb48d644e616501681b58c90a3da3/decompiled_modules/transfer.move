module 0xf80fd49950f4cd50d45d38bed4ac1fa7fb5bb48d644e616501681b58c90a3da3::transfer {
    public entry fun batch_transfer<T0>(arg0: 0x2::coin::Coin<T0>, arg1: vector<address>, arg2: vector<u64>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<address>(&arg1);
        assert!(v0 == 0x1::vector::length<u64>(&arg2), 0);
        assert!(0x2::coin::value<T0>(&arg0) >= sum_amounts(&arg2), 1);
        let v1 = 0;
        while (v1 < v0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0, *0x1::vector::borrow<u64>(&arg2, v1), arg3), *0x1::vector::borrow<address>(&arg1, v1));
            v1 = v1 + 1;
        };
        if (0x2::coin::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<T0>(arg0);
        };
    }

    public entry fun batch_transfer_equal<T0>(arg0: 0x2::coin::Coin<T0>, arg1: vector<address>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<address>(&arg1);
        assert!(0x2::coin::value<T0>(&arg0) >= arg2 * (v0 as u64), 1);
        let v1 = 0;
        while (v1 < v0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0, arg2, arg3), *0x1::vector::borrow<address>(&arg1, v1));
            v1 = v1 + 1;
        };
        if (0x2::coin::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<T0>(arg0);
        };
    }

    fun sum_amounts(arg0: &vector<u64>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(arg0)) {
            v0 = v0 + *0x1::vector::borrow<u64>(arg0, v1);
            v1 = v1 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v6
}

