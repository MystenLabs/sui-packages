module 0x59a8b2b45f4ea0770e3231e758c6edb9bb62317ed177911dc52abd4ebff605cc::utils {
    public fun type_to_bytes<T0>() : vector<u8> {
        let v0 = 0x1::type_name::get<T0>();
        *0x1::ascii::as_bytes(0x1::type_name::borrow_string(&v0))
    }

    // decompiled from Move bytecode v6
}

