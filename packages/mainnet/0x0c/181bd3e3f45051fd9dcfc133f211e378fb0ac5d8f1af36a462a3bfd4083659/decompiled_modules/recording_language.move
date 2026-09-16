module 0xc181bd3e3f45051fd9dcfc133f211e378fb0ac5d8f1af36a462a3bfd4083659::recording_language {
    struct ExtensionKey has copy, drop, store {
        dummy_field: bool,
    }

    struct RecordingLanguagesSetEvent<phantom T0, phantom T1> has copy, drop {
        recording_id: address,
        composition_id: address,
        admin_cap_id: address,
        had_languages: bool,
        previous_languages: vector<vector<u8>>,
        languages: vector<vector<u8>>,
        language_count_before: u64,
        language_count_after: u64,
        was_instrumental: bool,
        is_instrumental: bool,
        max_languages: u64,
    }

    struct RecordingLanguagesClearedEvent<phantom T0, phantom T1> has copy, drop {
        recording_id: address,
        composition_id: address,
        admin_cap_id: address,
        removed_languages: vector<vector<u8>>,
        language_count_before: u64,
        was_instrumental: bool,
    }

    fun encode_languages(arg0: &vector<0x69f2d3ee6b5ca1779749b5444d2e42dc7b85a1627d880985fad28f028dd154ea::language_code::LanguageCode>) : vector<vector<u8>> {
        let v0 = vector[];
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x69f2d3ee6b5ca1779749b5444d2e42dc7b85a1627d880985fad28f028dd154ea::language_code::LanguageCode>(arg0)) {
            let v2 = 0x69f2d3ee6b5ca1779749b5444d2e42dc7b85a1627d880985fad28f028dd154ea::language_code::code(0x1::vector::borrow<0x69f2d3ee6b5ca1779749b5444d2e42dc7b85a1627d880985fad28f028dd154ea::language_code::LanguageCode>(arg0, v1));
            0x1::vector::push_back<vector<u8>>(&mut v0, *0x1::string::as_bytes(&v2));
            v1 = v1 + 1;
        };
        v0
    }

    public fun has_languages<T0, T1>(arg0: &0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::Recording<T0, T1>) : bool {
        let v0 = ExtensionKey{dummy_field: false};
        0x2::dynamic_field::exists<ExtensionKey>(0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::uid<T0, T1>(arg0), v0)
    }

    public fun is_instrumental<T0, T1>(arg0: &0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::Recording<T0, T1>) : bool {
        if (has_languages<T0, T1>(arg0)) {
            let v1 = ExtensionKey{dummy_field: false};
            0x1::vector::is_empty<0x69f2d3ee6b5ca1779749b5444d2e42dc7b85a1627d880985fad28f028dd154ea::language_code::LanguageCode>(0x2::dynamic_field::borrow<ExtensionKey, vector<0x69f2d3ee6b5ca1779749b5444d2e42dc7b85a1627d880985fad28f028dd154ea::language_code::LanguageCode>>(0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::uid<T0, T1>(arg0), v1))
        } else {
            false
        }
    }

    public fun languages<T0, T1>(arg0: &0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::Recording<T0, T1>) : vector<0x69f2d3ee6b5ca1779749b5444d2e42dc7b85a1627d880985fad28f028dd154ea::language_code::LanguageCode> {
        assert!(has_languages<T0, T1>(arg0), 1);
        let v0 = ExtensionKey{dummy_field: false};
        *0x2::dynamic_field::borrow<ExtensionKey, vector<0x69f2d3ee6b5ca1779749b5444d2e42dc7b85a1627d880985fad28f028dd154ea::language_code::LanguageCode>>(0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::uid<T0, T1>(arg0), v0)
    }

    public fun set_instrumental<T0, T1>(arg0: &mut 0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::Recording<T0, T1>, arg1: &0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::RecordingAdminCap<T0>) {
        set_languages<T0, T1>(arg0, arg1, 0x1::vector::empty<0x69f2d3ee6b5ca1779749b5444d2e42dc7b85a1627d880985fad28f028dd154ea::language_code::LanguageCode>());
    }

    public fun set_languages<T0, T1>(arg0: &mut 0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::Recording<T0, T1>, arg1: &0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::RecordingAdminCap<T0>, arg2: vector<0x69f2d3ee6b5ca1779749b5444d2e42dc7b85a1627d880985fad28f028dd154ea::language_code::LanguageCode>) {
        validate(&arg2);
        let v0 = 0x2::object::id<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::Recording<T0, T1>>(arg0);
        let v1 = 0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::composition_id<T0, T1>(arg0);
        let v2 = 0x2::object::id<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::RecordingAdminCap<T0>>(arg1);
        let v3 = 0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::uid_mut<T0, T1>(arg0, arg1);
        let v4 = ExtensionKey{dummy_field: false};
        let v5 = 0x2::dynamic_field::exists<ExtensionKey>(v3, v4);
        let v6 = vector[];
        let v7 = 0;
        let v8 = false;
        let v9 = true;
        if (v5) {
            let v10 = ExtensionKey{dummy_field: false};
            let v11 = 0x2::dynamic_field::borrow<ExtensionKey, vector<0x69f2d3ee6b5ca1779749b5444d2e42dc7b85a1627d880985fad28f028dd154ea::language_code::LanguageCode>>(v3, v10);
            v6 = encode_languages(v11);
            v7 = 0x1::vector::length<0x69f2d3ee6b5ca1779749b5444d2e42dc7b85a1627d880985fad28f028dd154ea::language_code::LanguageCode>(v11);
            v8 = 0x1::vector::is_empty<0x69f2d3ee6b5ca1779749b5444d2e42dc7b85a1627d880985fad28f028dd154ea::language_code::LanguageCode>(v11);
            v9 = *v11 != arg2;
            let v12 = ExtensionKey{dummy_field: false};
            *0x2::dynamic_field::borrow_mut<ExtensionKey, vector<0x69f2d3ee6b5ca1779749b5444d2e42dc7b85a1627d880985fad28f028dd154ea::language_code::LanguageCode>>(v3, v12) = arg2;
        } else {
            let v13 = ExtensionKey{dummy_field: false};
            0x2::dynamic_field::add<ExtensionKey, vector<0x69f2d3ee6b5ca1779749b5444d2e42dc7b85a1627d880985fad28f028dd154ea::language_code::LanguageCode>>(v3, v13, arg2);
        };
        let v14 = ExtensionKey{dummy_field: false};
        let v15 = 0x2::dynamic_field::borrow<ExtensionKey, vector<0x69f2d3ee6b5ca1779749b5444d2e42dc7b85a1627d880985fad28f028dd154ea::language_code::LanguageCode>>(v3, v14);
        if (v9) {
            let v16 = RecordingLanguagesSetEvent<T0, T1>{
                recording_id          : 0x2::object::id_to_address(&v0),
                composition_id        : 0x2::object::id_to_address(&v1),
                admin_cap_id          : 0x2::object::id_to_address(&v2),
                had_languages         : v5,
                previous_languages    : v6,
                languages             : encode_languages(v15),
                language_count_before : v7,
                language_count_after  : 0x1::vector::length<0x69f2d3ee6b5ca1779749b5444d2e42dc7b85a1627d880985fad28f028dd154ea::language_code::LanguageCode>(v15),
                was_instrumental      : v8,
                is_instrumental       : 0x1::vector::is_empty<0x69f2d3ee6b5ca1779749b5444d2e42dc7b85a1627d880985fad28f028dd154ea::language_code::LanguageCode>(v15),
                max_languages         : 10,
            };
            0x2::event::emit<RecordingLanguagesSetEvent<T0, T1>>(v16);
        };
    }

    public fun unset_languages<T0, T1>(arg0: &mut 0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::Recording<T0, T1>, arg1: &0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::RecordingAdminCap<T0>) {
        let v0 = 0x2::object::id<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::Recording<T0, T1>>(arg0);
        let v1 = 0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::composition_id<T0, T1>(arg0);
        let v2 = 0x2::object::id<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::RecordingAdminCap<T0>>(arg1);
        let v3 = 0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::uid_mut<T0, T1>(arg0, arg1);
        let v4 = ExtensionKey{dummy_field: false};
        if (0x2::dynamic_field::exists<ExtensionKey>(v3, v4)) {
            let v5 = ExtensionKey{dummy_field: false};
            let v6 = 0x2::dynamic_field::remove<ExtensionKey, vector<0x69f2d3ee6b5ca1779749b5444d2e42dc7b85a1627d880985fad28f028dd154ea::language_code::LanguageCode>>(v3, v5);
            let v7 = RecordingLanguagesClearedEvent<T0, T1>{
                recording_id          : 0x2::object::id_to_address(&v0),
                composition_id        : 0x2::object::id_to_address(&v1),
                admin_cap_id          : 0x2::object::id_to_address(&v2),
                removed_languages     : encode_languages(&v6),
                language_count_before : 0x1::vector::length<0x69f2d3ee6b5ca1779749b5444d2e42dc7b85a1627d880985fad28f028dd154ea::language_code::LanguageCode>(&v6),
                was_instrumental      : 0x1::vector::is_empty<0x69f2d3ee6b5ca1779749b5444d2e42dc7b85a1627d880985fad28f028dd154ea::language_code::LanguageCode>(&v6),
            };
            0x2::event::emit<RecordingLanguagesClearedEvent<T0, T1>>(v7);
        };
    }

    fun validate(arg0: &vector<0x69f2d3ee6b5ca1779749b5444d2e42dc7b85a1627d880985fad28f028dd154ea::language_code::LanguageCode>) {
        assert!(0x1::vector::length<0x69f2d3ee6b5ca1779749b5444d2e42dc7b85a1627d880985fad28f028dd154ea::language_code::LanguageCode>(arg0) <= 10, 2);
        let v0 = 0x2::vec_set::empty<0x69f2d3ee6b5ca1779749b5444d2e42dc7b85a1627d880985fad28f028dd154ea::language_code::LanguageCode>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x69f2d3ee6b5ca1779749b5444d2e42dc7b85a1627d880985fad28f028dd154ea::language_code::LanguageCode>(arg0)) {
            let v2 = 0x1::vector::borrow<0x69f2d3ee6b5ca1779749b5444d2e42dc7b85a1627d880985fad28f028dd154ea::language_code::LanguageCode>(arg0, v1);
            assert!(!0x2::vec_set::contains<0x69f2d3ee6b5ca1779749b5444d2e42dc7b85a1627d880985fad28f028dd154ea::language_code::LanguageCode>(&v0, v2), 3);
            0x2::vec_set::insert<0x69f2d3ee6b5ca1779749b5444d2e42dc7b85a1627d880985fad28f028dd154ea::language_code::LanguageCode>(&mut v0, *v2);
            v1 = v1 + 1;
        };
    }

    // decompiled from Move bytecode v7
}

