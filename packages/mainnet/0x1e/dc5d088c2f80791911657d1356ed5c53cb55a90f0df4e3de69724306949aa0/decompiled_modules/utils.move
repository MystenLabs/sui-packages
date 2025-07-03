module 0x1edc5d088c2f80791911657d1356ed5c53cb55a90f0df4e3de69724306949aa0::utils {
    public fun type_to_bytes<T0>() : vector<u8> {
        let v0 = 0x1::type_name::get<T0>();
        *0x1::ascii::as_bytes(0x1::type_name::borrow_string(&v0))
    }

    // decompiled from Move bytecode v6
}

