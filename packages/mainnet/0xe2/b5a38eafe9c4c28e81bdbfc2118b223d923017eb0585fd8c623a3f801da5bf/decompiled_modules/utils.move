module 0xe2b5a38eafe9c4c28e81bdbfc2118b223d923017eb0585fd8c623a3f801da5bf::utils {
    public fun cmp_bytes(arg0: &vector<u8>, arg1: &vector<u8>) : u8 {
        let v0 = 0x1::vector::length<u8>(arg0);
        let v1 = 0x1::vector::length<u8>(arg1);
        let v2 = v0;
        if (v0 > v1) {
            v2 = v1;
        };
        let v3 = 0;
        while (v3 < v2) {
            if (*0x1::vector::borrow<u8>(arg0, v3) < *0x1::vector::borrow<u8>(arg1, v3)) {
                return 0
            };
            if (*0x1::vector::borrow<u8>(arg0, v3) > *0x1::vector::borrow<u8>(arg1, v3)) {
                return 2
            };
            v3 = v3 + 1;
        };
        if (v0 < v1) {
            return 0
        };
        if (v0 > v1) {
            return 2
        };
        1
    }

    public fun safe_mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    public fun send_balance<T0>(arg0: 0x2::balance::Balance<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) == 0) {
            0x2::balance::destroy_zero<T0>(arg0);
            return
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg2), arg1);
    }

    public fun split_coin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg1 > 0, 11000);
        assert!(0x2::coin::value<T0>(&arg0) >= arg1, 11001);
        if (0x2::coin::value<T0>(&arg0) == 0) {
            0x2::coin::destroy_zero<T0>(arg0);
            return 0x2::coin::split<T0>(&mut arg0, arg1, arg2)
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg2));
        0x2::coin::split<T0>(&mut arg0, arg1, arg2)
    }

    public fun split_coin_to_balance<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0x2::coin::into_balance<T0>(split_coin<T0>(arg0, arg1, arg2))
    }

    // decompiled from Move bytecode v6
}

