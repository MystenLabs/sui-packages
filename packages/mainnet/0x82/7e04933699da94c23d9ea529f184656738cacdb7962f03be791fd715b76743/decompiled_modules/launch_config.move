module 0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::launch_config {
    struct LaunchConfig has key {
        id: 0x2::object::UID,
        meme_decimals: 0x2::vec_set::VecSet<u8>,
        quotes: 0x2::table::Table<0x1::type_name::TypeName, bool>,
        quote_fee_bps: 0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::bps::Bps,
        meme_fee_bps: 0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::bps::Bps,
        migration_witnesses: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
        protocol_allocation: 0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::allocation::ProtocolAllocation,
        creation_fee: u64,
    }

    struct PartnerKey has copy, drop, store {
        pos0: 0x2::object::ID,
    }

    fun new(arg0: &mut 0x2::tx_context::TxContext) : LaunchConfig {
        LaunchConfig{
            id                  : 0x2::object::new(arg0),
            meme_decimals       : 0x2::vec_set::from_keys<u8>(x"0609"),
            quotes              : 0x2::table::new<0x1::type_name::TypeName, bool>(arg0),
            quote_fee_bps       : 0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::bps::new(0),
            meme_fee_bps        : 0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::bps::new(0),
            migration_witnesses : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
            protocol_allocation : 0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::allocation::protocol_allocation(0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::bps::new(0), 0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::bps::new(0)),
            creation_fee        : 0,
        }
    }

    public(friend) fun protocol_allocation(arg0: &LaunchConfig) : 0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::allocation::ProtocolAllocation {
        arg0.protocol_allocation
    }

    public fun add_partner(arg0: &mut LaunchConfig, arg1: &0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::blast_fun::PackageVersion, arg2: &0x2136ba8efa373b04d237c4eb5154d240f526e65f27a06164e88e9513d28f50df::blast_acl::AdminWitness<0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::blast_fun_domain::FeeAdmin>, arg3: &0x1ac5602bea673a59f693020e57ece4819e1bcb1c421c40494e9b225aeb949a85::blast_partners::Partner) {
        0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::blast_fun::assert_current(arg1);
        let v0 = 0x2::object::id<0x1ac5602bea673a59f693020e57ece4819e1bcb1c421c40494e9b225aeb949a85::blast_partners::Partner>(arg3);
        let v1 = PartnerKey{pos0: v0};
        if (0x2::dynamic_field::exists<PartnerKey>(&arg0.id, v1)) {
            let v2 = 0x2::dynamic_field::borrow_mut<PartnerKey, u64>(&mut arg0.id, v1);
            assert!(*v2 != 18446744073709551615, 23);
            *v2 = 18446744073709551615;
        } else {
            0x2::dynamic_field::add<PartnerKey, u64>(&mut arg0.id, v1, 18446744073709551615);
        };
        0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::events::partner_added(v0);
    }

    public(friend) fun assert_partner(arg0: &LaunchConfig, arg1: 0x2::object::ID, arg2: u64) {
        let v0 = PartnerKey{pos0: arg1};
        assert!(0x2::dynamic_field::exists<PartnerKey>(&arg0.id, v0), 36);
        assert!(arg2 < *0x2::dynamic_field::borrow<PartnerKey, u64>(&arg0.id, v0), 36);
    }

    public(friend) fun creation_fee(arg0: &LaunchConfig) : u64 {
        arg0.creation_fee
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<LaunchConfig>(new(arg0));
    }

    public fun remove_partner(arg0: &mut LaunchConfig, arg1: &0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::blast_fun::PackageVersion, arg2: &0x2136ba8efa373b04d237c4eb5154d240f526e65f27a06164e88e9513d28f50df::blast_acl::AdminWitness<0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::blast_fun_domain::FeeAdmin>, arg3: &0x1ac5602bea673a59f693020e57ece4819e1bcb1c421c40494e9b225aeb949a85::blast_partners::Partner, arg4: &0x2::clock::Clock) {
        0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::blast_fun::assert_current(arg1);
        let v0 = 0x2::object::id<0x1ac5602bea673a59f693020e57ece4819e1bcb1c421c40494e9b225aeb949a85::blast_partners::Partner>(arg3);
        let v1 = 0x2::clock::timestamp_ms(arg4);
        assert_partner(arg0, v0, v1);
        let v2 = v1 + 0x1ac5602bea673a59f693020e57ece4819e1bcb1c421c40494e9b225aeb949a85::blast_partners::delay_ms();
        let v3 = PartnerKey{pos0: v0};
        let v4 = 0x2::dynamic_field::borrow_mut<PartnerKey, u64>(&mut arg0.id, v3);
        assert!(*v4 == 18446744073709551615, 23);
        *v4 = v2;
        0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::events::partner_removed(v0, v2);
    }

    public fun set_creation_fee(arg0: &mut LaunchConfig, arg1: &0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::blast_fun::PackageVersion, arg2: &0x2136ba8efa373b04d237c4eb5154d240f526e65f27a06164e88e9513d28f50df::blast_acl::AdminWitness<0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::blast_fun_domain::FeeAdmin>, arg3: u64) {
        0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::blast_fun::assert_current(arg1);
        assert!(arg3 != arg0.creation_fee, 23);
        arg0.creation_fee = arg3;
        0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::events::creation_fee_changed(arg3);
    }

    public fun set_meme_decimals_allowed(arg0: &mut LaunchConfig, arg1: &0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::blast_fun::PackageVersion, arg2: &0x2136ba8efa373b04d237c4eb5154d240f526e65f27a06164e88e9513d28f50df::blast_acl::AdminWitness<0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::blast_fun_domain::ListingAdmin>, arg3: u8, arg4: bool) {
        0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::blast_fun::assert_current(arg1);
        if (arg4) {
            0x2::vec_set::insert<u8>(&mut arg0.meme_decimals, arg3);
        } else {
            0x2::vec_set::remove<u8>(&mut arg0.meme_decimals, &arg3);
        };
        0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::events::meme_decimals_set(arg3, arg4);
    }

    public fun set_migration_witness_allowed<T0: drop>(arg0: &mut LaunchConfig, arg1: &0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::blast_fun::PackageVersion, arg2: &0x2136ba8efa373b04d237c4eb5154d240f526e65f27a06164e88e9513d28f50df::blast_acl::AdminWitness<0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::blast_fun_domain::AdapterAdmin>, arg3: bool) {
        0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::blast_fun::assert_current(arg1);
        let v0 = 0x1::type_name::original_id<T0>();
        assert!(v0 != @0x1 && v0 != @0x2, 4);
        let v1 = 0x1::type_name::with_original_ids<T0>();
        if (arg3) {
            0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.migration_witnesses, v1);
        } else {
            0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg0.migration_witnesses, &v1);
        };
        0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::events::migration_witness_set<T0>(arg3);
    }

    public fun set_protocol_allocation(arg0: &mut LaunchConfig, arg1: &0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::blast_fun::PackageVersion, arg2: &0x2136ba8efa373b04d237c4eb5154d240f526e65f27a06164e88e9513d28f50df::blast_acl::AdminWitness<0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::blast_fun_domain::TreasuryAdmin>, arg3: 0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::bps::Bps, arg4: 0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::bps::Bps) {
        0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::blast_fun::assert_current(arg1);
        assert!(0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::bps::value(arg3) <= 9998 && 0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::bps::value(arg4) <= 9999, 5);
        let v0 = 0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::allocation::protocol_allocation(arg3, arg4);
        assert!(arg0.protocol_allocation != v0, 23);
        arg0.protocol_allocation = v0;
        0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::events::protocol_allocation_set(0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::bps::value(arg3), 0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::bps::value(arg4));
    }

    public fun set_quote_allowed<T0>(arg0: &mut LaunchConfig, arg1: &0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::blast_fun::PackageVersion, arg2: &0x2136ba8efa373b04d237c4eb5154d240f526e65f27a06164e88e9513d28f50df::blast_acl::AdminWitness<0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::blast_fun_domain::ListingAdmin>, arg3: bool) {
        0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::blast_fun::assert_current(arg1);
        if (arg3) {
            0x2::table::add<0x1::type_name::TypeName, bool>(&mut arg0.quotes, 0x1::type_name::with_original_ids<T0>(), true);
        } else {
            0x2::table::remove<0x1::type_name::TypeName, bool>(&mut arg0.quotes, 0x1::type_name::with_original_ids<T0>());
        };
        0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::events::quote_set<T0>(arg3);
    }

    public fun set_trade_fees(arg0: &mut LaunchConfig, arg1: &0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::blast_fun::PackageVersion, arg2: &0x2136ba8efa373b04d237c4eb5154d240f526e65f27a06164e88e9513d28f50df::blast_acl::AdminWitness<0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::blast_fun_domain::FeeAdmin>, arg3: 0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::bps::Bps, arg4: 0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::bps::Bps) {
        0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::blast_fun::assert_current(arg1);
        assert!(0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::bps::value(arg3) <= 1000 && 0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::bps::value(arg4) <= 1000, 1);
        assert!(arg3 != arg0.quote_fee_bps || arg4 != arg0.meme_fee_bps, 23);
        arg0.quote_fee_bps = arg3;
        arg0.meme_fee_bps = arg4;
        0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::events::launch_trade_fees_changed(0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::bps::value(arg3), 0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::bps::value(arg4));
    }

    public(friend) fun snapshot_for_launch<T0>(arg0: &LaunchConfig, arg1: 0x1::type_name::TypeName, arg2: u8) : (0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::bps::Bps, 0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::bps::Bps) {
        assert!(0x2::table::contains<0x1::type_name::TypeName, bool>(&arg0.quotes, 0x1::type_name::with_original_ids<T0>()), 32);
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.migration_witnesses, &arg1), 3);
        assert!(0x2::vec_set::contains<u8>(&arg0.meme_decimals, &arg2), 2);
        (arg0.quote_fee_bps, arg0.meme_fee_bps)
    }

    // decompiled from Move bytecode v7
}

