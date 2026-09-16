module 0x7960e75b049b2ef2c079d50e7b423ada405e4e7bcd7ad9e632c08adf238ca207::recording_credits {
    struct ExtensionKey has copy, drop, store {
        dummy_field: bool,
    }

    struct RecordingCredits has store {
        credits: 0x2::vec_map::VecMap<0x2::object::ID, 0x63f2fb16fffa0f09ce7525ccd4d1331710b82aae194338ff49fd15f389016ebf::credit::Credit<0x7960e75b049b2ef2c079d50e7b423ada405e4e7bcd7ad9e632c08adf238ca207::recording_party_role::RecordingPartyRole>>,
        primary_artist_ids: 0x2::vec_set::VecSet<0x2::object::ID>,
        featured_artist_ids: 0x2::vec_set::VecSet<0x2::object::ID>,
    }

    struct CreditAddedEvent<phantom T0, phantom T1> has copy, drop {
        recording_id: address,
        composition_id: address,
        admin_cap_id: address,
        party_id: address,
        role_kinds: vector<u8>,
        role_levels: vector<u8>,
        credit_index: u64,
        credit_count_before: u64,
        credit_count_after: u64,
        credits_initialized: bool,
    }

    struct CreditRemovedEvent<phantom T0, phantom T1> has copy, drop {
        recording_id: address,
        composition_id: address,
        admin_cap_id: address,
        party_id: address,
        role_kinds: vector<u8>,
        role_levels: vector<u8>,
        credit_index: u64,
        credit_count_before: u64,
        credit_count_after: u64,
        was_primary_artist: bool,
        was_featured_artist: bool,
    }

    struct PrimaryArtistAddedEvent<phantom T0, phantom T1> has copy, drop {
        recording_id: address,
        composition_id: address,
        admin_cap_id: address,
        party_id: address,
        primary_artist_index: u64,
        primary_artist_count_before: u64,
        primary_artist_count_after: u64,
        credit_count_after: u64,
    }

    struct PrimaryArtistRemovedEvent<phantom T0, phantom T1> has copy, drop {
        recording_id: address,
        composition_id: address,
        admin_cap_id: address,
        party_id: address,
        primary_artist_index: u64,
        primary_artist_count_before: u64,
        primary_artist_count_after: u64,
        credit_count_after: u64,
        caused_by_credit_removal: bool,
    }

    struct FeaturedArtistAddedEvent<phantom T0, phantom T1> has copy, drop {
        recording_id: address,
        composition_id: address,
        admin_cap_id: address,
        party_id: address,
        featured_artist_index: u64,
        featured_artist_count_before: u64,
        featured_artist_count_after: u64,
        credit_count_after: u64,
    }

    struct FeaturedArtistRemovedEvent<phantom T0, phantom T1> has copy, drop {
        recording_id: address,
        composition_id: address,
        admin_cap_id: address,
        party_id: address,
        featured_artist_index: u64,
        featured_artist_count_before: u64,
        featured_artist_count_after: u64,
        credit_count_after: u64,
        caused_by_credit_removal: bool,
    }

    fun borrow(arg0: &0x2::object::UID) : &RecordingCredits {
        let v0 = ExtensionKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists<ExtensionKey>(arg0, v0), 50);
        let v1 = ExtensionKey{dummy_field: false};
        0x2::dynamic_field::borrow<ExtensionKey, RecordingCredits>(arg0, v1)
    }

    fun borrow_mut(arg0: &mut 0x2::object::UID) : &mut RecordingCredits {
        let v0 = ExtensionKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists<ExtensionKey>(arg0, v0), 50);
        let v1 = ExtensionKey{dummy_field: false};
        0x2::dynamic_field::borrow_mut<ExtensionKey, RecordingCredits>(arg0, v1)
    }

    public fun add_credit<T0, T1>(arg0: &mut 0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::Recording<T0, T1>, arg1: &0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::RecordingAdminCap<T0>, arg2: &0x8625400639b03bcb16478721d1d6992a719f230000bfcee426f5c760e082b173::party::Party, arg3: 0x63f2fb16fffa0f09ce7525ccd4d1331710b82aae194338ff49fd15f389016ebf::credit::Credit<0x7960e75b049b2ef2c079d50e7b423ada405e4e7bcd7ad9e632c08adf238ca207::recording_party_role::RecordingPartyRole>) {
        assert!(0x1::vector::length<0x7960e75b049b2ef2c079d50e7b423ada405e4e7bcd7ad9e632c08adf238ca207::recording_party_role::RecordingPartyRole>(0x63f2fb16fffa0f09ce7525ccd4d1331710b82aae194338ff49fd15f389016ebf::credit::roles<0x7960e75b049b2ef2c079d50e7b423ada405e4e7bcd7ad9e632c08adf238ca207::recording_party_role::RecordingPartyRole>(&arg3)) <= 10, 30);
        let v0 = 0x2::object::id<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::Recording<T0, T1>>(arg0);
        let v1 = 0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::composition_id<T0, T1>(arg0);
        let v2 = 0x2::object::id<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::RecordingAdminCap<T0>>(arg1);
        let v3 = 0x2::object::id<0x8625400639b03bcb16478721d1d6992a719f230000bfcee426f5c760e082b173::party::Party>(arg2);
        let v4 = 0x2::object::id<0x8625400639b03bcb16478721d1d6992a719f230000bfcee426f5c760e082b173::party::Party>(arg2);
        let v5 = 0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::uid_mut<T0, T1>(arg0, arg1);
        let v6 = ExtensionKey{dummy_field: false};
        let v7 = 0x2::dynamic_field::exists<ExtensionKey>(v5, v6);
        let (v8, v9) = snapshot_credit(&arg3);
        let v10 = borrow_mut_or_init(v5);
        let v11 = 0x2::vec_map::length<0x2::object::ID, 0x63f2fb16fffa0f09ce7525ccd4d1331710b82aae194338ff49fd15f389016ebf::credit::Credit<0x7960e75b049b2ef2c079d50e7b423ada405e4e7bcd7ad9e632c08adf238ca207::recording_party_role::RecordingPartyRole>>(&v10.credits);
        assert!(v11 < 150, 32);
        assert!(!0x2::vec_map::contains<0x2::object::ID, 0x63f2fb16fffa0f09ce7525ccd4d1331710b82aae194338ff49fd15f389016ebf::credit::Credit<0x7960e75b049b2ef2c079d50e7b423ada405e4e7bcd7ad9e632c08adf238ca207::recording_party_role::RecordingPartyRole>>(&v10.credits, &v4), 40);
        0x2::vec_map::insert<0x2::object::ID, 0x63f2fb16fffa0f09ce7525ccd4d1331710b82aae194338ff49fd15f389016ebf::credit::Credit<0x7960e75b049b2ef2c079d50e7b423ada405e4e7bcd7ad9e632c08adf238ca207::recording_party_role::RecordingPartyRole>>(&mut v10.credits, v4, arg3);
        let v12 = CreditAddedEvent<T0, T1>{
            recording_id        : 0x2::object::id_to_address(&v0),
            composition_id      : 0x2::object::id_to_address(&v1),
            admin_cap_id        : 0x2::object::id_to_address(&v2),
            party_id            : 0x2::object::id_to_address(&v3),
            role_kinds          : v8,
            role_levels         : v9,
            credit_index        : 0x2::vec_map::get_idx<0x2::object::ID, 0x63f2fb16fffa0f09ce7525ccd4d1331710b82aae194338ff49fd15f389016ebf::credit::Credit<0x7960e75b049b2ef2c079d50e7b423ada405e4e7bcd7ad9e632c08adf238ca207::recording_party_role::RecordingPartyRole>>(&v10.credits, &v4),
            credit_count_before : v11,
            credit_count_after  : 0x2::vec_map::length<0x2::object::ID, 0x63f2fb16fffa0f09ce7525ccd4d1331710b82aae194338ff49fd15f389016ebf::credit::Credit<0x7960e75b049b2ef2c079d50e7b423ada405e4e7bcd7ad9e632c08adf238ca207::recording_party_role::RecordingPartyRole>>(&v10.credits),
            credits_initialized : !v7,
        };
        0x2::event::emit<CreditAddedEvent<T0, T1>>(v12);
    }

    public fun add_featured_artist<T0, T1>(arg0: &mut 0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::Recording<T0, T1>, arg1: &0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::RecordingAdminCap<T0>, arg2: &0x8625400639b03bcb16478721d1d6992a719f230000bfcee426f5c760e082b173::party::Party) {
        let v0 = 0x2::object::id<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::Recording<T0, T1>>(arg0);
        let v1 = 0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::composition_id<T0, T1>(arg0);
        let v2 = 0x2::object::id<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::RecordingAdminCap<T0>>(arg1);
        let v3 = 0x2::object::id<0x8625400639b03bcb16478721d1d6992a719f230000bfcee426f5c760e082b173::party::Party>(arg2);
        let v4 = 0x2::object::id<0x8625400639b03bcb16478721d1d6992a719f230000bfcee426f5c760e082b173::party::Party>(arg2);
        let v5 = 0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::uid_mut<T0, T1>(arg0, arg1);
        let v6 = borrow_mut(v5);
        let v7 = 0x2::vec_set::length<0x2::object::ID>(&v6.featured_artist_ids);
        assert!(v7 < 50, 35);
        assert!(0x2::vec_map::contains<0x2::object::ID, 0x63f2fb16fffa0f09ce7525ccd4d1331710b82aae194338ff49fd15f389016ebf::credit::Credit<0x7960e75b049b2ef2c079d50e7b423ada405e4e7bcd7ad9e632c08adf238ca207::recording_party_role::RecordingPartyRole>>(&v6.credits, &v4), 52);
        assert!(!0x2::vec_set::contains<0x2::object::ID>(&v6.primary_artist_ids, &v4), 41);
        assert!(!0x2::vec_set::contains<0x2::object::ID>(&v6.featured_artist_ids, &v4), 42);
        0x2::vec_set::insert<0x2::object::ID>(&mut v6.featured_artist_ids, v4);
        let v8 = FeaturedArtistAddedEvent<T0, T1>{
            recording_id                 : 0x2::object::id_to_address(&v0),
            composition_id               : 0x2::object::id_to_address(&v1),
            admin_cap_id                 : 0x2::object::id_to_address(&v2),
            party_id                     : 0x2::object::id_to_address(&v3),
            featured_artist_index        : set_index(&v6.featured_artist_ids, &v4),
            featured_artist_count_before : v7,
            featured_artist_count_after  : 0x2::vec_set::length<0x2::object::ID>(&v6.featured_artist_ids),
            credit_count_after           : 0x2::vec_map::length<0x2::object::ID, 0x63f2fb16fffa0f09ce7525ccd4d1331710b82aae194338ff49fd15f389016ebf::credit::Credit<0x7960e75b049b2ef2c079d50e7b423ada405e4e7bcd7ad9e632c08adf238ca207::recording_party_role::RecordingPartyRole>>(&v6.credits),
        };
        0x2::event::emit<FeaturedArtistAddedEvent<T0, T1>>(v8);
    }

    public fun add_primary_artist<T0, T1>(arg0: &mut 0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::Recording<T0, T1>, arg1: &0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::RecordingAdminCap<T0>, arg2: &0x8625400639b03bcb16478721d1d6992a719f230000bfcee426f5c760e082b173::party::Party) {
        let v0 = 0x2::object::id<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::Recording<T0, T1>>(arg0);
        let v1 = 0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::composition_id<T0, T1>(arg0);
        let v2 = 0x2::object::id<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::RecordingAdminCap<T0>>(arg1);
        let v3 = 0x2::object::id<0x8625400639b03bcb16478721d1d6992a719f230000bfcee426f5c760e082b173::party::Party>(arg2);
        let v4 = 0x2::object::id<0x8625400639b03bcb16478721d1d6992a719f230000bfcee426f5c760e082b173::party::Party>(arg2);
        let v5 = 0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::uid_mut<T0, T1>(arg0, arg1);
        let v6 = borrow_mut(v5);
        let v7 = 0x2::vec_set::length<0x2::object::ID>(&v6.primary_artist_ids);
        assert!(v7 < 20, 34);
        assert!(0x2::vec_map::contains<0x2::object::ID, 0x63f2fb16fffa0f09ce7525ccd4d1331710b82aae194338ff49fd15f389016ebf::credit::Credit<0x7960e75b049b2ef2c079d50e7b423ada405e4e7bcd7ad9e632c08adf238ca207::recording_party_role::RecordingPartyRole>>(&v6.credits, &v4), 52);
        assert!(!0x2::vec_set::contains<0x2::object::ID>(&v6.featured_artist_ids, &v4), 42);
        assert!(!0x2::vec_set::contains<0x2::object::ID>(&v6.primary_artist_ids, &v4), 41);
        0x2::vec_set::insert<0x2::object::ID>(&mut v6.primary_artist_ids, v4);
        let v8 = PrimaryArtistAddedEvent<T0, T1>{
            recording_id                : 0x2::object::id_to_address(&v0),
            composition_id              : 0x2::object::id_to_address(&v1),
            admin_cap_id                : 0x2::object::id_to_address(&v2),
            party_id                    : 0x2::object::id_to_address(&v3),
            primary_artist_index        : set_index(&v6.primary_artist_ids, &v4),
            primary_artist_count_before : v7,
            primary_artist_count_after  : 0x2::vec_set::length<0x2::object::ID>(&v6.primary_artist_ids),
            credit_count_after          : 0x2::vec_map::length<0x2::object::ID, 0x63f2fb16fffa0f09ce7525ccd4d1331710b82aae194338ff49fd15f389016ebf::credit::Credit<0x7960e75b049b2ef2c079d50e7b423ada405e4e7bcd7ad9e632c08adf238ca207::recording_party_role::RecordingPartyRole>>(&v6.credits),
        };
        0x2::event::emit<PrimaryArtistAddedEvent<T0, T1>>(v8);
    }

    fun borrow_mut_or_init(arg0: &mut 0x2::object::UID) : &mut RecordingCredits {
        let v0 = ExtensionKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<ExtensionKey>(arg0, v0)) {
            let v1 = ExtensionKey{dummy_field: false};
            let v2 = RecordingCredits{
                credits             : 0x2::vec_map::empty<0x2::object::ID, 0x63f2fb16fffa0f09ce7525ccd4d1331710b82aae194338ff49fd15f389016ebf::credit::Credit<0x7960e75b049b2ef2c079d50e7b423ada405e4e7bcd7ad9e632c08adf238ca207::recording_party_role::RecordingPartyRole>>(),
                primary_artist_ids  : 0x2::vec_set::empty<0x2::object::ID>(),
                featured_artist_ids : 0x2::vec_set::empty<0x2::object::ID>(),
            };
            0x2::dynamic_field::add<ExtensionKey, RecordingCredits>(arg0, v1, v2);
        };
        let v3 = ExtensionKey{dummy_field: false};
        0x2::dynamic_field::borrow_mut<ExtensionKey, RecordingCredits>(arg0, v3)
    }

    public fun credits<T0, T1>(arg0: &0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::Recording<T0, T1>) : &0x2::vec_map::VecMap<0x2::object::ID, 0x63f2fb16fffa0f09ce7525ccd4d1331710b82aae194338ff49fd15f389016ebf::credit::Credit<0x7960e75b049b2ef2c079d50e7b423ada405e4e7bcd7ad9e632c08adf238ca207::recording_party_role::RecordingPartyRole>> {
        &borrow(0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::uid<T0, T1>(arg0)).credits
    }

    public fun featured_artist_ids<T0, T1>(arg0: &0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::Recording<T0, T1>) : &0x2::vec_set::VecSet<0x2::object::ID> {
        &borrow(0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::uid<T0, T1>(arg0)).featured_artist_ids
    }

    public fun has_credits<T0, T1>(arg0: &0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::Recording<T0, T1>) : bool {
        let v0 = ExtensionKey{dummy_field: false};
        0x2::dynamic_field::exists<ExtensionKey>(0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::uid<T0, T1>(arg0), v0)
    }

    public fun is_featured_artist<T0, T1>(arg0: &0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::Recording<T0, T1>, arg1: 0x2::object::ID) : bool {
        has_credits<T0, T1>(arg0) && 0x2::vec_set::contains<0x2::object::ID>(&borrow(0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::uid<T0, T1>(arg0)).featured_artist_ids, &arg1)
    }

    public fun is_primary_artist<T0, T1>(arg0: &0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::Recording<T0, T1>, arg1: 0x2::object::ID) : bool {
        has_credits<T0, T1>(arg0) && 0x2::vec_set::contains<0x2::object::ID>(&borrow(0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::uid<T0, T1>(arg0)).primary_artist_ids, &arg1)
    }

    public fun primary_artist_ids<T0, T1>(arg0: &0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::Recording<T0, T1>) : &0x2::vec_set::VecSet<0x2::object::ID> {
        &borrow(0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::uid<T0, T1>(arg0)).primary_artist_ids
    }

    public fun remove_credit<T0, T1>(arg0: &mut 0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::Recording<T0, T1>, arg1: &0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::RecordingAdminCap<T0>, arg2: 0x2::object::ID) {
        let v0 = 0x2::object::id<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::Recording<T0, T1>>(arg0);
        let v1 = 0x2::object::id_to_address(&v0);
        let v2 = 0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::composition_id<T0, T1>(arg0);
        let v3 = 0x2::object::id_to_address(&v2);
        let v4 = 0x2::object::id<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::RecordingAdminCap<T0>>(arg1);
        let v5 = 0x2::object::id_to_address(&v4);
        let v6 = 0x2::object::id_to_address(&arg2);
        let v7 = 0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::uid_mut<T0, T1>(arg0, arg1);
        let v8 = borrow_mut(v7);
        assert!(0x2::vec_map::contains<0x2::object::ID, 0x63f2fb16fffa0f09ce7525ccd4d1331710b82aae194338ff49fd15f389016ebf::credit::Credit<0x7960e75b049b2ef2c079d50e7b423ada405e4e7bcd7ad9e632c08adf238ca207::recording_party_role::RecordingPartyRole>>(&v8.credits, &arg2), 52);
        let v9 = 0x2::vec_set::contains<0x2::object::ID>(&v8.primary_artist_ids, &arg2);
        let v10 = 0x2::vec_set::contains<0x2::object::ID>(&v8.featured_artist_ids, &arg2);
        let (_, v12) = 0x2::vec_map::remove<0x2::object::ID, 0x63f2fb16fffa0f09ce7525ccd4d1331710b82aae194338ff49fd15f389016ebf::credit::Credit<0x7960e75b049b2ef2c079d50e7b423ada405e4e7bcd7ad9e632c08adf238ca207::recording_party_role::RecordingPartyRole>>(&mut v8.credits, &arg2);
        let v13 = v12;
        let (v14, v15) = snapshot_credit(&v13);
        let v16 = CreditRemovedEvent<T0, T1>{
            recording_id        : v1,
            composition_id      : v3,
            admin_cap_id        : v5,
            party_id            : v6,
            role_kinds          : v14,
            role_levels         : v15,
            credit_index        : 0x2::vec_map::get_idx<0x2::object::ID, 0x63f2fb16fffa0f09ce7525ccd4d1331710b82aae194338ff49fd15f389016ebf::credit::Credit<0x7960e75b049b2ef2c079d50e7b423ada405e4e7bcd7ad9e632c08adf238ca207::recording_party_role::RecordingPartyRole>>(&v8.credits, &arg2),
            credit_count_before : 0x2::vec_map::length<0x2::object::ID, 0x63f2fb16fffa0f09ce7525ccd4d1331710b82aae194338ff49fd15f389016ebf::credit::Credit<0x7960e75b049b2ef2c079d50e7b423ada405e4e7bcd7ad9e632c08adf238ca207::recording_party_role::RecordingPartyRole>>(&v8.credits),
            credit_count_after  : 0x2::vec_map::length<0x2::object::ID, 0x63f2fb16fffa0f09ce7525ccd4d1331710b82aae194338ff49fd15f389016ebf::credit::Credit<0x7960e75b049b2ef2c079d50e7b423ada405e4e7bcd7ad9e632c08adf238ca207::recording_party_role::RecordingPartyRole>>(&v8.credits),
            was_primary_artist  : v9,
            was_featured_artist : v10,
        };
        0x2::event::emit<CreditRemovedEvent<T0, T1>>(v16);
        if (v9) {
            let v17 = borrow_mut(v7);
            0x2::vec_set::remove<0x2::object::ID>(&mut v17.primary_artist_ids, &arg2);
            let v18 = PrimaryArtistRemovedEvent<T0, T1>{
                recording_id                : v1,
                composition_id              : v3,
                admin_cap_id                : v5,
                party_id                    : v6,
                primary_artist_index        : set_index(&v17.primary_artist_ids, &arg2),
                primary_artist_count_before : 0x2::vec_set::length<0x2::object::ID>(&v17.primary_artist_ids),
                primary_artist_count_after  : 0x2::vec_set::length<0x2::object::ID>(&v17.primary_artist_ids),
                credit_count_after          : 0x2::vec_map::length<0x2::object::ID, 0x63f2fb16fffa0f09ce7525ccd4d1331710b82aae194338ff49fd15f389016ebf::credit::Credit<0x7960e75b049b2ef2c079d50e7b423ada405e4e7bcd7ad9e632c08adf238ca207::recording_party_role::RecordingPartyRole>>(&v17.credits),
                caused_by_credit_removal    : true,
            };
            0x2::event::emit<PrimaryArtistRemovedEvent<T0, T1>>(v18);
        };
        if (v10) {
            let v19 = borrow_mut(v7);
            0x2::vec_set::remove<0x2::object::ID>(&mut v19.featured_artist_ids, &arg2);
            let v20 = FeaturedArtistRemovedEvent<T0, T1>{
                recording_id                 : v1,
                composition_id               : v3,
                admin_cap_id                 : v5,
                party_id                     : v6,
                featured_artist_index        : set_index(&v19.featured_artist_ids, &arg2),
                featured_artist_count_before : 0x2::vec_set::length<0x2::object::ID>(&v19.featured_artist_ids),
                featured_artist_count_after  : 0x2::vec_set::length<0x2::object::ID>(&v19.featured_artist_ids),
                credit_count_after           : 0x2::vec_map::length<0x2::object::ID, 0x63f2fb16fffa0f09ce7525ccd4d1331710b82aae194338ff49fd15f389016ebf::credit::Credit<0x7960e75b049b2ef2c079d50e7b423ada405e4e7bcd7ad9e632c08adf238ca207::recording_party_role::RecordingPartyRole>>(&v19.credits),
                caused_by_credit_removal     : true,
            };
            0x2::event::emit<FeaturedArtistRemovedEvent<T0, T1>>(v20);
        };
    }

    public fun remove_featured_artist<T0, T1>(arg0: &mut 0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::Recording<T0, T1>, arg1: &0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::RecordingAdminCap<T0>, arg2: 0x2::object::ID) {
        let v0 = 0x2::object::id<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::Recording<T0, T1>>(arg0);
        let v1 = 0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::composition_id<T0, T1>(arg0);
        let v2 = 0x2::object::id<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::RecordingAdminCap<T0>>(arg1);
        let v3 = 0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::uid_mut<T0, T1>(arg0, arg1);
        let v4 = borrow_mut(v3);
        assert!(0x2::vec_set::contains<0x2::object::ID>(&v4.featured_artist_ids, &arg2), 52);
        0x2::vec_set::remove<0x2::object::ID>(&mut v4.featured_artist_ids, &arg2);
        let v5 = FeaturedArtistRemovedEvent<T0, T1>{
            recording_id                 : 0x2::object::id_to_address(&v0),
            composition_id               : 0x2::object::id_to_address(&v1),
            admin_cap_id                 : 0x2::object::id_to_address(&v2),
            party_id                     : 0x2::object::id_to_address(&arg2),
            featured_artist_index        : set_index(&v4.featured_artist_ids, &arg2),
            featured_artist_count_before : 0x2::vec_set::length<0x2::object::ID>(&v4.featured_artist_ids),
            featured_artist_count_after  : 0x2::vec_set::length<0x2::object::ID>(&v4.featured_artist_ids),
            credit_count_after           : 0x2::vec_map::length<0x2::object::ID, 0x63f2fb16fffa0f09ce7525ccd4d1331710b82aae194338ff49fd15f389016ebf::credit::Credit<0x7960e75b049b2ef2c079d50e7b423ada405e4e7bcd7ad9e632c08adf238ca207::recording_party_role::RecordingPartyRole>>(&v4.credits),
            caused_by_credit_removal     : false,
        };
        0x2::event::emit<FeaturedArtistRemovedEvent<T0, T1>>(v5);
    }

    public fun remove_primary_artist<T0, T1>(arg0: &mut 0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::Recording<T0, T1>, arg1: &0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::RecordingAdminCap<T0>, arg2: 0x2::object::ID) {
        let v0 = 0x2::object::id<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::Recording<T0, T1>>(arg0);
        let v1 = 0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::composition_id<T0, T1>(arg0);
        let v2 = 0x2::object::id<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::RecordingAdminCap<T0>>(arg1);
        let v3 = 0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::uid_mut<T0, T1>(arg0, arg1);
        let v4 = borrow_mut(v3);
        assert!(0x2::vec_set::contains<0x2::object::ID>(&v4.primary_artist_ids, &arg2), 52);
        0x2::vec_set::remove<0x2::object::ID>(&mut v4.primary_artist_ids, &arg2);
        let v5 = PrimaryArtistRemovedEvent<T0, T1>{
            recording_id                : 0x2::object::id_to_address(&v0),
            composition_id              : 0x2::object::id_to_address(&v1),
            admin_cap_id                : 0x2::object::id_to_address(&v2),
            party_id                    : 0x2::object::id_to_address(&arg2),
            primary_artist_index        : set_index(&v4.primary_artist_ids, &arg2),
            primary_artist_count_before : 0x2::vec_set::length<0x2::object::ID>(&v4.primary_artist_ids),
            primary_artist_count_after  : 0x2::vec_set::length<0x2::object::ID>(&v4.primary_artist_ids),
            credit_count_after          : 0x2::vec_map::length<0x2::object::ID, 0x63f2fb16fffa0f09ce7525ccd4d1331710b82aae194338ff49fd15f389016ebf::credit::Credit<0x7960e75b049b2ef2c079d50e7b423ada405e4e7bcd7ad9e632c08adf238ca207::recording_party_role::RecordingPartyRole>>(&v4.credits),
            caused_by_credit_removal    : false,
        };
        0x2::event::emit<PrimaryArtistRemovedEvent<T0, T1>>(v5);
    }

    fun set_index(arg0: &0x2::vec_set::VecSet<0x2::object::ID>, arg1: &0x2::object::ID) : u64 {
        let (_, v1) = 0x1::vector::index_of<0x2::object::ID>(0x2::vec_set::keys<0x2::object::ID>(arg0), arg1);
        v1
    }

    fun snapshot_credit(arg0: &0x63f2fb16fffa0f09ce7525ccd4d1331710b82aae194338ff49fd15f389016ebf::credit::Credit<0x7960e75b049b2ef2c079d50e7b423ada405e4e7bcd7ad9e632c08adf238ca207::recording_party_role::RecordingPartyRole>) : (vector<u8>, vector<u8>) {
        let v0 = b"";
        let v1 = b"";
        let v2 = 0x63f2fb16fffa0f09ce7525ccd4d1331710b82aae194338ff49fd15f389016ebf::credit::roles<0x7960e75b049b2ef2c079d50e7b423ada405e4e7bcd7ad9e632c08adf238ca207::recording_party_role::RecordingPartyRole>(arg0);
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x7960e75b049b2ef2c079d50e7b423ada405e4e7bcd7ad9e632c08adf238ca207::recording_party_role::RecordingPartyRole>(v2)) {
            let (v4, _, _, v7) = 0x7960e75b049b2ef2c079d50e7b423ada405e4e7bcd7ad9e632c08adf238ca207::recording_party_role::event_fields(0x1::vector::borrow<0x7960e75b049b2ef2c079d50e7b423ada405e4e7bcd7ad9e632c08adf238ca207::recording_party_role::RecordingPartyRole>(v2, v3));
            0x1::vector::push_back<u8>(&mut v0, v4);
            0x1::vector::push_back<u8>(&mut v1, v7);
            v3 = v3 + 1;
        };
        (v0, v1)
    }

    // decompiled from Move bytecode v7
}

