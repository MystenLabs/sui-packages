module 0x93b8647450e1c4c878cc091df7e285c0ff366cd7a88ed469dac389a87d922582::token_gating {
    public fun assert_balance<T0>(arg0: &0x2::coin::Coin<T0>, arg1: &0x1::string::String, arg2: u64) {
        let v0 = type_tag<T0>();
        assert!(&v0 == arg1, 1);
        assert!(0x2::coin::value<T0>(arg0) >= arg2, 0);
    }

    public fun type_tag<T0>() : 0x1::string::String {
        0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>()))
    }

    // decompiled from Move bytecode v6
}

