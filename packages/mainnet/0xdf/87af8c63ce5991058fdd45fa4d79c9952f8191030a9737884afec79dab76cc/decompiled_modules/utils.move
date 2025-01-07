module 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::utils {
    public fun compare_u8_vector(arg0: vector<u8>, arg1: vector<u8>) : u8 {
        let v0 = 0x1::vector::length<u8>(&arg0);
        let v1 = 0x1::vector::length<u8>(&arg1);
        let v2 = 0;
        while (v2 < v0 && v2 < v1) {
            let v3 = *0x1::vector::borrow<u8>(&arg0, v2);
            let v4 = *0x1::vector::borrow<u8>(&arg1, v2);
            if (v3 < v4) {
                return 1
            };
            if (v3 > v4) {
                return 2
            };
            v2 = v2 + 1;
        };
        if (v0 < v1) {
            1
        } else if (v0 > v1) {
            2
        } else {
            0
        }
    }

    public fun destroy_zero_coin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address) {
        if (0x2::coin::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
        } else {
            0x2::coin::destroy_zero<T0>(arg0);
        };
    }

    public fun get_amount_in(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg0 > 0, 3);
        assert!(arg1 > 0 && arg2 > 0, 1);
        (((arg1 as u128) * (arg0 as u128) * 10000 / ((arg2 as u128) - (arg0 as u128)) * 9970) as u64) + 1
    }

    public fun get_amount_out(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg0 > 0, 0);
        assert!(arg1 > 0 && arg2 > 0, 1);
        let v0 = (arg0 as u128) * 9980;
        ((v0 * (arg2 as u128) / ((arg1 as u128) * 10000 + v0)) as u64)
    }

    public fun get_equal_enum() : u8 {
        0
    }

    public fun get_greater_enum() : u8 {
        2
    }

    public fun get_lp_name<T0, T1>() : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"BlueMove-");
        0x1::string::append(&mut v0, 0x1::string::utf8(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>()))));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"-"));
        0x1::string::append(&mut v0, 0x1::string::utf8(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T1>()))));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"-LP"));
        v0
    }

    public fun get_smaller_enum() : u8 {
        1
    }

    public fun get_token_name<T0>() : 0x1::string::String {
        0x1::string::utf8(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())))
    }

    public fun quote(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg0 > 0, 2);
        assert!(arg1 > 0 && arg2 > 0, 1);
        (((arg0 as u128) * (arg2 as u128) / (arg1 as u128)) as u64)
    }

    public fun sort_token_type<T0, T1>() : bool {
        let v0 = compare_u8_vector(to_bytes<T0>(), to_bytes<T1>());
        assert!(v0 != get_equal_enum(), 22);
        v0 == get_smaller_enum()
    }

    public fun split_and_keep_coin<T0>(arg0: u64, arg1: vector<0x2::coin::Coin<T0>>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::zero<T0>(arg2);
        0x2::pay::join_vec<T0>(&mut v0, arg1);
        assert!(arg0 <= 0x2::coin::value<T0>(&v0), 2);
        if (0x2::coin::value<T0>(&v0) > 0) {
            0x2::pay::keep<T0>(v0, arg2);
        } else {
            0x2::coin::destroy_zero<T0>(v0);
        };
        0x2::coin::split<T0>(&mut v0, arg0, arg2)
    }

    public fun to_bytes<T0>() : vector<u8> {
        0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>()))
    }

    // decompiled from Move bytecode v6
}

