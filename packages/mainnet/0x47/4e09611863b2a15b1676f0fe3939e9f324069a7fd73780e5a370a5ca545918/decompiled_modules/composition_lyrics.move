module 0x474e09611863b2a15b1676f0fe3939e9f324069a7fd73780e5a370a5ca545918::composition_lyrics {
    struct ExtensionKey has copy, drop, store {
        pos0: 0x69f2d3ee6b5ca1779749b5444d2e42dc7b85a1627d880985fad28f028dd154ea::language_code::LanguageCode,
    }

    struct CompositionLyricsSetEvent<phantom T0> has copy, drop {
        composition_id: address,
        composition_admin_cap_id: address,
        language: vector<u8>,
        lyrics_existed_before: bool,
    }

    struct CompositionLyricsClearedEvent<phantom T0> has copy, drop {
        composition_id: address,
        composition_admin_cap_id: address,
        language: vector<u8>,
    }

    public fun clear_lyrics<T0>(arg0: &mut 0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::composition::Composition<T0>, arg1: &0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::composition::CompositionAdminCap<T0>, arg2: 0x69f2d3ee6b5ca1779749b5444d2e42dc7b85a1627d880985fad28f028dd154ea::language_code::LanguageCode) {
        let v0 = 0x2::object::id<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::composition::Composition<T0>>(arg0);
        let v1 = 0x2::object::id<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::composition::CompositionAdminCap<T0>>(arg1);
        let v2 = 0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::composition::uid_mut<T0>(arg0, arg1);
        let v3 = ExtensionKey{pos0: arg2};
        if (0x2::dynamic_field::exists<ExtensionKey>(v2, v3)) {
            0x2::dynamic_field::remove<ExtensionKey, vector<u8>>(v2, v3);
            let v4 = 0x69f2d3ee6b5ca1779749b5444d2e42dc7b85a1627d880985fad28f028dd154ea::language_code::code(&arg2);
            let v5 = CompositionLyricsClearedEvent<T0>{
                composition_id           : 0x2::object::id_to_address(&v0),
                composition_admin_cap_id : 0x2::object::id_to_address(&v1),
                language                 : *0x1::string::as_bytes(&v4),
            };
            0x2::event::emit<CompositionLyricsClearedEvent<T0>>(v5);
        };
    }

    public fun has_lyrics<T0>(arg0: &0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::composition::Composition<T0>, arg1: 0x69f2d3ee6b5ca1779749b5444d2e42dc7b85a1627d880985fad28f028dd154ea::language_code::LanguageCode) : bool {
        let v0 = ExtensionKey{pos0: arg1};
        0x2::dynamic_field::exists<ExtensionKey>(0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::composition::uid<T0>(arg0), v0)
    }

    public fun lyrics<T0>(arg0: &0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::composition::Composition<T0>, arg1: 0x69f2d3ee6b5ca1779749b5444d2e42dc7b85a1627d880985fad28f028dd154ea::language_code::LanguageCode) : &vector<u8> {
        assert!(has_lyrics<T0>(arg0, arg1), 13906834698329587716);
        let v0 = ExtensionKey{pos0: arg1};
        0x2::dynamic_field::borrow<ExtensionKey, vector<u8>>(0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::composition::uid<T0>(arg0), v0)
    }

    public fun max_lyrics_length() : u64 {
        32768
    }

    public fun set_lyrics<T0>(arg0: &mut 0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::composition::Composition<T0>, arg1: &0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::composition::CompositionAdminCap<T0>, arg2: 0x69f2d3ee6b5ca1779749b5444d2e42dc7b85a1627d880985fad28f028dd154ea::language_code::LanguageCode, arg3: vector<u8>) {
        let v0 = 0x2::object::id<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::composition::Composition<T0>>(arg0);
        let v1 = 0x2::object::id<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::composition::CompositionAdminCap<T0>>(arg1);
        let v2 = 0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::composition::uid_mut<T0>(arg0, arg1);
        assert!(0x1::vector::length<u8>(&arg3) <= 32768, 13906834457811288066);
        let v3 = ExtensionKey{pos0: arg2};
        let v4 = 0x2::dynamic_field::exists<ExtensionKey>(v2, v3);
        let v5 = if (v4) {
            let v6 = 0x2::dynamic_field::borrow_mut<ExtensionKey, vector<u8>>(v2, v3);
            *v6 = arg3;
            *v6 != arg3
        } else {
            0x2::dynamic_field::add<ExtensionKey, vector<u8>>(v2, v3, arg3);
            true
        };
        if (v5) {
            let v7 = 0x69f2d3ee6b5ca1779749b5444d2e42dc7b85a1627d880985fad28f028dd154ea::language_code::code(&arg2);
            let v8 = CompositionLyricsSetEvent<T0>{
                composition_id           : 0x2::object::id_to_address(&v0),
                composition_admin_cap_id : 0x2::object::id_to_address(&v1),
                language                 : *0x1::string::as_bytes(&v7),
                lyrics_existed_before    : v4,
            };
            0x2::event::emit<CompositionLyricsSetEvent<T0>>(v8);
        };
    }

    // decompiled from Move bytecode v7
}

