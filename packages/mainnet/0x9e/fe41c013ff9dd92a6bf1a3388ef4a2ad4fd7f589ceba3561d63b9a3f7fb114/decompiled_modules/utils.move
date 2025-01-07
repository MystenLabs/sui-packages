module 0x9efe41c013ff9dd92a6bf1a3388ef4a2ad4fd7f589ceba3561d63b9a3f7fb114::utils {
    public fun get_type_name_str<T0>() : 0x1::ascii::String {
        let v0 = 0x1::type_name::get<T0>();
        *0x1::type_name::borrow_string(&v0)
    }

    // decompiled from Move bytecode v6
}

