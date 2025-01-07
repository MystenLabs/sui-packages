module 0xaa0baef686525169f13ac793e08fb02e2fb9d9c614de46be24e8d4f3abd07d66::utils {
    struct UTILS has drop {
        dummy_field: bool,
    }

    public fun check_version(arg0: &0x56714d6578dafaaec566c1483ac0fc5fb206b506455a8d59b043d67d243243eb::version::Version) {
        let v0 = 0x1::type_name::get<UTILS>();
        let v1 = 0x1::type_name::get_address(&v0);
        assert!(0x56714d6578dafaaec566c1483ac0fc5fb206b506455a8d59b043d67d243243eb::version::get(arg0, 0x2::address::from_bytes(0x2::hex::decode(*0x1::ascii::as_bytes(&v1)))) == 0, 0);
    }

    public fun from_same_package<T0, T1>() : bool {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::type_name::get<T1>();
        0x1::type_name::get_address(&v0) == 0x1::type_name::get_address(&v1)
    }

    // decompiled from Move bytecode v6
}

