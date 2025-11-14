module 0x4ffa40e2053a92842a487f4734ae4f7b11a27e3a5b7e66b16f2354776134eea::lp_coin {
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

