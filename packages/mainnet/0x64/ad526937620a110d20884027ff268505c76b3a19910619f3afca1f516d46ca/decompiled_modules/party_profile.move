module 0x64ad526937620a110d20884027ff268505c76b3a19910619f3afca1f516d46ca::party_profile {
    struct Profile has drop, store {
        bio_short: 0x1::string::String,
        bio_long: 0x1::option::Option<0x1::string::String>,
        country: 0x1::option::Option<0x6fada7a2d6c13805380cdff622298b7fff0c8e16d2ce6c3768bcd3f9a6a5e611::country_code::CountryCode>,
        languages: vector<0x69f2d3ee6b5ca1779749b5444d2e42dc7b85a1627d880985fad28f028dd154ea::language_code::LanguageCode>,
    }

    struct PartyProfileKey has copy, drop, store {
        dummy_field: bool,
    }

    struct PartyProfileSetEvent has copy, drop {
        party_id: 0x2::object::ID,
        bio_short: 0x1::string::String,
        bio_long: 0x1::option::Option<0x1::string::String>,
        country: 0x1::option::Option<0x1::string::String>,
        languages: vector<0x1::string::String>,
    }

    struct PartyProfileClearedEvent has copy, drop {
        party_id: 0x2::object::ID,
    }

    public fun bio_long(arg0: &Profile) : 0x1::option::Option<0x1::string::String> {
        arg0.bio_long
    }

    public fun bio_short(arg0: &Profile) : 0x1::string::String {
        arg0.bio_short
    }

    public fun clear_profile(arg0: &mut 0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::Party, arg1: &0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::PartyAdminCap) {
        let v0 = 0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::uid_mut(arg0, arg1);
        let v1 = PartyProfileKey{dummy_field: false};
        if (0x2::dynamic_field::exists<PartyProfileKey>(v0, v1)) {
            let v2 = PartyProfileKey{dummy_field: false};
            0x2::dynamic_field::remove<PartyProfileKey, Profile>(v0, v2);
            let v3 = PartyProfileClearedEvent{party_id: 0x2::object::id<0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::Party>(arg0)};
            0x2::event::emit<PartyProfileClearedEvent>(v3);
        };
    }

    public fun country(arg0: &Profile) : 0x1::option::Option<0x6fada7a2d6c13805380cdff622298b7fff0c8e16d2ce6c3768bcd3f9a6a5e611::country_code::CountryCode> {
        arg0.country
    }

    public fun has_profile(arg0: &0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::Party) : bool {
        let v0 = PartyProfileKey{dummy_field: false};
        0x2::dynamic_field::exists<PartyProfileKey>(0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::uid(arg0), v0)
    }

    public fun languages(arg0: &Profile) : vector<0x69f2d3ee6b5ca1779749b5444d2e42dc7b85a1627d880985fad28f028dd154ea::language_code::LanguageCode> {
        arg0.languages
    }

    public fun profile(arg0: &0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::Party) : &Profile {
        assert!(has_profile(arg0), 5);
        let v0 = PartyProfileKey{dummy_field: false};
        0x2::dynamic_field::borrow<PartyProfileKey, Profile>(0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::uid(arg0), v0)
    }

    public fun set_profile(arg0: &mut 0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::Party, arg1: &0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::PartyAdminCap, arg2: 0x1::string::String, arg3: 0x1::option::Option<0x1::string::String>, arg4: 0x1::option::Option<0x6fada7a2d6c13805380cdff622298b7fff0c8e16d2ce6c3768bcd3f9a6a5e611::country_code::CountryCode>, arg5: vector<0x69f2d3ee6b5ca1779749b5444d2e42dc7b85a1627d880985fad28f028dd154ea::language_code::LanguageCode>) {
        assert!(!0x1::string::is_empty(&arg2), 0);
        assert!(0x1::string::length(&arg2) <= 300, 1);
        let v0 = &arg3;
        if (0x1::option::is_some<0x1::string::String>(v0)) {
            let v1 = 0x1::option::borrow<0x1::string::String>(v0);
            assert!(!0x1::string::is_empty(v1), 2);
            assert!(0x1::string::length(v1) <= 8192, 3);
        };
        assert!(0x1::vector::length<0x69f2d3ee6b5ca1779749b5444d2e42dc7b85a1627d880985fad28f028dd154ea::language_code::LanguageCode>(&arg5) <= 10, 4);
        let v2 = 0x2::vec_set::empty<0x69f2d3ee6b5ca1779749b5444d2e42dc7b85a1627d880985fad28f028dd154ea::language_code::LanguageCode>();
        let v3 = &arg5;
        let v4 = 0;
        while (v4 < 0x1::vector::length<0x69f2d3ee6b5ca1779749b5444d2e42dc7b85a1627d880985fad28f028dd154ea::language_code::LanguageCode>(v3)) {
            let v5 = 0x1::vector::borrow<0x69f2d3ee6b5ca1779749b5444d2e42dc7b85a1627d880985fad28f028dd154ea::language_code::LanguageCode>(v3, v4);
            assert!(!0x2::vec_set::contains<0x69f2d3ee6b5ca1779749b5444d2e42dc7b85a1627d880985fad28f028dd154ea::language_code::LanguageCode>(&v2, v5), 6);
            0x2::vec_set::insert<0x69f2d3ee6b5ca1779749b5444d2e42dc7b85a1627d880985fad28f028dd154ea::language_code::LanguageCode>(&mut v2, *v5);
            v4 = v4 + 1;
        };
        let v6 = &arg4;
        let v7 = if (0x1::option::is_some<0x6fada7a2d6c13805380cdff622298b7fff0c8e16d2ce6c3768bcd3f9a6a5e611::country_code::CountryCode>(v6)) {
            0x1::option::some<0x1::string::String>(0x6fada7a2d6c13805380cdff622298b7fff0c8e16d2ce6c3768bcd3f9a6a5e611::country_code::code(0x1::option::borrow<0x6fada7a2d6c13805380cdff622298b7fff0c8e16d2ce6c3768bcd3f9a6a5e611::country_code::CountryCode>(v6)))
        } else {
            0x1::option::none<0x1::string::String>()
        };
        let v8 = &arg5;
        let v9 = 0x1::vector::empty<0x1::string::String>();
        let v10 = 0;
        while (v10 < 0x1::vector::length<0x69f2d3ee6b5ca1779749b5444d2e42dc7b85a1627d880985fad28f028dd154ea::language_code::LanguageCode>(v8)) {
            0x1::vector::push_back<0x1::string::String>(&mut v9, 0x69f2d3ee6b5ca1779749b5444d2e42dc7b85a1627d880985fad28f028dd154ea::language_code::code(0x1::vector::borrow<0x69f2d3ee6b5ca1779749b5444d2e42dc7b85a1627d880985fad28f028dd154ea::language_code::LanguageCode>(v8, v10)));
            v10 = v10 + 1;
        };
        let v11 = PartyProfileSetEvent{
            party_id  : 0x2::object::id<0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::Party>(arg0),
            bio_short : arg2,
            bio_long  : arg3,
            country   : v7,
            languages : v9,
        };
        let v12 = Profile{
            bio_short : arg2,
            bio_long  : arg3,
            country   : arg4,
            languages : arg5,
        };
        let v13 = 0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::uid_mut(arg0, arg1);
        let v14 = PartyProfileKey{dummy_field: false};
        if (0x2::dynamic_field::exists<PartyProfileKey>(v13, v14)) {
            let v15 = PartyProfileKey{dummy_field: false};
            let v16 = 0x2::dynamic_field::borrow_mut<PartyProfileKey, Profile>(v13, v15);
            if (v16 == &v12) {
                return
            };
            *v16 = v12;
        } else {
            let v17 = PartyProfileKey{dummy_field: false};
            0x2::dynamic_field::add<PartyProfileKey, Profile>(v13, v17, v12);
        };
        0x2::event::emit<PartyProfileSetEvent>(v11);
    }

    // decompiled from Move bytecode v7
}

