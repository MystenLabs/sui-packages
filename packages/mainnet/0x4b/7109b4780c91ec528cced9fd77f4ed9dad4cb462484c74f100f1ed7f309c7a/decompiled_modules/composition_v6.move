module 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6 {
    struct CompositionProtocolConfigV6 has key {
        id: 0x2::object::UID,
        version: u64,
        v5_config_id: 0x2::object::ID,
        v5_admin_cap_id: 0x2::object::ID,
        treasury_id: 0x2::object::ID,
        registry_id: 0x2::object::ID,
        validator_cap_id: 0x2::object::ID,
        validator_epoch: u64,
        payment_coin_type: 0x1::string::String,
        primary_protocol_fee_bps: u16,
        validator_policy_commitment: vector<u8>,
        soul_owner_proof_type: 0x1::option::Option<0x1::string::String>,
        enabled: bool,
    }

    struct CompositionProtocolTreasuryV6<phantom T0> has key {
        id: 0x2::object::UID,
        version: u64,
        config_id: 0x2::object::ID,
        revenue: 0x2::balance::Balance<T0>,
        total_collected: u64,
        total_withdrawn: u64,
    }

    struct CompositionAdminCapV6 has key {
        id: 0x2::object::UID,
        version: u64,
        config_id: 0x2::object::ID,
    }

    struct PhysicalV7InitializedKey has copy, drop, store {
        dummy_field: bool,
    }

    struct ValidatorCapV6 has key {
        id: 0x2::object::UID,
        version: u64,
        config_id: 0x2::object::ID,
        validator_epoch: u64,
    }

    struct WalletEntitlementKeyV6 has copy, drop, store {
        profile_id: 0x2::object::ID,
        product_id: 0x2::object::ID,
        wallet: address,
    }

    struct SoulEntitlementKeyV6 has copy, drop, store {
        profile_id: 0x2::object::ID,
        product_id: 0x2::object::ID,
        soul_id: 0x2::object::ID,
    }

    struct LoadoutNonceKeyV6 has copy, drop, store {
        profile_id: 0x2::object::ID,
        soul_id: 0x2::object::ID,
        client_nonce: vector<u8>,
    }

    struct EntitlementRecordV6 has copy, drop, store {
        purchaser: address,
        granted_at_ms: u64,
        paid_atomic: u64,
        owned_instance_id: 0x1::option::Option<0x2::object::ID>,
    }

    struct OwnedLockRecordV6 has copy, drop, store {
        profile_id: 0x2::object::ID,
        product_id: 0x2::object::ID,
        holder: address,
        soul_id: 0x2::object::ID,
        ownership_epoch: u64,
    }

    struct CompositionRegistryV6 has key {
        id: 0x2::object::UID,
        version: u64,
        config_id: 0x2::object::ID,
        profiles: 0x2::table::Table<0x2::object::ID, 0x2::object::ID>,
        wallet_entitlements: 0x2::table::Table<WalletEntitlementKeyV6, EntitlementRecordV6>,
        soul_entitlements: 0x2::table::Table<SoulEntitlementKeyV6, EntitlementRecordV6>,
        owned_locks: 0x2::table::Table<0x2::object::ID, OwnedLockRecordV6>,
        soul_owned_lock_counts: 0x2::table::Table<0x2::object::ID, u64>,
        used_nonces: 0x2::table::Table<LoadoutNonceKeyV6, bool>,
    }

    struct MakerProfileV6 has key {
        id: 0x2::object::UID,
        version: u64,
        config_id: 0x2::object::ID,
        root_id: 0x2::object::ID,
        mode: u8,
        loadout_mutable: bool,
        item_assetization: bool,
        third_party_policy: u8,
        slot_schema_commitment: vector<u8>,
        renderer_commitment: vector<u8>,
        rights_origin: u8,
        primary_protocol_fee_bps: u16,
        companion_manifest_blob_id: 0x1::string::String,
        companion_manifest_hash: vector<u8>,
        extensions_hash: vector<u8>,
        sealed: bool,
        admissions: 0x2::table::Table<0x2::object::ID, AdmissionRecordV6>,
        admission_count: u64,
    }

    struct ItemProductV6 has key {
        id: 0x2::object::UID,
        version: u64,
        config_id: 0x2::object::ID,
        source_root_id: 0x1::option::Option<0x2::object::ID>,
        publisher: address,
        original_creator: address,
        origin_kind: u8,
        family_commitment: vector<u8>,
        definition_commitment: vector<u8>,
        asset_commitment: vector<u8>,
        slot_key: 0x1::string::String,
        slot_schema_commitment: vector<u8>,
        rights_origin: u8,
        access_kind: u8,
        binding_kind: u8,
        price_atomic: u64,
        primary_protocol_fee_bps: u16,
        maker_ecosystem_fee_bps: u16,
        transferable: bool,
        required_product_ids: vector<0x2::object::ID>,
        excluded_product_ids: vector<0x2::object::ID>,
        extensions_hash: vector<u8>,
    }

    struct ValidatorAttestationV6 has key {
        id: 0x2::object::UID,
        version: u64,
        config_id: 0x2::object::ID,
        profile_id: 0x2::object::ID,
        product_id: 0x2::object::ID,
        definition_commitment: vector<u8>,
        slot_schema_commitment: vector<u8>,
        validator_policy_commitment: vector<u8>,
        validator_epoch: u64,
        issued_at_ms: u64,
    }

    struct AdmissionRecordV6 has copy, drop, store {
        source_kind: u8,
        attestation_id: 0x1::option::Option<0x2::object::ID>,
        admitted_by: address,
        admitted_at_ms: u64,
        definition_commitment: vector<u8>,
        asset_commitment: vector<u8>,
        slot_key: 0x1::string::String,
        rights_origin: u8,
        access_kind: u8,
        binding_kind: u8,
        price_atomic: u64,
        maker_ecosystem_fee_bps: u16,
        transferable: bool,
        required_product_ids: vector<0x2::object::ID>,
        excluded_product_ids: vector<0x2::object::ID>,
        publisher: address,
        active: bool,
    }

    struct OwnedItemV6 has key {
        id: 0x2::object::UID,
        version: u64,
        config_id: 0x2::object::ID,
        profile_id: 0x2::object::ID,
        product_id: 0x2::object::ID,
        holder: address,
        transferable: bool,
        locked_soul: 0x1::option::Option<0x2::object::ID>,
        ownership_epoch: u64,
    }

    struct LoadoutSelectionV6 has copy, drop, store {
        product_id: 0x2::object::ID,
        slot_key: 0x1::string::String,
        subject_kind: u8,
        owned_instance_id: 0x1::option::Option<0x2::object::ID>,
    }

    struct LoadoutHashInputV6 has copy, drop, store {
        selections: vector<LoadoutSelectionV6>,
    }

    struct LoadoutAuthorizationV6 {
        profile_id: 0x2::object::ID,
        root_id: 0x2::object::ID,
        soul_id: 0x2::object::ID,
        authorizer: address,
        client_nonce: vector<u8>,
        loadout_hash: vector<u8>,
        slot_schema_commitment: vector<u8>,
        selections: vector<LoadoutSelectionV6>,
        wallet_bound_count: u64,
        version: u64,
    }

    struct InitialLoadoutAuthorizationV6 {
        profile_id: 0x2::object::ID,
        root_id: 0x2::object::ID,
        soul_id: 0x2::object::ID,
        authorizer: address,
        client_nonce: vector<u8>,
        loadout_hash: vector<u8>,
        slot_schema_commitment: vector<u8>,
        selections: vector<LoadoutSelectionV6>,
        wallet_bound_count: u64,
        version: u64,
    }

    struct CompositionProtocolInitializedV6 has copy, drop {
        config_id: 0x2::object::ID,
        treasury_id: 0x2::object::ID,
        registry_id: 0x2::object::ID,
        validator_cap_id: 0x2::object::ID,
        validator_epoch: u64,
        validator_policy_commitment: vector<u8>,
        payment_coin_type: 0x1::string::String,
        enabled: bool,
    }

    struct MakerProfileCreatedV6 has copy, drop {
        profile_id: 0x2::object::ID,
        root_id: 0x2::object::ID,
        mode: u8,
        item_assetization: bool,
        third_party_policy: u8,
        companion_manifest_blob_id: 0x1::string::String,
        companion_manifest_hash: vector<u8>,
    }

    struct MakerProfileSealedV6 has copy, drop {
        profile_id: 0x2::object::ID,
        root_id: 0x2::object::ID,
    }

    struct MakerProfileCancelledV6 has copy, drop {
        profile_id: 0x2::object::ID,
        root_id: 0x2::object::ID,
        cancelled_by: address,
    }

    struct ItemProductPublishedV6 has copy, drop {
        product_id: 0x2::object::ID,
        source_root_id: 0x1::option::Option<0x2::object::ID>,
        publisher: address,
        origin_kind: u8,
        access_kind: u8,
        binding_kind: u8,
        price_atomic: u64,
        maker_ecosystem_fee_bps: u16,
        transferable: bool,
    }

    struct ItemAdmittedV6 has copy, drop {
        profile_id: 0x2::object::ID,
        product_id: 0x2::object::ID,
        source_kind: u8,
        attestation_id: 0x1::option::Option<0x2::object::ID>,
        admitted_by: address,
    }

    struct ItemAdmissionStatusChangedV6 has copy, drop {
        profile_id: 0x2::object::ID,
        product_id: 0x2::object::ID,
        active: bool,
        changed_by: address,
    }

    struct ValidatorRotatedV6 has copy, drop {
        config_id: 0x2::object::ID,
        validator_cap_id: 0x2::object::ID,
        validator_epoch: u64,
        validator_policy_commitment: vector<u8>,
    }

    struct EntitlementGrantedV6 has copy, drop {
        profile_id: 0x2::object::ID,
        product_id: 0x2::object::ID,
        subject_kind: u8,
        wallet: address,
        soul_id: 0x1::option::Option<0x2::object::ID>,
        paid_atomic: u64,
        owned_instance_id: 0x1::option::Option<0x2::object::ID>,
    }

    struct OwnedItemLockChangedV6 has copy, drop {
        instance_id: 0x2::object::ID,
        profile_id: 0x2::object::ID,
        product_id: 0x2::object::ID,
        holder: address,
        soul_id: 0x2::object::ID,
        locked: bool,
    }

    struct LoadoutAuthorizedV6 has copy, drop {
        profile_id: 0x2::object::ID,
        root_id: 0x2::object::ID,
        soul_id: 0x2::object::ID,
        authorizer: address,
        client_nonce: vector<u8>,
        loadout_hash: vector<u8>,
        wallet_bound_count: u64,
        authorization_kind: u8,
    }

    public fun access_embedded_v6() : u8 {
        0
    }

    public fun access_free_v6() : u8 {
        1
    }

    public fun access_paid_v6() : u8 {
        2
    }

    fun add_admission(arg0: &CompositionProtocolConfigV6, arg1: &mut MakerProfileV6, arg2: &ItemProductV6, arg3: u8, arg4: 0x1::option::Option<0x2::object::ID>, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert_protocol_enabled_v6(arg0);
        assert!(arg1.config_id == 0x2::object::id<CompositionProtocolConfigV6>(arg0), 2);
        assert!(arg1.sealed, 10);
        assert!(arg2.config_id == arg1.config_id, 2);
        assert!(arg3 == arg2.origin_kind, 59);
        assert!(&arg2.slot_schema_commitment == &arg1.slot_schema_commitment, 16);
        let v0 = 0x2::object::id<ItemProductV6>(arg2);
        assert!(!0x2::table::contains<0x2::object::ID, AdmissionRecordV6>(&arg1.admissions, v0), 17);
        assert_rule_targets_admitted(arg1, arg2);
        0x2::table::add<0x2::object::ID, AdmissionRecordV6>(&mut arg1.admissions, v0, admission_record(arg2, arg3, arg4, 0x2::tx_context::sender(arg6), 0x2::clock::timestamp_ms(arg5)));
        arg1.admission_count = arg1.admission_count + 1;
        let v1 = ItemAdmittedV6{
            profile_id     : 0x2::object::id<MakerProfileV6>(arg1),
            product_id     : v0,
            source_kind    : arg3,
            attestation_id : arg4,
            admitted_by    : 0x2::tx_context::sender(arg6),
        };
        0x2::event::emit<ItemAdmittedV6>(v1);
    }

    public fun admission_active_v6(arg0: &MakerProfileV6, arg1: 0x2::object::ID) : bool {
        assert!(0x2::table::contains<0x2::object::ID, AdmissionRecordV6>(&arg0.admissions, arg1), 18);
        0x2::table::borrow<0x2::object::ID, AdmissionRecordV6>(&arg0.admissions, arg1).active
    }

    public fun admission_certified_v6() : u8 {
        1
    }

    public fun admission_official_v6() : u8 {
        0
    }

    public fun admission_open_v6() : u8 {
        2
    }

    fun admission_record(arg0: &ItemProductV6, arg1: u8, arg2: 0x1::option::Option<0x2::object::ID>, arg3: address, arg4: u64) : AdmissionRecordV6 {
        AdmissionRecordV6{
            source_kind             : arg1,
            attestation_id          : arg2,
            admitted_by             : arg3,
            admitted_at_ms          : arg4,
            definition_commitment   : arg0.definition_commitment,
            asset_commitment        : arg0.asset_commitment,
            slot_key                : arg0.slot_key,
            rights_origin           : arg0.rights_origin,
            access_kind             : arg0.access_kind,
            binding_kind            : arg0.binding_kind,
            price_atomic            : arg0.price_atomic,
            maker_ecosystem_fee_bps : arg0.maker_ecosystem_fee_bps,
            transferable            : arg0.transferable,
            required_product_ids    : arg0.required_product_ids,
            excluded_product_ids    : arg0.excluded_product_ids,
            publisher               : arg0.publisher,
            active                  : true,
        }
    }

    public fun admission_source_kind_v6(arg0: &MakerProfileV6, arg1: 0x2::object::ID) : u8 {
        assert!(0x2::table::contains<0x2::object::ID, AdmissionRecordV6>(&arg0.admissions, arg1), 18);
        0x2::table::borrow<0x2::object::ID, AdmissionRecordV6>(&arg0.admissions, arg1).source_kind
    }

    public fun admit_certified_item_v6(arg0: &mut MakerProfileV6, arg1: &ItemProductV6, arg2: &ValidatorAttestationV6, arg3: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerRootV5, arg4: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerControlCapV5, arg5: &CompositionProtocolConfigV6, arg6: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::CommerceProtocolConfigV5, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) {
        assert_v6_publication_gate(arg5, arg6);
        0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::assert_extension_control_v5(arg3, arg4, arg8);
        assert_profile_link(arg5, arg0, arg3);
        assert!(arg1.origin_kind == 1, 59);
        assert!(arg0.third_party_policy >= 1, 20);
        assert!(0x1::option::is_none<0x2::object::ID>(&arg1.source_root_id), 22);
        assert_attestation(arg5, arg0, arg1, arg2);
        add_admission(arg5, arg0, arg1, 1, 0x1::option::some<0x2::object::ID>(0x2::object::id<ValidatorAttestationV6>(arg2)), arg7, arg8);
    }

    public fun admit_official_item_v6(arg0: &mut MakerProfileV6, arg1: &ItemProductV6, arg2: &ValidatorAttestationV6, arg3: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerRootV5, arg4: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerControlCapV5, arg5: &CompositionProtocolConfigV6, arg6: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::CommerceProtocolConfigV5, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) {
        assert_v6_publication_gate(arg5, arg6);
        0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::assert_extension_control_v5(arg3, arg4, arg8);
        assert_profile_link(arg5, arg0, arg3);
        assert!(arg1.origin_kind == 0, 59);
        assert!(0x1::option::is_some<0x2::object::ID>(&arg1.source_root_id), 21);
        assert!(*0x1::option::borrow<0x2::object::ID>(&arg1.source_root_id) == arg0.root_id, 21);
        assert_attestation(arg5, arg0, arg1, arg2);
        add_admission(arg5, arg0, arg1, 0, 0x1::option::some<0x2::object::ID>(0x2::object::id<ValidatorAttestationV6>(arg2)), arg7, arg8);
    }

    public fun admit_open_item_v6(arg0: &mut MakerProfileV6, arg1: &ItemProductV6, arg2: &ValidatorAttestationV6, arg3: &CompositionProtocolConfigV6, arg4: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::CommerceProtocolConfigV5, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert_v6_publication_gate(arg3, arg4);
        assert!(arg0.config_id == 0x2::object::id<CompositionProtocolConfigV6>(arg3), 2);
        assert!(arg1.origin_kind == 2, 59);
        assert!(arg0.third_party_policy == 2, 20);
        assert!(0x1::option::is_none<0x2::object::ID>(&arg1.source_root_id), 22);
        assert_attestation(arg3, arg0, arg1, arg2);
        add_admission(arg3, arg0, arg1, 2, 0x1::option::some<0x2::object::ID>(0x2::object::id<ValidatorAttestationV6>(arg2)), arg5, arg6);
    }

    fun assert_admin(arg0: &CompositionProtocolConfigV6, arg1: &CompositionAdminCapV6) {
        assert!(arg1.config_id == 0x2::object::id<CompositionProtocolConfigV6>(arg0), 0);
    }

    fun assert_admission_matches_product(arg0: &AdmissionRecordV6, arg1: &ItemProductV6) {
        let v0 = if (arg0.source_kind == arg1.origin_kind) {
            if (&arg0.definition_commitment == &arg1.definition_commitment) {
                if (&arg0.asset_commitment == &arg1.asset_commitment) {
                    if (&arg0.slot_key == &arg1.slot_key) {
                        if (arg0.rights_origin == arg1.rights_origin) {
                            if (arg0.access_kind == arg1.access_kind) {
                                if (arg0.binding_kind == arg1.binding_kind) {
                                    if (arg0.price_atomic == arg1.price_atomic) {
                                        if (arg0.maker_ecosystem_fee_bps == arg1.maker_ecosystem_fee_bps) {
                                            if (arg0.transferable == arg1.transferable) {
                                                if (&arg0.required_product_ids == &arg1.required_product_ids) {
                                                    if (&arg0.excluded_product_ids == &arg1.excluded_product_ids) {
                                                        arg0.publisher == arg1.publisher
                                                    } else {
                                                        false
                                                    }
                                                } else {
                                                    false
                                                }
                                            } else {
                                                false
                                            }
                                        } else {
                                            false
                                        }
                                    } else {
                                        false
                                    }
                                } else {
                                    false
                                }
                            } else {
                                false
                            }
                        } else {
                            false
                        }
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 2);
    }

    fun assert_attestation(arg0: &CompositionProtocolConfigV6, arg1: &MakerProfileV6, arg2: &ItemProductV6, arg3: &ValidatorAttestationV6) {
        let v0 = if (arg3.config_id == 0x2::object::id<CompositionProtocolConfigV6>(arg0)) {
            if (arg3.profile_id == 0x2::object::id<MakerProfileV6>(arg1)) {
                if (arg3.product_id == 0x2::object::id<ItemProductV6>(arg2)) {
                    if (&arg3.definition_commitment == &arg2.definition_commitment) {
                        if (&arg3.slot_schema_commitment == &arg1.slot_schema_commitment) {
                            if (&arg3.validator_policy_commitment == &arg0.validator_policy_commitment) {
                                arg3.validator_epoch == arg0.validator_epoch
                            } else {
                                false
                            }
                        } else {
                            false
                        }
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 23);
    }

    fun assert_companion_manifest(arg0: &0x1::string::String, arg1: &vector<u8>) {
        assert!(0x1::vector::length<u8>(0x1::string::as_bytes(arg0)) > 0, 53);
        assert_hash(arg1);
    }

    fun assert_hash(arg0: &vector<u8>) {
        assert!(0x1::vector::length<u8>(arg0) == 32, 6);
    }

    fun assert_loadout_rules(arg0: &MakerProfileV6, arg1: &vector<LoadoutSelectionV6>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<LoadoutSelectionV6>(arg1)) {
            let v1 = 0x2::table::borrow<0x2::object::ID, AdmissionRecordV6>(&arg0.admissions, 0x1::vector::borrow<LoadoutSelectionV6>(arg1, v0).product_id);
            let v2 = 0;
            while (v2 < 0x1::vector::length<0x2::object::ID>(&v1.required_product_ids)) {
                assert!(selection_vector_contains_product(arg1, *0x1::vector::borrow<0x2::object::ID>(&v1.required_product_ids, v2)), 49);
                v2 = v2 + 1;
            };
            v2 = 0;
            while (v2 < 0x1::vector::length<0x2::object::ID>(&v1.excluded_product_ids)) {
                assert!(!selection_vector_contains_product(arg1, *0x1::vector::borrow<0x2::object::ID>(&v1.excluded_product_ids, v2)), 50);
                v2 = v2 + 1;
            };
            v0 = v0 + 1;
        };
    }

    fun assert_non_empty(arg0: &0x1::string::String) {
        assert!(0x1::vector::length<u8>(0x1::string::as_bytes(arg0)) > 0, 16);
    }

    fun assert_player_action(arg0: &CompositionRegistryV6, arg1: &CompositionProtocolConfigV6, arg2: &MakerProfileV6, arg3: &ItemProductV6, arg4: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerRootV5, arg5: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::CommerceProtocolConfigV5) {
        assert_v6_operational(arg1, arg2, arg4, arg5);
        assert_registry(arg1, arg0);
        assert!(arg2.sealed, 10);
        assert!(arg3.config_id == 0x2::object::id<CompositionProtocolConfigV6>(arg1), 2);
        let v0 = 0x2::object::id<ItemProductV6>(arg3);
        assert!(0x2::table::contains<0x2::object::ID, AdmissionRecordV6>(&arg2.admissions, v0), 18);
        let v1 = 0x2::table::borrow<0x2::object::ID, AdmissionRecordV6>(&arg2.admissions, v0);
        assert!(v1.active, 19);
        assert_admission_matches_product(v1, arg3);
    }

    fun assert_product_rules(arg0: &ItemProductV6) {
        let v0 = 0x2::object::id<ItemProductV6>(arg0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x2::object::ID>(&arg0.required_product_ids)) {
            let v2 = *0x1::vector::borrow<0x2::object::ID>(&arg0.required_product_ids, v1);
            assert!(v2 != v0, 48);
            assert!(!id_vector_contains_before(&arg0.required_product_ids, v2, v1), 48);
            assert!(!id_vector_contains(&arg0.excluded_product_ids, v2), 48);
            v1 = v1 + 1;
        };
        v1 = 0;
        while (v1 < 0x1::vector::length<0x2::object::ID>(&arg0.excluded_product_ids)) {
            let v3 = *0x1::vector::borrow<0x2::object::ID>(&arg0.excluded_product_ids, v1);
            assert!(v3 != v0, 48);
            assert!(!id_vector_contains_before(&arg0.excluded_product_ids, v3, v1), 48);
            v1 = v1 + 1;
        };
    }

    fun assert_profile_link(arg0: &CompositionProtocolConfigV6, arg1: &MakerProfileV6, arg2: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerRootV5) {
        assert!(arg1.config_id == 0x2::object::id<CompositionProtocolConfigV6>(arg0), 2);
        assert!(arg1.root_id == 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::root_id_v5(arg2), 2);
        assert!(arg1.rights_origin == 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::root_rights_origin_v5(arg2), 2);
        assert!(arg1.primary_protocol_fee_bps == arg0.primary_protocol_fee_bps, 2);
    }

    fun assert_protocol_enabled_v6(arg0: &CompositionProtocolConfigV6) {
        assert!(arg0.enabled, 1);
    }

    fun assert_protocol_link(arg0: &CompositionProtocolConfigV6, arg1: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::CommerceProtocolConfigV5) {
        assert!(arg0.v5_config_id == 0x2::object::id<0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::CommerceProtocolConfigV5>(arg1), 2);
        assert!(&arg0.payment_coin_type == 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::extension_payment_coin_type_v5(arg1), 3);
        assert!(arg0.primary_protocol_fee_bps == 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::primary_protocol_fee_bps_v5(arg1), 2);
    }

    fun assert_registry(arg0: &CompositionProtocolConfigV6, arg1: &CompositionRegistryV6) {
        assert!(0x2::object::id<CompositionRegistryV6>(arg1) == arg0.registry_id, 2);
        assert!(arg1.config_id == 0x2::object::id<CompositionProtocolConfigV6>(arg0), 2);
    }

    fun assert_rule_targets_admitted(arg0: &MakerProfileV6, arg1: &ItemProductV6) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x2::object::ID>(&arg1.required_product_ids)) {
            assert!(0x2::table::contains<0x2::object::ID, AdmissionRecordV6>(&arg0.admissions, *0x1::vector::borrow<0x2::object::ID>(&arg1.required_product_ids, v0)), 47);
            v0 = v0 + 1;
        };
        v0 = 0;
        while (v0 < 0x1::vector::length<0x2::object::ID>(&arg1.excluded_product_ids)) {
            assert!(0x2::table::contains<0x2::object::ID, AdmissionRecordV6>(&arg0.admissions, *0x1::vector::borrow<0x2::object::ID>(&arg1.excluded_product_ids, v0)), 47);
            v0 = v0 + 1;
        };
    }

    public fun assert_secondary_market_loadout_v6(arg0: &CompositionRegistryV6, arg1: &CompositionProtocolConfigV6, arg2: &MakerProfileV6, arg3: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerRootV5, arg4: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::CommerceProtocolConfigV5, arg5: 0x2::object::ID, arg6: &vector<u8>, arg7: &vector<LoadoutSelectionV6>) {
        assert_protocol_enabled_v6(arg1);
        assert_protocol_link(arg1, arg4);
        assert_profile_link(arg1, arg2, arg3);
        0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::assert_extension_protocol_enabled_v5(arg4);
        assert_registry(arg1, arg0);
        assert!(arg2.sealed, 10);
        assert!(0x2::object::id_to_address(&arg5) != @0x0, 30);
        assert!(0x1::vector::length<LoadoutSelectionV6>(arg7) > 0, 44);
        assert!(0x1::vector::length<u8>(arg6) == 32, 42);
        let v0 = hash_loadout_selections_v6(arg7);
        assert!(arg6 == &v0, 42);
        assert!(soul_owned_lock_count_v6(arg0, arg5) == 0, 56);
        let v1 = 0;
        while (v1 < 0x1::vector::length<LoadoutSelectionV6>(arg7)) {
            let v2 = 0x1::vector::borrow<LoadoutSelectionV6>(arg7, v1);
            assert_unique_slot(arg7, v1);
            assert!(v2.subject_kind == 1 || v2.subject_kind == 2, 57);
            assert!(0x1::option::is_none<0x2::object::ID>(&v2.owned_instance_id), 57);
            assert_selection(arg0, arg2, arg5, @0x0, v2);
            v1 = v1 + 1;
        };
        assert_loadout_rules(arg2, arg7);
    }

    fun assert_selection(arg0: &CompositionRegistryV6, arg1: &MakerProfileV6, arg2: 0x2::object::ID, arg3: address, arg4: &LoadoutSelectionV6) {
        assert!(0x2::table::contains<0x2::object::ID, AdmissionRecordV6>(&arg1.admissions, arg4.product_id), 18);
        let v0 = 0x2::table::borrow<0x2::object::ID, AdmissionRecordV6>(&arg1.admissions, arg4.product_id);
        assert!(v0.active, 19);
        assert!(&v0.slot_key == &arg4.slot_key, 16);
        if (v0.binding_kind == 0) {
            assert!(arg4.subject_kind == 2, 32);
            assert!(0x1::option::is_none<0x2::object::ID>(&arg4.owned_instance_id), 34);
        } else if (v0.binding_kind == 1) {
            assert!(arg4.subject_kind == 0, 32);
            assert!(0x1::option::is_none<0x2::object::ID>(&arg4.owned_instance_id), 34);
            let v1 = WalletEntitlementKeyV6{
                profile_id : 0x2::object::id<MakerProfileV6>(arg1),
                product_id : arg4.product_id,
                wallet     : arg3,
            };
            assert!(0x2::table::contains<WalletEntitlementKeyV6, EntitlementRecordV6>(&arg0.wallet_entitlements, v1), 26);
            assert!(0x1::option::is_none<0x2::object::ID>(&0x2::table::borrow<WalletEntitlementKeyV6, EntitlementRecordV6>(&arg0.wallet_entitlements, v1).owned_instance_id), 34);
        } else if (v0.binding_kind == 2) {
            assert!(arg4.subject_kind == 1, 32);
            assert!(0x1::option::is_none<0x2::object::ID>(&arg4.owned_instance_id), 34);
            let v2 = SoulEntitlementKeyV6{
                profile_id : 0x2::object::id<MakerProfileV6>(arg1),
                product_id : arg4.product_id,
                soul_id    : arg2,
            };
            assert!(0x2::table::contains<SoulEntitlementKeyV6, EntitlementRecordV6>(&arg0.soul_entitlements, v2), 26);
            assert!(0x1::option::is_none<0x2::object::ID>(&0x2::table::borrow<SoulEntitlementKeyV6, EntitlementRecordV6>(&arg0.soul_entitlements, v2).owned_instance_id), 34);
        } else {
            assert!(v0.binding_kind == 3, 45);
            assert!(arg1.item_assetization, 45);
            assert!(arg4.subject_kind == 0, 32);
            assert!(0x1::option::is_some<0x2::object::ID>(&arg4.owned_instance_id), 33);
            let v3 = WalletEntitlementKeyV6{
                profile_id : 0x2::object::id<MakerProfileV6>(arg1),
                product_id : arg4.product_id,
                wallet     : arg3,
            };
            assert!(0x2::table::contains<WalletEntitlementKeyV6, EntitlementRecordV6>(&arg0.wallet_entitlements, v3), 26);
            let v4 = 0x2::table::borrow<WalletEntitlementKeyV6, EntitlementRecordV6>(&arg0.wallet_entitlements, v3);
            assert!(0x1::option::is_some<0x2::object::ID>(&v4.owned_instance_id), 33);
            let v5 = *0x1::option::borrow<0x2::object::ID>(&arg4.owned_instance_id);
            assert!(v5 == *0x1::option::borrow<0x2::object::ID>(&v4.owned_instance_id), 35);
            assert!(0x2::table::contains<0x2::object::ID, OwnedLockRecordV6>(&arg0.owned_locks, v5), 37);
            let v6 = 0x2::table::borrow<0x2::object::ID, OwnedLockRecordV6>(&arg0.owned_locks, v5);
            let v7 = if (v6.profile_id == 0x2::object::id<MakerProfileV6>(arg1)) {
                if (v6.product_id == arg4.product_id) {
                    v6.holder == arg3
                } else {
                    false
                }
            } else {
                false
            };
            assert!(v7, 35);
            assert!(v6.soul_id == arg2, 38);
        };
    }

    fun assert_soul_owner_proof_type<T0: drop>(arg0: &CompositionProtocolConfigV6) {
        assert!(0x1::option::is_some<0x1::string::String>(&arg0.soul_owner_proof_type), 5);
        let v0 = defining_type_name<T0>();
        assert!(&v0 == 0x1::option::borrow<0x1::string::String>(&arg0.soul_owner_proof_type), 31);
    }

    public fun assert_soul_transferable_v6(arg0: u64) {
        assert!(arg0 == 0, 38);
    }

    fun assert_treasury<T0>(arg0: &CompositionProtocolConfigV6, arg1: &CompositionProtocolTreasuryV6<T0>) {
        assert!(0x2::object::id<CompositionProtocolTreasuryV6<T0>>(arg1) == arg0.treasury_id, 2);
        assert!(arg1.config_id == 0x2::object::id<CompositionProtocolConfigV6>(arg0), 2);
    }

    fun assert_unique_slot(arg0: &vector<LoadoutSelectionV6>, arg1: u64) {
        let v0 = 0;
        while (v0 < arg1) {
            assert!(&0x1::vector::borrow<LoadoutSelectionV6>(arg0, v0).slot_key != &0x1::vector::borrow<LoadoutSelectionV6>(arg0, arg1).slot_key, 43);
            v0 = v0 + 1;
        };
    }

    fun assert_v6_operational(arg0: &CompositionProtocolConfigV6, arg1: &MakerProfileV6, arg2: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerRootV5, arg3: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::CommerceProtocolConfigV5) {
        assert_protocol_enabled_v6(arg0);
        assert_protocol_link(arg0, arg3);
        assert_profile_link(arg0, arg1, arg2);
        0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::assert_extension_operational_v5(arg2, arg3);
    }

    fun assert_v6_publication_gate(arg0: &CompositionProtocolConfigV6, arg1: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::CommerceProtocolConfigV5) {
        assert_protocol_enabled_v6(arg0);
        assert_protocol_link(arg0, arg1);
        0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::assert_extension_protocol_enabled_v5(arg1);
    }

    fun assert_valid_access(arg0: &MakerProfileV6, arg1: u8, arg2: u8, arg3: u64, arg4: bool) {
        let v0 = if (arg1 == 0) {
            true
        } else if (arg1 == 1) {
            true
        } else {
            arg1 == 2
        };
        assert!(v0, 14);
        assert!(arg2 <= 3, 45);
        if (arg2 == 0) {
            assert!(arg1 == 0, 45);
            assert!(arg3 == 0, 14);
            assert!(!arg4, 51);
        } else {
            assert!(arg1 != 0, 45);
            if (arg1 == 1) {
                assert!(arg3 == 0, 14);
            } else {
                assert!(arg3 > 0, 14);
            };
            if (arg2 == 3) {
                assert!(arg0.item_assetization, 45);
            } else {
                assert!(!arg4, 51);
            };
        };
        if (arg0.mode == 0) {
            assert!(arg2 == 0, 45);
        };
    }

    fun assert_valid_origin_kind(arg0: u8) {
        let v0 = if (arg0 == 0) {
            true
        } else if (arg0 == 1) {
            true
        } else {
            arg0 == 2
        };
        assert!(v0, 58);
    }

    fun assert_valid_profile_mode(arg0: u8) {
        assert!(arg0 == 0 || arg0 == 1, 7);
    }

    fun assert_valid_rights_origin(arg0: u8) {
        assert!(arg0 == 0 || arg0 == 1, 15);
    }

    fun assert_valid_third_party_policy(arg0: u8) {
        assert!(arg0 <= 2, 8);
    }

    public fun authorize_initial_loadout_v6<T0: drop>(arg0: &mut CompositionRegistryV6, arg1: &CompositionProtocolConfigV6, arg2: &MakerProfileV6, arg3: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerRootV5, arg4: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::CommerceProtocolConfigV5, arg5: 0x2::object::ID, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<LoadoutSelectionV6>, arg9: T0, arg10: &0x2::tx_context::TxContext) : InitialLoadoutAuthorizationV6 {
        assert_v6_operational(arg1, arg2, arg3, arg4);
        assert_registry(arg1, arg0);
        assert_soul_owner_proof_type<T0>(arg1);
        assert!(arg2.sealed, 10);
        assert!(0x2::object::id_to_address(&arg5) != @0x0, 30);
        assert!(0x1::vector::length<u8>(&arg6) == 32, 40);
        assert!(0x1::vector::length<LoadoutSelectionV6>(&arg8) > 0, 44);
        assert!(0x1::vector::length<u8>(&arg7) == 32, 42);
        assert!(arg7 == hash_loadout_selections_v6(&arg8), 42);
        let v0 = LoadoutNonceKeyV6{
            profile_id   : 0x2::object::id<MakerProfileV6>(arg2),
            soul_id      : arg5,
            client_nonce : arg6,
        };
        assert!(!0x2::table::contains<LoadoutNonceKeyV6, bool>(&arg0.used_nonces, v0), 41);
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<LoadoutSelectionV6>(&arg8)) {
            let v3 = 0x1::vector::borrow<LoadoutSelectionV6>(&arg8, v2);
            assert_unique_slot(&arg8, v2);
            assert_selection(arg0, arg2, arg5, 0x2::tx_context::sender(arg10), v3);
            if (v3.subject_kind == 0) {
                v1 = v1 + 1;
            };
            v2 = v2 + 1;
        };
        assert_loadout_rules(arg2, &arg8);
        0x2::table::add<LoadoutNonceKeyV6, bool>(&mut arg0.used_nonces, v0, true);
        let v4 = LoadoutAuthorizedV6{
            profile_id         : 0x2::object::id<MakerProfileV6>(arg2),
            root_id            : arg2.root_id,
            soul_id            : arg5,
            authorizer         : 0x2::tx_context::sender(arg10),
            client_nonce       : arg6,
            loadout_hash       : arg7,
            wallet_bound_count : v1,
            authorization_kind : 0,
        };
        0x2::event::emit<LoadoutAuthorizedV6>(v4);
        InitialLoadoutAuthorizationV6{
            profile_id             : 0x2::object::id<MakerProfileV6>(arg2),
            root_id                : arg2.root_id,
            soul_id                : arg5,
            authorizer             : 0x2::tx_context::sender(arg10),
            client_nonce           : arg6,
            loadout_hash           : arg7,
            slot_schema_commitment : arg2.slot_schema_commitment,
            selections             : arg8,
            wallet_bound_count     : v1,
            version                : 6,
        }
    }

    public fun authorize_loadout_v6<T0: drop>(arg0: &mut CompositionRegistryV6, arg1: &CompositionProtocolConfigV6, arg2: &MakerProfileV6, arg3: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerRootV5, arg4: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::CommerceProtocolConfigV5, arg5: 0x2::object::ID, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<LoadoutSelectionV6>, arg9: T0, arg10: &0x2::tx_context::TxContext) : LoadoutAuthorizationV6 {
        assert_v6_operational(arg1, arg2, arg3, arg4);
        assert_registry(arg1, arg0);
        assert_soul_owner_proof_type<T0>(arg1);
        assert!(arg2.sealed, 10);
        assert!(arg2.mode == 1, 12);
        assert!(arg2.loadout_mutable, 13);
        assert!(0x2::object::id_to_address(&arg5) != @0x0, 30);
        assert!(0x1::vector::length<u8>(&arg6) == 32, 40);
        assert!(0x1::vector::length<LoadoutSelectionV6>(&arg8) > 0, 44);
        assert!(0x1::vector::length<u8>(&arg7) == 32, 42);
        assert!(arg7 == hash_loadout_selections_v6(&arg8), 42);
        let v0 = LoadoutNonceKeyV6{
            profile_id   : 0x2::object::id<MakerProfileV6>(arg2),
            soul_id      : arg5,
            client_nonce : arg6,
        };
        assert!(!0x2::table::contains<LoadoutNonceKeyV6, bool>(&arg0.used_nonces, v0), 41);
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<LoadoutSelectionV6>(&arg8)) {
            let v3 = 0x1::vector::borrow<LoadoutSelectionV6>(&arg8, v2);
            assert_unique_slot(&arg8, v2);
            assert_selection(arg0, arg2, arg5, 0x2::tx_context::sender(arg10), v3);
            if (v3.subject_kind == 0) {
                v1 = v1 + 1;
            };
            v2 = v2 + 1;
        };
        assert_loadout_rules(arg2, &arg8);
        0x2::table::add<LoadoutNonceKeyV6, bool>(&mut arg0.used_nonces, v0, true);
        let v4 = LoadoutAuthorizedV6{
            profile_id         : 0x2::object::id<MakerProfileV6>(arg2),
            root_id            : arg2.root_id,
            soul_id            : arg5,
            authorizer         : 0x2::tx_context::sender(arg10),
            client_nonce       : arg6,
            loadout_hash       : arg7,
            wallet_bound_count : v1,
            authorization_kind : 1,
        };
        0x2::event::emit<LoadoutAuthorizedV6>(v4);
        LoadoutAuthorizationV6{
            profile_id             : 0x2::object::id<MakerProfileV6>(arg2),
            root_id                : arg2.root_id,
            soul_id                : arg5,
            authorizer             : 0x2::tx_context::sender(arg10),
            client_nonce           : arg6,
            loadout_hash           : arg7,
            slot_schema_commitment : arg2.slot_schema_commitment,
            selections             : arg8,
            wallet_bound_count     : v1,
            version                : 6,
        }
    }

    public fun bind_soul_owner_proof_type_v6<T0: drop>(arg0: &mut CompositionProtocolConfigV6, arg1: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::CommerceProtocolConfigV5, arg2: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::ProtocolFeeAdminCap) {
        assert_protocol_link(arg0, arg1);
        0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::assert_extension_protocol_admin_v5(arg1, arg2);
        assert!(!arg0.enabled, 4);
        assert!(0x1::option::is_none<0x1::string::String>(&arg0.soul_owner_proof_type), 4);
        arg0.soul_owner_proof_type = 0x1::option::some<0x1::string::String>(defining_type_name<T0>());
    }

    public fun binding_account_v6() : u8 {
        1
    }

    public fun binding_embedded_v6() : u8 {
        0
    }

    public fun binding_owned_v6() : u8 {
        3
    }

    public fun binding_soul_v6() : u8 {
        2
    }

    fun bps_amount(arg0: u64, arg1: u16) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (10000 as u128)) as u64)
    }

    public fun cancel_unsealed_maker_profile_v6(arg0: MakerProfileV6, arg1: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerRootV5, arg2: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerControlCapV5, arg3: &CompositionProtocolConfigV6, arg4: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::CommerceProtocolConfigV5, arg5: &mut CompositionRegistryV6, arg6: &0x2::tx_context::TxContext) {
        assert_protocol_link(arg3, arg4);
        0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::assert_extension_control_v5(arg1, arg2, arg6);
        assert_registry(arg3, arg5);
        assert_profile_link(arg3, &arg0, arg1);
        assert!(!arg0.sealed && arg0.admission_count == 0, 55);
        let v0 = 0x2::object::id<MakerProfileV6>(&arg0);
        let v1 = arg0.root_id;
        assert!(0x2::table::remove<0x2::object::ID, 0x2::object::ID>(&mut arg5.profiles, v1) == v0, 2);
        let v2 = MakerProfileCancelledV6{
            profile_id   : v0,
            root_id      : v1,
            cancelled_by : 0x2::tx_context::sender(arg6),
        };
        0x2::event::emit<MakerProfileCancelledV6>(v2);
        let MakerProfileV6 {
            id                         : v3,
            version                    : _,
            config_id                  : _,
            root_id                    : _,
            mode                       : _,
            loadout_mutable            : _,
            item_assetization          : _,
            third_party_policy         : _,
            slot_schema_commitment     : _,
            renderer_commitment        : _,
            rights_origin              : _,
            primary_protocol_fee_bps   : _,
            companion_manifest_blob_id : _,
            companion_manifest_hash    : _,
            extensions_hash            : _,
            sealed                     : _,
            admissions                 : v19,
            admission_count            : _,
        } = arg0;
        0x2::table::destroy_empty<0x2::object::ID, AdmissionRecordV6>(v19);
        0x2::object::delete(v3);
    }

    public fun claim_free_owned_item_for_physical_v7(arg0: &mut CompositionRegistryV6, arg1: &CompositionProtocolConfigV6, arg2: &MakerProfileV6, arg3: &ItemProductV6, arg4: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerRootV5, arg5: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::CommerceProtocolConfigV5, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : OwnedItemV6 {
        assert_player_action(arg0, arg1, arg2, arg3, arg4, arg5);
        assert!(arg3.access_kind == 1, 14);
        assert!(arg3.binding_kind == 3, 45);
        0x1::option::destroy_some<OwnedItemV6>(grant_wallet_entitlement_internal(arg0, arg1, arg2, arg3, 0, arg6, arg7))
    }

    public fun claim_free_soul_item_v6<T0: drop>(arg0: &mut CompositionRegistryV6, arg1: &CompositionProtocolConfigV6, arg2: &MakerProfileV6, arg3: &ItemProductV6, arg4: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerRootV5, arg5: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::CommerceProtocolConfigV5, arg6: 0x2::object::ID, arg7: T0, arg8: &0x2::clock::Clock, arg9: &0x2::tx_context::TxContext) {
        assert_player_action(arg0, arg1, arg2, arg3, arg4, arg5);
        assert!(arg3.access_kind == 1, 14);
        assert!(arg3.binding_kind == 2, 45);
        grant_soul_entitlement_internal<T0>(arg0, arg1, arg2, arg3, arg6, 0, arg7, arg8, arg9);
    }

    public fun claim_free_wallet_item_v6(arg0: &mut CompositionRegistryV6, arg1: &CompositionProtocolConfigV6, arg2: &MakerProfileV6, arg3: &ItemProductV6, arg4: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerRootV5, arg5: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::CommerceProtocolConfigV5, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert_player_action(arg0, arg1, arg2, arg3, arg4, arg5);
        assert!(arg3.access_kind == 1, 14);
        assert!(arg3.binding_kind == 1 || arg3.binding_kind == 3, 45);
        let v0 = grant_wallet_entitlement_internal(arg0, arg1, arg2, arg3, 0, arg6, arg7);
        if (0x1::option::is_some<OwnedItemV6>(&v0)) {
            0x2::transfer::transfer<OwnedItemV6>(0x1::option::destroy_some<OwnedItemV6>(v0), 0x2::tx_context::sender(arg7));
        } else {
            0x1::option::destroy_none<OwnedItemV6>(v0);
        };
    }

    public fun claim_physical_v7_initializer(arg0: &CompositionProtocolConfigV6, arg1: &mut CompositionAdminCapV6) {
        assert_admin(arg0, arg1);
        let v0 = PhysicalV7InitializedKey{dummy_field: false};
        assert!(!0x2::dynamic_field::exists<PhysicalV7InitializedKey>(&arg1.id, v0), 60);
        let v1 = PhysicalV7InitializedKey{dummy_field: false};
        0x2::dynamic_field::add<PhysicalV7InitializedKey, u64>(&mut arg1.id, v1, 7);
    }

    public fun composition_admin_cap_config_id_v6(arg0: &CompositionAdminCapV6) : 0x2::object::ID {
        arg0.config_id
    }

    public fun composition_admin_cap_id_v6(arg0: &CompositionAdminCapV6) : 0x2::object::ID {
        0x2::object::id<CompositionAdminCapV6>(arg0)
    }

    public fun composition_protocol_version_v6() : u64 {
        6
    }

    public fun consume_initial_loadout_authorization_v6(arg0: InitialLoadoutAuthorizationV6) : (0x2::object::ID, 0x2::object::ID, 0x2::object::ID, address, vector<u8>, vector<u8>, vector<u8>, vector<LoadoutSelectionV6>, u64, u64) {
        let InitialLoadoutAuthorizationV6 {
            profile_id             : v0,
            root_id                : v1,
            soul_id                : v2,
            authorizer             : v3,
            client_nonce           : v4,
            loadout_hash           : v5,
            slot_schema_commitment : v6,
            selections             : v7,
            wallet_bound_count     : v8,
            version                : v9,
        } = arg0;
        (v0, v1, v2, v3, v4, v5, v6, v7, v8, v9)
    }

    public fun consume_loadout_authorization_v6(arg0: LoadoutAuthorizationV6) : (0x2::object::ID, 0x2::object::ID, 0x2::object::ID, address, vector<u8>, vector<u8>, vector<u8>, vector<LoadoutSelectionV6>, u64, u64) {
        let LoadoutAuthorizationV6 {
            profile_id             : v0,
            root_id                : v1,
            soul_id                : v2,
            authorizer             : v3,
            client_nonce           : v4,
            loadout_hash           : v5,
            slot_schema_commitment : v6,
            selections             : v7,
            wallet_bound_count     : v8,
            version                : v9,
        } = arg0;
        (v0, v1, v2, v3, v4, v5, v6, v7, v8, v9)
    }

    public fun consume_owned_item_for_physical_v7(arg0: &mut CompositionRegistryV6, arg1: &CompositionProtocolConfigV6, arg2: &MakerProfileV6, arg3: OwnedItemV6, arg4: &0x2::tx_context::TxContext) : (0x2::object::ID, address, bool, u64) {
        assert_registry(arg1, arg0);
        assert!(arg2.config_id == 0x2::object::id<CompositionProtocolConfigV6>(arg1), 2);
        assert!(arg3.config_id == 0x2::object::id<CompositionProtocolConfigV6>(arg1), 35);
        assert!(arg3.profile_id == 0x2::object::id<MakerProfileV6>(arg2), 35);
        assert!(arg3.holder == 0x2::tx_context::sender(arg4), 39);
        assert!(0x1::option::is_none<0x2::object::ID>(&arg3.locked_soul), 36);
        let v0 = 0x2::object::id<OwnedItemV6>(&arg3);
        assert!(!0x2::table::contains<0x2::object::ID, OwnedLockRecordV6>(&arg0.owned_locks, v0), 36);
        let v1 = WalletEntitlementKeyV6{
            profile_id : arg3.profile_id,
            product_id : arg3.product_id,
            wallet     : arg3.holder,
        };
        assert!(0x2::table::contains<WalletEntitlementKeyV6, EntitlementRecordV6>(&arg0.wallet_entitlements, v1), 26);
        let v2 = 0x2::table::remove<WalletEntitlementKeyV6, EntitlementRecordV6>(&mut arg0.wallet_entitlements, v1);
        assert!(0x1::option::is_some<0x2::object::ID>(&v2.owned_instance_id), 33);
        assert!(*0x1::option::borrow<0x2::object::ID>(&v2.owned_instance_id) == v0, 35);
        let OwnedItemV6 {
            id              : v3,
            version         : _,
            config_id       : _,
            profile_id      : _,
            product_id      : v7,
            holder          : v8,
            transferable    : v9,
            locked_soul     : _,
            ownership_epoch : v11,
        } = arg3;
        0x2::object::delete(v3);
        (v7, v8, v9, v11)
    }

    public fun create_maker_profile_v6(arg0: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerRootV5, arg1: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerControlCapV5, arg2: &CompositionProtocolConfigV6, arg3: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::CommerceProtocolConfigV5, arg4: &mut CompositionRegistryV6, arg5: u8, arg6: bool, arg7: u8, arg8: vector<u8>, arg9: vector<u8>, arg10: 0x1::string::String, arg11: vector<u8>, arg12: vector<u8>, arg13: &mut 0x2::tx_context::TxContext) {
        assert_v6_publication_gate(arg2, arg3);
        0x2::transfer::share_object<MakerProfileV6>(new_profile(arg0, arg1, arg2, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13));
    }

    fun create_owned_item(arg0: &CompositionProtocolConfigV6, arg1: &MakerProfileV6, arg2: &ItemProductV6, arg3: address, arg4: &mut 0x2::tx_context::TxContext) : OwnedItemV6 {
        OwnedItemV6{
            id              : 0x2::object::new(arg4),
            version         : 6,
            config_id       : 0x2::object::id<CompositionProtocolConfigV6>(arg0),
            profile_id      : 0x2::object::id<MakerProfileV6>(arg1),
            product_id      : 0x2::object::id<ItemProductV6>(arg2),
            holder          : arg3,
            transferable    : arg2.transferable,
            locked_soul     : 0x1::option::none<0x2::object::ID>(),
            ownership_epoch : 0,
        }
    }

    public fun deactivate_item_admission_v6(arg0: &mut MakerProfileV6, arg1: 0x2::object::ID, arg2: &CompositionProtocolConfigV6, arg3: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::CommerceProtocolConfigV5, arg4: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::ProtocolFeeAdminCap, arg5: &CompositionAdminCapV6, arg6: &0x2::tx_context::TxContext) {
        assert_protocol_link(arg2, arg3);
        0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::assert_extension_protocol_admin_v5(arg3, arg4);
        assert_admin(arg2, arg5);
        assert!(arg0.config_id == 0x2::object::id<CompositionProtocolConfigV6>(arg2), 2);
        assert!(0x2::table::contains<0x2::object::ID, AdmissionRecordV6>(&arg0.admissions, arg1), 18);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, AdmissionRecordV6>(&mut arg0.admissions, arg1);
        assert!(v0.active, 19);
        v0.active = false;
        let v1 = ItemAdmissionStatusChangedV6{
            profile_id : 0x2::object::id<MakerProfileV6>(arg0),
            product_id : arg1,
            active     : false,
            changed_by : 0x2::tx_context::sender(arg6),
        };
        0x2::event::emit<ItemAdmissionStatusChangedV6>(v1);
    }

    fun decrement_soul_owned_lock_count(arg0: &mut CompositionRegistryV6, arg1: 0x2::object::ID) {
        assert!(0x2::table::contains<0x2::object::ID, u64>(&arg0.soul_owned_lock_counts, arg1), 37);
        let v0 = *0x2::table::borrow<0x2::object::ID, u64>(&arg0.soul_owned_lock_counts, arg1);
        assert!(v0 > 0, 37);
        if (v0 == 1) {
            assert!(0x2::table::remove<0x2::object::ID, u64>(&mut arg0.soul_owned_lock_counts, arg1) == 1, 37);
        } else {
            let v1 = 0x2::table::borrow_mut<0x2::object::ID, u64>(&mut arg0.soul_owned_lock_counts, arg1);
            *v1 = *v1 - 1;
        };
    }

    fun defining_type_name<T0>() : 0x1::string::String {
        0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()))
    }

    fun grant_soul_entitlement_internal<T0: drop>(arg0: &mut CompositionRegistryV6, arg1: &CompositionProtocolConfigV6, arg2: &MakerProfileV6, arg3: &ItemProductV6, arg4: 0x2::object::ID, arg5: u64, arg6: T0, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) {
        assert_soul_owner_proof_type<T0>(arg1);
        assert!(0x2::object::id_to_address(&arg4) != @0x0, 30);
        let v0 = SoulEntitlementKeyV6{
            profile_id : 0x2::object::id<MakerProfileV6>(arg2),
            product_id : 0x2::object::id<ItemProductV6>(arg3),
            soul_id    : arg4,
        };
        assert!(!0x2::table::contains<SoulEntitlementKeyV6, EntitlementRecordV6>(&arg0.soul_entitlements, v0), 25);
        let v1 = EntitlementRecordV6{
            purchaser         : 0x2::tx_context::sender(arg8),
            granted_at_ms     : 0x2::clock::timestamp_ms(arg7),
            paid_atomic       : arg5,
            owned_instance_id : 0x1::option::none<0x2::object::ID>(),
        };
        0x2::table::add<SoulEntitlementKeyV6, EntitlementRecordV6>(&mut arg0.soul_entitlements, v0, v1);
        let v2 = EntitlementGrantedV6{
            profile_id        : 0x2::object::id<MakerProfileV6>(arg2),
            product_id        : 0x2::object::id<ItemProductV6>(arg3),
            subject_kind      : 1,
            wallet            : 0x2::tx_context::sender(arg8),
            soul_id           : 0x1::option::some<0x2::object::ID>(arg4),
            paid_atomic       : arg5,
            owned_instance_id : 0x1::option::none<0x2::object::ID>(),
        };
        0x2::event::emit<EntitlementGrantedV6>(v2);
    }

    fun grant_wallet_entitlement_internal(arg0: &mut CompositionRegistryV6, arg1: &CompositionProtocolConfigV6, arg2: &MakerProfileV6, arg3: &ItemProductV6, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<OwnedItemV6> {
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = WalletEntitlementKeyV6{
            profile_id : 0x2::object::id<MakerProfileV6>(arg2),
            product_id : 0x2::object::id<ItemProductV6>(arg3),
            wallet     : v0,
        };
        assert!(!0x2::table::contains<WalletEntitlementKeyV6, EntitlementRecordV6>(&arg0.wallet_entitlements, v1), 25);
        let v2 = if (arg3.binding_kind == 3) {
            assert!(arg2.item_assetization, 45);
            0x1::option::some<OwnedItemV6>(create_owned_item(arg1, arg2, arg3, v0, arg6))
        } else {
            0x1::option::none<OwnedItemV6>()
        };
        let v3 = v2;
        let v4 = if (0x1::option::is_some<OwnedItemV6>(&v3)) {
            0x1::option::some<0x2::object::ID>(0x2::object::id<OwnedItemV6>(0x1::option::borrow<OwnedItemV6>(&v3)))
        } else {
            0x1::option::none<0x2::object::ID>()
        };
        let v5 = EntitlementRecordV6{
            purchaser         : v0,
            granted_at_ms     : 0x2::clock::timestamp_ms(arg5),
            paid_atomic       : arg4,
            owned_instance_id : v4,
        };
        0x2::table::add<WalletEntitlementKeyV6, EntitlementRecordV6>(&mut arg0.wallet_entitlements, v1, v5);
        let v6 = EntitlementGrantedV6{
            profile_id        : 0x2::object::id<MakerProfileV6>(arg2),
            product_id        : 0x2::object::id<ItemProductV6>(arg3),
            subject_kind      : 0,
            wallet            : v0,
            soul_id           : 0x1::option::none<0x2::object::ID>(),
            paid_atomic       : arg4,
            owned_instance_id : v4,
        };
        0x2::event::emit<EntitlementGrantedV6>(v6);
        v3
    }

    public fun hash_loadout_selections_v6(arg0: &vector<LoadoutSelectionV6>) : vector<u8> {
        let v0 = LoadoutHashInputV6{selections: *arg0};
        0x1::hash::sha2_256(0x1::bcs::to_bytes<LoadoutHashInputV6>(&v0))
    }

    fun id_vector_contains(arg0: &vector<0x2::object::ID>, arg1: 0x2::object::ID) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x2::object::ID>(arg0)) {
            if (*0x1::vector::borrow<0x2::object::ID>(arg0, v0) == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    fun id_vector_contains_before(arg0: &vector<0x2::object::ID>, arg1: 0x2::object::ID, arg2: u64) : bool {
        let v0 = 0;
        while (v0 < arg2) {
            if (*0x1::vector::borrow<0x2::object::ID>(arg0, v0) == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    fun increment_soul_owned_lock_count(arg0: &mut CompositionRegistryV6, arg1: 0x2::object::ID) {
        if (0x2::table::contains<0x2::object::ID, u64>(&arg0.soul_owned_lock_counts, arg1)) {
            let v0 = 0x2::table::borrow_mut<0x2::object::ID, u64>(&mut arg0.soul_owned_lock_counts, arg1);
            *v0 = *v0 + 1;
        } else {
            0x2::table::add<0x2::object::ID, u64>(&mut arg0.soul_owned_lock_counts, arg1, 1);
        };
    }

    public fun initial_loadout_authorization_wallet_bound_count_v6(arg0: &InitialLoadoutAuthorizationV6) : u64 {
        arg0.wallet_bound_count
    }

    public fun initialize_composition_protocol_v6<T0>(arg0: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::CommerceProtocolConfigV5, arg1: &mut 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::ProtocolFeeAdminCap, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::assert_extension_protocol_admin_v5(arg0, arg1);
        assert_hash(&arg2);
        let v0 = payment_coin_type_name<T0>();
        assert!(&v0 == 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::extension_payment_coin_type_v5(arg0), 3);
        0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::claim_composition_v6_initializer(arg1);
        let (v1, v2, v3, v4, v5) = new_protocol_objects<T0>(arg0, arg1, arg2, arg3);
        let v6 = v5;
        let v7 = v3;
        let v8 = v2;
        let v9 = v1;
        let v10 = CompositionProtocolInitializedV6{
            config_id                   : 0x2::object::id<CompositionProtocolConfigV6>(&v9),
            treasury_id                 : 0x2::object::id<CompositionProtocolTreasuryV6<T0>>(&v8),
            registry_id                 : 0x2::object::id<CompositionRegistryV6>(&v7),
            validator_cap_id            : 0x2::object::id<ValidatorCapV6>(&v6),
            validator_epoch             : v9.validator_epoch,
            validator_policy_commitment : v9.validator_policy_commitment,
            payment_coin_type           : payment_coin_type_name<T0>(),
            enabled                     : false,
        };
        0x2::event::emit<CompositionProtocolInitializedV6>(v10);
        0x2::transfer::share_object<CompositionProtocolConfigV6>(v9);
        0x2::transfer::share_object<CompositionProtocolTreasuryV6<T0>>(v8);
        0x2::transfer::share_object<CompositionRegistryV6>(v7);
        0x2::transfer::transfer<CompositionAdminCapV6>(v4, 0x2::tx_context::sender(arg3));
        0x2::transfer::transfer<ValidatorCapV6>(v6, 0x2::tx_context::sender(arg3));
    }

    public fun item_is_admitted_v6(arg0: &MakerProfileV6, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, AdmissionRecordV6>(&arg0.admissions, arg1)
    }

    public fun loadout_authorization_wallet_bound_count_v6(arg0: &LoadoutAuthorizationV6) : u64 {
        arg0.wallet_bound_count
    }

    public fun loadout_selection_owned_instance_id_v6(arg0: &LoadoutSelectionV6) : 0x1::option::Option<0x2::object::ID> {
        arg0.owned_instance_id
    }

    public fun loadout_selection_product_id_v6(arg0: &LoadoutSelectionV6) : 0x2::object::ID {
        arg0.product_id
    }

    public fun loadout_selection_slot_key_v6(arg0: &LoadoutSelectionV6) : &0x1::string::String {
        &arg0.slot_key
    }

    public fun loadout_selection_subject_kind_v6(arg0: &LoadoutSelectionV6) : u8 {
        arg0.subject_kind
    }

    public fun lock_owned_item_to_soul_v6<T0: drop>(arg0: &mut CompositionRegistryV6, arg1: &CompositionProtocolConfigV6, arg2: &MakerProfileV6, arg3: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerRootV5, arg4: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::CommerceProtocolConfigV5, arg5: &mut OwnedItemV6, arg6: 0x2::object::ID, arg7: T0, arg8: &0x2::tx_context::TxContext) {
        assert_v6_operational(arg1, arg2, arg3, arg4);
        assert_registry(arg1, arg0);
        assert_soul_owner_proof_type<T0>(arg1);
        assert!(0x2::object::id_to_address(&arg6) != @0x0, 30);
        assert!(arg5.config_id == 0x2::object::id<CompositionProtocolConfigV6>(arg1), 35);
        assert!(arg5.profile_id == 0x2::object::id<MakerProfileV6>(arg2), 35);
        assert!(arg5.holder == 0x2::tx_context::sender(arg8), 39);
        assert!(0x1::option::is_none<0x2::object::ID>(&arg5.locked_soul), 36);
        let v0 = 0x2::object::id<OwnedItemV6>(arg5);
        assert!(!0x2::table::contains<0x2::object::ID, OwnedLockRecordV6>(&arg0.owned_locks, v0), 36);
        arg5.locked_soul = 0x1::option::some<0x2::object::ID>(arg6);
        let v1 = OwnedLockRecordV6{
            profile_id      : arg5.profile_id,
            product_id      : arg5.product_id,
            holder          : arg5.holder,
            soul_id         : arg6,
            ownership_epoch : arg5.ownership_epoch,
        };
        0x2::table::add<0x2::object::ID, OwnedLockRecordV6>(&mut arg0.owned_locks, v0, v1);
        increment_soul_owned_lock_count(arg0, arg6);
        let v2 = OwnedItemLockChangedV6{
            instance_id : v0,
            profile_id  : arg5.profile_id,
            product_id  : arg5.product_id,
            holder      : arg5.holder,
            soul_id     : arg6,
            locked      : true,
        };
        0x2::event::emit<OwnedItemLockChangedV6>(v2);
    }

    fun new_external_item_product(arg0: &MakerProfileV6, arg1: &CompositionProtocolConfigV6, arg2: u8, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: 0x1::string::String, arg7: u8, arg8: u8, arg9: u8, arg10: u64, arg11: u16, arg12: bool, arg13: vector<0x2::object::ID>, arg14: vector<0x2::object::ID>, arg15: vector<u8>, arg16: &mut 0x2::tx_context::TxContext) : ItemProductV6 {
        assert!(arg0.config_id == 0x2::object::id<CompositionProtocolConfigV6>(arg1), 2);
        assert!(arg2 == 1 || arg2 == 2, 58);
        let v0 = 0x2::tx_context::sender(arg16);
        let v1 = 0x2::tx_context::sender(arg16);
        new_item_product(arg1, arg0, 0x1::option::none<0x2::object::ID>(), v0, v1, arg2, arg3, arg4, arg5, arg6, arg0.slot_schema_commitment, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16)
    }

    fun new_item_product(arg0: &CompositionProtocolConfigV6, arg1: &MakerProfileV6, arg2: 0x1::option::Option<0x2::object::ID>, arg3: address, arg4: address, arg5: u8, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<u8>, arg9: 0x1::string::String, arg10: vector<u8>, arg11: u8, arg12: u8, arg13: u8, arg14: u64, arg15: u16, arg16: bool, arg17: vector<0x2::object::ID>, arg18: vector<0x2::object::ID>, arg19: vector<u8>, arg20: &mut 0x2::tx_context::TxContext) : ItemProductV6 {
        assert_protocol_enabled_v6(arg0);
        assert!(arg3 != @0x0 && arg4 != @0x0, 28);
        assert_hash(&arg6);
        assert_hash(&arg7);
        assert_hash(&arg8);
        assert_hash(&arg10);
        assert_hash(&arg19);
        assert_non_empty(&arg9);
        assert_valid_origin_kind(arg5);
        assert_valid_rights_origin(arg11);
        assert_valid_access(arg1, arg12, arg13, arg14, arg16);
        assert!(arg15 <= 1000, 46);
        let v0 = ItemProductV6{
            id                       : 0x2::object::new(arg20),
            version                  : 6,
            config_id                : 0x2::object::id<CompositionProtocolConfigV6>(arg0),
            source_root_id           : arg2,
            publisher                : arg3,
            original_creator         : arg4,
            origin_kind              : arg5,
            family_commitment        : arg6,
            definition_commitment    : arg7,
            asset_commitment         : arg8,
            slot_key                 : arg9,
            slot_schema_commitment   : arg10,
            rights_origin            : arg11,
            access_kind              : arg12,
            binding_kind             : arg13,
            price_atomic             : arg14,
            primary_protocol_fee_bps : arg0.primary_protocol_fee_bps,
            maker_ecosystem_fee_bps  : arg15,
            transferable             : arg16,
            required_product_ids     : arg17,
            excluded_product_ids     : arg18,
            extensions_hash          : arg19,
        };
        assert_product_rules(&v0);
        let v1 = ItemProductPublishedV6{
            product_id              : 0x2::object::id<ItemProductV6>(&v0),
            source_root_id          : arg2,
            publisher               : arg3,
            origin_kind             : arg5,
            access_kind             : arg12,
            binding_kind            : arg13,
            price_atomic            : arg14,
            maker_ecosystem_fee_bps : arg15,
            transferable            : arg16,
        };
        0x2::event::emit<ItemProductPublishedV6>(v1);
        v0
    }

    public fun new_loadout_selection_v6(arg0: 0x2::object::ID, arg1: 0x1::string::String, arg2: u8, arg3: 0x1::option::Option<0x2::object::ID>) : LoadoutSelectionV6 {
        assert_non_empty(&arg1);
        let v0 = if (arg2 == 0) {
            true
        } else if (arg2 == 1) {
            true
        } else {
            arg2 == 2
        };
        assert!(v0, 32);
        if (arg2 == 1 || arg2 == 2) {
            assert!(0x1::option::is_none<0x2::object::ID>(&arg3), 34);
        };
        LoadoutSelectionV6{
            product_id        : arg0,
            slot_key          : arg1,
            subject_kind      : arg2,
            owned_instance_id : arg3,
        }
    }

    fun new_official_item_product(arg0: &MakerProfileV6, arg1: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerRootV5, arg2: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerControlCapV5, arg3: &CompositionProtocolConfigV6, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: 0x1::string::String, arg8: u8, arg9: u8, arg10: u64, arg11: u16, arg12: bool, arg13: vector<0x2::object::ID>, arg14: vector<0x2::object::ID>, arg15: vector<u8>, arg16: &mut 0x2::tx_context::TxContext) : ItemProductV6 {
        0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::assert_extension_control_v5(arg1, arg2, arg16);
        assert_profile_link(arg3, arg0, arg1);
        new_item_product(arg3, arg0, 0x1::option::some<0x2::object::ID>(arg0.root_id), 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::root_current_owner_v5(arg1), 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::root_current_owner_v5(arg1), 0, arg4, arg5, arg6, arg7, arg0.slot_schema_commitment, arg0.rights_origin, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16)
    }

    fun new_profile(arg0: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerRootV5, arg1: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerControlCapV5, arg2: &CompositionProtocolConfigV6, arg3: &mut CompositionRegistryV6, arg4: u8, arg5: bool, arg6: u8, arg7: vector<u8>, arg8: vector<u8>, arg9: 0x1::string::String, arg10: vector<u8>, arg11: vector<u8>, arg12: &mut 0x2::tx_context::TxContext) : MakerProfileV6 {
        assert_protocol_enabled_v6(arg2);
        0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::assert_extension_control_v5(arg0, arg1, arg12);
        assert_registry(arg2, arg3);
        assert_valid_profile_mode(arg4);
        assert_valid_third_party_policy(arg6);
        if (arg4 == 0) {
            assert!(!arg5, 7);
            assert!(arg6 == 0, 7);
        };
        assert_hash(&arg7);
        assert_hash(&arg8);
        assert_companion_manifest(&arg9, &arg10);
        assert_hash(&arg11);
        let v0 = 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::root_id_v5(arg0);
        assert!(!0x2::table::contains<0x2::object::ID, 0x2::object::ID>(&arg3.profiles, v0), 9);
        let v1 = MakerProfileV6{
            id                         : 0x2::object::new(arg12),
            version                    : 6,
            config_id                  : 0x2::object::id<CompositionProtocolConfigV6>(arg2),
            root_id                    : v0,
            mode                       : arg4,
            loadout_mutable            : arg4 == 1,
            item_assetization          : arg5,
            third_party_policy         : arg6,
            slot_schema_commitment     : arg7,
            renderer_commitment        : arg8,
            rights_origin              : 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::root_rights_origin_v5(arg0),
            primary_protocol_fee_bps   : arg2.primary_protocol_fee_bps,
            companion_manifest_blob_id : arg9,
            companion_manifest_hash    : arg10,
            extensions_hash            : arg11,
            sealed                     : false,
            admissions                 : 0x2::table::new<0x2::object::ID, AdmissionRecordV6>(arg12),
            admission_count            : 0,
        };
        0x2::table::add<0x2::object::ID, 0x2::object::ID>(&mut arg3.profiles, v0, 0x2::object::id<MakerProfileV6>(&v1));
        let v2 = MakerProfileCreatedV6{
            profile_id                 : 0x2::object::id<MakerProfileV6>(&v1),
            root_id                    : v0,
            mode                       : arg4,
            item_assetization          : arg5,
            third_party_policy         : arg6,
            companion_manifest_blob_id : v1.companion_manifest_blob_id,
            companion_manifest_hash    : v1.companion_manifest_hash,
        };
        0x2::event::emit<MakerProfileCreatedV6>(v2);
        v1
    }

    fun new_protocol_objects<T0>(arg0: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::CommerceProtocolConfigV5, arg1: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::ProtocolFeeAdminCap, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) : (CompositionProtocolConfigV6, CompositionProtocolTreasuryV6<T0>, CompositionRegistryV6, CompositionAdminCapV6, ValidatorCapV6) {
        0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::assert_extension_protocol_admin_v5(arg0, arg1);
        assert_hash(&arg2);
        let v0 = payment_coin_type_name<T0>();
        assert!(&v0 == 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::extension_payment_coin_type_v5(arg0), 3);
        let v1 = 0x2::object::new(arg3);
        let v2 = 0x2::object::uid_to_inner(&v1);
        let v3 = CompositionProtocolTreasuryV6<T0>{
            id              : 0x2::object::new(arg3),
            version         : 6,
            config_id       : v2,
            revenue         : 0x2::balance::zero<T0>(),
            total_collected : 0,
            total_withdrawn : 0,
        };
        let v4 = CompositionRegistryV6{
            id                     : 0x2::object::new(arg3),
            version                : 6,
            config_id              : v2,
            profiles               : 0x2::table::new<0x2::object::ID, 0x2::object::ID>(arg3),
            wallet_entitlements    : 0x2::table::new<WalletEntitlementKeyV6, EntitlementRecordV6>(arg3),
            soul_entitlements      : 0x2::table::new<SoulEntitlementKeyV6, EntitlementRecordV6>(arg3),
            owned_locks            : 0x2::table::new<0x2::object::ID, OwnedLockRecordV6>(arg3),
            soul_owned_lock_counts : 0x2::table::new<0x2::object::ID, u64>(arg3),
            used_nonces            : 0x2::table::new<LoadoutNonceKeyV6, bool>(arg3),
        };
        let v5 = CompositionAdminCapV6{
            id        : 0x2::object::new(arg3),
            version   : 6,
            config_id : v2,
        };
        let v6 = ValidatorCapV6{
            id              : 0x2::object::new(arg3),
            version         : 6,
            config_id       : v2,
            validator_epoch : 0,
        };
        let v7 = CompositionProtocolConfigV6{
            id                          : v1,
            version                     : 6,
            v5_config_id                : 0x2::object::id<0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::CommerceProtocolConfigV5>(arg0),
            v5_admin_cap_id             : 0x2::object::id<0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::ProtocolFeeAdminCap>(arg1),
            treasury_id                 : 0x2::object::id<CompositionProtocolTreasuryV6<T0>>(&v3),
            registry_id                 : 0x2::object::id<CompositionRegistryV6>(&v4),
            validator_cap_id            : 0x2::object::id<ValidatorCapV6>(&v6),
            validator_epoch             : 0,
            payment_coin_type           : payment_coin_type_name<T0>(),
            primary_protocol_fee_bps    : 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::primary_protocol_fee_bps_v5(arg0),
            validator_policy_commitment : arg2,
            soul_owner_proof_type       : 0x1::option::none<0x1::string::String>(),
            enabled                     : false,
        };
        (v7, v3, v4, v5, v6)
    }

    fun new_validator_attestation(arg0: &CompositionProtocolConfigV6, arg1: &ValidatorCapV6, arg2: &MakerProfileV6, arg3: &ItemProductV6, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : ValidatorAttestationV6 {
        assert_protocol_enabled_v6(arg0);
        let v0 = if (arg1.config_id == 0x2::object::id<CompositionProtocolConfigV6>(arg0)) {
            if (0x2::object::id<ValidatorCapV6>(arg1) == arg0.validator_cap_id) {
                arg1.validator_epoch == arg0.validator_epoch
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 24);
        assert!(arg2.config_id == 0x2::object::id<CompositionProtocolConfigV6>(arg0), 2);
        assert!(arg3.config_id == 0x2::object::id<CompositionProtocolConfigV6>(arg0), 2);
        assert!(&arg3.slot_schema_commitment == &arg2.slot_schema_commitment, 16);
        ValidatorAttestationV6{
            id                          : 0x2::object::new(arg5),
            version                     : 6,
            config_id                   : 0x2::object::id<CompositionProtocolConfigV6>(arg0),
            profile_id                  : 0x2::object::id<MakerProfileV6>(arg2),
            product_id                  : 0x2::object::id<ItemProductV6>(arg3),
            definition_commitment       : arg3.definition_commitment,
            slot_schema_commitment      : arg2.slot_schema_commitment,
            validator_policy_commitment : arg0.validator_policy_commitment,
            validator_epoch             : arg0.validator_epoch,
            issued_at_ms                : 0x2::clock::timestamp_ms(arg4),
        }
    }

    public fun origin_certified_v6() : u8 {
        1
    }

    public fun origin_official_v6() : u8 {
        0
    }

    public fun origin_open_v6() : u8 {
        2
    }

    public fun owned_item_holder_v6(arg0: &OwnedItemV6) : address {
        arg0.holder
    }

    public fun owned_item_id_v6(arg0: &OwnedItemV6) : 0x2::object::ID {
        0x2::object::id<OwnedItemV6>(arg0)
    }

    public fun owned_item_locked_soul_v6(arg0: &OwnedItemV6) : 0x1::option::Option<0x2::object::ID> {
        arg0.locked_soul
    }

    public fun owned_item_ownership_epoch_v6(arg0: &OwnedItemV6) : u64 {
        arg0.ownership_epoch
    }

    public fun owned_item_product_id_v6(arg0: &OwnedItemV6) : 0x2::object::ID {
        arg0.product_id
    }

    public fun owned_item_transferable_v6(arg0: &OwnedItemV6) : bool {
        arg0.transferable
    }

    fun payment_coin_type_name<T0>() : 0x1::string::String {
        defining_type_name<T0>()
    }

    public fun product_access_kind_v6(arg0: &ItemProductV6) : u8 {
        arg0.access_kind
    }

    public fun product_asset_commitment_v6(arg0: &ItemProductV6) : &vector<u8> {
        &arg0.asset_commitment
    }

    public fun product_binding_kind_v6(arg0: &ItemProductV6) : u8 {
        arg0.binding_kind
    }

    public fun product_config_id_v6(arg0: &ItemProductV6) : 0x2::object::ID {
        arg0.config_id
    }

    public fun product_definition_commitment_v6(arg0: &ItemProductV6) : &vector<u8> {
        &arg0.definition_commitment
    }

    public fun product_excluded_product_ids_v6(arg0: &ItemProductV6) : &vector<0x2::object::ID> {
        &arg0.excluded_product_ids
    }

    public fun product_family_commitment_v6(arg0: &ItemProductV6) : &vector<u8> {
        &arg0.family_commitment
    }

    public fun product_id_v6(arg0: &ItemProductV6) : 0x2::object::ID {
        0x2::object::id<ItemProductV6>(arg0)
    }

    public fun product_maker_ecosystem_fee_bps_v6(arg0: &ItemProductV6) : u16 {
        arg0.maker_ecosystem_fee_bps
    }

    public fun product_origin_kind_v6(arg0: &ItemProductV6) : u8 {
        arg0.origin_kind
    }

    public fun product_original_creator_v6(arg0: &ItemProductV6) : address {
        arg0.original_creator
    }

    public fun product_price_atomic_v6(arg0: &ItemProductV6) : u64 {
        arg0.price_atomic
    }

    public fun product_primary_protocol_fee_bps_v6(arg0: &ItemProductV6) : u16 {
        arg0.primary_protocol_fee_bps
    }

    public fun product_publisher_v6(arg0: &ItemProductV6) : address {
        arg0.publisher
    }

    public fun product_required_product_ids_v6(arg0: &ItemProductV6) : &vector<0x2::object::ID> {
        &arg0.required_product_ids
    }

    public fun product_rights_origin_v6(arg0: &ItemProductV6) : u8 {
        arg0.rights_origin
    }

    public fun product_slot_key_v6(arg0: &ItemProductV6) : &0x1::string::String {
        &arg0.slot_key
    }

    public fun product_slot_schema_commitment_v6(arg0: &ItemProductV6) : &vector<u8> {
        &arg0.slot_schema_commitment
    }

    public fun product_source_root_id_v6(arg0: &ItemProductV6) : 0x1::option::Option<0x2::object::ID> {
        arg0.source_root_id
    }

    public fun product_transferable_v6(arg0: &ItemProductV6) : bool {
        arg0.transferable
    }

    public fun profile_admission_count_v6(arg0: &MakerProfileV6) : u64 {
        arg0.admission_count
    }

    public fun profile_companion_manifest_blob_id_v6(arg0: &MakerProfileV6) : &0x1::string::String {
        &arg0.companion_manifest_blob_id
    }

    public fun profile_companion_manifest_hash_v6(arg0: &MakerProfileV6) : &vector<u8> {
        &arg0.companion_manifest_hash
    }

    public fun profile_config_id_v6(arg0: &MakerProfileV6) : 0x2::object::ID {
        arg0.config_id
    }

    public fun profile_extensions_hash_v6(arg0: &MakerProfileV6) : &vector<u8> {
        &arg0.extensions_hash
    }

    public fun profile_id_v6(arg0: &MakerProfileV6) : 0x2::object::ID {
        0x2::object::id<MakerProfileV6>(arg0)
    }

    public fun profile_item_assetization_v6(arg0: &MakerProfileV6) : bool {
        arg0.item_assetization
    }

    public fun profile_loadout_mutable_v6(arg0: &MakerProfileV6) : bool {
        arg0.loadout_mutable
    }

    public fun profile_mode_composable_v6() : u8 {
        1
    }

    public fun profile_mode_fixed_v6() : u8 {
        0
    }

    public fun profile_mode_v6(arg0: &MakerProfileV6) : u8 {
        arg0.mode
    }

    public fun profile_renderer_commitment_v6(arg0: &MakerProfileV6) : &vector<u8> {
        &arg0.renderer_commitment
    }

    public fun profile_root_id_v6(arg0: &MakerProfileV6) : 0x2::object::ID {
        arg0.root_id
    }

    public fun profile_sealed_v6(arg0: &MakerProfileV6) : bool {
        arg0.sealed
    }

    public fun profile_slot_schema_commitment_v6(arg0: &MakerProfileV6) : &vector<u8> {
        &arg0.slot_schema_commitment
    }

    public fun profile_third_party_policy_v6(arg0: &MakerProfileV6) : u8 {
        arg0.third_party_policy
    }

    public fun protocol_config_id_v6(arg0: &CompositionProtocolConfigV6) : 0x2::object::ID {
        0x2::object::id<CompositionProtocolConfigV6>(arg0)
    }

    public fun protocol_enabled_v6(arg0: &CompositionProtocolConfigV6) : bool {
        arg0.enabled
    }

    public fun protocol_primary_fee_bps_v6(arg0: &CompositionProtocolConfigV6) : u16 {
        arg0.primary_protocol_fee_bps
    }

    public fun protocol_soul_owner_proof_type_v6(arg0: &CompositionProtocolConfigV6) : 0x1::option::Option<0x1::string::String> {
        arg0.soul_owner_proof_type
    }

    public fun protocol_treasury_balance_v6<T0>(arg0: &CompositionProtocolTreasuryV6<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.revenue)
    }

    public fun protocol_v5_config_id_v6(arg0: &CompositionProtocolConfigV6) : 0x2::object::ID {
        arg0.v5_config_id
    }

    public fun protocol_validator_cap_id_v6(arg0: &CompositionProtocolConfigV6) : 0x2::object::ID {
        arg0.validator_cap_id
    }

    public fun protocol_validator_epoch_v6(arg0: &CompositionProtocolConfigV6) : u64 {
        arg0.validator_epoch
    }

    public fun protocol_validator_policy_commitment_v6(arg0: &CompositionProtocolConfigV6) : &vector<u8> {
        &arg0.validator_policy_commitment
    }

    public fun publish_external_item_product_v6(arg0: &MakerProfileV6, arg1: &CompositionProtocolConfigV6, arg2: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::CommerceProtocolConfigV5, arg3: u8, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: 0x1::string::String, arg8: u8, arg9: u8, arg10: u8, arg11: u64, arg12: u16, arg13: bool, arg14: vector<0x2::object::ID>, arg15: vector<0x2::object::ID>, arg16: vector<u8>, arg17: &mut 0x2::tx_context::TxContext) {
        assert_v6_publication_gate(arg1, arg2);
        0x2::transfer::freeze_object<ItemProductV6>(new_external_item_product(arg0, arg1, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17));
    }

    public fun publish_official_item_product_v6(arg0: &MakerProfileV6, arg1: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerRootV5, arg2: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerControlCapV5, arg3: &CompositionProtocolConfigV6, arg4: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::CommerceProtocolConfigV5, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: 0x1::string::String, arg9: u8, arg10: u8, arg11: u64, arg12: u16, arg13: bool, arg14: vector<0x2::object::ID>, arg15: vector<0x2::object::ID>, arg16: vector<u8>, arg17: &mut 0x2::tx_context::TxContext) {
        assert_v6_publication_gate(arg3, arg4);
        0x2::transfer::freeze_object<ItemProductV6>(new_official_item_product(arg0, arg1, arg2, arg3, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17));
    }

    public fun publish_validator_attestation_v6(arg0: &CompositionProtocolConfigV6, arg1: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::CommerceProtocolConfigV5, arg2: &ValidatorCapV6, arg3: &MakerProfileV6, arg4: &ItemProductV6, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert_v6_publication_gate(arg0, arg1);
        0x2::transfer::freeze_object<ValidatorAttestationV6>(new_validator_attestation(arg0, arg2, arg3, arg4, arg5, arg6));
    }

    public fun purchase_owned_item_for_physical_v7<T0>(arg0: &mut CompositionRegistryV6, arg1: &CompositionProtocolConfigV6, arg2: &mut CompositionProtocolTreasuryV6<T0>, arg3: &MakerProfileV6, arg4: &ItemProductV6, arg5: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerRootV5, arg6: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::CommerceProtocolConfigV5, arg7: 0x2::coin::Coin<T0>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : OwnedItemV6 {
        assert_player_action(arg0, arg1, arg3, arg4, arg5, arg6);
        assert!(arg4.access_kind == 2, 14);
        assert!(arg4.binding_kind == 3, 45);
        split_item_payment<T0>(arg1, arg2, arg3, arg4, arg5, arg7, arg9);
        0x1::option::destroy_some<OwnedItemV6>(grant_wallet_entitlement_internal(arg0, arg1, arg3, arg4, 0x2::coin::value<T0>(&arg7), arg8, arg9))
    }

    public fun purchase_soul_item_v6<T0, T1: drop>(arg0: &mut CompositionRegistryV6, arg1: &CompositionProtocolConfigV6, arg2: &mut CompositionProtocolTreasuryV6<T0>, arg3: &MakerProfileV6, arg4: &ItemProductV6, arg5: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerRootV5, arg6: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::CommerceProtocolConfigV5, arg7: 0x2::object::ID, arg8: T1, arg9: 0x2::coin::Coin<T0>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert_player_action(arg0, arg1, arg3, arg4, arg5, arg6);
        assert!(arg4.access_kind == 2, 14);
        assert!(arg4.binding_kind == 2, 45);
        split_item_payment<T0>(arg1, arg2, arg3, arg4, arg5, arg9, arg11);
        grant_soul_entitlement_internal<T1>(arg0, arg1, arg3, arg4, arg7, 0x2::coin::value<T0>(&arg9), arg8, arg10, arg11);
    }

    public fun purchase_wallet_item_v6<T0>(arg0: &mut CompositionRegistryV6, arg1: &CompositionProtocolConfigV6, arg2: &mut CompositionProtocolTreasuryV6<T0>, arg3: &MakerProfileV6, arg4: &ItemProductV6, arg5: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerRootV5, arg6: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::CommerceProtocolConfigV5, arg7: 0x2::coin::Coin<T0>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert_player_action(arg0, arg1, arg3, arg4, arg5, arg6);
        assert!(arg4.access_kind == 2, 14);
        assert!(arg4.binding_kind == 1 || arg4.binding_kind == 3, 45);
        split_item_payment<T0>(arg1, arg2, arg3, arg4, arg5, arg7, arg9);
        let v0 = grant_wallet_entitlement_internal(arg0, arg1, arg3, arg4, 0x2::coin::value<T0>(&arg7), arg8, arg9);
        if (0x1::option::is_some<OwnedItemV6>(&v0)) {
            0x2::transfer::transfer<OwnedItemV6>(0x1::option::destroy_some<OwnedItemV6>(v0), 0x2::tx_context::sender(arg9));
        } else {
            0x1::option::destroy_none<OwnedItemV6>(v0);
        };
    }

    public fun reactivate_item_admission_v6(arg0: &mut MakerProfileV6, arg1: &ItemProductV6, arg2: &ValidatorAttestationV6, arg3: &CompositionProtocolConfigV6, arg4: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::CommerceProtocolConfigV5, arg5: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::ProtocolFeeAdminCap, arg6: &CompositionAdminCapV6, arg7: &0x2::tx_context::TxContext) {
        assert_v6_publication_gate(arg3, arg4);
        0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::assert_extension_protocol_admin_v5(arg4, arg5);
        assert_admin(arg3, arg6);
        assert!(arg0.config_id == 0x2::object::id<CompositionProtocolConfigV6>(arg3), 2);
        let v0 = 0x2::object::id<ItemProductV6>(arg1);
        assert!(0x2::table::contains<0x2::object::ID, AdmissionRecordV6>(&arg0.admissions, v0), 18);
        assert_attestation(arg3, arg0, arg1, arg2);
        let v1 = 0x2::table::borrow_mut<0x2::object::ID, AdmissionRecordV6>(&mut arg0.admissions, v0);
        assert!(!v1.active, 17);
        assert_admission_matches_product(v1, arg1);
        v1.attestation_id = 0x1::option::some<0x2::object::ID>(0x2::object::id<ValidatorAttestationV6>(arg2));
        v1.active = true;
        let v2 = ItemAdmissionStatusChangedV6{
            profile_id : 0x2::object::id<MakerProfileV6>(arg0),
            product_id : v0,
            active     : true,
            changed_by : 0x2::tx_context::sender(arg7),
        };
        0x2::event::emit<ItemAdmissionStatusChangedV6>(v2);
    }

    public fun rights_license_wrapped_v6() : u8 {
        1
    }

    public fun rights_onchain_native_v6() : u8 {
        0
    }

    fun rotate_validator(arg0: &mut CompositionProtocolConfigV6, arg1: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::CommerceProtocolConfigV5, arg2: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::ProtocolFeeAdminCap, arg3: &CompositionAdminCapV6, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) : ValidatorCapV6 {
        assert_protocol_link(arg0, arg1);
        0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::assert_extension_protocol_admin_v5(arg1, arg2);
        assert_admin(arg0, arg3);
        assert!(!arg0.enabled, 54);
        assert_hash(&arg4);
        arg0.validator_epoch = arg0.validator_epoch + 1;
        arg0.validator_policy_commitment = arg4;
        let v0 = ValidatorCapV6{
            id              : 0x2::object::new(arg5),
            version         : 6,
            config_id       : 0x2::object::id<CompositionProtocolConfigV6>(arg0),
            validator_epoch : arg0.validator_epoch,
        };
        arg0.validator_cap_id = 0x2::object::id<ValidatorCapV6>(&v0);
        let v1 = ValidatorRotatedV6{
            config_id                   : 0x2::object::id<CompositionProtocolConfigV6>(arg0),
            validator_cap_id            : 0x2::object::id<ValidatorCapV6>(&v0),
            validator_epoch             : arg0.validator_epoch,
            validator_policy_commitment : arg0.validator_policy_commitment,
        };
        0x2::event::emit<ValidatorRotatedV6>(v1);
        v0
    }

    public fun rotate_validator_v6(arg0: &mut CompositionProtocolConfigV6, arg1: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::CommerceProtocolConfigV5, arg2: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::ProtocolFeeAdminCap, arg3: &CompositionAdminCapV6, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = rotate_validator(arg0, arg1, arg2, arg3, arg4, arg5);
        0x2::transfer::transfer<ValidatorCapV6>(v0, 0x2::tx_context::sender(arg5));
    }

    public fun seal_maker_profile_v6(arg0: &mut MakerProfileV6, arg1: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerRootV5, arg2: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerControlCapV5, arg3: &CompositionProtocolConfigV6, arg4: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::CommerceProtocolConfigV5, arg5: &0x2::tx_context::TxContext) {
        assert_v6_publication_gate(arg3, arg4);
        0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::assert_extension_control_v5(arg1, arg2, arg5);
        assert_profile_link(arg3, arg0, arg1);
        assert!(!arg0.sealed, 11);
        arg0.sealed = true;
        let v0 = MakerProfileSealedV6{
            profile_id : 0x2::object::id<MakerProfileV6>(arg0),
            root_id    : arg0.root_id,
        };
        0x2::event::emit<MakerProfileSealedV6>(v0);
    }

    fun selection_vector_contains_product(arg0: &vector<LoadoutSelectionV6>, arg1: 0x2::object::ID) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<LoadoutSelectionV6>(arg0)) {
            if (0x1::vector::borrow<LoadoutSelectionV6>(arg0, v0).product_id == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun soul_entitlement_exists_v6(arg0: &CompositionRegistryV6, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x2::object::ID) : bool {
        let v0 = SoulEntitlementKeyV6{
            profile_id : arg1,
            product_id : arg2,
            soul_id    : arg3,
        };
        0x2::table::contains<SoulEntitlementKeyV6, EntitlementRecordV6>(&arg0.soul_entitlements, v0)
    }

    public fun soul_owned_lock_count_v6(arg0: &CompositionRegistryV6, arg1: 0x2::object::ID) : u64 {
        if (0x2::table::contains<0x2::object::ID, u64>(&arg0.soul_owned_lock_counts, arg1)) {
            *0x2::table::borrow<0x2::object::ID, u64>(&arg0.soul_owned_lock_counts, arg1)
        } else {
            0
        }
    }

    fun split_item_payment<T0>(arg0: &CompositionProtocolConfigV6, arg1: &mut CompositionProtocolTreasuryV6<T0>, arg2: &MakerProfileV6, arg3: &ItemProductV6, arg4: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerRootV5, arg5: 0x2::coin::Coin<T0>, arg6: &mut 0x2::tx_context::TxContext) {
        assert_treasury<T0>(arg0, arg1);
        let v0 = payment_coin_type_name<T0>();
        assert!(&v0 == &arg0.payment_coin_type, 3);
        assert!(0x2::coin::value<T0>(&arg5) == arg3.price_atomic, 27);
        let v1 = bps_amount(arg3.price_atomic, arg3.primary_protocol_fee_bps);
        let v2 = bps_amount(arg3.price_atomic, arg3.maker_ecosystem_fee_bps);
        if (v1 > 0) {
            0x2::coin::put<T0>(&mut arg1.revenue, 0x2::coin::split<T0>(&mut arg5, v1, arg6));
        };
        arg1.total_collected = arg1.total_collected + v1;
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg5, v2, arg6), 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::root_current_owner_v5(arg4));
        };
        let v3 = if (0x1::option::is_some<0x2::object::ID>(&arg3.source_root_id)) {
            assert!(*0x1::option::borrow<0x2::object::ID>(&arg3.source_root_id) == arg2.root_id, 21);
            0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::root_current_owner_v5(arg4)
        } else {
            arg3.publisher
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg5, v3);
    }

    public fun subject_embedded_v6() : u8 {
        2
    }

    public fun subject_soul_v6() : u8 {
        1
    }

    public fun subject_wallet_v6() : u8 {
        0
    }

    public fun third_party_certified_v6() : u8 {
        1
    }

    public fun third_party_official_only_v6() : u8 {
        0
    }

    public fun third_party_open_v6() : u8 {
        2
    }

    public fun transfer_composition_admin_cap_v6(arg0: CompositionAdminCapV6, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(arg1 != @0x0 && arg1 != 0x2::tx_context::sender(arg2), 28);
        0x2::transfer::transfer<CompositionAdminCapV6>(arg0, arg1);
    }

    public fun transfer_owned_item_v6(arg0: &mut CompositionRegistryV6, arg1: &CompositionProtocolConfigV6, arg2: &MakerProfileV6, arg3: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerRootV5, arg4: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::CommerceProtocolConfigV5, arg5: OwnedItemV6, arg6: address, arg7: &0x2::tx_context::TxContext) {
        assert_v6_operational(arg1, arg2, arg3, arg4);
        assert_registry(arg1, arg0);
        assert!(arg6 != @0x0 && arg6 != 0x2::tx_context::sender(arg7), 28);
        assert!(arg5.config_id == 0x2::object::id<CompositionProtocolConfigV6>(arg1), 35);
        assert!(arg5.profile_id == 0x2::object::id<MakerProfileV6>(arg2), 35);
        assert!(arg5.holder == 0x2::tx_context::sender(arg7), 39);
        assert!(arg5.transferable, 51);
        assert!(0x1::option::is_none<0x2::object::ID>(&arg5.locked_soul), 36);
        let v0 = 0x2::object::id<OwnedItemV6>(&arg5);
        assert!(!0x2::table::contains<0x2::object::ID, OwnedLockRecordV6>(&arg0.owned_locks, v0), 36);
        let v1 = WalletEntitlementKeyV6{
            profile_id : arg5.profile_id,
            product_id : arg5.product_id,
            wallet     : arg5.holder,
        };
        assert!(0x2::table::contains<WalletEntitlementKeyV6, EntitlementRecordV6>(&arg0.wallet_entitlements, v1), 26);
        let v2 = WalletEntitlementKeyV6{
            profile_id : arg5.profile_id,
            product_id : arg5.product_id,
            wallet     : arg6,
        };
        assert!(!0x2::table::contains<WalletEntitlementKeyV6, EntitlementRecordV6>(&arg0.wallet_entitlements, v2), 52);
        let v3 = 0x2::table::remove<WalletEntitlementKeyV6, EntitlementRecordV6>(&mut arg0.wallet_entitlements, v1);
        assert!(0x1::option::is_some<0x2::object::ID>(&v3.owned_instance_id), 33);
        assert!(*0x1::option::borrow<0x2::object::ID>(&v3.owned_instance_id) == v0, 35);
        0x2::table::add<WalletEntitlementKeyV6, EntitlementRecordV6>(&mut arg0.wallet_entitlements, v2, v3);
        arg5.holder = arg6;
        arg5.ownership_epoch = arg5.ownership_epoch + 1;
        0x2::transfer::transfer<OwnedItemV6>(arg5, arg6);
    }

    public fun transfer_validator_cap_v6(arg0: ValidatorCapV6, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(arg1 != @0x0 && arg1 != 0x2::tx_context::sender(arg2), 28);
        0x2::transfer::transfer<ValidatorCapV6>(arg0, arg1);
    }

    public fun unlock_owned_item_from_soul_v6<T0: drop>(arg0: &mut CompositionRegistryV6, arg1: &CompositionProtocolConfigV6, arg2: &MakerProfileV6, arg3: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerRootV5, arg4: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::CommerceProtocolConfigV5, arg5: &mut OwnedItemV6, arg6: 0x2::object::ID, arg7: T0, arg8: &0x2::tx_context::TxContext) {
        assert_protocol_link(arg1, arg4);
        assert_profile_link(arg1, arg2, arg3);
        assert_registry(arg1, arg0);
        assert_soul_owner_proof_type<T0>(arg1);
        assert!(0x2::object::id_to_address(&arg6) != @0x0, 30);
        assert!(arg5.config_id == 0x2::object::id<CompositionProtocolConfigV6>(arg1), 35);
        assert!(arg5.profile_id == 0x2::object::id<MakerProfileV6>(arg2), 35);
        assert!(arg5.holder == 0x2::tx_context::sender(arg8), 39);
        assert!(0x1::option::is_some<0x2::object::ID>(&arg5.locked_soul), 37);
        assert!(*0x1::option::borrow<0x2::object::ID>(&arg5.locked_soul) == arg6, 38);
        let v0 = 0x2::object::id<OwnedItemV6>(arg5);
        assert!(0x2::table::contains<0x2::object::ID, OwnedLockRecordV6>(&arg0.owned_locks, v0), 37);
        let v1 = 0x2::table::remove<0x2::object::ID, OwnedLockRecordV6>(&mut arg0.owned_locks, v0);
        let v2 = if (v1.profile_id == arg5.profile_id) {
            if (v1.product_id == arg5.product_id) {
                if (v1.holder == arg5.holder) {
                    v1.ownership_epoch == arg5.ownership_epoch
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v2, 35);
        assert!(v1.soul_id == arg6, 38);
        decrement_soul_owned_lock_count(arg0, arg6);
        arg5.locked_soul = 0x1::option::none<0x2::object::ID>();
        let v3 = OwnedItemLockChangedV6{
            instance_id : v0,
            profile_id  : arg5.profile_id,
            product_id  : arg5.product_id,
            holder      : arg5.holder,
            soul_id     : arg6,
            locked      : false,
        };
        0x2::event::emit<OwnedItemLockChangedV6>(v3);
    }

    public fun update_protocol_enabled_v6(arg0: &mut CompositionProtocolConfigV6, arg1: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::CommerceProtocolConfigV5, arg2: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::ProtocolFeeAdminCap, arg3: bool) {
        assert_protocol_link(arg0, arg1);
        0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::assert_extension_protocol_admin_v5(arg1, arg2);
        if (arg3) {
            assert!(0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::protocol_enabled_v5(arg1), 1);
            assert!(0x1::option::is_some<0x1::string::String>(&arg0.soul_owner_proof_type), 5);
            assert_hash(&arg0.validator_policy_commitment);
        };
        arg0.enabled = arg3;
    }

    public fun validator_cap_config_id_v6(arg0: &ValidatorCapV6) : 0x2::object::ID {
        arg0.config_id
    }

    public fun validator_cap_epoch_v6(arg0: &ValidatorCapV6) : u64 {
        arg0.validator_epoch
    }

    public fun validator_cap_id_v6(arg0: &ValidatorCapV6) : 0x2::object::ID {
        0x2::object::id<ValidatorCapV6>(arg0)
    }

    public fun wallet_entitlement_exists_v6(arg0: &CompositionRegistryV6, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: address) : bool {
        let v0 = WalletEntitlementKeyV6{
            profile_id : arg1,
            product_id : arg2,
            wallet     : arg3,
        };
        0x2::table::contains<WalletEntitlementKeyV6, EntitlementRecordV6>(&arg0.wallet_entitlements, v0)
    }

    public fun withdraw_protocol_revenue_v6<T0>(arg0: &CompositionProtocolConfigV6, arg1: &mut CompositionProtocolTreasuryV6<T0>, arg2: &CompositionAdminCapV6, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg2);
        assert_treasury<T0>(arg0, arg1);
        assert!(arg4 != @0x0, 28);
        assert!(arg3 > 0 && arg3 <= 0x2::balance::value<T0>(&arg1.revenue), 29);
        arg1.total_withdrawn = arg1.total_withdrawn + arg3;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.revenue, arg3, arg5), arg4);
    }

    // decompiled from Move bytecode v7
}

