module 0x3085ad044d8f9b4128a35e5195495d7f0a9756a32a4228e8d6633d7174b34f7f::blast_vault_package {
    struct BLAST_VAULT_PACKAGE has drop {
        dummy_field: bool,
    }

    struct PackageWitness has drop {
        dummy_field: bool,
    }

    struct WitnessesKey has copy, drop, store {
        dummy_field: bool,
    }

    struct VaultRegistry has key {
        id: 0x2::object::UID,
        witnesses: 0xde7a411dcc38f03fef78877747cc1027abe9009c054c831540e7f8a4128ad9b::delayed_set::DelayedSet<WitnessesKey, 0x1::type_name::TypeName>,
    }

    public fun make_immutable(arg0: &mut 0xde7a411dcc38f03fef78877747cc1027abe9009c054c831540e7f8a4128ad9b::package_admin::PackageAdmin<BLAST_VAULT_PACKAGE>, arg1: &0xde7a411dcc38f03fef78877747cc1027abe9009c054c831540e7f8a4128ad9b::blast_acl::AdminWitness<0xde7a411dcc38f03fef78877747cc1027abe9009c054c831540e7f8a4128ad9b::package_admin::UpgradeAdmin<BLAST_VAULT_PACKAGE>>, arg2: &0xde7a411dcc38f03fef78877747cc1027abe9009c054c831540e7f8a4128ad9b::package_version::PackageVersion<BLAST_VAULT_PACKAGE>, arg3: &0x2::clock::Clock) {
        0xde7a411dcc38f03fef78877747cc1027abe9009c054c831540e7f8a4128ad9b::package_version::assert_current<BLAST_VAULT_PACKAGE>(arg2, 1);
        let v0 = PackageWitness{dummy_field: false};
        0xde7a411dcc38f03fef78877747cc1027abe9009c054c831540e7f8a4128ad9b::package_admin::make_immutable<BLAST_VAULT_PACKAGE, PackageWitness>(arg0, arg1, v0, arg2, arg3);
    }

    public fun apply_witness<T0: drop>(arg0: &mut VaultRegistry, arg1: &0xde7a411dcc38f03fef78877747cc1027abe9009c054c831540e7f8a4128ad9b::package_version::PackageVersion<BLAST_VAULT_PACKAGE>, arg2: &0x2::clock::Clock) {
        0xde7a411dcc38f03fef78877747cc1027abe9009c054c831540e7f8a4128ad9b::package_version::assert_current<BLAST_VAULT_PACKAGE>(arg1, 1);
        0xde7a411dcc38f03fef78877747cc1027abe9009c054c831540e7f8a4128ad9b::delayed_set::apply_add<WitnessesKey, 0x1::type_name::TypeName>(&mut arg0.witnesses, 0x1::type_name::with_original_ids<T0>(), arg2);
    }

    public fun apply_witness_delay(arg0: &mut VaultRegistry, arg1: &0xde7a411dcc38f03fef78877747cc1027abe9009c054c831540e7f8a4128ad9b::package_version::PackageVersion<BLAST_VAULT_PACKAGE>, arg2: &0x2::clock::Clock) {
        0xde7a411dcc38f03fef78877747cc1027abe9009c054c831540e7f8a4128ad9b::package_version::assert_current<BLAST_VAULT_PACKAGE>(arg1, 1);
        0xde7a411dcc38f03fef78877747cc1027abe9009c054c831540e7f8a4128ad9b::delayed_set::apply_delay<WitnessesKey, 0x1::type_name::TypeName>(&mut arg0.witnesses, arg2);
    }

    public(friend) fun assert_package_witness(arg0: &VaultRegistry, arg1: 0x1::type_name::TypeName) {
        assert!(0xde7a411dcc38f03fef78877747cc1027abe9009c054c831540e7f8a4128ad9b::delayed_set::contains<WitnessesKey, 0x1::type_name::TypeName>(&arg0.witnesses, &arg1), 33);
    }

    public(friend) fun assert_venue<T0>(arg0: &VaultRegistry) {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        assert!(0xde7a411dcc38f03fef78877747cc1027abe9009c054c831540e7f8a4128ad9b::delayed_set::contains<WitnessesKey, 0x1::type_name::TypeName>(&arg0.witnesses, &v0), 1);
    }

    public fun cancel_witness<T0: drop>(arg0: &mut VaultRegistry, arg1: &0xde7a411dcc38f03fef78877747cc1027abe9009c054c831540e7f8a4128ad9b::blast_acl::AdminWitness<0x7ff2de5a2df7cc9c8b514dfbb25285b6cc72074d5e166186d8891860143c2f45::blast_domain::CancelAdmin>, arg2: &0xde7a411dcc38f03fef78877747cc1027abe9009c054c831540e7f8a4128ad9b::package_version::PackageVersion<BLAST_VAULT_PACKAGE>) {
        0xde7a411dcc38f03fef78877747cc1027abe9009c054c831540e7f8a4128ad9b::package_version::assert_current<BLAST_VAULT_PACKAGE>(arg2, 1);
        0xde7a411dcc38f03fef78877747cc1027abe9009c054c831540e7f8a4128ad9b::delayed_set::cancel_add<WitnessesKey, 0x1::type_name::TypeName>(&mut arg0.witnesses, 0x1::type_name::with_original_ids<T0>());
    }

    public fun cancel_witness_delay(arg0: &mut VaultRegistry, arg1: &0xde7a411dcc38f03fef78877747cc1027abe9009c054c831540e7f8a4128ad9b::blast_acl::AdminWitness<0x7ff2de5a2df7cc9c8b514dfbb25285b6cc72074d5e166186d8891860143c2f45::blast_domain::CancelAdmin>, arg2: &0xde7a411dcc38f03fef78877747cc1027abe9009c054c831540e7f8a4128ad9b::package_version::PackageVersion<BLAST_VAULT_PACKAGE>) {
        0xde7a411dcc38f03fef78877747cc1027abe9009c054c831540e7f8a4128ad9b::package_version::assert_current<BLAST_VAULT_PACKAGE>(arg2, 1);
        0xde7a411dcc38f03fef78877747cc1027abe9009c054c831540e7f8a4128ad9b::delayed_set::cancel_delay<WitnessesKey, 0x1::type_name::TypeName>(&mut arg0.witnesses);
    }

    fun init(arg0: BLAST_VAULT_PACKAGE, arg1: &mut 0x2::tx_context::TxContext) {
        0xde7a411dcc38f03fef78877747cc1027abe9009c054c831540e7f8a4128ad9b::package_version::keep<BLAST_VAULT_PACKAGE>(0xde7a411dcc38f03fef78877747cc1027abe9009c054c831540e7f8a4128ad9b::package_version::new_publication<BLAST_VAULT_PACKAGE, PackageWitness>(arg0, 1, arg1), arg1);
        0x2::transfer::share_object<VaultRegistry>(new_registry(arg1));
    }

    fun new_registry(arg0: &mut 0x2::tx_context::TxContext) : VaultRegistry {
        let v0 = 0x2::object::new(arg0);
        let v1 = WitnessesKey{dummy_field: false};
        VaultRegistry{
            id        : v0,
            witnesses : 0xde7a411dcc38f03fef78877747cc1027abe9009c054c831540e7f8a4128ad9b::delayed_set::new<WitnessesKey, 0x1::type_name::TypeName>(v1, &v0, 0),
        }
    }

    public fun remove_witness<T0: drop>(arg0: &mut VaultRegistry, arg1: &0xde7a411dcc38f03fef78877747cc1027abe9009c054c831540e7f8a4128ad9b::blast_acl::AdminWitness<0x7ff2de5a2df7cc9c8b514dfbb25285b6cc72074d5e166186d8891860143c2f45::blast_domain::VenueAdmin>, arg2: &0xde7a411dcc38f03fef78877747cc1027abe9009c054c831540e7f8a4128ad9b::package_version::PackageVersion<BLAST_VAULT_PACKAGE>) {
        0xde7a411dcc38f03fef78877747cc1027abe9009c054c831540e7f8a4128ad9b::package_version::assert_current<BLAST_VAULT_PACKAGE>(arg2, 1);
        0xde7a411dcc38f03fef78877747cc1027abe9009c054c831540e7f8a4128ad9b::delayed_set::remove<WitnessesKey, 0x1::type_name::TypeName>(&mut arg0.witnesses, 0x1::type_name::with_original_ids<T0>());
    }

    public fun schedule_witness<T0: drop>(arg0: &mut VaultRegistry, arg1: &0xde7a411dcc38f03fef78877747cc1027abe9009c054c831540e7f8a4128ad9b::blast_acl::AdminWitness<0x7ff2de5a2df7cc9c8b514dfbb25285b6cc72074d5e166186d8891860143c2f45::blast_domain::VenueAdmin>, arg2: &0xde7a411dcc38f03fef78877747cc1027abe9009c054c831540e7f8a4128ad9b::package_version::PackageVersion<BLAST_VAULT_PACKAGE>, arg3: &0x2::clock::Clock) {
        0xde7a411dcc38f03fef78877747cc1027abe9009c054c831540e7f8a4128ad9b::package_version::assert_current<BLAST_VAULT_PACKAGE>(arg2, 1);
        let v0 = 0x1::type_name::with_original_ids<T0>();
        assert!(!0x1::type_name::is_primitive(&v0), 0);
        let v1 = 0x1::type_name::original_id<T0>();
        assert!(v1 != @0x1 && v1 != @0x2, 0);
        0xde7a411dcc38f03fef78877747cc1027abe9009c054c831540e7f8a4128ad9b::delayed_set::schedule_add<WitnessesKey, 0x1::type_name::TypeName>(&mut arg0.witnesses, v0, arg3);
    }

    public fun schedule_witness_delay(arg0: &mut VaultRegistry, arg1: &0xde7a411dcc38f03fef78877747cc1027abe9009c054c831540e7f8a4128ad9b::blast_acl::AdminWitness<0x7ff2de5a2df7cc9c8b514dfbb25285b6cc72074d5e166186d8891860143c2f45::blast_domain::VenueAdmin>, arg2: &0xde7a411dcc38f03fef78877747cc1027abe9009c054c831540e7f8a4128ad9b::package_version::PackageVersion<BLAST_VAULT_PACKAGE>, arg3: u64, arg4: &0x2::clock::Clock) {
        0xde7a411dcc38f03fef78877747cc1027abe9009c054c831540e7f8a4128ad9b::package_version::assert_current<BLAST_VAULT_PACKAGE>(arg2, 1);
        0xde7a411dcc38f03fef78877747cc1027abe9009c054c831540e7f8a4128ad9b::delayed_set::schedule_delay<WitnessesKey, 0x1::type_name::TypeName>(&mut arg0.witnesses, arg3, arg4);
    }

    public(friend) fun uid_mut(arg0: &mut VaultRegistry) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public fun unpause(arg0: &VaultRegistry, arg1: &0xde7a411dcc38f03fef78877747cc1027abe9009c054c831540e7f8a4128ad9b::blast_acl::AdminWitness<0xde7a411dcc38f03fef78877747cc1027abe9009c054c831540e7f8a4128ad9b::package_admin::UnpauseAdmin<BLAST_VAULT_PACKAGE>>, arg2: &0xde7a411dcc38f03fef78877747cc1027abe9009c054c831540e7f8a4128ad9b::package_admin::PackageAdmin<BLAST_VAULT_PACKAGE>, arg3: &mut 0xde7a411dcc38f03fef78877747cc1027abe9009c054c831540e7f8a4128ad9b::package_version::PackageVersion<BLAST_VAULT_PACKAGE>, arg4: &0x7ff2de5a2df7cc9c8b514dfbb25285b6cc72074d5e166186d8891860143c2f45::blast_treasury::Treasury, arg5: u8) {
        0xde7a411dcc38f03fef78877747cc1027abe9009c054c831540e7f8a4128ad9b::package_version::assert_current<BLAST_VAULT_PACKAGE>(arg3, 1);
        assert!(0xde7a411dcc38f03fef78877747cc1027abe9009c054c831540e7f8a4128ad9b::delayed_set::is_guarded<WitnessesKey, 0x1::type_name::TypeName>(&arg0.witnesses) && 0x7ff2de5a2df7cc9c8b514dfbb25285b6cc72074d5e166186d8891860143c2f45::blast_treasury::is_guarded(arg4), 2);
        let v0 = PackageWitness{dummy_field: false};
        0xde7a411dcc38f03fef78877747cc1027abe9009c054c831540e7f8a4128ad9b::package_admin::clear_pause_bits<BLAST_VAULT_PACKAGE, PackageWitness>(arg2, arg1, v0, arg3, arg5);
    }

    // decompiled from Move bytecode v7
}

