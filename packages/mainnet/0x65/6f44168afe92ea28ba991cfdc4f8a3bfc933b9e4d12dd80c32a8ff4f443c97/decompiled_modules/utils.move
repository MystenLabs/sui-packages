module 0x656f44168afe92ea28ba991cfdc4f8a3bfc933b9e4d12dd80c32a8ff4f443c97::utils {
    public fun type_to_bytes<T0>() : vector<u8> {
        let v0 = 0x1::type_name::get<T0>();
        *0x1::ascii::as_bytes(0x1::type_name::borrow_string(&v0))
    }

    // decompiled from Move bytecode v6
}

