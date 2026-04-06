module 0xb3a692af64df57943e376279995f211e3c1734d6c1c3b833a37ed039ae61bc04::utils {
    public fun type_name_bytes<T0>() : vector<u8> {
        0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()))
    }

    // decompiled from Move bytecode v7
}

