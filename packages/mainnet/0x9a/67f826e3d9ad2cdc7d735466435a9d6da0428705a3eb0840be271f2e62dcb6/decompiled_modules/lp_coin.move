module 0x9a67f826e3d9ad2cdc7d735466435a9d6da0428705a3eb0840be271f2e62dcb6::lp_coin {
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

