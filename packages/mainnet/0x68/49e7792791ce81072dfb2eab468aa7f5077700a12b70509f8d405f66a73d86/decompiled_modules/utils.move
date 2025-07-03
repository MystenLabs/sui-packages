module 0x6849e7792791ce81072dfb2eab468aa7f5077700a12b70509f8d405f66a73d86::utils {
    public fun type_to_bytes<T0>() : vector<u8> {
        let v0 = 0x1::type_name::get<T0>();
        *0x1::ascii::as_bytes(0x1::type_name::borrow_string(&v0))
    }

    // decompiled from Move bytecode v6
}

