module 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::auth {
    public fun auth_caller_identifier<T0: drop>() : address {
        let v0 = 0x1::type_name::get<T0>();
        assert!(!0x1::type_name::is_primitive(&v0), 0);
        let v1 = 0x1::type_name::into_string(v0);
        0x2::address::from_bytes(0x2::hash::keccak256(0x1::ascii::as_bytes(&v1)))
    }

    // decompiled from Move bytecode v6
}

