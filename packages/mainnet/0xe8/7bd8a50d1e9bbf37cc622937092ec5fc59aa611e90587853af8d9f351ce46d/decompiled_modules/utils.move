module 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::utils {
    public fun add_delta(arg0: u128, arg1: 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::i128::I128) : u128 {
        let v0 = 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::i128::abs_u128(arg1);
        if (0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::i128::is_neg(arg1)) {
            assert!(arg0 >= v0, 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::errors::insufficient_liquidity());
            arg0 - v0
        } else {
            assert!(v0 < 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::constants::max_u128() - arg0, 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::errors::insufficient_liquidity());
            arg0 + v0
        }
    }

    public fun deposit_balance<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: 0x2::balance::Balance<T0>, arg2: u64) : 0x2::balance::Balance<T0> {
        assert!(0x2::balance::value<T0>(&arg1) >= arg2, 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::errors::insufficient_coin_balance());
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
        assert!(0x2::balance::value<T0>(arg0) >= arg1, 0xe87bd8a50d1e9bbf37cc622937092ec5fc59aa611e90587853af8d9f351ce46d::errors::insufficient_coin_balance());
        0x2::balance::split<T0>(arg0, arg1)
    }

    // decompiled from Move bytecode v6
}

