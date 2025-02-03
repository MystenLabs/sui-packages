module 0x97924d29550c2810051ce13ebb5b2450d627229bd332bbf0ce28fef8a60eaabe::utils {
    public fun deposit_balance<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: 0x2::balance::Balance<T0>, arg2: u64) : 0x2::balance::Balance<T0> {
        assert!(0x2::balance::value<T0>(&arg1) >= arg2, 0x97924d29550c2810051ce13ebb5b2450d627229bd332bbf0ce28fef8a60eaabe::errors::insufficient_coin_balance());
        0x2::balance::join<T0>(arg0, 0x2::balance::split<T0>(&mut arg1, arg2));
        arg1
    }

    public fun get_type_string<T0>() : 0x1::string::String {
        0x1::string::utf8(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())))
    }

    public fun timestamp_seconds(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0) / 1000
    }

    public fun transfer_balance<T0>(arg0: 0x2::balance::Balance<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg2), arg1);
        } else {
            0x2::balance::destroy_zero<T0>(arg0);
        };
    }

    public fun transfer_coin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address) {
        if (0x2::coin::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
        } else {
            0x2::coin::destroy_zero<T0>(arg0);
        };
    }

    public fun u128_to_string(arg0: u128) : 0x1::string::String {
        if (arg0 == 0) {
            return 0x1::string::utf8(b"0")
        };
        let v0 = 0x1::vector::empty<u8>();
        while (arg0 > 0) {
            let v1 = ((arg0 % 10) as u8);
            arg0 = arg0 / 10;
            0x1::vector::push_back<u8>(&mut v0, v1 + 48);
        };
        0x1::vector::reverse<u8>(&mut v0);
        0x1::string::utf8(v0)
    }

    public fun withdraw_balance<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        assert!(0x2::balance::value<T0>(arg0) >= arg1, 0x97924d29550c2810051ce13ebb5b2450d627229bd332bbf0ce28fef8a60eaabe::errors::insufficient_coin_balance());
        0x2::balance::split<T0>(arg0, arg1)
    }

    // decompiled from Move bytecode v6
}

