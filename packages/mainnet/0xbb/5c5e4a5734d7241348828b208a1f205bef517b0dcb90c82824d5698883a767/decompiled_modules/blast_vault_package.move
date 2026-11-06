module 0xbb5c5e4a5734d7241348828b208a1f205bef517b0dcb90c82824d5698883a767::blast_vault_package {
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
        witnesses: 0x59488bcc3d97f666f579822995f9576ac46c9423ae601253f5e3c60693ab5c78::delayed_set::DelayedSet<WitnessesKey, 0x1::type_name::TypeName>,
    }

    public fun make_immutable(arg0: &mut 0x59488bcc3d97f666f579822995f9576ac46c9423ae601253f5e3c60693ab5c78::package_admin::PackageAdmin<BLAST_VAULT_PACKAGE>, arg1: &0x59488bcc3d97f666f579822995f9576ac46c9423ae601253f5e3c60693ab5c78::blast_acl::AdminWitness<0x59488bcc3d97f666f579822995f9576ac46c9423ae601253f5e3c60693ab5c78::package_admin::UpgradeAdmin<BLAST_VAULT_PACKAGE>>, arg2: &0x59488bcc3d97f666f579822995f9576ac46c9423ae601253f5e3c60693ab5c78::package_version::PackageVersion<BLAST_VAULT_PACKAGE>, arg3: &0x2::clock::Clock) {
        0x59488bcc3d97f666f579822995f9576ac46c9423ae601253f5e3c60693ab5c78::package_version::assert_current<BLAST_VAULT_PACKAGE>(arg2, 1);
        let v0 = PackageWitness{dummy_field: false};
        0x59488bcc3d97f666f579822995f9576ac46c9423ae601253f5e3c60693ab5c78::package_admin::make_immutable<BLAST_VAULT_PACKAGE, PackageWitness>(arg0, arg1, v0, arg2, arg3);
    }

    public fun apply_witness<T0: drop>(arg0: &mut VaultRegistry, arg1: &0x59488bcc3d97f666f579822995f9576ac46c9423ae601253f5e3c60693ab5c78::package_version::PackageVersion<BLAST_VAULT_PACKAGE>, arg2: &0x2::clock::Clock) {
        0x59488bcc3d97f666f579822995f9576ac46c9423ae601253f5e3c60693ab5c78::package_version::assert_current<BLAST_VAULT_PACKAGE>(arg1, 1);
        0x59488bcc3d97f666f579822995f9576ac46c9423ae601253f5e3c60693ab5c78::delayed_set::apply_add<WitnessesKey, 0x1::type_name::TypeName>(&mut arg0.witnesses, 0x1::type_name::with_original_ids<T0>(), arg2);
    }

    public fun apply_witness_delay(arg0: &mut VaultRegistry, arg1: &0x59488bcc3d97f666f579822995f9576ac46c9423ae601253f5e3c60693ab5c78::package_version::PackageVersion<BLAST_VAULT_PACKAGE>, arg2: &0x2::clock::Clock) {
        0x59488bcc3d97f666f579822995f9576ac46c9423ae601253f5e3c60693ab5c78::package_version::assert_current<BLAST_VAULT_PACKAGE>(arg1, 1);
        0x59488bcc3d97f666f579822995f9576ac46c9423ae601253f5e3c60693ab5c78::delayed_set::apply_delay<WitnessesKey, 0x1::type_name::TypeName>(&mut arg0.witnesses, arg2);
    }

    public(friend) fun assert_package_witness(arg0: &VaultRegistry, arg1: 0x1::type_name::TypeName) {
        assert!(0x59488bcc3d97f666f579822995f9576ac46c9423ae601253f5e3c60693ab5c78::delayed_set::contains<WitnessesKey, 0x1::type_name::TypeName>(&arg0.witnesses, &arg1), 33);
    }

    public(friend) fun assert_venue<T0>(arg0: &VaultRegistry) {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        assert!(0x59488bcc3d97f666f579822995f9576ac46c9423ae601253f5e3c60693ab5c78::delayed_set::contains<WitnessesKey, 0x1::type_name::TypeName>(&arg0.witnesses, &v0), 1);
    }

    public fun cancel_witness<T0: drop>(arg0: &mut VaultRegistry, arg1: &0x59488bcc3d97f666f579822995f9576ac46c9423ae601253f5e3c60693ab5c78::blast_acl::AdminWitness<0xd1499adfec9cea739c2fb58d4e870c997c9f5e56482a03edd31b76e82bf1b2a2::blast_domain::CancelAdmin>, arg2: &0x59488bcc3d97f666f579822995f9576ac46c9423ae601253f5e3c60693ab5c78::package_version::PackageVersion<BLAST_VAULT_PACKAGE>) {
        0x59488bcc3d97f666f579822995f9576ac46c9423ae601253f5e3c60693ab5c78::package_version::assert_current<BLAST_VAULT_PACKAGE>(arg2, 1);
        0x59488bcc3d97f666f579822995f9576ac46c9423ae601253f5e3c60693ab5c78::delayed_set::cancel_add<WitnessesKey, 0x1::type_name::TypeName>(&mut arg0.witnesses, 0x1::type_name::with_original_ids<T0>());
    }

    public fun cancel_witness_delay(arg0: &mut VaultRegistry, arg1: &0x59488bcc3d97f666f579822995f9576ac46c9423ae601253f5e3c60693ab5c78::blast_acl::AdminWitness<0xd1499adfec9cea739c2fb58d4e870c997c9f5e56482a03edd31b76e82bf1b2a2::blast_domain::CancelAdmin>, arg2: &0x59488bcc3d97f666f579822995f9576ac46c9423ae601253f5e3c60693ab5c78::package_version::PackageVersion<BLAST_VAULT_PACKAGE>) {
        0x59488bcc3d97f666f579822995f9576ac46c9423ae601253f5e3c60693ab5c78::package_version::assert_current<BLAST_VAULT_PACKAGE>(arg2, 1);
        0x59488bcc3d97f666f579822995f9576ac46c9423ae601253f5e3c60693ab5c78::delayed_set::cancel_delay<WitnessesKey, 0x1::type_name::TypeName>(&mut arg0.witnesses);
    }

    fun init(arg0: BLAST_VAULT_PACKAGE, arg1: &mut 0x2::tx_context::TxContext) {
        0x59488bcc3d97f666f579822995f9576ac46c9423ae601253f5e3c60693ab5c78::package_version::keep<BLAST_VAULT_PACKAGE>(0x59488bcc3d97f666f579822995f9576ac46c9423ae601253f5e3c60693ab5c78::package_version::new_publication<BLAST_VAULT_PACKAGE, PackageWitness>(arg0, 1, arg1), arg1);
        0x2::transfer::share_object<VaultRegistry>(new_registry(arg1));
    }

    fun new_registry(arg0: &mut 0x2::tx_context::TxContext) : VaultRegistry {
        let v0 = 0x2::object::new(arg0);
        let v1 = WitnessesKey{dummy_field: false};
        VaultRegistry{
            id        : v0,
            witnesses : 0x59488bcc3d97f666f579822995f9576ac46c9423ae601253f5e3c60693ab5c78::delayed_set::new<WitnessesKey, 0x1::type_name::TypeName>(v1, &v0, 0),
        }
    }

    public fun remove_witness<T0: drop>(arg0: &mut VaultRegistry, arg1: &0x59488bcc3d97f666f579822995f9576ac46c9423ae601253f5e3c60693ab5c78::blast_acl::AdminWitness<0xd1499adfec9cea739c2fb58d4e870c997c9f5e56482a03edd31b76e82bf1b2a2::blast_domain::VenueAdmin>, arg2: &0x59488bcc3d97f666f579822995f9576ac46c9423ae601253f5e3c60693ab5c78::package_version::PackageVersion<BLAST_VAULT_PACKAGE>) {
        0x59488bcc3d97f666f579822995f9576ac46c9423ae601253f5e3c60693ab5c78::package_version::assert_current<BLAST_VAULT_PACKAGE>(arg2, 1);
        0x59488bcc3d97f666f579822995f9576ac46c9423ae601253f5e3c60693ab5c78::delayed_set::remove<WitnessesKey, 0x1::type_name::TypeName>(&mut arg0.witnesses, 0x1::type_name::with_original_ids<T0>());
    }

    public fun schedule_witness<T0: drop>(arg0: &mut VaultRegistry, arg1: &0x59488bcc3d97f666f579822995f9576ac46c9423ae601253f5e3c60693ab5c78::blast_acl::AdminWitness<0xd1499adfec9cea739c2fb58d4e870c997c9f5e56482a03edd31b76e82bf1b2a2::blast_domain::VenueAdmin>, arg2: &0x59488bcc3d97f666f579822995f9576ac46c9423ae601253f5e3c60693ab5c78::package_version::PackageVersion<BLAST_VAULT_PACKAGE>, arg3: &0x2::clock::Clock) {
        0x59488bcc3d97f666f579822995f9576ac46c9423ae601253f5e3c60693ab5c78::package_version::assert_current<BLAST_VAULT_PACKAGE>(arg2, 1);
        let v0 = 0x1::type_name::with_original_ids<T0>();
        assert!(!0x1::type_name::is_primitive(&v0), 0);
        let v1 = 0x1::type_name::original_id<T0>();
        assert!(v1 != @0x1 && v1 != @0x2, 0);
        0x59488bcc3d97f666f579822995f9576ac46c9423ae601253f5e3c60693ab5c78::delayed_set::schedule_add<WitnessesKey, 0x1::type_name::TypeName>(&mut arg0.witnesses, v0, arg3);
    }

    public fun schedule_witness_delay(arg0: &mut VaultRegistry, arg1: &0x59488bcc3d97f666f579822995f9576ac46c9423ae601253f5e3c60693ab5c78::blast_acl::AdminWitness<0xd1499adfec9cea739c2fb58d4e870c997c9f5e56482a03edd31b76e82bf1b2a2::blast_domain::VenueAdmin>, arg2: &0x59488bcc3d97f666f579822995f9576ac46c9423ae601253f5e3c60693ab5c78::package_version::PackageVersion<BLAST_VAULT_PACKAGE>, arg3: u64, arg4: &0x2::clock::Clock) {
        0x59488bcc3d97f666f579822995f9576ac46c9423ae601253f5e3c60693ab5c78::package_version::assert_current<BLAST_VAULT_PACKAGE>(arg2, 1);
        0x59488bcc3d97f666f579822995f9576ac46c9423ae601253f5e3c60693ab5c78::delayed_set::schedule_delay<WitnessesKey, 0x1::type_name::TypeName>(&mut arg0.witnesses, arg3, arg4);
    }

    public(friend) fun uid_mut(arg0: &mut VaultRegistry) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public fun unpause(arg0: &VaultRegistry, arg1: &0x59488bcc3d97f666f579822995f9576ac46c9423ae601253f5e3c60693ab5c78::blast_acl::AdminWitness<0x59488bcc3d97f666f579822995f9576ac46c9423ae601253f5e3c60693ab5c78::package_admin::UnpauseAdmin<BLAST_VAULT_PACKAGE>>, arg2: &0x59488bcc3d97f666f579822995f9576ac46c9423ae601253f5e3c60693ab5c78::package_admin::PackageAdmin<BLAST_VAULT_PACKAGE>, arg3: &mut 0x59488bcc3d97f666f579822995f9576ac46c9423ae601253f5e3c60693ab5c78::package_version::PackageVersion<BLAST_VAULT_PACKAGE>, arg4: &0xd1499adfec9cea739c2fb58d4e870c997c9f5e56482a03edd31b76e82bf1b2a2::blast_treasury::Treasury, arg5: u8) {
        0x59488bcc3d97f666f579822995f9576ac46c9423ae601253f5e3c60693ab5c78::package_version::assert_current<BLAST_VAULT_PACKAGE>(arg3, 1);
        assert!(0x59488bcc3d97f666f579822995f9576ac46c9423ae601253f5e3c60693ab5c78::delayed_set::is_guarded<WitnessesKey, 0x1::type_name::TypeName>(&arg0.witnesses) && 0xd1499adfec9cea739c2fb58d4e870c997c9f5e56482a03edd31b76e82bf1b2a2::blast_treasury::is_guarded(arg4), 2);
        let v0 = PackageWitness{dummy_field: false};
        0x59488bcc3d97f666f579822995f9576ac46c9423ae601253f5e3c60693ab5c78::package_admin::clear_pause_bits<BLAST_VAULT_PACKAGE, PackageWitness>(arg2, arg1, v0, arg3, arg5);
    }

    // decompiled from Move bytecode v7
}

