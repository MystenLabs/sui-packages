module 0x7738b6dadbeded34dfd936072e1967b33d68a799d7d6ee1c420f04ee6790d75f::para {
    public fun calculate<T0, T1, T2>(arg0: &T0, arg1: &T1, arg2: &T2, arg3: u64) : 0x1::string::String {
        let v0 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>()));
        0x1::string::append(&mut v0, 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T1>())));
        0x1::string::append(&mut v0, 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T2>())));
        v0
    }

    // decompiled from Move bytecode v6
}

