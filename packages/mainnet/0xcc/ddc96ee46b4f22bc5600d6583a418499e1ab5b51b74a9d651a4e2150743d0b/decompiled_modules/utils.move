module 0xccddc96ee46b4f22bc5600d6583a418499e1ab5b51b74a9d651a4e2150743d0b::utils {
    public fun type_name_bytes<T0>() : vector<u8> {
        0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()))
    }

    // decompiled from Move bytecode v7
}

