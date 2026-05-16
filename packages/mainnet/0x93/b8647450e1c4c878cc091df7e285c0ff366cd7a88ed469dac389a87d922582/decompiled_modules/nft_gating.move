module 0x93b8647450e1c4c878cc091df7e285c0ff366cd7a88ed469dac389a87d922582::nft_gating {
    public fun assert_type_matches<T0: key>(arg0: &T0, arg1: &0x1::string::String) {
        let v0 = type_tag<T0>();
        assert!(&v0 == arg1, 0);
    }

    entry fun seal_approve_nft<T0: key>(arg0: vector<u8>, arg1: &T0, arg2: 0x1::string::String) {
        assert_type_matches<T0>(arg1, &arg2);
    }

    public fun type_tag<T0>() : 0x1::string::String {
        0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>()))
    }

    // decompiled from Move bytecode v6
}

