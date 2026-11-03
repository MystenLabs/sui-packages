module 0xaf88fcde57f11424ddaafabe8abe5985e94b23355b3f95ae96130d8db2f202ed::creation_policy {
    struct CreationPolicy has key {
        id: 0x2::object::UID,
        allowed_quotes: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
        allowed_migration_witnesses: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
        witness_delay_ms: u64,
        pending_witness_delay: 0x1::option::Option<0xbda3fdf4eb1abcba8224fd02da869ee92c109ac75fad3fd51800004c200a7949::delayed::Pending<bool>>,
        pending_witnesses: 0x2::vec_map::VecMap<0x1::type_name::TypeName, 0xbda3fdf4eb1abcba8224fd02da869ee92c109ac75fad3fd51800004c200a7949::delayed::Pending<bool>>,
    }

    struct PartnerKey has copy, drop, store {
        pos0: 0x2::object::ID,
    }

    struct MigrationDelayScheduled has copy, drop {
        delay_ms: u64,
        ready_at_ms: u64,
    }

    struct MigrationDelayChanged has copy, drop {
        delay_ms: u64,
    }

    struct MigrationDelayCancelled has copy, drop {
        dummy_field: bool,
    }

    struct MigrationWitnessScheduled has copy, drop {
        witness: 0x1::type_name::TypeName,
        ready_at_ms: u64,
        delay_ms: u64,
    }

    struct MigrationWitnessCancelled has copy, drop {
        witness: 0x1::type_name::TypeName,
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

    fun new(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) : CreationPolicy {
        CreationPolicy{
            id                          : 0x2::object::new(arg1),
            allowed_quotes              : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
            allowed_migration_witnesses : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
            witness_delay_ms            : arg0,
            pending_witness_delay       : 0x1::option::none<0xbda3fdf4eb1abcba8224fd02da869ee92c109ac75fad3fd51800004c200a7949::delayed::Pending<bool>>(),
            pending_witnesses           : 0x2::vec_map::empty<0x1::type_name::TypeName, 0xbda3fdf4eb1abcba8224fd02da869ee92c109ac75fad3fd51800004c200a7949::delayed::Pending<bool>>(),
        }
    }

    public fun add_partner(arg0: &mut CreationPolicy, arg1: &0xaf88fcde57f11424ddaafabe8abe5985e94b23355b3f95ae96130d8db2f202ed::blast_presale_package::PackageVersion, arg2: &0xbda3fdf4eb1abcba8224fd02da869ee92c109ac75fad3fd51800004c200a7949::blast_acl::AdminWitness<0xaf88fcde57f11424ddaafabe8abe5985e94b23355b3f95ae96130d8db2f202ed::blast_presale_domain::FeeAdmin>, arg3: &0x5526582a1ae9d3cdde47e3b9ec1a24c285a2edff70d750a4b973229e3ae7b5b5::blast_partners::Partner) {
        0xaf88fcde57f11424ddaafabe8abe5985e94b23355b3f95ae96130d8db2f202ed::blast_presale_package::assert_current(arg1);
        let v0 = 0x2::object::id<0x5526582a1ae9d3cdde47e3b9ec1a24c285a2edff70d750a4b973229e3ae7b5b5::blast_partners::Partner>(arg3);
        let v1 = PartnerKey{pos0: v0};
        if (0x2::dynamic_field::exists<PartnerKey>(&arg0.id, v1)) {
            let v2 = 0x2::dynamic_field::borrow_mut<PartnerKey, u64>(&mut arg0.id, v1);
            assert!(*v2 != 18446744073709551615, 13835058759656800257);
            *v2 = 18446744073709551615;
        } else {
            0x2::dynamic_field::add<PartnerKey, u64>(&mut arg0.id, v1, 18446744073709551615);
        };
        let v3 = PartnerAdded{partner_id: v0};
        0x2::event::emit<PartnerAdded>(v3);
    }

    public fun apply_migration_delay(arg0: &mut CreationPolicy, arg1: &0xaf88fcde57f11424ddaafabe8abe5985e94b23355b3f95ae96130d8db2f202ed::blast_presale_package::PackageVersion, arg2: &0x2::clock::Clock) {
        0xaf88fcde57f11424ddaafabe8abe5985e94b23355b3f95ae96130d8db2f202ed::blast_presale_package::assert_current(arg1);
        let (_, v1) = 0xbda3fdf4eb1abcba8224fd02da869ee92c109ac75fad3fd51800004c200a7949::delayed::take_ready<bool>(0x1::option::extract<0xbda3fdf4eb1abcba8224fd02da869ee92c109ac75fad3fd51800004c200a7949::delayed::Pending<bool>>(&mut arg0.pending_witness_delay), arg2);
        arg0.witness_delay_ms = v1;
        let v2 = MigrationDelayChanged{delay_ms: v1};
        0x2::event::emit<MigrationDelayChanged>(v2);
    }

    public fun apply_migration_witness<T0: drop>(arg0: &mut CreationPolicy, arg1: &0xaf88fcde57f11424ddaafabe8abe5985e94b23355b3f95ae96130d8db2f202ed::blast_presale_package::PackageVersion, arg2: &0x2::clock::Clock) {
        0xaf88fcde57f11424ddaafabe8abe5985e94b23355b3f95ae96130d8db2f202ed::blast_presale_package::assert_current(arg1);
        let v0 = 0x1::type_name::with_original_ids<T0>();
        let (_, _) = 0xbda3fdf4eb1abcba8224fd02da869ee92c109ac75fad3fd51800004c200a7949::delayed::take_ready<bool>(*0x2::vec_map::get<0x1::type_name::TypeName, 0xbda3fdf4eb1abcba8224fd02da869ee92c109ac75fad3fd51800004c200a7949::delayed::Pending<bool>>(&arg0.pending_witnesses, &v0), arg2);
        let (_, _) = 0x2::vec_map::remove<0x1::type_name::TypeName, 0xbda3fdf4eb1abcba8224fd02da869ee92c109ac75fad3fd51800004c200a7949::delayed::Pending<bool>>(&mut arg0.pending_witnesses, &v0);
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.allowed_migration_witnesses, v0);
        let v5 = MigrationWitnessSet{
            migration_witness : v0,
            allowed           : true,
        };
        0x2::event::emit<MigrationWitnessSet>(v5);
    }

    public(friend) fun assert_allowed<T0, T1>(arg0: &CreationPolicy) {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.allowed_quotes, &v0), 13835340578231025667);
        let v1 = 0x1::type_name::with_original_ids<T1>();
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.allowed_migration_witnesses, &v1), 13835622074682703877);
    }

    public(friend) fun assert_partner(arg0: &CreationPolicy, arg1: 0x2::object::ID, arg2: u64) {
        let v0 = PartnerKey{pos0: arg1};
        assert!(0x2::dynamic_field::exists<PartnerKey>(&arg0.id, v0), 13836185058996125705);
        assert!(arg2 < *0x2::dynamic_field::borrow<PartnerKey, u64>(&arg0.id, v0), 13836185071881027593);
    }

    public fun cancel_migration_delay(arg0: &mut CreationPolicy, arg1: &0xaf88fcde57f11424ddaafabe8abe5985e94b23355b3f95ae96130d8db2f202ed::blast_presale_package::PackageVersion, arg2: &0xbda3fdf4eb1abcba8224fd02da869ee92c109ac75fad3fd51800004c200a7949::blast_acl::AdminWitness<0xaf88fcde57f11424ddaafabe8abe5985e94b23355b3f95ae96130d8db2f202ed::blast_presale_domain::CancelAdmin>) {
        0xaf88fcde57f11424ddaafabe8abe5985e94b23355b3f95ae96130d8db2f202ed::blast_presale_package::assert_current(arg1);
        0x1::option::extract<0xbda3fdf4eb1abcba8224fd02da869ee92c109ac75fad3fd51800004c200a7949::delayed::Pending<bool>>(&mut arg0.pending_witness_delay);
        let v0 = MigrationDelayCancelled{dummy_field: false};
        0x2::event::emit<MigrationDelayCancelled>(v0);
    }

    public fun cancel_migration_witness<T0: drop>(arg0: &mut CreationPolicy, arg1: &0xaf88fcde57f11424ddaafabe8abe5985e94b23355b3f95ae96130d8db2f202ed::blast_presale_package::PackageVersion, arg2: &0xbda3fdf4eb1abcba8224fd02da869ee92c109ac75fad3fd51800004c200a7949::blast_acl::AdminWitness<0xaf88fcde57f11424ddaafabe8abe5985e94b23355b3f95ae96130d8db2f202ed::blast_presale_domain::CancelAdmin>) {
        0xaf88fcde57f11424ddaafabe8abe5985e94b23355b3f95ae96130d8db2f202ed::blast_presale_package::assert_current(arg1);
        let v0 = 0x1::type_name::with_original_ids<T0>();
        let (_, _) = 0x2::vec_map::remove<0x1::type_name::TypeName, 0xbda3fdf4eb1abcba8224fd02da869ee92c109ac75fad3fd51800004c200a7949::delayed::Pending<bool>>(&mut arg0.pending_witnesses, &v0);
        let v3 = MigrationWitnessCancelled{witness: v0};
        0x2::event::emit<MigrationWitnessCancelled>(v3);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<CreationPolicy>(new(0, arg0));
    }

    public fun remove_migration_witness<T0: drop>(arg0: &mut CreationPolicy, arg1: &0xaf88fcde57f11424ddaafabe8abe5985e94b23355b3f95ae96130d8db2f202ed::blast_presale_package::PackageVersion, arg2: &0xbda3fdf4eb1abcba8224fd02da869ee92c109ac75fad3fd51800004c200a7949::blast_acl::AdminWitness<0xaf88fcde57f11424ddaafabe8abe5985e94b23355b3f95ae96130d8db2f202ed::blast_presale_domain::AdapterAdmin>) {
        0xaf88fcde57f11424ddaafabe8abe5985e94b23355b3f95ae96130d8db2f202ed::blast_presale_package::assert_current(arg1);
        let v0 = 0x1::type_name::with_original_ids<T0>();
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.allowed_migration_witnesses, &v0) || 0x2::vec_map::contains<0x1::type_name::TypeName, 0xbda3fdf4eb1abcba8224fd02da869ee92c109ac75fad3fd51800004c200a7949::delayed::Pending<bool>>(&arg0.pending_witnesses, &v0), 13835058643692683265);
        if (0x2::vec_map::contains<0x1::type_name::TypeName, 0xbda3fdf4eb1abcba8224fd02da869ee92c109ac75fad3fd51800004c200a7949::delayed::Pending<bool>>(&arg0.pending_witnesses, &v0)) {
            let (_, _) = 0x2::vec_map::remove<0x1::type_name::TypeName, 0xbda3fdf4eb1abcba8224fd02da869ee92c109ac75fad3fd51800004c200a7949::delayed::Pending<bool>>(&mut arg0.pending_witnesses, &v0);
            let v3 = MigrationWitnessCancelled{witness: v0};
            0x2::event::emit<MigrationWitnessCancelled>(v3);
        };
        if (0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.allowed_migration_witnesses, &v0)) {
            0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg0.allowed_migration_witnesses, &v0);
            let v4 = MigrationWitnessSet{
                migration_witness : v0,
                allowed           : false,
            };
            0x2::event::emit<MigrationWitnessSet>(v4);
        };
    }

    public fun remove_partner(arg0: &mut CreationPolicy, arg1: &0xaf88fcde57f11424ddaafabe8abe5985e94b23355b3f95ae96130d8db2f202ed::blast_presale_package::PackageVersion, arg2: &0xbda3fdf4eb1abcba8224fd02da869ee92c109ac75fad3fd51800004c200a7949::blast_acl::AdminWitness<0xaf88fcde57f11424ddaafabe8abe5985e94b23355b3f95ae96130d8db2f202ed::blast_presale_domain::FeeAdmin>, arg3: &0x5526582a1ae9d3cdde47e3b9ec1a24c285a2edff70d750a4b973229e3ae7b5b5::blast_partners::Partner, arg4: &0x2::clock::Clock) {
        0xaf88fcde57f11424ddaafabe8abe5985e94b23355b3f95ae96130d8db2f202ed::blast_presale_package::assert_current(arg1);
        let v0 = 0x2::object::id<0x5526582a1ae9d3cdde47e3b9ec1a24c285a2edff70d750a4b973229e3ae7b5b5::blast_partners::Partner>(arg3);
        let v1 = 0x2::clock::timestamp_ms(arg4);
        assert_partner(arg0, v0, v1);
        let v2 = v1 + 0x5526582a1ae9d3cdde47e3b9ec1a24c285a2edff70d750a4b973229e3ae7b5b5::blast_partners::delay_ms();
        let v3 = PartnerKey{pos0: v0};
        let v4 = 0x2::dynamic_field::borrow_mut<PartnerKey, u64>(&mut arg0.id, v3);
        assert!(*v4 == 18446744073709551615, 13835058871325949953);
        *v4 = v2;
        let v5 = PartnerRemoved{
            partner_id        : v0,
            accepted_until_ms : v2,
        };
        0x2::event::emit<PartnerRemoved>(v5);
    }

    public fun schedule_migration_delay(arg0: &mut CreationPolicy, arg1: &0xaf88fcde57f11424ddaafabe8abe5985e94b23355b3f95ae96130d8db2f202ed::blast_presale_package::PackageVersion, arg2: &0xbda3fdf4eb1abcba8224fd02da869ee92c109ac75fad3fd51800004c200a7949::blast_acl::AdminWitness<0xaf88fcde57f11424ddaafabe8abe5985e94b23355b3f95ae96130d8db2f202ed::blast_presale_domain::AdapterAdmin>, arg3: u64, arg4: &0x2::clock::Clock) {
        0xaf88fcde57f11424ddaafabe8abe5985e94b23355b3f95ae96130d8db2f202ed::blast_presale_package::assert_current(arg1);
        let v0 = 0xbda3fdf4eb1abcba8224fd02da869ee92c109ac75fad3fd51800004c200a7949::delayed::new_pending<bool>(false, arg0.witness_delay_ms, arg3, arg4);
        arg0.pending_witness_delay = 0x1::option::some<0xbda3fdf4eb1abcba8224fd02da869ee92c109ac75fad3fd51800004c200a7949::delayed::Pending<bool>>(v0);
        let v1 = MigrationDelayScheduled{
            delay_ms    : arg3,
            ready_at_ms : 0xbda3fdf4eb1abcba8224fd02da869ee92c109ac75fad3fd51800004c200a7949::delayed::ready_at_ms<bool>(&v0),
        };
        0x2::event::emit<MigrationDelayScheduled>(v1);
    }

    public fun schedule_migration_witness<T0: drop>(arg0: &mut CreationPolicy, arg1: &0xaf88fcde57f11424ddaafabe8abe5985e94b23355b3f95ae96130d8db2f202ed::blast_presale_package::PackageVersion, arg2: &0xbda3fdf4eb1abcba8224fd02da869ee92c109ac75fad3fd51800004c200a7949::blast_acl::AdminWitness<0xaf88fcde57f11424ddaafabe8abe5985e94b23355b3f95ae96130d8db2f202ed::blast_presale_domain::AdapterAdmin>, arg3: &0x2::clock::Clock) {
        0xaf88fcde57f11424ddaafabe8abe5985e94b23355b3f95ae96130d8db2f202ed::blast_presale_package::assert_current(arg1);
        let v0 = 0x1::type_name::with_original_ids<T0>();
        assert!(!0x1::type_name::is_primitive(&v0), 13835902793745301511);
        let v1 = 0x1::type_name::original_id<T0>();
        assert!(v1 != @0x1 && v1 != @0x2, 13835902806630203399);
        assert!(!0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.allowed_migration_witnesses, &v0), 13835058385994645505);
        let v2 = arg0.witness_delay_ms;
        let v3 = 0xbda3fdf4eb1abcba8224fd02da869ee92c109ac75fad3fd51800004c200a7949::delayed::new_pending<bool>(true, v2, v2, arg3);
        if (0x2::vec_map::contains<0x1::type_name::TypeName, 0xbda3fdf4eb1abcba8224fd02da869ee92c109ac75fad3fd51800004c200a7949::delayed::Pending<bool>>(&arg0.pending_witnesses, &v0)) {
            let (_, _) = 0x2::vec_map::remove<0x1::type_name::TypeName, 0xbda3fdf4eb1abcba8224fd02da869ee92c109ac75fad3fd51800004c200a7949::delayed::Pending<bool>>(&mut arg0.pending_witnesses, &v0);
        };
        0x2::vec_map::insert<0x1::type_name::TypeName, 0xbda3fdf4eb1abcba8224fd02da869ee92c109ac75fad3fd51800004c200a7949::delayed::Pending<bool>>(&mut arg0.pending_witnesses, v0, v3);
        let v6 = MigrationWitnessScheduled{
            witness     : v0,
            ready_at_ms : 0xbda3fdf4eb1abcba8224fd02da869ee92c109ac75fad3fd51800004c200a7949::delayed::ready_at_ms<bool>(&v3),
            delay_ms    : v2,
        };
        0x2::event::emit<MigrationWitnessScheduled>(v6);
    }

    public fun set_quote_allowed<T0>(arg0: &mut CreationPolicy, arg1: &0xaf88fcde57f11424ddaafabe8abe5985e94b23355b3f95ae96130d8db2f202ed::blast_presale_package::PackageVersion, arg2: &0xbda3fdf4eb1abcba8224fd02da869ee92c109ac75fad3fd51800004c200a7949::blast_acl::AdminWitness<0xaf88fcde57f11424ddaafabe8abe5985e94b23355b3f95ae96130d8db2f202ed::blast_presale_domain::ListingAdmin>, arg3: bool) {
        0xaf88fcde57f11424ddaafabe8abe5985e94b23355b3f95ae96130d8db2f202ed::blast_presale_package::assert_current(arg1);
        let v0 = 0x1::type_name::with_original_ids<T0>();
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.allowed_quotes, &v0) != arg3, 13835058261440593921);
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

