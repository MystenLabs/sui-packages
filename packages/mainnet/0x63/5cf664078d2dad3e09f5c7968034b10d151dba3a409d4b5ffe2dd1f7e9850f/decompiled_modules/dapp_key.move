module 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key {
    struct DappKey has copy, drop {
        dummy_field: bool,
    }

    public fun eq<T0: copy + drop, T1: copy + drop>(arg0: &T0, arg1: &T1) : bool {
        0x1::type_name::get<T0>() == 0x1::type_name::get<T1>()
    }

    public(friend) fun new() : DappKey {
        DappKey{dummy_field: false}
    }

    public fun package_id() : address {
        let v0 = 0x1::type_name::get<DappKey>();
        let v1 = 0x1::type_name::get_address(&v0);
        0x2::address::from_ascii_bytes(0x1::ascii::as_bytes(&v1))
    }

    public fun to_string() : 0x1::ascii::String {
        0x1::type_name::into_string(0x1::type_name::get<DappKey>())
    }

    // decompiled from Move bytecode v6
}

