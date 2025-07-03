module 0x10b30bb10ebc6b2fd3c9b435946c6a96745c10d3e3dd83a0778d378211c02bfc::utils {
    public fun type_to_bytes<T0>() : vector<u8> {
        let v0 = 0x1::type_name::get<T0>();
        *0x1::ascii::as_bytes(0x1::type_name::borrow_string(&v0))
    }

    // decompiled from Move bytecode v6
}

