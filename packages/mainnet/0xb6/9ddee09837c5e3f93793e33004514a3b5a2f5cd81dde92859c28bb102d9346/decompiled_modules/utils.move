module 0xb69ddee09837c5e3f93793e33004514a3b5a2f5cd81dde92859c28bb102d9346::utils {
    public fun type_name_bytes<T0>() : vector<u8> {
        0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()))
    }

    // decompiled from Move bytecode v7
}

