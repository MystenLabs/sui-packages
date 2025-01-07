module 0x1a4a14591830e3bef3c03cbcb30c17c5e9ddb165b0a6c93208e314cc086c100c::utils {
    public fun get_type_name_str<T0>() : 0x1::ascii::String {
        let v0 = 0x1::type_name::get<T0>();
        *0x1::type_name::borrow_string(&v0)
    }

    // decompiled from Move bytecode v6
}

