module 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::auth {
    public fun auth_caller_identifier<T0: drop>() : address {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(!0x1::type_name::is_primitive(&v0), 0);
        let v1 = 0x1::type_name::into_string(v0);
        0x2::address::from_bytes(0x2::hash::keccak256(0x1::ascii::as_bytes(&v1)))
    }

    public fun auth_caller_package_address<T0: drop>() : address {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        assert!(!0x1::type_name::is_primitive(&v0), 0);
        let v1 = 0x1::type_name::address_string(&v0);
        0x2::address::from_ascii_bytes(0x1::ascii::as_bytes(&v1))
    }

    // decompiled from Move bytecode v7
}

