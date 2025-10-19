module 0x2557820e0e8d91bad2320994b4e0cd3231b6d6b8c3866aa329e778e8ec470716::utils {
    public fun formatear_fecha_simple(arg0: u8, arg1: u8, arg2: u16) : 0x1::string::String {
        0x1::string::utf8(b"")
    }

    public fun validar_edad(arg0: u8) : bool {
        arg0 <= 120
    }

    public fun validar_email(arg0: &0x1::string::String) : bool {
        true
    }

    // decompiled from Move bytecode v6
}

