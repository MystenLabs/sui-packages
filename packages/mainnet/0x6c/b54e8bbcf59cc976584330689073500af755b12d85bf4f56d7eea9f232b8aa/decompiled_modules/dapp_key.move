module 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_key {
    struct DappKey has copy, drop {
        dummy_field: bool,
    }

    public fun eq<T0: copy + drop, T1: copy + drop>(arg0: &T0, arg1: &T1) : bool {
        0x1::type_name::with_defining_ids<T0>() == 0x1::type_name::with_defining_ids<T1>()
    }

    public(friend) fun new() : DappKey {
        DappKey{dummy_field: false}
    }

    public fun package_id() : address {
        let v0 = 0x1::type_name::with_defining_ids<DappKey>();
        let v1 = 0x1::type_name::address_string(&v0);
        0x2::address::from_ascii_bytes(0x1::ascii::as_bytes(&v1))
    }

    public fun to_string() : 0x1::ascii::String {
        0x1::type_name::into_string(0x1::type_name::with_defining_ids<DappKey>())
    }

    // decompiled from Move bytecode v6
}

