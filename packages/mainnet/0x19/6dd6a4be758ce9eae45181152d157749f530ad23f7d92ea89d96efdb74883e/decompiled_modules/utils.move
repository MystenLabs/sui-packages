module 0x196dd6a4be758ce9eae45181152d157749f530ad23f7d92ea89d96efdb74883e::utils {
    public fun type_name_bytes<T0>() : vector<u8> {
        0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()))
    }

    // decompiled from Move bytecode v7
}

