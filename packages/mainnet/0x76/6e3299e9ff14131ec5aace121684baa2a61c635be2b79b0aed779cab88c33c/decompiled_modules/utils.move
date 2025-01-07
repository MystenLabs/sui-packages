module 0x766e3299e9ff14131ec5aace121684baa2a61c635be2b79b0aed779cab88c33c::utils {
    public fun get_full_type<T0>() : 0x1::string::String {
        let v0 = 0x1::type_name::get<T0>();
        0x1::string::from_ascii(*0x1::type_name::borrow_string(&v0))
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

