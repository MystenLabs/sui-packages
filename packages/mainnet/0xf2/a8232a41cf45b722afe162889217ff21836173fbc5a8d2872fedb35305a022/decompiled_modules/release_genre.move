module 0xf2a8232a41cf45b722afe162889217ff21836173fbc5a8d2872fedb35305a022::release_genre {
    struct ExtensionKey has copy, drop, store {
        dummy_field: bool,
    }

    struct ReleaseGenreAddedEvent has copy, drop {
        release_id: address,
        admin_cap_id: address,
        genre_id: address,
        genre_index: u64,
        genre_count_before: u64,
        genre_count_after: u64,
        field_existed_before: bool,
        field_exists_after: bool,
        had_primary_before: bool,
        has_primary_after: bool,
        primary_genre_id_before: address,
        primary_genre_id_after: address,
        primary_changed: bool,
    }

    struct ReleaseGenreRemovedEvent has copy, drop {
        release_id: address,
        admin_cap_id: address,
        genre_id: address,
        genre_index: u64,
        genre_count_before: u64,
        genre_count_after: u64,
        field_existed_before: bool,
        field_exists_after: bool,
        had_primary_before: bool,
        has_primary_after: bool,
        primary_genre_id_before: address,
        primary_genre_id_after: address,
        primary_changed: bool,
    }

    struct ReleaseGenresClearedEvent has copy, drop {
        release_id: address,
        admin_cap_id: address,
        clear_cause: u8,
        trigger_genre_id: address,
        genres_before: vector<address>,
        genre_count_before: u64,
        genre_count_after: u64,
        field_existed_before: bool,
        field_exists_after: bool,
        had_primary_before: bool,
        has_primary_after: bool,
        primary_genre_id_before: address,
        primary_genre_id_after: address,
        primary_changed: bool,
    }

    public fun add_genre(arg0: &mut 0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::Release, arg1: &0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::ReleaseAdminCap, arg2: &0x793da2359ac24b204174ea37440b2cbb42c34f989320a84e48a504ec8a0e3dcc::genre::Genre) {
        let v0 = 0x2::object::id<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::Release>(arg0);
        let v1 = 0x2::object::id<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::ReleaseAdminCap>(arg1);
        let v2 = 0x2::object::id<0x793da2359ac24b204174ea37440b2cbb42c34f989320a84e48a504ec8a0e3dcc::genre::Genre>(arg2);
        let v3 = ExtensionKey{dummy_field: false};
        let v4 = 0x2::dynamic_field::exists<ExtensionKey>(0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::uid(arg0), v3);
        let v5 = if (v4) {
            let v6 = ExtensionKey{dummy_field: false};
            ids_as_addresses(0x2::dynamic_field::borrow<ExtensionKey, vector<0x2::object::ID>>(0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::uid(arg0), v6))
        } else {
            vector[]
        };
        let v7 = v5;
        let v8 = primary_id(&v7);
        if (v4) {
            let v9 = ExtensionKey{dummy_field: false};
            let v10 = 0x2::dynamic_field::borrow_mut<ExtensionKey, vector<0x2::object::ID>>(0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::uid_mut(arg0, arg1), v9);
            let v11 = 0x2::object::id<0x793da2359ac24b204174ea37440b2cbb42c34f989320a84e48a504ec8a0e3dcc::genre::Genre>(arg2);
            assert!(!0x1::vector::contains<0x2::object::ID>(v10, &v11), 40);
            assert!(0x1::vector::length<0x2::object::ID>(v10) < 6, 41);
            0x1::vector::push_back<0x2::object::ID>(v10, 0x2::object::id<0x793da2359ac24b204174ea37440b2cbb42c34f989320a84e48a504ec8a0e3dcc::genre::Genre>(arg2));
        } else {
            let v12 = ExtensionKey{dummy_field: false};
            let v13 = 0x1::vector::empty<0x2::object::ID>();
            0x1::vector::push_back<0x2::object::ID>(&mut v13, 0x2::object::id<0x793da2359ac24b204174ea37440b2cbb42c34f989320a84e48a504ec8a0e3dcc::genre::Genre>(arg2));
            0x2::dynamic_field::add<ExtensionKey, vector<0x2::object::ID>>(0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::uid_mut(arg0, arg1), v12, v13);
        };
        let v14 = ExtensionKey{dummy_field: false};
        let v15 = ids_as_addresses(0x2::dynamic_field::borrow<ExtensionKey, vector<0x2::object::ID>>(0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::uid(arg0), v14));
        let v16 = primary_id(&v15);
        let v17 = ReleaseGenreAddedEvent{
            release_id              : 0x2::object::id_to_address(&v0),
            admin_cap_id            : 0x2::object::id_to_address(&v1),
            genre_id                : 0x2::object::id_to_address(&v2),
            genre_index             : 0x1::vector::length<address>(&v7),
            genre_count_before      : 0x1::vector::length<address>(&v7),
            genre_count_after       : 0x1::vector::length<address>(&v15),
            field_existed_before    : v4,
            field_exists_after      : true,
            had_primary_before      : !0x1::vector::is_empty<address>(&v7),
            has_primary_after       : true,
            primary_genre_id_before : v8,
            primary_genre_id_after  : v16,
            primary_changed         : v8 != v16,
        };
        0x2::event::emit<ReleaseGenreAddedEvent>(v17);
    }

    public fun clear_genres(arg0: &mut 0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::Release, arg1: &0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::ReleaseAdminCap) {
        let v0 = 0x2::object::id<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::Release>(arg0);
        let v1 = 0x2::object::id<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::ReleaseAdminCap>(arg1);
        let v2 = 0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::uid_mut(arg0, arg1);
        let v3 = ExtensionKey{dummy_field: false};
        if (0x2::dynamic_field::exists<ExtensionKey>(v2, v3)) {
            let v4 = ExtensionKey{dummy_field: false};
            let v5 = ids_as_addresses(0x2::dynamic_field::borrow<ExtensionKey, vector<0x2::object::ID>>(v2, v4));
            let v6 = ExtensionKey{dummy_field: false};
            0x2::dynamic_field::remove<ExtensionKey, vector<0x2::object::ID>>(v2, v6);
            let v7 = ReleaseGenresClearedEvent{
                release_id              : 0x2::object::id_to_address(&v0),
                admin_cap_id            : 0x2::object::id_to_address(&v1),
                clear_cause             : 0,
                trigger_genre_id        : @0x0,
                genres_before           : v5,
                genre_count_before      : 0x1::vector::length<address>(&v5),
                genre_count_after       : 0,
                field_existed_before    : true,
                field_exists_after      : false,
                had_primary_before      : true,
                has_primary_after       : false,
                primary_genre_id_before : primary_id(&v5),
                primary_genre_id_after  : @0x0,
                primary_changed         : true,
            };
            0x2::event::emit<ReleaseGenresClearedEvent>(v7);
        };
    }

    public fun genres(arg0: &0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::Release) : vector<0x2::object::ID> {
        let v0 = 0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::uid(arg0);
        let v1 = ExtensionKey{dummy_field: false};
        if (0x2::dynamic_field::exists<ExtensionKey>(v0, v1)) {
            let v3 = ExtensionKey{dummy_field: false};
            *0x2::dynamic_field::borrow<ExtensionKey, vector<0x2::object::ID>>(v0, v3)
        } else {
            0x1::vector::empty<0x2::object::ID>()
        }
    }

    fun ids_as_addresses(arg0: &vector<0x2::object::ID>) : vector<address> {
        let v0 = vector[];
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x2::object::ID>(arg0)) {
            0x1::vector::push_back<address>(&mut v0, 0x2::object::id_to_address(0x1::vector::borrow<0x2::object::ID>(arg0, v1)));
            v1 = v1 + 1;
        };
        v0
    }

    fun primary_id(arg0: &vector<address>) : address {
        if (0x1::vector::is_empty<address>(arg0)) {
            @0x0
        } else {
            *0x1::vector::borrow<address>(arg0, 0)
        }
    }

    public fun remove_genre(arg0: &mut 0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::Release, arg1: &0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::ReleaseAdminCap, arg2: 0x2::object::ID) {
        let v0 = 0x2::object::id<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::Release>(arg0);
        let v1 = 0x2::object::id<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::ReleaseAdminCap>(arg1);
        let v2 = ExtensionKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists<ExtensionKey>(0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::uid(arg0), v2), 42);
        let v3 = ExtensionKey{dummy_field: false};
        let v4 = ids_as_addresses(0x2::dynamic_field::borrow<ExtensionKey, vector<0x2::object::ID>>(0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::uid(arg0), v3));
        let v5 = primary_id(&v4);
        let v6 = 0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::uid_mut(arg0, arg1);
        let v7 = ExtensionKey{dummy_field: false};
        let v8 = 0x2::dynamic_field::borrow_mut<ExtensionKey, vector<0x2::object::ID>>(v6, v7);
        let (v9, v10) = 0x1::vector::index_of<0x2::object::ID>(v8, &arg2);
        assert!(v9, 42);
        0x1::vector::remove<0x2::object::ID>(v8, v10);
        let v11 = ids_as_addresses(v8);
        let v12 = 0x1::vector::is_empty<0x2::object::ID>(v8);
        let v13 = primary_id(&v11);
        if (v12) {
            let v14 = ExtensionKey{dummy_field: false};
            0x2::dynamic_field::remove<ExtensionKey, vector<0x2::object::ID>>(v6, v14);
        };
        let v15 = ReleaseGenreRemovedEvent{
            release_id              : 0x2::object::id_to_address(&v0),
            admin_cap_id            : 0x2::object::id_to_address(&v1),
            genre_id                : 0x2::object::id_to_address(&arg2),
            genre_index             : v10,
            genre_count_before      : 0x1::vector::length<address>(&v4),
            genre_count_after       : 0x1::vector::length<address>(&v11),
            field_existed_before    : true,
            field_exists_after      : !v12,
            had_primary_before      : true,
            has_primary_after       : !v12,
            primary_genre_id_before : v5,
            primary_genre_id_after  : v13,
            primary_changed         : v5 != v13,
        };
        0x2::event::emit<ReleaseGenreRemovedEvent>(v15);
    }

    // decompiled from Move bytecode v7
}

