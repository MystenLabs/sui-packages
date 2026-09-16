module 0xdd333001cee3473b41e501a13897aaedd93ee7d369bacdf195402c6cb7610bf4::release_kind {
    struct ExtensionKey has copy, drop, store {
        dummy_field: bool,
    }

    struct ReleaseKindSetEvent has copy, drop {
        release_id: address,
        release_admin_cap_id: address,
        kind_record_existed_before: bool,
        previous_kind: vector<u8>,
        previous_kind_length: u64,
        kind: vector<u8>,
        kind_length: u64,
        kind_record_exists_after: bool,
        kind_changed: bool,
    }

    struct ReleaseKindUnsetEvent has copy, drop {
        release_id: address,
        release_admin_cap_id: address,
        kind_record_existed_before: bool,
        previous_kind: vector<u8>,
        previous_kind_length: u64,
        kind: vector<u8>,
        kind_length: u64,
        kind_record_exists_after: bool,
        kind_changed: bool,
    }

    public fun has_kind(arg0: &0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::Release) : bool {
        let v0 = ExtensionKey{dummy_field: false};
        0x2::dynamic_field::exists<ExtensionKey>(0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::uid(arg0), v0)
    }

    public fun kind(arg0: &0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::Release) : 0x1::string::String {
        assert!(has_kind(arg0), 1);
        let v0 = ExtensionKey{dummy_field: false};
        *0x2::dynamic_field::borrow<ExtensionKey, 0x1::string::String>(0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::uid(arg0), v0)
    }

    public fun set_kind(arg0: &mut 0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::Release, arg1: &0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::ReleaseAdminCap, arg2: 0x1::string::String) {
        let v0 = 0x1::string::as_bytes(&arg2);
        assert!(!0x1::vector::is_empty<u8>(v0), 2);
        assert!(0x1::vector::length<u8>(v0) <= 32, 3);
        let v1 = 0x2::object::id<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::Release>(arg0);
        let v2 = 0x2::object::id<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::ReleaseAdminCap>(arg1);
        let v3 = *v0;
        let v4 = 0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::uid_mut(arg0, arg1);
        let v5 = ExtensionKey{dummy_field: false};
        let v6 = 0x2::dynamic_field::exists<ExtensionKey>(v4, v5);
        let v7 = b"";
        let v8 = 0;
        if (v6) {
            let v9 = ExtensionKey{dummy_field: false};
            v7 = *0x1::string::as_bytes(0x2::dynamic_field::borrow<ExtensionKey, 0x1::string::String>(v4, v9));
            v8 = 0x1::vector::length<u8>(&v7);
            let v10 = ExtensionKey{dummy_field: false};
            *0x2::dynamic_field::borrow_mut<ExtensionKey, 0x1::string::String>(v4, v10) = arg2;
        } else {
            let v11 = ExtensionKey{dummy_field: false};
            0x2::dynamic_field::add<ExtensionKey, 0x1::string::String>(v4, v11, arg2);
        };
        let v12 = ExtensionKey{dummy_field: false};
        let v13 = v7 != v3;
        if (v13) {
            let v14 = ReleaseKindSetEvent{
                release_id                 : 0x2::object::id_to_address(&v1),
                release_admin_cap_id       : 0x2::object::id_to_address(&v2),
                kind_record_existed_before : v6,
                previous_kind              : v7,
                previous_kind_length       : v8,
                kind                       : v3,
                kind_length                : 0x1::vector::length<u8>(&v3),
                kind_record_exists_after   : 0x2::dynamic_field::exists<ExtensionKey>(v4, v12),
                kind_changed               : v13,
            };
            0x2::event::emit<ReleaseKindSetEvent>(v14);
        };
    }

    public fun unset_kind(arg0: &mut 0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::Release, arg1: &0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::ReleaseAdminCap) {
        let v0 = 0x2::object::id<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::Release>(arg0);
        let v1 = 0x2::object::id<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::ReleaseAdminCap>(arg1);
        let v2 = 0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::uid_mut(arg0, arg1);
        let v3 = ExtensionKey{dummy_field: false};
        let v4 = 0x2::dynamic_field::exists<ExtensionKey>(v2, v3);
        if (v4) {
            let v5 = ExtensionKey{dummy_field: false};
            let v6 = *0x1::string::as_bytes(0x2::dynamic_field::borrow<ExtensionKey, 0x1::string::String>(v2, v5));
            let v7 = ExtensionKey{dummy_field: false};
            0x2::dynamic_field::remove<ExtensionKey, 0x1::string::String>(v2, v7);
            let v8 = ExtensionKey{dummy_field: false};
            let v9 = ReleaseKindUnsetEvent{
                release_id                 : 0x2::object::id_to_address(&v0),
                release_admin_cap_id       : 0x2::object::id_to_address(&v1),
                kind_record_existed_before : v4,
                previous_kind              : v6,
                previous_kind_length       : 0x1::vector::length<u8>(&v6),
                kind                       : b"",
                kind_length                : 0,
                kind_record_exists_after   : 0x2::dynamic_field::exists<ExtensionKey>(v2, v8),
                kind_changed               : true,
            };
            0x2::event::emit<ReleaseKindUnsetEvent>(v9);
        };
    }

    // decompiled from Move bytecode v7
}

