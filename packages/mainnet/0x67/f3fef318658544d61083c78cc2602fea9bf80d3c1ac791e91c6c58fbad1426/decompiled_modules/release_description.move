module 0x67f3fef318658544d61083c78cc2602fea9bf80d3c1ac791e91c6c58fbad1426::release_description {
    struct ExtensionKey has copy, drop, store {
        dummy_field: bool,
    }

    struct ReleaseDescriptionSetEvent has copy, drop {
        release_id: address,
        release_admin_cap_id: address,
        description_existed_before: bool,
    }

    struct ReleaseDescriptionClearedEvent has copy, drop {
        release_id: address,
        release_admin_cap_id: address,
    }

    public fun clear_description(arg0: &mut 0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::Release, arg1: &0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::ReleaseAdminCap) {
        let v0 = 0x2::object::id<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::Release>(arg0);
        let v1 = 0x2::object::id<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::ReleaseAdminCap>(arg1);
        let v2 = 0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::uid_mut(arg0, arg1);
        let v3 = ExtensionKey{dummy_field: false};
        if (0x2::dynamic_field::exists<ExtensionKey>(v2, v3)) {
            let v4 = ExtensionKey{dummy_field: false};
            0x2::dynamic_field::remove<ExtensionKey, 0x1::string::String>(v2, v4);
            let v5 = ReleaseDescriptionClearedEvent{
                release_id           : 0x2::object::id_to_address(&v0),
                release_admin_cap_id : 0x2::object::id_to_address(&v1),
            };
            0x2::event::emit<ReleaseDescriptionClearedEvent>(v5);
        };
    }

    public fun description(arg0: &0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::Release) : &0x1::string::String {
        assert!(has_description(arg0), 13906834835768672262);
        let v0 = ExtensionKey{dummy_field: false};
        0x2::dynamic_field::borrow<ExtensionKey, 0x1::string::String>(0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::uid(arg0), v0)
    }

    public fun has_description(arg0: &0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::Release) : bool {
        let v0 = ExtensionKey{dummy_field: false};
        0x2::dynamic_field::exists<ExtensionKey>(0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::uid(arg0), v0)
    }

    public fun set_description(arg0: &mut 0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::Release, arg1: &0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::ReleaseAdminCap, arg2: 0x1::string::String) {
        let v0 = 0x1::string::as_bytes(&arg2);
        assert!(!0x1::vector::is_empty<u8>(v0), 13906834599545208834);
        assert!(0x1::vector::length<u8>(v0) <= 8192, 13906834603840307204);
        let v1 = 0x2::object::id<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::Release>(arg0);
        let v2 = 0x2::object::id<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::ReleaseAdminCap>(arg1);
        let v3 = 0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::uid_mut(arg0, arg1);
        let v4 = ExtensionKey{dummy_field: false};
        let v5 = 0x2::dynamic_field::exists<ExtensionKey>(v3, v4);
        let v6 = if (v5) {
            let v7 = ExtensionKey{dummy_field: false};
            let v8 = 0x2::dynamic_field::borrow_mut<ExtensionKey, 0x1::string::String>(v3, v7);
            *v8 = arg2;
            *0x1::string::as_bytes(v8) != *0x1::string::as_bytes(&arg2)
        } else {
            let v9 = ExtensionKey{dummy_field: false};
            0x2::dynamic_field::add<ExtensionKey, 0x1::string::String>(v3, v9, arg2);
            true
        };
        if (v6) {
            let v10 = ReleaseDescriptionSetEvent{
                release_id                 : 0x2::object::id_to_address(&v1),
                release_admin_cap_id       : 0x2::object::id_to_address(&v2),
                description_existed_before : v5,
            };
            0x2::event::emit<ReleaseDescriptionSetEvent>(v10);
        };
    }

    // decompiled from Move bytecode v7
}

