module 0xde726563dac34e5759c94d34e142d6b7ced4b8ca948b6d137638995568777d4f::utils {
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

    public fun to_u64(arg0: u128) : u64 {
        assert!(arg0 <= 18446744073709551615, 501);
        (arg0 as u64)
    }

    // decompiled from Move bytecode v6
}

