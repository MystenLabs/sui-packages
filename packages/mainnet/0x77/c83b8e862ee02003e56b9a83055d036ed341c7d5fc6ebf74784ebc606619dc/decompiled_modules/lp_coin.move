module 0x77c83b8e862ee02003e56b9a83055d036ed341c7d5fc6ebf74784ebc606619dc::lp_coin {
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

