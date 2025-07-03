module 0xb149d1183cdca02b3673724f95f7a32e9b63dcf5a07d3d9e93936444ea081cc9::utils {
    public fun type_to_bytes<T0>() : vector<u8> {
        let v0 = 0x1::type_name::get<T0>();
        *0x1::ascii::as_bytes(0x1::type_name::borrow_string(&v0))
    }

    // decompiled from Move bytecode v6
}

