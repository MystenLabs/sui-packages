module 0x330e01ca853460e42bfb49724ab28c39183a8919bd3c9f245b0aa06ca2cc13f9::party_profile {
    struct ProfileKey has copy, drop, store {
        dummy_field: bool,
    }

    struct Profile has drop, store {
        bio_short: 0x1::string::String,
        bio_long: 0x1::option::Option<0x1::string::String>,
        country: 0x1::option::Option<0x6fada7a2d6c13805380cdff622298b7fff0c8e16d2ce6c3768bcd3f9a6a5e611::country_code::CountryCode>,
        languages: vector<0x69f2d3ee6b5ca1779749b5444d2e42dc7b85a1627d880985fad28f028dd154ea::language_code::LanguageCode>,
    }

    struct PartyProfileSetEvent has copy, drop {
        party_id: address,
        admin_cap_id: address,
        had_profile: bool,
        previous_country: 0x1::option::Option<vector<u8>>,
        previous_languages: vector<vector<u8>>,
        country: 0x1::option::Option<vector<u8>>,
        languages: vector<vector<u8>>,
    }

    struct PartyProfileClearedEvent has copy, drop {
        party_id: address,
        admin_cap_id: address,
        previous_country: 0x1::option::Option<vector<u8>>,
        previous_languages: vector<vector<u8>>,
    }

    public fun bio_long(arg0: &Profile) : 0x1::option::Option<0x1::string::String> {
        arg0.bio_long
    }

    public fun bio_short(arg0: &Profile) : 0x1::string::String {
        arg0.bio_short
    }

    public fun clear_profile(arg0: &mut 0x8625400639b03bcb16478721d1d6992a719f230000bfcee426f5c760e082b173::party::Party, arg1: &0x8625400639b03bcb16478721d1d6992a719f230000bfcee426f5c760e082b173::party::PartyAdminCap) {
        let v0 = 0x2::object::id<0x8625400639b03bcb16478721d1d6992a719f230000bfcee426f5c760e082b173::party::Party>(arg0);
        let v1 = 0x2::object::id<0x8625400639b03bcb16478721d1d6992a719f230000bfcee426f5c760e082b173::party::PartyAdminCap>(arg1);
        let v2 = 0x8625400639b03bcb16478721d1d6992a719f230000bfcee426f5c760e082b173::party::uid_mut(arg0, arg1);
        let v3 = ProfileKey{dummy_field: false};
        if (0x2::dynamic_field::exists<ProfileKey>(v2, v3)) {
            let v4 = ProfileKey{dummy_field: false};
            let v5 = 0x2::dynamic_field::remove<ProfileKey, Profile>(v2, v4);
            let v6 = PartyProfileClearedEvent{
                party_id           : 0x2::object::id_to_address(&v0),
                admin_cap_id       : 0x2::object::id_to_address(&v1),
                previous_country   : optional_country_bytes(&v5.country),
                previous_languages : language_bytes(&v5.languages),
            };
            0x2::event::emit<PartyProfileClearedEvent>(v6);
        };
    }

    public fun country(arg0: &Profile) : 0x1::option::Option<0x6fada7a2d6c13805380cdff622298b7fff0c8e16d2ce6c3768bcd3f9a6a5e611::country_code::CountryCode> {
        arg0.country
    }

    public fun has_profile(arg0: &0x8625400639b03bcb16478721d1d6992a719f230000bfcee426f5c760e082b173::party::Party) : bool {
        let v0 = ProfileKey{dummy_field: false};
        0x2::dynamic_field::exists<ProfileKey>(0x8625400639b03bcb16478721d1d6992a719f230000bfcee426f5c760e082b173::party::uid(arg0), v0)
    }

    fun language_bytes(arg0: &vector<0x69f2d3ee6b5ca1779749b5444d2e42dc7b85a1627d880985fad28f028dd154ea::language_code::LanguageCode>) : vector<vector<u8>> {
        let v0 = vector[];
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x69f2d3ee6b5ca1779749b5444d2e42dc7b85a1627d880985fad28f028dd154ea::language_code::LanguageCode>(arg0)) {
            let v2 = 0x69f2d3ee6b5ca1779749b5444d2e42dc7b85a1627d880985fad28f028dd154ea::language_code::code(0x1::vector::borrow<0x69f2d3ee6b5ca1779749b5444d2e42dc7b85a1627d880985fad28f028dd154ea::language_code::LanguageCode>(arg0, v1));
            0x1::vector::push_back<vector<u8>>(&mut v0, *0x1::string::as_bytes(&v2));
            v1 = v1 + 1;
        };
        v0
    }

    public fun languages(arg0: &Profile) : vector<0x69f2d3ee6b5ca1779749b5444d2e42dc7b85a1627d880985fad28f028dd154ea::language_code::LanguageCode> {
        arg0.languages
    }

    fun optional_country_bytes(arg0: &0x1::option::Option<0x6fada7a2d6c13805380cdff622298b7fff0c8e16d2ce6c3768bcd3f9a6a5e611::country_code::CountryCode>) : 0x1::option::Option<vector<u8>> {
        let v0 = 0x1::option::none<vector<u8>>();
        if (0x1::option::is_some<0x6fada7a2d6c13805380cdff622298b7fff0c8e16d2ce6c3768bcd3f9a6a5e611::country_code::CountryCode>(arg0)) {
            let v1 = 0x6fada7a2d6c13805380cdff622298b7fff0c8e16d2ce6c3768bcd3f9a6a5e611::country_code::code(0x1::option::borrow<0x6fada7a2d6c13805380cdff622298b7fff0c8e16d2ce6c3768bcd3f9a6a5e611::country_code::CountryCode>(arg0));
            0x1::option::fill<vector<u8>>(&mut v0, *0x1::string::as_bytes(&v1));
        };
        v0
    }

    public fun profile(arg0: &0x8625400639b03bcb16478721d1d6992a719f230000bfcee426f5c760e082b173::party::Party) : &Profile {
        let v0 = ProfileKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists<ProfileKey>(0x8625400639b03bcb16478721d1d6992a719f230000bfcee426f5c760e082b173::party::uid(arg0), v0), 5);
        let v1 = ProfileKey{dummy_field: false};
        0x2::dynamic_field::borrow<ProfileKey, Profile>(0x8625400639b03bcb16478721d1d6992a719f230000bfcee426f5c760e082b173::party::uid(arg0), v1)
    }

    public fun set_profile(arg0: &mut 0x8625400639b03bcb16478721d1d6992a719f230000bfcee426f5c760e082b173::party::Party, arg1: &0x8625400639b03bcb16478721d1d6992a719f230000bfcee426f5c760e082b173::party::PartyAdminCap, arg2: 0x1::string::String, arg3: 0x1::option::Option<0x1::string::String>, arg4: 0x1::option::Option<0x6fada7a2d6c13805380cdff622298b7fff0c8e16d2ce6c3768bcd3f9a6a5e611::country_code::CountryCode>, arg5: vector<0x69f2d3ee6b5ca1779749b5444d2e42dc7b85a1627d880985fad28f028dd154ea::language_code::LanguageCode>) {
        validate_bio_short(&arg2);
        let v0 = &arg3;
        if (0x1::option::is_some<0x1::string::String>(v0)) {
            let v1 = 0x1::option::borrow<0x1::string::String>(v0);
            assert!(!0x1::string::is_empty(v1), 2);
            assert!(0x1::string::length(v1) <= 8192, 3);
        };
        validate_languages(&arg5);
        let v2 = 0x2::object::id<0x8625400639b03bcb16478721d1d6992a719f230000bfcee426f5c760e082b173::party::Party>(arg0);
        let v3 = 0x2::object::id<0x8625400639b03bcb16478721d1d6992a719f230000bfcee426f5c760e082b173::party::PartyAdminCap>(arg1);
        let v4 = Profile{
            bio_short : arg2,
            bio_long  : arg3,
            country   : arg4,
            languages : arg5,
        };
        let v5 = 0x8625400639b03bcb16478721d1d6992a719f230000bfcee426f5c760e082b173::party::uid_mut(arg0, arg1);
        let v6 = ProfileKey{dummy_field: false};
        let v7 = 0x2::dynamic_field::exists<ProfileKey>(v5, v6);
        let v8 = if (v7) {
            let v9 = ProfileKey{dummy_field: false};
            optional_country_bytes(&0x2::dynamic_field::borrow<ProfileKey, Profile>(v5, v9).country)
        } else {
            0x1::option::none<vector<u8>>()
        };
        let v10 = if (v7) {
            let v11 = ProfileKey{dummy_field: false};
            language_bytes(&0x2::dynamic_field::borrow<ProfileKey, Profile>(v5, v11).languages)
        } else {
            vector[]
        };
        let v12 = if (!v7) {
            true
        } else {
            let v13 = ProfileKey{dummy_field: false};
            0x2::dynamic_field::borrow<ProfileKey, Profile>(v5, v13) != &v4
        };
        if (v7) {
            let v14 = ProfileKey{dummy_field: false};
            *0x2::dynamic_field::borrow_mut<ProfileKey, Profile>(v5, v14) = v4;
        } else {
            let v15 = ProfileKey{dummy_field: false};
            0x2::dynamic_field::add<ProfileKey, Profile>(v5, v15, v4);
        };
        if (v12) {
            let v16 = PartyProfileSetEvent{
                party_id           : 0x2::object::id_to_address(&v2),
                admin_cap_id       : 0x2::object::id_to_address(&v3),
                had_profile        : v7,
                previous_country   : v8,
                previous_languages : v10,
                country            : optional_country_bytes(&v4.country),
                languages          : language_bytes(&v4.languages),
            };
            0x2::event::emit<PartyProfileSetEvent>(v16);
        };
    }

    fun validate_bio_short(arg0: &0x1::string::String) {
        assert!(!0x1::string::is_empty(arg0), 0);
        assert!(0x1::string::length(arg0) <= 300, 1);
    }

    fun validate_languages(arg0: &vector<0x69f2d3ee6b5ca1779749b5444d2e42dc7b85a1627d880985fad28f028dd154ea::language_code::LanguageCode>) {
        assert!(0x1::vector::length<0x69f2d3ee6b5ca1779749b5444d2e42dc7b85a1627d880985fad28f028dd154ea::language_code::LanguageCode>(arg0) <= 10, 4);
        let v0 = 0x2::vec_set::empty<0x69f2d3ee6b5ca1779749b5444d2e42dc7b85a1627d880985fad28f028dd154ea::language_code::LanguageCode>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x69f2d3ee6b5ca1779749b5444d2e42dc7b85a1627d880985fad28f028dd154ea::language_code::LanguageCode>(arg0)) {
            let v2 = 0x1::vector::borrow<0x69f2d3ee6b5ca1779749b5444d2e42dc7b85a1627d880985fad28f028dd154ea::language_code::LanguageCode>(arg0, v1);
            assert!(!0x2::vec_set::contains<0x69f2d3ee6b5ca1779749b5444d2e42dc7b85a1627d880985fad28f028dd154ea::language_code::LanguageCode>(&v0, v2), 6);
            0x2::vec_set::insert<0x69f2d3ee6b5ca1779749b5444d2e42dc7b85a1627d880985fad28f028dd154ea::language_code::LanguageCode>(&mut v0, *v2);
            v1 = v1 + 1;
        };
    }

    // decompiled from Move bytecode v7
}

