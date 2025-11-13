module 0x2995a1fe7814ce5cb44afa5b4b00549c8c6f3b29337faed8f8f19a8edd0c58e4::lp_coin {
    struct LP<phantom T0, phantom T1> has drop, store {
        dummy_field: bool,
    }

    public(friend) fun create_witness<T0, T1>() : LP<T0, T1> {
        LP<T0, T1>{dummy_field: false}
    }

    public fun lp_name<T0, T1>() : 0x1::type_name::TypeName {
        0x1::type_name::with_defining_ids<LP<T0, T1>>()
    }

    // decompiled from Move bytecode v6
}

