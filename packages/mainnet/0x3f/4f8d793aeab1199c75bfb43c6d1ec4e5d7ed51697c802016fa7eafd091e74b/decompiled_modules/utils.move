module 0x3f4f8d793aeab1199c75bfb43c6d1ec4e5d7ed51697c802016fa7eafd091e74b::utils {
    public fun type_to_bytes<T0>() : vector<u8> {
        let v0 = 0x1::type_name::get<T0>();
        *0x1::ascii::as_bytes(0x1::type_name::borrow_string(&v0))
    }

    // decompiled from Move bytecode v6
}

