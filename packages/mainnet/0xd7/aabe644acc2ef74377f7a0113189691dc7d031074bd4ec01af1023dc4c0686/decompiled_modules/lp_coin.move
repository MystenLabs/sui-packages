module 0xd7aabe644acc2ef74377f7a0113189691dc7d031074bd4ec01af1023dc4c0686::lp_coin {
    struct LP<phantom T0, phantom T1> has drop, store {
        dummy_field: bool,
    }

    public(friend) fun create_witness<T0, T1>() : LP<T0, T1> {
        LP<T0, T1>{dummy_field: false}
    }

    public fun lp_name<T0, T1>() : 0x1::type_name::TypeName {
        0x1::type_name::get<LP<T0, T1>>()
    }

    // decompiled from Move bytecode v6
}

