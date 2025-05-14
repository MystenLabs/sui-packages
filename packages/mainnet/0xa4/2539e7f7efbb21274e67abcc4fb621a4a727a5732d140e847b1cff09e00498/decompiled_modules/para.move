module 0xa42539e7f7efbb21274e67abcc4fb621a4a727a5732d140e847b1cff09e00498::para {
    public fun calculate<T0, T1, T2, T3, T4, T5, T6, T7, T8, T9>(arg0: &T0, arg1: &T1, arg2: &T2, arg3: &T3, arg4: &T4, arg5: &T5, arg6: &T6, arg7: &T7, arg8: &T8, arg9: &T9, arg10: vector<u8>) : (u64, u64, u64) {
        let v0 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>()));
        0x1::string::append(&mut v0, 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T1>())));
        0x1::string::append(&mut v0, 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T2>())));
        (0, 0, 0)
    }

    // decompiled from Move bytecode v6
}

