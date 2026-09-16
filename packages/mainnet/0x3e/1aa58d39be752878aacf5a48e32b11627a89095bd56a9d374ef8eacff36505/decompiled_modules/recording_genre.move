module 0x3e1aa58d39be752878aacf5a48e32b11627a89095bd56a9d374ef8eacff36505::recording_genre {
    struct ExtensionKey has copy, drop, store {
        dummy_field: bool,
    }

    struct RecordingGenreAddedEvent<phantom T0, phantom T1> has copy, drop {
        recording_id: address,
        composition_id: address,
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

    struct RecordingGenreRemovedEvent<phantom T0, phantom T1> has copy, drop {
        recording_id: address,
        composition_id: address,
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

    struct RecordingGenresClearedEvent<phantom T0, phantom T1> has copy, drop {
        recording_id: address,
        composition_id: address,
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

    public fun add_genre<T0, T1>(arg0: &mut 0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::Recording<T0, T1>, arg1: &0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::RecordingAdminCap<T0>, arg2: &0x793da2359ac24b204174ea37440b2cbb42c34f989320a84e48a504ec8a0e3dcc::genre::Genre) {
        let v0 = 0x2::object::id<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::Recording<T0, T1>>(arg0);
        let v1 = 0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::composition_id<T0, T1>(arg0);
        let v2 = 0x2::object::id<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::RecordingAdminCap<T0>>(arg1);
        let v3 = 0x2::object::id<0x793da2359ac24b204174ea37440b2cbb42c34f989320a84e48a504ec8a0e3dcc::genre::Genre>(arg2);
        let v4 = 0x2::object::id_to_address(&v3);
        let v5 = ExtensionKey{dummy_field: false};
        let v6 = 0x2::dynamic_field::exists<ExtensionKey>(0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::uid<T0, T1>(arg0), v5);
        let (v7, v8, v9, v10, v11, v12, v13, v14) = if (v6) {
            let v15 = ExtensionKey{dummy_field: false};
            let v16 = 0x2::dynamic_field::borrow_mut<ExtensionKey, vector<0x2::object::ID>>(0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::uid_mut<T0, T1>(arg0, arg1), v15);
            let v17 = *v16;
            let (v18, v19) = primary_state(&v17);
            assert!(!0x1::vector::contains<0x2::object::ID>(v16, &v3), 40);
            assert!(0x1::vector::length<0x2::object::ID>(v16) < 6, 41);
            0x1::vector::push_back<0x2::object::ID>(v16, v3);
            let v20 = *v16;
            let (v21, v22) = primary_state(&v20);
            let v23 = v18 != v21 || v19 != v22;
            (v19, v22, v23, 0x1::vector::length<0x2::object::ID>(v16), 0x1::vector::length<0x2::object::ID>(&v17), 0x1::vector::length<0x2::object::ID>(&v20), v18, v21)
        } else {
            let v24 = ExtensionKey{dummy_field: false};
            let v25 = 0x1::vector::empty<0x2::object::ID>();
            0x1::vector::push_back<0x2::object::ID>(&mut v25, v3);
            0x2::dynamic_field::add<ExtensionKey, vector<0x2::object::ID>>(0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::uid_mut<T0, T1>(arg0, arg1), v24, v25);
            (@0x0, v4, true, 0, 0, 1, false, true)
        };
        let v26 = RecordingGenreAddedEvent<T0, T1>{
            recording_id            : 0x2::object::id_to_address(&v0),
            composition_id          : 0x2::object::id_to_address(&v1),
            admin_cap_id            : 0x2::object::id_to_address(&v2),
            genre_id                : v4,
            genre_index             : v10,
            genre_count_before      : v11,
            genre_count_after       : v12,
            field_existed_before    : v6,
            field_exists_after      : true,
            had_primary_before      : v13,
            has_primary_after       : v14,
            primary_genre_id_before : v7,
            primary_genre_id_after  : v8,
            primary_changed         : v9,
        };
        0x2::event::emit<RecordingGenreAddedEvent<T0, T1>>(v26);
    }

    public fun clear_genres<T0, T1>(arg0: &mut 0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::Recording<T0, T1>, arg1: &0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::RecordingAdminCap<T0>) {
        let v0 = 0x2::object::id<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::Recording<T0, T1>>(arg0);
        let v1 = 0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::composition_id<T0, T1>(arg0);
        let v2 = 0x2::object::id<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::RecordingAdminCap<T0>>(arg1);
        let v3 = 0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::uid_mut<T0, T1>(arg0, arg1);
        let v4 = ExtensionKey{dummy_field: false};
        if (0x2::dynamic_field::exists<ExtensionKey>(v3, v4)) {
            let v5 = ExtensionKey{dummy_field: false};
            let v6 = 0x2::dynamic_field::remove<ExtensionKey, vector<0x2::object::ID>>(v3, v5);
            let (v7, v8) = primary_state(&v6);
            let v9 = v7 || v8 != @0x0;
            let v10 = RecordingGenresClearedEvent<T0, T1>{
                recording_id            : 0x2::object::id_to_address(&v0),
                composition_id          : 0x2::object::id_to_address(&v1),
                admin_cap_id            : 0x2::object::id_to_address(&v2),
                clear_cause             : 0,
                trigger_genre_id        : @0x0,
                genres_before           : ids_to_addresses(&v6),
                genre_count_before      : 0x1::vector::length<0x2::object::ID>(&v6),
                genre_count_after       : 0,
                field_existed_before    : true,
                field_exists_after      : false,
                had_primary_before      : v7,
                has_primary_after       : false,
                primary_genre_id_before : v8,
                primary_genre_id_after  : @0x0,
                primary_changed         : v9,
            };
            0x2::event::emit<RecordingGenresClearedEvent<T0, T1>>(v10);
        };
    }

    public fun genres<T0, T1>(arg0: &0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::Recording<T0, T1>) : vector<0x2::object::ID> {
        let v0 = 0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::uid<T0, T1>(arg0);
        let v1 = ExtensionKey{dummy_field: false};
        if (0x2::dynamic_field::exists<ExtensionKey>(v0, v1)) {
            let v3 = ExtensionKey{dummy_field: false};
            *0x2::dynamic_field::borrow<ExtensionKey, vector<0x2::object::ID>>(v0, v3)
        } else {
            0x1::vector::empty<0x2::object::ID>()
        }
    }

    fun ids_to_addresses(arg0: &vector<0x2::object::ID>) : vector<address> {
        let v0 = vector[];
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x2::object::ID>(arg0)) {
            0x1::vector::push_back<address>(&mut v0, 0x2::object::id_to_address(0x1::vector::borrow<0x2::object::ID>(arg0, v1)));
            v1 = v1 + 1;
        };
        v0
    }

    fun primary_state(arg0: &vector<0x2::object::ID>) : (bool, address) {
        if (0x1::vector::is_empty<0x2::object::ID>(arg0)) {
            (false, @0x0)
        } else {
            (true, 0x2::object::id_to_address(0x1::vector::borrow<0x2::object::ID>(arg0, 0)))
        }
    }

    public fun remove_genre<T0, T1>(arg0: &mut 0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::Recording<T0, T1>, arg1: &0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::RecordingAdminCap<T0>, arg2: 0x2::object::ID) {
        let v0 = 0x2::object::id<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::Recording<T0, T1>>(arg0);
        let v1 = 0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::composition_id<T0, T1>(arg0);
        let v2 = 0x2::object::id<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::RecordingAdminCap<T0>>(arg1);
        let v3 = ExtensionKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists<ExtensionKey>(0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::uid<T0, T1>(arg0), v3), 42);
        let v4 = 0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::uid_mut<T0, T1>(arg0, arg1);
        let v5 = ExtensionKey{dummy_field: false};
        let v6 = 0x2::dynamic_field::borrow_mut<ExtensionKey, vector<0x2::object::ID>>(v4, v5);
        let (v7, v8) = 0x1::vector::index_of<0x2::object::ID>(v6, &arg2);
        assert!(v7, 42);
        let v9 = *v6;
        let (v10, v11) = primary_state(&v9);
        0x1::vector::remove<0x2::object::ID>(v6, v8);
        let v12 = *v6;
        let (v13, v14) = primary_state(&v12);
        let v15 = 0x1::vector::is_empty<0x2::object::ID>(&v12);
        let v16 = v10 != v13 || v11 != v14;
        if (v15) {
            let v17 = ExtensionKey{dummy_field: false};
            0x2::dynamic_field::remove<ExtensionKey, vector<0x2::object::ID>>(v4, v17);
        };
        let v18 = RecordingGenreRemovedEvent<T0, T1>{
            recording_id            : 0x2::object::id_to_address(&v0),
            composition_id          : 0x2::object::id_to_address(&v1),
            admin_cap_id            : 0x2::object::id_to_address(&v2),
            genre_id                : 0x2::object::id_to_address(&arg2),
            genre_index             : v8,
            genre_count_before      : 0x1::vector::length<0x2::object::ID>(&v9),
            genre_count_after       : 0x1::vector::length<0x2::object::ID>(&v12),
            field_existed_before    : true,
            field_exists_after      : !v15,
            had_primary_before      : v10,
            has_primary_after       : v13,
            primary_genre_id_before : v11,
            primary_genre_id_after  : v14,
            primary_changed         : v16,
        };
        0x2::event::emit<RecordingGenreRemovedEvent<T0, T1>>(v18);
    }

    // decompiled from Move bytecode v7
}

