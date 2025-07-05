module 0x14c1f05029a76bb16d95f62ce42a3c195fd67a64a80ec7e10329d4e0334508cf::utils {
    public fun type_to_bytes<T0>() : vector<u8> {
        let v0 = 0x1::type_name::get<T0>();
        *0x1::ascii::as_bytes(0x1::type_name::borrow_string(&v0))
    }

    // decompiled from Move bytecode v6
}

