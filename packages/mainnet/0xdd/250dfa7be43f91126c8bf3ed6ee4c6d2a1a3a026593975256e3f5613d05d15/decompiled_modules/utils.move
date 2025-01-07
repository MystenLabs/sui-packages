module 0xdd250dfa7be43f91126c8bf3ed6ee4c6d2a1a3a026593975256e3f5613d05d15::utils {
    public fun get_type_name_str<T0>() : 0x1::ascii::String {
        let v0 = 0x1::type_name::get<T0>();
        *0x1::type_name::borrow_string(&v0)
    }

    // decompiled from Move bytecode v6
}

