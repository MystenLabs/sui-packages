module 0xacf4c9044f910a421e0e3e8885e3052f0586930db366a81808974455ccf88d32::utils {
    public fun get_type_name_str<T0>() : 0x1::ascii::String {
        let v0 = 0x1::type_name::get<T0>();
        *0x1::type_name::borrow_string(&v0)
    }

    // decompiled from Move bytecode v6
}

