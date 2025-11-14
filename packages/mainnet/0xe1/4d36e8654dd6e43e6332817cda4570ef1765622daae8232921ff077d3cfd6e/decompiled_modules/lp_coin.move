module 0xbcf1564932be855733bd9c1b13e4926206729e685f44bfbb9907a46074ea3bf3::lp_coin {
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

