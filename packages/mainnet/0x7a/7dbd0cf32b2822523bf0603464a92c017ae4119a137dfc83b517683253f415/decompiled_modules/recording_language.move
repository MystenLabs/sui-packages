module 0x7a7dbd0cf32b2822523bf0603464a92c017ae4119a137dfc83b517683253f415::recording_language {
    struct RecordingLanguageKey has copy, drop, store {
        dummy_field: bool,
    }

    struct RecordingLanguagesSetEvent has copy, drop {
        recording_id: 0x2::object::ID,
        languages: vector<0x1::string::String>,
    }

    struct RecordingLanguagesClearedEvent has copy, drop {
        recording_id: 0x2::object::ID,
    }

    public fun clear_languages<T0>(arg0: &mut 0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::Recording<T0>, arg1: &0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::RecordingAdminCap<T0>) {
        let v0 = 0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::uid_mut<T0>(arg0, arg1);
        let v1 = RecordingLanguageKey{dummy_field: false};
        if (0x2::dynamic_field::exists<RecordingLanguageKey>(v0, v1)) {
            let v2 = RecordingLanguageKey{dummy_field: false};
            0x2::dynamic_field::remove<RecordingLanguageKey, vector<0x69f2d3ee6b5ca1779749b5444d2e42dc7b85a1627d880985fad28f028dd154ea::language_code::LanguageCode>>(v0, v2);
            let v3 = RecordingLanguagesClearedEvent{recording_id: 0x2::object::id<0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::Recording<T0>>(arg0)};
            0x2::event::emit<RecordingLanguagesClearedEvent>(v3);
        };
    }

    public fun has_languages<T0>(arg0: &0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::Recording<T0>) : bool {
        let v0 = RecordingLanguageKey{dummy_field: false};
        0x2::dynamic_field::exists<RecordingLanguageKey>(0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::uid<T0>(arg0), v0)
    }

    public fun languages<T0>(arg0: &0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::Recording<T0>) : &vector<0x69f2d3ee6b5ca1779749b5444d2e42dc7b85a1627d880985fad28f028dd154ea::language_code::LanguageCode> {
        assert!(has_languages<T0>(arg0), 0);
        let v0 = RecordingLanguageKey{dummy_field: false};
        0x2::dynamic_field::borrow<RecordingLanguageKey, vector<0x69f2d3ee6b5ca1779749b5444d2e42dc7b85a1627d880985fad28f028dd154ea::language_code::LanguageCode>>(0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::uid<T0>(arg0), v0)
    }

    public fun set_languages<T0>(arg0: &mut 0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::Recording<T0>, arg1: &0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::RecordingAdminCap<T0>, arg2: vector<0x69f2d3ee6b5ca1779749b5444d2e42dc7b85a1627d880985fad28f028dd154ea::language_code::LanguageCode>) {
        assert!(0x1::vector::length<0x69f2d3ee6b5ca1779749b5444d2e42dc7b85a1627d880985fad28f028dd154ea::language_code::LanguageCode>(&arg2) <= 10, 1);
        let v0 = 0x2::vec_set::empty<0x69f2d3ee6b5ca1779749b5444d2e42dc7b85a1627d880985fad28f028dd154ea::language_code::LanguageCode>();
        let v1 = &arg2;
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x69f2d3ee6b5ca1779749b5444d2e42dc7b85a1627d880985fad28f028dd154ea::language_code::LanguageCode>(v1)) {
            let v3 = 0x1::vector::borrow<0x69f2d3ee6b5ca1779749b5444d2e42dc7b85a1627d880985fad28f028dd154ea::language_code::LanguageCode>(v1, v2);
            assert!(!0x2::vec_set::contains<0x69f2d3ee6b5ca1779749b5444d2e42dc7b85a1627d880985fad28f028dd154ea::language_code::LanguageCode>(&v0, v3), 2);
            0x2::vec_set::insert<0x69f2d3ee6b5ca1779749b5444d2e42dc7b85a1627d880985fad28f028dd154ea::language_code::LanguageCode>(&mut v0, *v3);
            v2 = v2 + 1;
        };
        let v4 = 0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::uid_mut<T0>(arg0, arg1);
        let v5 = RecordingLanguageKey{dummy_field: false};
        if (0x2::dynamic_field::exists<RecordingLanguageKey>(v4, v5)) {
            let v6 = RecordingLanguageKey{dummy_field: false};
            let v7 = 0x2::dynamic_field::borrow_mut<RecordingLanguageKey, vector<0x69f2d3ee6b5ca1779749b5444d2e42dc7b85a1627d880985fad28f028dd154ea::language_code::LanguageCode>>(v4, v6);
            if (*v7 == arg2) {
                return
            };
            *v7 = arg2;
        } else {
            let v8 = RecordingLanguageKey{dummy_field: false};
            0x2::dynamic_field::add<RecordingLanguageKey, vector<0x69f2d3ee6b5ca1779749b5444d2e42dc7b85a1627d880985fad28f028dd154ea::language_code::LanguageCode>>(v4, v8, arg2);
        };
        let v9 = &arg2;
        let v10 = 0x1::vector::empty<0x1::string::String>();
        let v11 = 0;
        while (v11 < 0x1::vector::length<0x69f2d3ee6b5ca1779749b5444d2e42dc7b85a1627d880985fad28f028dd154ea::language_code::LanguageCode>(v9)) {
            0x1::vector::push_back<0x1::string::String>(&mut v10, 0x69f2d3ee6b5ca1779749b5444d2e42dc7b85a1627d880985fad28f028dd154ea::language_code::code(0x1::vector::borrow<0x69f2d3ee6b5ca1779749b5444d2e42dc7b85a1627d880985fad28f028dd154ea::language_code::LanguageCode>(v9, v11)));
            v11 = v11 + 1;
        };
        let v12 = RecordingLanguagesSetEvent{
            recording_id : 0x2::object::id<0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::Recording<T0>>(arg0),
            languages    : v10,
        };
        0x2::event::emit<RecordingLanguagesSetEvent>(v12);
    }

    // decompiled from Move bytecode v7
}

