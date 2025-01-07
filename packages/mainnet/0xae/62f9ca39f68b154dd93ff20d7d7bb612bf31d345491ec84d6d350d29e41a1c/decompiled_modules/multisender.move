module 0xae62f9ca39f68b154dd93ff20d7d7bb612bf31d345491ec84d6d350d29e41a1c::multisender {
    fun calculate_total_amount(arg0: &vector<u64>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(arg0)) {
            v0 = v0 + *0x1::vector::borrow<u64>(arg0, v1);
            v1 = v1 + 1;
        };
        v0
    }

    entry fun entry_send_to_multiple<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: vector<address>, arg2: vector<u64>, arg3: &mut 0x2::tx_context::TxContext) {
        send_to_multiple<T0>(arg0, arg1, arg2, arg3);
    }

    public fun send_to_multiple<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: vector<address>, arg2: vector<u64>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<address>(&arg1);
        assert!(v0 == 0x1::vector::length<u64>(&arg2), 1);
        assert!(0x2::coin::value<T0>(arg0) >= calculate_total_amount(&arg2), 0);
        let v1 = 0;
        while (v1 < v0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(arg0, *0x1::vector::borrow<u64>(&arg2, v1), arg3), *0x1::vector::borrow<address>(&arg1, v1));
            v1 = v1 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

