module 0x82d5574d149954f355908cbaaaeb584bd5a918736fb7465a099f846cf0ab9f91::utils {
    public fun type_name_bytes<T0>() : vector<u8> {
        0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()))
    }

    // decompiled from Move bytecode v7
}

