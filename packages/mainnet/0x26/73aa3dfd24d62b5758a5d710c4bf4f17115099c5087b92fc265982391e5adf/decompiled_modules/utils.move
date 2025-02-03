module 0x7ec05d4d0c863d8e6e8a4cdda12a126f3d2bda1dede3ef8f149cefe301ef3c2e::utils {
    public fun cal_amount_with_percent(arg0: u64, arg1: u64) : u64 {
        mul_u64_div_u64(arg0, arg1, 100000000000)
    }

    public fun get_full_type<T0>() : 0x1::string::String {
        let v0 = 0x1::type_name::get<T0>();
        0x1::string::from_ascii(*0x1::type_name::borrow_string(&v0))
    }

    public fun get_key_by_struct<T0>() : 0x1::string::String {
        let v0 = 0x1::type_name::get<T0>();
        0x1::string::from_ascii(0x1::type_name::get_module(&v0))
    }

    public fun get_module_type<T0>() : 0x1::string::String {
        let v0 = 0x1::type_name::get<T0>();
        0x1::string::from_ascii(0x1::type_name::get_address(&v0))
    }

    public fun max_percent() : u64 {
        100000000000
    }

    public fun merge_and_split<T0>(arg0: vector<0x2::coin::Coin<T0>>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T0>) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg0);
        assert!(0x2::coin::value<T0>(&v0) >= arg1, 800);
        0x2::pay::join_vec<T0>(&mut v0, arg0);
        if (0x2::coin::value<T0>(&v0) > arg1) {
            (0x2::coin::split<T0>(&mut v0, arg1, arg2), v0)
        } else {
            (v0, 0x2::coin::zero<T0>(arg2))
        }
    }

    public fun mul_u64_div_decimal(arg0: u64, arg1: u64, arg2: u8) : u64 {
        let v0 = (arg0 as u128) * (arg1 as u128) / (0x2::math::pow(10, arg2) as u128);
        assert!(v0 <= 18446744073709551615, 1);
        (v0 as u64)
    }

    public fun mul_u64_div_u64(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = (arg0 as u128) * (arg1 as u128) / (arg2 as u128);
        assert!(v0 <= 18446744073709551615, 1);
        (v0 as u64)
    }

    // decompiled from Move bytecode v6
}

