module 0xb56a39db642bed4d96db0a757db1c834e7db13789feab06b557e904d01df0b8b::utils {
    public fun type_to_bytes<T0>() : vector<u8> {
        let v0 = 0x1::type_name::get<T0>();
        *0x1::ascii::as_bytes(0x1::type_name::borrow_string(&v0))
    }

    // decompiled from Move bytecode v6
}

