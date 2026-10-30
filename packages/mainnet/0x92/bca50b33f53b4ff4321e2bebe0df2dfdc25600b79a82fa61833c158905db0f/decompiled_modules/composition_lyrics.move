module 0x92bca50b33f53b4ff4321e2bebe0df2dfdc25600b79a82fa61833c158905db0f::composition_lyrics {
    struct CompositionLyricsKey has copy, drop, store {
        pos0: 0x69f2d3ee6b5ca1779749b5444d2e42dc7b85a1627d880985fad28f028dd154ea::language_code::LanguageCode,
    }

    struct CompositionLyricsSetEvent has copy, drop {
        composition_id: 0x2::object::ID,
        language: 0x1::string::String,
        lyrics: vector<u8>,
    }

    struct CompositionLyricsClearedEvent has copy, drop {
        composition_id: 0x2::object::ID,
        language: 0x1::string::String,
    }

    public fun clear_lyrics<T0>(arg0: &mut 0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::composition::Composition<T0>, arg1: &0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::composition::CompositionAdminCap<T0>, arg2: 0x69f2d3ee6b5ca1779749b5444d2e42dc7b85a1627d880985fad28f028dd154ea::language_code::LanguageCode) {
        let v0 = 0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::composition::uid_mut<T0>(arg0, arg1);
        let v1 = CompositionLyricsKey{pos0: arg2};
        if (0x2::dynamic_field::exists<CompositionLyricsKey>(v0, v1)) {
            0x2::dynamic_field::remove<CompositionLyricsKey, vector<u8>>(v0, v1);
            let v2 = CompositionLyricsClearedEvent{
                composition_id : 0x2::object::id<0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::composition::Composition<T0>>(arg0),
                language       : 0x69f2d3ee6b5ca1779749b5444d2e42dc7b85a1627d880985fad28f028dd154ea::language_code::code(&arg2),
            };
            0x2::event::emit<CompositionLyricsClearedEvent>(v2);
        };
    }

    public fun has_lyrics<T0>(arg0: &0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::composition::Composition<T0>, arg1: 0x69f2d3ee6b5ca1779749b5444d2e42dc7b85a1627d880985fad28f028dd154ea::language_code::LanguageCode) : bool {
        let v0 = CompositionLyricsKey{pos0: arg1};
        0x2::dynamic_field::exists<CompositionLyricsKey>(0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::composition::uid<T0>(arg0), v0)
    }

    public fun lyrics<T0>(arg0: &0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::composition::Composition<T0>, arg1: 0x69f2d3ee6b5ca1779749b5444d2e42dc7b85a1627d880985fad28f028dd154ea::language_code::LanguageCode) : &vector<u8> {
        assert!(has_lyrics<T0>(arg0, arg1), 0);
        let v0 = CompositionLyricsKey{pos0: arg1};
        0x2::dynamic_field::borrow<CompositionLyricsKey, vector<u8>>(0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::composition::uid<T0>(arg0), v0)
    }

    public fun max_lyrics_length() : u64 {
        32768
    }

    public fun set_lyrics<T0>(arg0: &mut 0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::composition::Composition<T0>, arg1: &0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::composition::CompositionAdminCap<T0>, arg2: 0x69f2d3ee6b5ca1779749b5444d2e42dc7b85a1627d880985fad28f028dd154ea::language_code::LanguageCode, arg3: vector<u8>) {
        assert!(!0x1::vector::is_empty<u8>(&arg3), 1);
        assert!(0x1::vector::length<u8>(&arg3) <= 32768, 2);
        let v0 = 0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::composition::uid_mut<T0>(arg0, arg1);
        let v1 = CompositionLyricsKey{pos0: arg2};
        if (0x2::dynamic_field::exists<CompositionLyricsKey>(v0, v1)) {
            let v2 = 0x2::dynamic_field::borrow_mut<CompositionLyricsKey, vector<u8>>(v0, v1);
            if (*v2 == arg3) {
                return
            };
            *v2 = arg3;
        } else {
            0x2::dynamic_field::add<CompositionLyricsKey, vector<u8>>(v0, v1, arg3);
        };
        let v3 = CompositionLyricsSetEvent{
            composition_id : 0x2::object::id<0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::composition::Composition<T0>>(arg0),
            language       : 0x69f2d3ee6b5ca1779749b5444d2e42dc7b85a1627d880985fad28f028dd154ea::language_code::code(&arg2),
            lyrics         : arg3,
        };
        0x2::event::emit<CompositionLyricsSetEvent>(v3);
    }

    // decompiled from Move bytecode v7
}

