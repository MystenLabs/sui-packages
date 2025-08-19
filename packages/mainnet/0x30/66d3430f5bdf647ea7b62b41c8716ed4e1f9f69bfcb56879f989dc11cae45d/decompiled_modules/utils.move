module 0x31949681f0148830ccb1cdf4dec21ba25ee91ad63fb76c2b47e0ca887afc671a::utils {
    public fun get_type_name_str<T0>() : 0x1::string::String {
        0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>()))
    }

    public fun mul_div(arg0: u128, arg1: u128, arg2: u128) : u128 {
        assert!(arg2 != 0, 500);
        arg0 * arg1 / arg2
    }

    public fun mul_div_u64(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 != 0, 500);
        let v0 = (arg0 as u128) * (arg1 as u128) / (arg2 as u128);
        assert!(v0 <= 18446744073709551615, 501);
        (v0 as u64)
    }

    public(friend) fun safe_get_collateral_amount<T0>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation) : u64 {
        if (0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::has_coin_x_as_collateral(arg0, 0x1::type_name::get<T0>())) {
            0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::collateral(arg0, 0x1::type_name::get<T0>())
        } else {
            0
        }
    }

    public(friend) fun safe_get_debt_amount<T0>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation) : u64 {
        if (0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::has_coin_x_as_debt(arg0, 0x1::type_name::get<T0>())) {
            let (v1, _) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::debt(arg0, 0x1::type_name::get<T0>());
            v1
        } else {
            0
        }
    }

    public fun safe_mul_div(arg0: u128, arg1: u128, arg2: u128) : u128 {
        if (arg2 != 0) {
            arg0 * arg1 / arg2
        } else {
            arg1
        }
    }

    public fun to_u64(arg0: u128) : u64 {
        assert!(arg0 <= 18446744073709551615, 501);
        (arg0 as u64)
    }

    // decompiled from Move bytecode v6
}

