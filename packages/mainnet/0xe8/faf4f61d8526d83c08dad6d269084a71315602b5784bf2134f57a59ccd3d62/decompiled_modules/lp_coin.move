module 0xe8faf4f61d8526d83c08dad6d269084a71315602b5784bf2134f57a59ccd3d62::lp_coin {
    struct LP<phantom T0, phantom T1> has drop, store {
        dummy_field: bool,
    }

    public(friend) fun create_witness<T0, T1>() : LP<T0, T1> {
        LP<T0, T1>{dummy_field: false}
    }

    public fun get_pair_types<T0, T1>() : (0x1::type_name::TypeName, 0x1::type_name::TypeName) {
        (0x1::type_name::get<T0>(), 0x1::type_name::get<T1>())
    }

    public fun lp_name<T0, T1>() : 0x1::type_name::TypeName {
        0x1::type_name::get<LP<T0, T1>>()
    }

    // decompiled from Move bytecode v6
}

