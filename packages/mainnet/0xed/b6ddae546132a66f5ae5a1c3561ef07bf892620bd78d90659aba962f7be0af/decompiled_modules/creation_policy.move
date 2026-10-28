module 0xedb6ddae546132a66f5ae5a1c3561ef07bf892620bd78d90659aba962f7be0af::creation_policy {
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

    public fun add_partner(arg0: &mut CreationPolicy, arg1: &0xedb6ddae546132a66f5ae5a1c3561ef07bf892620bd78d90659aba962f7be0af::blast_presale_package::PackageVersion, arg2: &0x2136ba8efa373b04d237c4eb5154d240f526e65f27a06164e88e9513d28f50df::blast_acl::AdminWitness<0xedb6ddae546132a66f5ae5a1c3561ef07bf892620bd78d90659aba962f7be0af::blast_presale_domain::FeeAdmin>, arg3: &0x1ac5602bea673a59f693020e57ece4819e1bcb1c421c40494e9b225aeb949a85::blast_partners::Partner) {
        0xedb6ddae546132a66f5ae5a1c3561ef07bf892620bd78d90659aba962f7be0af::blast_presale_package::assert_current(arg1);
        let v0 = 0x2::object::id<0x1ac5602bea673a59f693020e57ece4819e1bcb1c421c40494e9b225aeb949a85::blast_partners::Partner>(arg3);
        let v1 = PartnerKey{pos0: v0};
        if (0x2::dynamic_field::exists<PartnerKey>(&arg0.id, v1)) {
            let v2 = 0x2::dynamic_field::borrow_mut<PartnerKey, u64>(&mut arg0.id, v1);
            assert!(*v2 != 18446744073709551615, 13835058463304056833);
            *v2 = 18446744073709551615;
        } else {
            0x2::dynamic_field::add<PartnerKey, u64>(&mut arg0.id, v1, 18446744073709551615);
        };
        let v3 = PartnerAdded{partner_id: v0};
        0x2::event::emit<PartnerAdded>(v3);
    }

    public(friend) fun assert_allowed<T0, T1>(arg0: &CreationPolicy) {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.allowed_quotes, &v0), 13835340097194688515);
        let v1 = 0x1::type_name::with_original_ids<T1>();
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.allowed_migration_witnesses, &v1), 13835621593646366725);
    }

    public(friend) fun assert_partner(arg0: &CreationPolicy, arg1: 0x2::object::ID, arg2: u64) {
        let v0 = PartnerKey{pos0: arg1};
        assert!(0x2::dynamic_field::exists<PartnerKey>(&arg0.id, v0), 13836184577959788553);
        assert!(arg2 < *0x2::dynamic_field::borrow<PartnerKey, u64>(&arg0.id, v0), 13836184586549723145);
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

    public fun remove_partner(arg0: &mut CreationPolicy, arg1: &0xedb6ddae546132a66f5ae5a1c3561ef07bf892620bd78d90659aba962f7be0af::blast_presale_package::PackageVersion, arg2: &0x2136ba8efa373b04d237c4eb5154d240f526e65f27a06164e88e9513d28f50df::blast_acl::AdminWitness<0xedb6ddae546132a66f5ae5a1c3561ef07bf892620bd78d90659aba962f7be0af::blast_presale_domain::FeeAdmin>, arg3: &0x1ac5602bea673a59f693020e57ece4819e1bcb1c421c40494e9b225aeb949a85::blast_partners::Partner, arg4: &0x2::clock::Clock) {
        0xedb6ddae546132a66f5ae5a1c3561ef07bf892620bd78d90659aba962f7be0af::blast_presale_package::assert_current(arg1);
        let v0 = 0x2::object::id<0x1ac5602bea673a59f693020e57ece4819e1bcb1c421c40494e9b225aeb949a85::blast_partners::Partner>(arg3);
        let v1 = 0x2::clock::timestamp_ms(arg4);
        assert_partner(arg0, v0, v1);
        let v2 = v1 + 0x1ac5602bea673a59f693020e57ece4819e1bcb1c421c40494e9b225aeb949a85::blast_partners::delay_ms();
        let v3 = PartnerKey{pos0: v0};
        let v4 = 0x2::dynamic_field::borrow_mut<PartnerKey, u64>(&mut arg0.id, v3);
        assert!(*v4 == 18446744073709551615, 13835058574973206529);
        *v4 = v2;
        let v5 = PartnerRemoved{
            partner_id        : v0,
            accepted_until_ms : v2,
        };
        0x2::event::emit<PartnerRemoved>(v5);
    }

    public fun set_migration_witness_allowed<T0: drop>(arg0: &mut CreationPolicy, arg1: &0xedb6ddae546132a66f5ae5a1c3561ef07bf892620bd78d90659aba962f7be0af::blast_presale_package::PackageVersion, arg2: &0x2136ba8efa373b04d237c4eb5154d240f526e65f27a06164e88e9513d28f50df::blast_acl::AdminWitness<0xedb6ddae546132a66f5ae5a1c3561ef07bf892620bd78d90659aba962f7be0af::blast_presale_domain::AdapterAdmin>, arg3: bool) {
        0xedb6ddae546132a66f5ae5a1c3561ef07bf892620bd78d90659aba962f7be0af::blast_presale_package::assert_current(arg1);
        let v0 = 0x1::type_name::with_original_ids<T0>();
        assert!(!arg3 || !is_constructible_by_anyone<T0>(), 13835902772270465031);
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.allowed_migration_witnesses, &v0) != arg3, 13835058360224841729);
        if (arg3) {
            0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.allowed_migration_witnesses, v0);
        } else {
            0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg0.allowed_migration_witnesses, &v0);
        };
        let v1 = MigrationWitnessSet{
            migration_witness : v0,
            allowed           : arg3,
        };
        0x2::event::emit<MigrationWitnessSet>(v1);
    }

    public fun set_quote_allowed<T0>(arg0: &mut CreationPolicy, arg1: &0xedb6ddae546132a66f5ae5a1c3561ef07bf892620bd78d90659aba962f7be0af::blast_presale_package::PackageVersion, arg2: &0x2136ba8efa373b04d237c4eb5154d240f526e65f27a06164e88e9513d28f50df::blast_acl::AdminWitness<0xedb6ddae546132a66f5ae5a1c3561ef07bf892620bd78d90659aba962f7be0af::blast_presale_domain::ListingAdmin>, arg3: bool) {
        0xedb6ddae546132a66f5ae5a1c3561ef07bf892620bd78d90659aba962f7be0af::blast_presale_package::assert_current(arg1);
        let v0 = 0x1::type_name::with_original_ids<T0>();
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.allowed_quotes, &v0) != arg3, 13835058248555692033);
        if (arg3) {
            0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.allowed_quotes, v0);
        } else {
            0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg0.allowed_quotes, &v0);
        };
        let v1 = QuoteSet{
            quote   : v0,
            allowed : arg3,
        };
        0x2::event::emit<QuoteSet>(v1);
    }

    // decompiled from Move bytecode v7
}

