module 0x2d300f3d8819c6e09fd1558e518c2ffab97b324479843d4f94b561b10a441fd0::creation_policy {
    struct CreationPolicy has key {
        id: 0x2::object::UID,
        allowed_quotes: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
        allowed_migration_witnesses: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
    }

    struct PartnerKey has copy, drop, store {
        pos0: 0x2::object::ID,
    }

    struct QuoteSet has copy, drop {
        quote: 0x1::type_name::TypeName,
        allowed: bool,
    }

    struct MigrationWitnessSet has copy, drop {
        migration_witness: 0x1::type_name::TypeName,
        allowed: bool,
    }

    struct PartnerAdded has copy, drop {
        partner_id: 0x2::object::ID,
    }

    struct PartnerRemoved has copy, drop {
        partner_id: 0x2::object::ID,
        accepted_until_ms: u64,
    }

    fun new(arg0: &mut 0x2::tx_context::TxContext) : CreationPolicy {
        CreationPolicy{
            id                          : 0x2::object::new(arg0),
            allowed_quotes              : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
            allowed_migration_witnesses : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
        }
    }

    public fun add_partner(arg0: &mut CreationPolicy, arg1: &0x726fb49b880faa89719b95c6ef3a91be794f771ed3560fe5894d0a605c8469f9::blast_acl::AdminWitness<0x2d300f3d8819c6e09fd1558e518c2ffab97b324479843d4f94b561b10a441fd0::blast_presale_domain::FeeAdmin>, arg2: &0x96fbe2db7337dea5ef6926203d32cf602e527d5e2dcae176fbbc3e3d2a30d94f::blast_partners::Partner) {
        let v0 = 0x2::object::id<0x96fbe2db7337dea5ef6926203d32cf602e527d5e2dcae176fbbc3e3d2a30d94f::blast_partners::Partner>(arg2);
        let v1 = PartnerKey{pos0: v0};
        if (0x2::dynamic_field::exists<PartnerKey>(&arg0.id, v1)) {
            let v2 = 0x2::dynamic_field::borrow_mut<PartnerKey, u64>(&mut arg0.id, v1);
            assert!(*v2 != 18446744073709551615, 13835058424649351169);
            *v2 = 18446744073709551615;
        } else {
            0x2::dynamic_field::add<PartnerKey, u64>(&mut arg0.id, v1, 18446744073709551615);
        };
        let v3 = PartnerAdded{partner_id: v0};
        0x2::event::emit<PartnerAdded>(v3);
    }

    public(friend) fun assert_allowed<T0, T1>(arg0: &CreationPolicy) {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.allowed_quotes, &v0), 13835340054245015555);
        let v1 = 0x1::type_name::with_original_ids<T1>();
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.allowed_migration_witnesses, &v1), 13835621554991661061);
    }

    public(friend) fun assert_partner(arg0: &CreationPolicy, arg1: 0x2::object::ID, arg2: u64) {
        let v0 = PartnerKey{pos0: arg1};
        assert!(0x2::dynamic_field::exists<PartnerKey>(&arg0.id, v0), 13836184539305082889);
        assert!(arg2 < *0x2::dynamic_field::borrow<PartnerKey, u64>(&arg0.id, v0), 13836184547895017481);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<CreationPolicy>(new(arg0));
    }

    fun is_constructible_by_anyone<T0>() : bool {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        if (0x1::type_name::is_primitive(&v0)) {
            return true
        };
        let v1 = 0x1::type_name::original_id<T0>();
        v1 == @0x1 || v1 == @0x2
    }

    public fun remove_partner(arg0: &mut CreationPolicy, arg1: &0x726fb49b880faa89719b95c6ef3a91be794f771ed3560fe5894d0a605c8469f9::blast_acl::AdminWitness<0x2d300f3d8819c6e09fd1558e518c2ffab97b324479843d4f94b561b10a441fd0::blast_presale_domain::FeeAdmin>, arg2: &0x96fbe2db7337dea5ef6926203d32cf602e527d5e2dcae176fbbc3e3d2a30d94f::blast_partners::Partner, arg3: &0x2::clock::Clock) {
        let v0 = 0x2::object::id<0x96fbe2db7337dea5ef6926203d32cf602e527d5e2dcae176fbbc3e3d2a30d94f::blast_partners::Partner>(arg2);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        assert_partner(arg0, v0, v1);
        let v2 = v1 + 0x96fbe2db7337dea5ef6926203d32cf602e527d5e2dcae176fbbc3e3d2a30d94f::blast_partners::delay_ms();
        let v3 = PartnerKey{pos0: v0};
        let v4 = 0x2::dynamic_field::borrow_mut<PartnerKey, u64>(&mut arg0.id, v3);
        assert!(*v4 == 18446744073709551615, 13835058523433598977);
        *v4 = v2;
        let v5 = PartnerRemoved{
            partner_id        : v0,
            accepted_until_ms : v2,
        };
        0x2::event::emit<PartnerRemoved>(v5);
    }

    public fun set_migration_witness_allowed<T0: drop>(arg0: &mut CreationPolicy, arg1: &0x726fb49b880faa89719b95c6ef3a91be794f771ed3560fe5894d0a605c8469f9::blast_acl::AdminWitness<0x2d300f3d8819c6e09fd1558e518c2ffab97b324479843d4f94b561b10a441fd0::blast_presale_domain::AdapterAdmin>, arg2: bool) {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        assert!(!arg2 || !is_constructible_by_anyone<T0>(), 13835902746500661255);
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.allowed_migration_witnesses, &v0) != arg2, 13835058334455037953);
        if (arg2) {
            0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.allowed_migration_witnesses, v0);
        } else {
            0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg0.allowed_migration_witnesses, &v0);
        };
        let v1 = MigrationWitnessSet{
            migration_witness : v0,
            allowed           : arg2,
        };
        0x2::event::emit<MigrationWitnessSet>(v1);
    }

    public fun set_quote_allowed<T0>(arg0: &mut CreationPolicy, arg1: &0x726fb49b880faa89719b95c6ef3a91be794f771ed3560fe5894d0a605c8469f9::blast_acl::AdminWitness<0x2d300f3d8819c6e09fd1558e518c2ffab97b324479843d4f94b561b10a441fd0::blast_presale_domain::ListingAdmin>, arg2: bool) {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.allowed_quotes, &v0) != arg2, 13835058235670790145);
        if (arg2) {
            0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.allowed_quotes, v0);
        } else {
            0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg0.allowed_quotes, &v0);
        };
        let v1 = QuoteSet{
            quote   : v0,
            allowed : arg2,
        };
        0x2::event::emit<QuoteSet>(v1);
    }

    // decompiled from Move bytecode v7
}

