module 0x79639bf1a840e24434f4e6f6f7e7c43f147f71f69eb765cfe6d9b02ae30bfe1f::utils {
    public fun type_to_bytes<T0>() : vector<u8> {
        let v0 = 0x1::type_name::get<T0>();
        *0x1::ascii::as_bytes(0x1::type_name::borrow_string(&v0))
    }

    // decompiled from Move bytecode v6
}

