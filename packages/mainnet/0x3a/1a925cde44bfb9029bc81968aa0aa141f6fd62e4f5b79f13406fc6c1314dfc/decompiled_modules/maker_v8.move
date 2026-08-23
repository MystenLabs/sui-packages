module 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::maker_v8 {
    struct EconomicsSnapshotV8 has copy, drop, store {
        protocol_config_id: 0x2::object::ID,
        protocol_config_revision: u64,
        protocol_config_commitment: vector<u8>,
        protocol_treasury_id: 0x2::object::ID,
        payment_coin_type: 0x1::string::String,
        maker_access: u8,
        maker_price_atomic: u64,
        complete_mode: u8,
        complete_price_atomic: u64,
        complete_per_wallet_quota: u64,
        complete_total_cap: u64,
        primary_content_fee_bps: u16,
        fixed_complete_fee_atomic: u64,
        maker_market_fee_bps: u16,
        soul_market_fee_bps: u16,
        commitment: vector<u8>,
    }

    struct RightsSnapshotV8 has copy, drop, store {
        origin: u8,
        creator: address,
        creator_confirmed: bool,
        evidence_certified: bool,
        certification_catalog_id: 0x1::option::Option<0x2::object::ID>,
        certification_binding_commitment: 0x1::option::Option<vector<u8>>,
        evidence_locator: 0x1::string::String,
        evidence_blob_id: 0x1::string::String,
        evidence_sha256: vector<u8>,
        terms_commitment: vector<u8>,
        soul_creator_royalty_bps: u16,
        maker_source_royalty_bps: u16,
        maker_resale_royalty_bps: u16,
        commitment: vector<u8>,
    }

    struct WrappedRightsCertificationV8 {
        creator: address,
        catalog_id: 0x2::object::ID,
        product_binding_commitment: vector<u8>,
        evidence_locator: 0x1::string::String,
        evidence_blob_id: 0x1::string::String,
        evidence_sha256: vector<u8>,
        terms_commitment: vector<u8>,
    }

    struct PackAdmissionBindingV8 has copy, drop, store {
        pack_registry_id: 0x2::object::ID,
        admission_authority_id: 0x2::object::ID,
        policy_commitment: vector<u8>,
        commitment: vector<u8>,
    }

    struct CapabilityRegistryBindingV8 has copy, drop, store {
        native_capability_mask: u64,
        catalog_id: 0x2::object::ID,
        call_cap_set: 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::PackageCallCapSetBindingV8,
        protocol_config_id: 0x2::object::ID,
        base_registry_id: 0x2::object::ID,
        maker_treasury_id: 0x2::object::ID,
        protocol_treasury_id: 0x2::object::ID,
        seal_policy_config_id: 0x2::object::ID,
        seal_registry_id: 0x2::object::ID,
        runtime_definition_registry_id: 0x2::object::ID,
        pack_registry_id: 0x2::object::ID,
        admission_authority_id: 0x2::object::ID,
        output_registry_id: 0x2::object::ID,
        soul_registry_id: 0x2::object::ID,
        physical_registry_id: 0x2::object::ID,
        market_registry_id: 0x2::object::ID,
        market_treasury_id: 0x2::object::ID,
        seal_readiness_commitment: vector<u8>,
        runtime_readiness_commitment: vector<u8>,
        output_readiness_commitment: vector<u8>,
        physical_readiness_commitment: vector<u8>,
        market_readiness_commitment: vector<u8>,
        commitment: vector<u8>,
    }

    struct MakerRootV8<phantom T0> has key {
        id: 0x2::object::UID,
        version: u64,
        core_original_package_id: 0x2::object::ID,
        core_callable_package_id: 0x2::object::ID,
        creator: address,
        owner: address,
        admin_cap_id: 0x2::object::ID,
        control_epoch: u64,
        lifecycle: u8,
        maker_key: 0x1::string::String,
        maker_version: u64,
        version_commitment: vector<u8>,
        previous_root_id: 0x1::option::Option<0x2::object::ID>,
        previous_version_commitment: 0x1::option::Option<vector<u8>>,
        successor_authority_id: 0x1::option::Option<0x2::object::ID>,
        successor_root_id: 0x1::option::Option<0x2::object::ID>,
        renderer_commitment: vector<u8>,
        manifest_blob_id: 0x1::string::String,
        manifest_sha256: vector<u8>,
        content_commitment: vector<u8>,
        base_registry_id: 0x1::option::Option<0x2::object::ID>,
        maker_treasury_id: 0x1::option::Option<0x2::object::ID>,
        expected_base_definition_count: u64,
        expected_base_registry_commitment: vector<u8>,
        expected_pack_admission_policy_commitment: vector<u8>,
        economics: EconomicsSnapshotV8,
        rights: RightsSnapshotV8,
        product_release_binding: 0x1::option::Option<0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::CertifiedProductReleaseBindingV8>,
        pack_admission_binding: 0x1::option::Option<PackAdmissionBindingV8>,
        capability_registry_binding: 0x1::option::Option<CapabilityRegistryBindingV8>,
        created_at_ms: u64,
    }

    struct MakerAdminCapV8 has key {
        id: 0x2::object::UID,
        version: u64,
        root_id: 0x2::object::ID,
        owner: address,
        control_epoch: u64,
    }

    struct SuccessorAuthorityV8<phantom T0> has key {
        id: 0x2::object::UID,
        version: u64,
        previous_root_id: 0x2::object::ID,
        maker_key: 0x1::string::String,
        maker_version: u64,
        version_commitment: vector<u8>,
        control_epoch: u64,
        owner: address,
        allowed_lifecycle: u8,
    }

    struct EconomicsCommitmentInputV8 has drop {
        domain: vector<u8>,
        version: u64,
        protocol_config_id: 0x2::object::ID,
        protocol_config_revision: u64,
        protocol_config_commitment: vector<u8>,
        protocol_treasury_id: 0x2::object::ID,
        payment_coin_type: 0x1::string::String,
        maker_access: u8,
        maker_price_atomic: u64,
        complete_mode: u8,
        complete_price_atomic: u64,
        complete_per_wallet_quota: u64,
        complete_total_cap: u64,
        primary_content_fee_bps: u16,
        fixed_complete_fee_atomic: u64,
        maker_market_fee_bps: u16,
        soul_market_fee_bps: u16,
    }

    struct RightsCommitmentInputV8 has drop {
        domain: vector<u8>,
        version: u64,
        origin: u8,
        creator: address,
        creator_confirmed: bool,
        evidence_certified: bool,
        certification_catalog_id: 0x1::option::Option<0x2::object::ID>,
        certification_binding_commitment: 0x1::option::Option<vector<u8>>,
        evidence_locator: 0x1::string::String,
        evidence_blob_id: 0x1::string::String,
        evidence_sha256: vector<u8>,
        terms_commitment: vector<u8>,
        soul_creator_royalty_bps: u16,
        maker_source_royalty_bps: u16,
        maker_resale_royalty_bps: u16,
    }

    struct VersionCommitmentInputV8 has drop {
        domain: vector<u8>,
        version: u64,
        core_original_package_id: 0x2::object::ID,
        protocol_config_id: 0x2::object::ID,
        protocol_config_revision: u64,
        protocol_config_commitment: vector<u8>,
        maker_key: 0x1::string::String,
        maker_version: u64,
        previous_root_id: 0x1::option::Option<0x2::object::ID>,
        previous_version_commitment: 0x1::option::Option<vector<u8>>,
        renderer_commitment: vector<u8>,
        manifest_blob_id: 0x1::string::String,
        manifest_sha256: vector<u8>,
        content_commitment: vector<u8>,
        expected_base_definition_count: u64,
        expected_base_registry_commitment: vector<u8>,
        expected_pack_admission_policy_commitment: vector<u8>,
        economics_commitment: vector<u8>,
        rights_commitment: vector<u8>,
    }

    struct PackAdmissionCommitmentInputV8 has drop {
        domain: vector<u8>,
        version: u64,
        root_id: 0x2::object::ID,
        root_version_commitment: vector<u8>,
        pack_registry_id: 0x2::object::ID,
        admission_authority_id: 0x2::object::ID,
        policy_commitment: vector<u8>,
    }

    struct CapabilityRegistryCommitmentInputV8 has drop {
        domain: vector<u8>,
        version: u64,
        root_id: 0x2::object::ID,
        root_version_commitment: vector<u8>,
        native_capability_mask: u64,
        catalog_id: 0x2::object::ID,
        call_cap_set: 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::PackageCallCapSetBindingV8,
        protocol_config_id: 0x2::object::ID,
        base_registry_id: 0x2::object::ID,
        maker_treasury_id: 0x2::object::ID,
        protocol_treasury_id: 0x2::object::ID,
        seal_policy_config_id: 0x2::object::ID,
        seal_registry_id: 0x2::object::ID,
        runtime_definition_registry_id: 0x2::object::ID,
        pack_registry_id: 0x2::object::ID,
        admission_authority_id: 0x2::object::ID,
        output_registry_id: 0x2::object::ID,
        soul_registry_id: 0x2::object::ID,
        physical_registry_id: 0x2::object::ID,
        market_registry_id: 0x2::object::ID,
        market_treasury_id: 0x2::object::ID,
        seal_readiness_commitment: vector<u8>,
        runtime_readiness_commitment: vector<u8>,
        output_readiness_commitment: vector<u8>,
        physical_readiness_commitment: vector<u8>,
        market_readiness_commitment: vector<u8>,
    }

    struct ProductReleaseBindingFinalizedV8 has copy, drop {
        root_id: 0x2::object::ID,
        catalog_id: 0x2::object::ID,
        binding_commitment: vector<u8>,
    }

    struct MakerControlTransferredV8 has copy, drop {
        root_id: 0x2::object::ID,
        previous_owner: address,
        new_owner: address,
        previous_control_epoch: u64,
        new_control_epoch: u64,
        new_admin_cap_id: 0x2::object::ID,
    }

    struct PackAdmissionBindingFinalizedV8 has copy, drop {
        root_id: 0x2::object::ID,
        pack_registry_id: 0x2::object::ID,
        admission_authority_id: 0x2::object::ID,
        policy_commitment: vector<u8>,
        binding_commitment: vector<u8>,
    }

    public fun access_free_v8() : u8 {
        0
    }

    public fun access_paid_v8() : u8 {
        1
    }

    public(friend) fun activate_from_core_v8<T0>(arg0: &mut MakerRootV8<T0>, arg1: &MakerAdminCapV8) {
        assert_draft_admin_v8<T0>(arg0, arg1);
        assert_activation_scaffold_ready_v8<T0>(arg0);
        assert!(0x1::option::is_some<CapabilityRegistryBindingV8>(&arg0.capability_registry_binding), 27);
        assert_capability_registry_binding<T0>(arg0, 0x1::option::borrow<CapabilityRegistryBindingV8>(&arg0.capability_registry_binding));
        arg0.lifecycle = 1;
    }

    public fun admin_control_epoch_v8(arg0: &MakerAdminCapV8) : u64 {
        arg0.control_epoch
    }

    public fun admin_id_v8(arg0: &MakerAdminCapV8) : 0x2::object::ID {
        0x2::object::id<MakerAdminCapV8>(arg0)
    }

    public fun admin_owner_v8(arg0: &MakerAdminCapV8) : address {
        arg0.owner
    }

    public fun admin_root_id_v8(arg0: &MakerAdminCapV8) : 0x2::object::ID {
        arg0.root_id
    }

    public fun assert_activation_scaffold_ready_v8<T0>(arg0: &MakerRootV8<T0>) {
        assert_draft_v8<T0>(arg0);
        assert!(0x1::option::is_some<0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::CertifiedProductReleaseBindingV8>(&arg0.product_release_binding), 11);
        assert!(0x1::option::is_some<PackAdmissionBindingV8>(&arg0.pack_admission_binding), 13);
        assert!(0x1::option::is_some<0x2::object::ID>(&arg0.base_registry_id), 17);
        assert!(0x1::option::is_some<0x2::object::ID>(&arg0.maker_treasury_id), 24);
        0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::assert_product_release_binding_well_formed_v8(0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::certified_binding_v8(0x1::option::borrow<0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::CertifiedProductReleaseBindingV8>(&arg0.product_release_binding)));
        assert_pack_admission_binding<T0>(arg0, 0x1::option::borrow<PackAdmissionBindingV8>(&arg0.pack_admission_binding));
    }

    public fun assert_active_capability_registry_v8<T0>(arg0: &MakerRootV8<T0>) {
        assert!(arg0.lifecycle == 1, 0);
        root_capability_registry_binding_v8<T0>(arg0);
    }

    public fun assert_admin_v8<T0>(arg0: &MakerRootV8<T0>, arg1: &MakerAdminCapV8) {
        assert!(arg1.version == 8, 1);
        assert!(arg1.root_id == 0x2::object::id<MakerRootV8<T0>>(arg0), 1);
        assert!(0x2::object::id<MakerAdminCapV8>(arg1) == arg0.admin_cap_id, 1);
        assert!(arg1.owner == arg0.owner, 1);
        assert!(arg1.control_epoch == arg0.control_epoch, 1);
    }

    public fun assert_base_registry_identity_v8<T0>(arg0: &MakerRootV8<T0>, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: u64, arg4: &vector<u8>) {
        assert!(0x1::option::is_some<0x2::object::ID>(&arg0.base_registry_id), 17);
        assert!(arg1 == *0x1::option::borrow<0x2::object::ID>(&arg0.base_registry_id), 15);
        assert!(arg2 == 0x2::object::id<MakerRootV8<T0>>(arg0), 15);
        assert!(arg3 == arg0.maker_version, 15);
        assert!(arg4 == &arg0.content_commitment, 15);
    }

    fun assert_capability_registry_binding<T0>(arg0: &MakerRootV8<T0>, arg1: &CapabilityRegistryBindingV8) {
        assert!(arg1.native_capability_mask == 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::native_capability_mask_v8(), 28);
        assert!(0x1::option::is_some<0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::CertifiedProductReleaseBindingV8>(&arg0.product_release_binding), 11);
        let v0 = 0x1::option::borrow<0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::CertifiedProductReleaseBindingV8>(&arg0.product_release_binding);
        assert!(arg1.catalog_id == 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::certified_catalog_id_v8(v0), 20);
        0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::assert_same_call_cap_set_v8(&arg1.call_cap_set, 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::certified_call_cap_set_v8(v0));
        assert!(arg1.protocol_config_id == arg0.economics.protocol_config_id, 8);
        assert!(0x1::option::is_some<0x2::object::ID>(&arg0.base_registry_id), 17);
        assert!(arg1.base_registry_id == *0x1::option::borrow<0x2::object::ID>(&arg0.base_registry_id), 15);
        assert!(0x1::option::is_some<0x2::object::ID>(&arg0.maker_treasury_id), 24);
        assert!(arg1.maker_treasury_id == *0x1::option::borrow<0x2::object::ID>(&arg0.maker_treasury_id), 25);
        assert!(arg1.protocol_treasury_id == arg0.economics.protocol_treasury_id, 8);
        assert_hash(&arg1.seal_readiness_commitment);
        assert_hash(&arg1.runtime_readiness_commitment);
        assert_hash(&arg1.output_readiness_commitment);
        assert_hash(&arg1.physical_readiness_commitment);
        assert_hash(&arg1.market_readiness_commitment);
        let v1 = 0x1::vector::empty<0x2::object::ID>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x2::object::ID>(v2, 0x2::object::id<MakerRootV8<T0>>(arg0));
        0x1::vector::push_back<0x2::object::ID>(v2, arg0.admin_cap_id);
        0x1::vector::push_back<0x2::object::ID>(v2, arg1.catalog_id);
        0x1::vector::push_back<0x2::object::ID>(v2, arg1.protocol_config_id);
        0x1::vector::push_back<0x2::object::ID>(v2, arg1.base_registry_id);
        0x1::vector::push_back<0x2::object::ID>(v2, arg1.maker_treasury_id);
        0x1::vector::push_back<0x2::object::ID>(v2, arg1.protocol_treasury_id);
        0x1::vector::push_back<0x2::object::ID>(v2, arg1.seal_policy_config_id);
        0x1::vector::push_back<0x2::object::ID>(v2, arg1.seal_registry_id);
        0x1::vector::push_back<0x2::object::ID>(v2, arg1.runtime_definition_registry_id);
        0x1::vector::push_back<0x2::object::ID>(v2, arg1.pack_registry_id);
        0x1::vector::push_back<0x2::object::ID>(v2, arg1.admission_authority_id);
        0x1::vector::push_back<0x2::object::ID>(v2, arg1.output_registry_id);
        0x1::vector::push_back<0x2::object::ID>(v2, arg1.soul_registry_id);
        0x1::vector::push_back<0x2::object::ID>(v2, arg1.physical_registry_id);
        0x1::vector::push_back<0x2::object::ID>(v2, arg1.market_registry_id);
        0x1::vector::push_back<0x2::object::ID>(v2, arg1.market_treasury_id);
        0x1::vector::push_back<0x2::object::ID>(v2, 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::seal_authority_id_v8(&arg1.call_cap_set));
        0x1::vector::push_back<0x2::object::ID>(v2, 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::runtime_authority_id_v8(&arg1.call_cap_set));
        0x1::vector::push_back<0x2::object::ID>(v2, 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::output_authority_id_v8(&arg1.call_cap_set));
        0x1::vector::push_back<0x2::object::ID>(v2, 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::physical_authority_id_v8(&arg1.call_cap_set));
        0x1::vector::push_back<0x2::object::ID>(v2, 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::market_authority_id_v8(&arg1.call_cap_set));
        0x1::vector::push_back<0x2::object::ID>(v2, 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::release_authority_id_v8(&arg1.call_cap_set));
        assert_distinct_nonzero_ids(v1);
        let v3 = capability_registry_commitment<T0>(arg0, arg1);
        assert!(&v3 == &arg1.commitment, 28);
    }

    public fun assert_control_epoch_v8<T0>(arg0: &MakerRootV8<T0>, arg1: u64) {
        assert!(arg0.control_epoch == arg1, 18);
    }

    public fun assert_creator_v8<T0>(arg0: &MakerRootV8<T0>, arg1: address) {
        assert!(arg0.creator == arg1, 2);
    }

    public fun assert_current_protocol_config_v8<T0>(arg0: &MakerRootV8<T0>, arg1: &0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::protocol_config_v8::ProtocolConfigV8) {
        0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::protocol_config_v8::assert_exact_snapshot_v8<T0>(arg1, arg0.economics.protocol_config_id, arg0.economics.protocol_config_revision, &arg0.economics.protocol_config_commitment);
        assert!(0x1::option::is_some<0x2::object::ID>(0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::protocol_config_v8::config_treasury_id_v8(arg1)), 8);
        assert!(*0x1::option::borrow<0x2::object::ID>(0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::protocol_config_v8::config_treasury_id_v8(arg1)) == arg0.economics.protocol_treasury_id, 8);
        assert_economics_snapshot_v8<T0>(arg1, &arg0.economics);
    }

    fun assert_distinct_nonzero_ids(arg0: vector<0x2::object::ID>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x2::object::ID>(&arg0)) {
            assert!(*0x1::vector::borrow<0x2::object::ID>(&arg0, v0) != 0x2::object::id_from_address(@0x0), 14);
            let v1 = v0 + 1;
            while (v1 < 0x1::vector::length<0x2::object::ID>(&arg0)) {
                assert!(*0x1::vector::borrow<0x2::object::ID>(&arg0, v0) != *0x1::vector::borrow<0x2::object::ID>(&arg0, v1), 14);
                v1 = v1 + 1;
            };
            v0 = v0 + 1;
        };
    }

    public fun assert_draft_admin_v8<T0>(arg0: &MakerRootV8<T0>, arg1: &MakerAdminCapV8) {
        assert_admin_v8<T0>(arg0, arg1);
        assert_draft_v8<T0>(arg0);
    }

    public fun assert_draft_v8<T0>(arg0: &MakerRootV8<T0>) {
        assert!(arg0.lifecycle == 0, 0);
    }

    public fun assert_economics_snapshot_v8<T0>(arg0: &0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::protocol_config_v8::ProtocolConfigV8, arg1: &EconomicsSnapshotV8) {
        0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::protocol_config_v8::assert_exact_snapshot_v8<T0>(arg0, arg1.protocol_config_id, arg1.protocol_config_revision, &arg1.protocol_config_commitment);
        assert!(arg1.payment_coin_type == 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::protocol_config_v8::payment_coin_type_name_v8<T0>(), 8);
        assert!(0x1::option::is_some<0x2::object::ID>(0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::protocol_config_v8::config_treasury_id_v8(arg0)), 8);
        assert!(*0x1::option::borrow<0x2::object::ID>(0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::protocol_config_v8::config_treasury_id_v8(arg0)) == arg1.protocol_treasury_id, 8);
        assert!(arg1.primary_content_fee_bps == 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::protocol_config_v8::config_primary_content_fee_bps_v8(arg0), 8);
        assert!(arg1.fixed_complete_fee_atomic == 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::protocol_config_v8::config_fixed_complete_fee_atomic_v8(arg0), 8);
        assert!(arg1.maker_market_fee_bps == 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::protocol_config_v8::config_maker_market_fee_bps_v8(arg0), 8);
        assert!(arg1.soul_market_fee_bps == 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::protocol_config_v8::config_soul_market_fee_bps_v8(arg0), 8);
        assert_valid_access(arg1.maker_access, arg1.maker_price_atomic);
        assert_valid_complete_policy(arg1.complete_mode, arg1.complete_price_atomic, arg1.complete_per_wallet_quota, arg1.complete_total_cap);
        let v0 = EconomicsCommitmentInputV8{
            domain                     : b"animacraft-v8/economics-snapshot",
            version                    : 8,
            protocol_config_id         : arg1.protocol_config_id,
            protocol_config_revision   : arg1.protocol_config_revision,
            protocol_config_commitment : arg1.protocol_config_commitment,
            protocol_treasury_id       : arg1.protocol_treasury_id,
            payment_coin_type          : arg1.payment_coin_type,
            maker_access               : arg1.maker_access,
            maker_price_atomic         : arg1.maker_price_atomic,
            complete_mode              : arg1.complete_mode,
            complete_price_atomic      : arg1.complete_price_atomic,
            complete_per_wallet_quota  : arg1.complete_per_wallet_quota,
            complete_total_cap         : arg1.complete_total_cap,
            primary_content_fee_bps    : arg1.primary_content_fee_bps,
            fixed_complete_fee_atomic  : arg1.fixed_complete_fee_atomic,
            maker_market_fee_bps       : arg1.maker_market_fee_bps,
            soul_market_fee_bps        : arg1.soul_market_fee_bps,
        };
        let v1 = 0x1::hash::sha2_256(0x1::bcs::to_bytes<EconomicsCommitmentInputV8>(&v0));
        assert!(&v1 == &arg1.commitment, 8);
    }

    fun assert_hash(arg0: &vector<u8>) {
        assert!(0x1::vector::length<u8>(arg0) == 32, 3);
        let v0 = false;
        let v1 = 0;
        while (v1 < 32) {
            if (*0x1::vector::borrow<u8>(arg0, v1) != 0) {
                v0 = true;
            };
            v1 = v1 + 1;
        };
        assert!(v0, 3);
    }

    fun assert_lineage(arg0: &0x1::option::Option<0x2::object::ID>, arg1: &0x1::option::Option<vector<u8>>) {
        assert!(0x1::option::is_some<0x2::object::ID>(arg0) == 0x1::option::is_some<vector<u8>>(arg1), 7);
        if (0x1::option::is_some<vector<u8>>(arg1)) {
            assert_hash(0x1::option::borrow<vector<u8>>(arg1));
        };
    }

    public fun assert_maker_treasury_identity_v8<T0>(arg0: &MakerRootV8<T0>, arg1: 0x2::object::ID) {
        assert!(0x1::option::is_some<0x2::object::ID>(&arg0.maker_treasury_id), 24);
        assert!(*0x1::option::borrow<0x2::object::ID>(&arg0.maker_treasury_id) == arg1, 25);
    }

    fun assert_market_executor<T0>(arg0: &MakerRootV8<T0>, arg1: &0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::ProductReleaseCatalogV8, arg2: &0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::PackageCallCapV8<0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::MarketRoleV8>) {
        assert!(root_product_release_catalog_id_v8<T0>(arg0) == 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::catalog_id_v8(arg1), 20);
        0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::assert_market_call_cap_v8(arg1, arg2);
    }

    public fun assert_native_capability_mask_v8<T0>(arg0: &MakerRootV8<T0>) {
        0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::assert_native_capability_mask_v8(root_product_release_binding_v8<T0>(arg0));
    }

    fun assert_non_empty_bounded(arg0: &0x1::string::String, arg1: u64) {
        let v0 = 0x1::vector::length<u8>(0x1::string::as_bytes(arg0));
        assert!(v0 > 0 && v0 <= arg1, 4);
    }

    fun assert_pack_admission_binding<T0>(arg0: &MakerRootV8<T0>, arg1: &PackAdmissionBindingV8) {
        assert!(arg1.policy_commitment == arg0.expected_pack_admission_policy_commitment, 3);
        let v0 = PackAdmissionCommitmentInputV8{
            domain                  : b"animacraft-v8/pack-admission-binding",
            version                 : 8,
            root_id                 : 0x2::object::id<MakerRootV8<T0>>(arg0),
            root_version_commitment : arg0.version_commitment,
            pack_registry_id        : arg1.pack_registry_id,
            admission_authority_id  : arg1.admission_authority_id,
            policy_commitment       : arg1.policy_commitment,
        };
        let v1 = 0x1::hash::sha2_256(0x1::bcs::to_bytes<PackAdmissionCommitmentInputV8>(&v0));
        assert!(&v1 == &arg1.commitment, 3);
    }

    public fun assert_release_type_origins_v8<T0, T1, T2>(arg0: &MakerRootV8<T0>) {
        assert_activation_scaffold_ready_v8<T0>(arg0);
        0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::assert_type_origins_v8<T1, T2>(0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::release_binding_v8(0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::certified_binding_v8(0x1::option::borrow<0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::CertifiedProductReleaseBindingV8>(&arg0.product_release_binding))));
    }

    fun assert_rights_evidence(arg0: u8, arg1: &0x1::option::Option<0x2::object::ID>, arg2: &0x1::option::Option<vector<u8>>, arg3: &0x1::string::String, arg4: &0x1::string::String, arg5: &vector<u8>, arg6: &vector<u8>) {
        if (arg0 == 0) {
            assert!(0x1::option::is_none<0x2::object::ID>(arg1), 6);
            assert!(0x1::option::is_none<vector<u8>>(arg2), 6);
            assert!(0x1::vector::is_empty<u8>(0x1::string::as_bytes(arg3)), 6);
            assert!(0x1::vector::is_empty<u8>(0x1::string::as_bytes(arg4)), 6);
            assert!(0x1::vector::is_empty<u8>(arg5), 6);
            assert!(0x1::vector::is_empty<u8>(arg6), 6);
        } else {
            assert!(arg0 == 1, 6);
            assert!(0x1::option::is_some<0x2::object::ID>(arg1), 6);
            assert!(0x1::option::is_some<vector<u8>>(arg2), 6);
            assert_hash(0x1::option::borrow<vector<u8>>(arg2));
            assert_non_empty_bounded(arg3, 1024);
            assert_non_empty_bounded(arg4, 512);
            assert_hash(arg5);
            assert_hash(arg6);
        };
    }

    public fun assert_rights_snapshot_v8(arg0: &RightsSnapshotV8) {
        assert!(arg0.origin == 0 || arg0.origin == 1, 6);
        assert!(arg0.creator != @0x0, 6);
        assert!(arg0.creator_confirmed, 6);
        assert!(arg0.evidence_certified == arg0.origin == 1, 6);
        assert_rights_evidence(arg0.origin, &arg0.certification_catalog_id, &arg0.certification_binding_commitment, &arg0.evidence_locator, &arg0.evidence_blob_id, &arg0.evidence_sha256, &arg0.terms_commitment);
        assert_valid_royalty(arg0.soul_creator_royalty_bps);
        assert_valid_royalty(arg0.maker_source_royalty_bps);
        assert_valid_royalty(arg0.maker_resale_royalty_bps);
        assert!(arg0.soul_creator_royalty_bps + arg0.maker_source_royalty_bps <= 1000, 6);
        let v0 = RightsCommitmentInputV8{
            domain                           : b"animacraft-v8/rights-snapshot",
            version                          : 8,
            origin                           : arg0.origin,
            creator                          : arg0.creator,
            creator_confirmed                : arg0.creator_confirmed,
            evidence_certified               : arg0.evidence_certified,
            certification_catalog_id         : arg0.certification_catalog_id,
            certification_binding_commitment : arg0.certification_binding_commitment,
            evidence_locator                 : arg0.evidence_locator,
            evidence_blob_id                 : arg0.evidence_blob_id,
            evidence_sha256                  : arg0.evidence_sha256,
            terms_commitment                 : arg0.terms_commitment,
            soul_creator_royalty_bps         : arg0.soul_creator_royalty_bps,
            maker_source_royalty_bps         : arg0.maker_source_royalty_bps,
            maker_resale_royalty_bps         : arg0.maker_resale_royalty_bps,
        };
        let v1 = 0x1::hash::sha2_256(0x1::bcs::to_bytes<RightsCommitmentInputV8>(&v0));
        assert!(&v1 == &arg0.commitment, 6);
    }

    public fun assert_root_identity_v8<T0>(arg0: &MakerRootV8<T0>, arg1: 0x2::object::ID, arg2: u64, arg3: &vector<u8>) {
        assert!(arg1 == 0x2::object::id<MakerRootV8<T0>>(arg0), 15);
        assert!(arg2 == arg0.maker_version, 15);
        assert!(arg3 == &arg0.content_commitment, 15);
    }

    fun assert_successor_authority<T0>(arg0: &MakerRootV8<T0>, arg1: &SuccessorAuthorityV8<T0>) {
        assert!(arg1.version == 8, 22);
        assert!(0x1::option::is_some<0x2::object::ID>(&arg0.successor_authority_id), 22);
        assert!(0x2::object::id<SuccessorAuthorityV8<T0>>(arg1) == *0x1::option::borrow<0x2::object::ID>(&arg0.successor_authority_id), 22);
        assert!(arg1.previous_root_id == 0x2::object::id<MakerRootV8<T0>>(arg0), 22);
        assert!(arg1.maker_key == arg0.maker_key, 22);
        assert!(arg1.maker_version == arg0.maker_version, 22);
        assert!(&arg1.version_commitment == &arg0.version_commitment, 22);
        assert!(arg1.control_epoch == arg0.control_epoch, 22);
        assert!(arg1.owner == arg0.owner, 22);
        assert!(arg1.allowed_lifecycle == 3, 22);
        assert!(arg0.lifecycle == arg1.allowed_lifecycle, 22);
    }

    fun assert_valid_access(arg0: u8, arg1: u64) {
        let v0 = if (arg0 == 0 && arg1 == 0) {
            true
        } else if (arg0 == 1) {
            if (arg1 > 0) {
                arg1 <= 1000000000000
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 5);
    }

    fun assert_valid_complete_policy(arg0: u8, arg1: u64, arg2: u64, arg3: u64) {
        assert!(arg1 <= 1000000000000, 5);
        assert!(arg2 <= 1000000000 && arg3 <= 1000000000, 5);
        assert!(arg3 == 0 || arg2 <= arg3, 5);
        let v0 = if (arg0 == 0) {
            if (arg1 == 0) {
                arg2 == 0
            } else {
                false
            }
        } else {
            false
        };
        let v1 = if (v0) {
            true
        } else {
            let v2 = if (arg0 == 1) {
                if (arg1 > 0) {
                    arg2 > 0
                } else {
                    false
                }
            } else {
                false
            };
            if (v2) {
                true
            } else {
                let v3 = if (arg0 == 2) {
                    if (arg1 > 0) {
                        arg2 == 0
                    } else {
                        false
                    }
                } else {
                    false
                };
                if (v3) {
                    true
                } else if (arg0 == 3) {
                    if (arg1 == 0) {
                        arg2 > 0
                    } else {
                        false
                    }
                } else {
                    false
                }
            }
        };
        assert!(v1, 5);
    }

    fun assert_valid_royalty(arg0: u16) {
        assert!(arg0 <= 1000, 6);
        assert!(arg0 % 50 == 0, 6);
    }

    public fun capability_admission_authority_id_v8(arg0: &CapabilityRegistryBindingV8) : 0x2::object::ID {
        arg0.admission_authority_id
    }

    public fun capability_base_registry_id_v8(arg0: &CapabilityRegistryBindingV8) : 0x2::object::ID {
        arg0.base_registry_id
    }

    public fun capability_binding_commitment_v8(arg0: &CapabilityRegistryBindingV8) : &vector<u8> {
        &arg0.commitment
    }

    public fun capability_call_cap_set_v8(arg0: &CapabilityRegistryBindingV8) : &0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::PackageCallCapSetBindingV8 {
        &arg0.call_cap_set
    }

    public fun capability_catalog_id_v8(arg0: &CapabilityRegistryBindingV8) : 0x2::object::ID {
        arg0.catalog_id
    }

    public fun capability_maker_treasury_id_v8(arg0: &CapabilityRegistryBindingV8) : 0x2::object::ID {
        arg0.maker_treasury_id
    }

    public fun capability_market_readiness_commitment_v8(arg0: &CapabilityRegistryBindingV8) : &vector<u8> {
        &arg0.market_readiness_commitment
    }

    public fun capability_market_registry_id_v8(arg0: &CapabilityRegistryBindingV8) : 0x2::object::ID {
        arg0.market_registry_id
    }

    public fun capability_market_treasury_id_v8(arg0: &CapabilityRegistryBindingV8) : 0x2::object::ID {
        arg0.market_treasury_id
    }

    public fun capability_native_capability_mask_v8(arg0: &CapabilityRegistryBindingV8) : u64 {
        arg0.native_capability_mask
    }

    public fun capability_output_readiness_commitment_v8(arg0: &CapabilityRegistryBindingV8) : &vector<u8> {
        &arg0.output_readiness_commitment
    }

    public fun capability_output_registry_id_v8(arg0: &CapabilityRegistryBindingV8) : 0x2::object::ID {
        arg0.output_registry_id
    }

    public fun capability_pack_registry_id_v8(arg0: &CapabilityRegistryBindingV8) : 0x2::object::ID {
        arg0.pack_registry_id
    }

    public fun capability_physical_readiness_commitment_v8(arg0: &CapabilityRegistryBindingV8) : &vector<u8> {
        &arg0.physical_readiness_commitment
    }

    public fun capability_physical_registry_id_v8(arg0: &CapabilityRegistryBindingV8) : 0x2::object::ID {
        arg0.physical_registry_id
    }

    public fun capability_protocol_config_id_v8(arg0: &CapabilityRegistryBindingV8) : 0x2::object::ID {
        arg0.protocol_config_id
    }

    public fun capability_protocol_treasury_id_v8(arg0: &CapabilityRegistryBindingV8) : 0x2::object::ID {
        arg0.protocol_treasury_id
    }

    fun capability_registry_commitment<T0>(arg0: &MakerRootV8<T0>, arg1: &CapabilityRegistryBindingV8) : vector<u8> {
        let v0 = CapabilityRegistryCommitmentInputV8{
            domain                         : b"animacraft-v8/capability-registry-binding",
            version                        : 8,
            root_id                        : 0x2::object::id<MakerRootV8<T0>>(arg0),
            root_version_commitment        : arg0.version_commitment,
            native_capability_mask         : arg1.native_capability_mask,
            catalog_id                     : arg1.catalog_id,
            call_cap_set                   : arg1.call_cap_set,
            protocol_config_id             : arg1.protocol_config_id,
            base_registry_id               : arg1.base_registry_id,
            maker_treasury_id              : arg1.maker_treasury_id,
            protocol_treasury_id           : arg1.protocol_treasury_id,
            seal_policy_config_id          : arg1.seal_policy_config_id,
            seal_registry_id               : arg1.seal_registry_id,
            runtime_definition_registry_id : arg1.runtime_definition_registry_id,
            pack_registry_id               : arg1.pack_registry_id,
            admission_authority_id         : arg1.admission_authority_id,
            output_registry_id             : arg1.output_registry_id,
            soul_registry_id               : arg1.soul_registry_id,
            physical_registry_id           : arg1.physical_registry_id,
            market_registry_id             : arg1.market_registry_id,
            market_treasury_id             : arg1.market_treasury_id,
            seal_readiness_commitment      : arg1.seal_readiness_commitment,
            runtime_readiness_commitment   : arg1.runtime_readiness_commitment,
            output_readiness_commitment    : arg1.output_readiness_commitment,
            physical_readiness_commitment  : arg1.physical_readiness_commitment,
            market_readiness_commitment    : arg1.market_readiness_commitment,
        };
        0x1::hash::sha2_256(0x1::bcs::to_bytes<CapabilityRegistryCommitmentInputV8>(&v0))
    }

    public fun capability_runtime_definition_registry_id_v8(arg0: &CapabilityRegistryBindingV8) : 0x2::object::ID {
        arg0.runtime_definition_registry_id
    }

    public fun capability_runtime_readiness_commitment_v8(arg0: &CapabilityRegistryBindingV8) : &vector<u8> {
        &arg0.runtime_readiness_commitment
    }

    public fun capability_seal_policy_config_id_v8(arg0: &CapabilityRegistryBindingV8) : 0x2::object::ID {
        arg0.seal_policy_config_id
    }

    public fun capability_seal_readiness_commitment_v8(arg0: &CapabilityRegistryBindingV8) : &vector<u8> {
        &arg0.seal_readiness_commitment
    }

    public fun capability_seal_registry_id_v8(arg0: &CapabilityRegistryBindingV8) : 0x2::object::ID {
        arg0.seal_registry_id
    }

    public fun capability_soul_registry_id_v8(arg0: &CapabilityRegistryBindingV8) : 0x2::object::ID {
        arg0.soul_registry_id
    }

    public fun certify_wrapped_rights_v8(arg0: &0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::protocol_config_v8::ProtocolConfigV8, arg1: &0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::ProductReleaseCatalogV8, arg2: &0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::PackageCallCapV8<0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::ReleaseRoleV8>, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: vector<u8>, arg6: vector<u8>, arg7: &0x2::tx_context::TxContext) : WrappedRightsCertificationV8 {
        0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::assert_catalog_current_v8(arg0, arg1);
        0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::assert_release_call_cap_v8(arg1, arg2);
        assert_non_empty_bounded(&arg3, 1024);
        assert_non_empty_bounded(&arg4, 512);
        assert_hash(&arg5);
        assert_hash(&arg6);
        WrappedRightsCertificationV8{
            creator                    : 0x2::tx_context::sender(arg7),
            catalog_id                 : 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::catalog_id_v8(arg1),
            product_binding_commitment : *0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::product_binding_commitment_v8(0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::catalog_binding_v8(arg1)),
            evidence_locator           : arg3,
            evidence_blob_id           : arg4,
            evidence_sha256            : arg5,
            terms_commitment           : arg6,
        }
    }

    public fun complete_free_quota_then_block_v8() : u8 {
        3
    }

    public fun complete_free_quota_then_paid_v8() : u8 {
        1
    }

    public fun complete_paid_every_time_v8() : u8 {
        2
    }

    public fun complete_unlimited_free_v8() : u8 {
        0
    }

    public fun custody_maker_admin_for_market_v8<T0>(arg0: &MakerRootV8<T0>, arg1: MakerAdminCapV8, arg2: &0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::ProductReleaseCatalogV8, arg3: &0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::PackageCallCapV8<0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::MarketRoleV8>, arg4: &mut 0x2::object::UID) {
        assert_market_executor<T0>(arg0, arg2, arg3);
        assert!(arg0.lifecycle == 2, 0);
        assert_admin_v8<T0>(arg0, &arg1);
        0x2::transfer::transfer<MakerAdminCapV8>(arg1, 0x2::object::uid_to_address(arg4));
    }

    public fun economics_commitment_v8(arg0: &EconomicsSnapshotV8) : &vector<u8> {
        &arg0.commitment
    }

    public fun economics_complete_free_quota_per_wallet_v8(arg0: &EconomicsSnapshotV8) : u64 {
        arg0.complete_per_wallet_quota
    }

    public fun economics_complete_mode_v8(arg0: &EconomicsSnapshotV8) : u8 {
        arg0.complete_mode
    }

    public fun economics_complete_price_atomic_v8(arg0: &EconomicsSnapshotV8) : u64 {
        arg0.complete_price_atomic
    }

    public fun economics_complete_total_cap_v8(arg0: &EconomicsSnapshotV8) : u64 {
        arg0.complete_total_cap
    }

    public fun economics_fixed_complete_fee_atomic_v8(arg0: &EconomicsSnapshotV8) : u64 {
        arg0.fixed_complete_fee_atomic
    }

    public fun economics_maker_access_v8(arg0: &EconomicsSnapshotV8) : u8 {
        arg0.maker_access
    }

    public fun economics_maker_market_fee_bps_v8(arg0: &EconomicsSnapshotV8) : u16 {
        arg0.maker_market_fee_bps
    }

    public fun economics_maker_price_atomic_v8(arg0: &EconomicsSnapshotV8) : u64 {
        arg0.maker_price_atomic
    }

    public fun economics_payment_coin_type_v8(arg0: &EconomicsSnapshotV8) : &0x1::string::String {
        &arg0.payment_coin_type
    }

    public fun economics_primary_content_fee_bps_v8(arg0: &EconomicsSnapshotV8) : u16 {
        arg0.primary_content_fee_bps
    }

    public fun economics_protocol_config_commitment_v8(arg0: &EconomicsSnapshotV8) : &vector<u8> {
        &arg0.protocol_config_commitment
    }

    public fun economics_protocol_config_id_v8(arg0: &EconomicsSnapshotV8) : 0x2::object::ID {
        arg0.protocol_config_id
    }

    public fun economics_protocol_config_revision_v8(arg0: &EconomicsSnapshotV8) : u64 {
        arg0.protocol_config_revision
    }

    public fun economics_soul_market_fee_bps_v8(arg0: &EconomicsSnapshotV8) : u16 {
        arg0.soul_market_fee_bps
    }

    public(friend) fun finalize_base_registry_binding_v8<T0>(arg0: &mut MakerRootV8<T0>, arg1: &MakerAdminCapV8, arg2: 0x2::object::ID) {
        assert_draft_admin_v8<T0>(arg0, arg1);
        assert!(0x1::option::is_none<0x2::object::ID>(&arg0.base_registry_id), 16);
        assert!(arg2 != 0x2::object::id<MakerRootV8<T0>>(arg0), 14);
        assert!(arg2 != arg0.admin_cap_id, 14);
        arg0.base_registry_id = 0x1::option::some<0x2::object::ID>(arg2);
    }

    public(friend) fun finalize_capability_registry_binding_v8<T0>(arg0: &mut MakerRootV8<T0>, arg1: &MakerAdminCapV8, arg2: u64, arg3: 0x2::object::ID, arg4: 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::PackageCallCapSetBindingV8, arg5: 0x2::object::ID, arg6: 0x2::object::ID, arg7: 0x2::object::ID, arg8: 0x2::object::ID, arg9: 0x2::object::ID, arg10: 0x2::object::ID, arg11: 0x2::object::ID, arg12: 0x2::object::ID, arg13: 0x2::object::ID, arg14: 0x2::object::ID, arg15: 0x2::object::ID, arg16: 0x2::object::ID, arg17: 0x2::object::ID, arg18: 0x2::object::ID, arg19: vector<u8>, arg20: vector<u8>, arg21: vector<u8>, arg22: vector<u8>, arg23: vector<u8>) {
        assert_draft_admin_v8<T0>(arg0, arg1);
        assert!(0x1::option::is_none<CapabilityRegistryBindingV8>(&arg0.capability_registry_binding), 26);
        let v0 = CapabilityRegistryBindingV8{
            native_capability_mask         : arg2,
            catalog_id                     : arg3,
            call_cap_set                   : arg4,
            protocol_config_id             : arg5,
            base_registry_id               : arg6,
            maker_treasury_id              : arg7,
            protocol_treasury_id           : arg8,
            seal_policy_config_id          : arg9,
            seal_registry_id               : arg10,
            runtime_definition_registry_id : arg11,
            pack_registry_id               : arg12,
            admission_authority_id         : arg13,
            output_registry_id             : arg14,
            soul_registry_id               : arg15,
            physical_registry_id           : arg16,
            market_registry_id             : arg17,
            market_treasury_id             : arg18,
            seal_readiness_commitment      : arg19,
            runtime_readiness_commitment   : arg20,
            output_readiness_commitment    : arg21,
            physical_readiness_commitment  : arg22,
            market_readiness_commitment    : arg23,
            commitment                     : b"",
        };
        v0.commitment = capability_registry_commitment<T0>(arg0, &v0);
        assert_capability_registry_binding<T0>(arg0, &v0);
        arg0.capability_registry_binding = 0x1::option::some<CapabilityRegistryBindingV8>(v0);
    }

    public(friend) fun finalize_maker_treasury_binding_v8<T0>(arg0: &mut MakerRootV8<T0>, arg1: &MakerAdminCapV8, arg2: 0x2::object::ID) {
        assert_draft_admin_v8<T0>(arg0, arg1);
        assert!(0x1::option::is_none<0x2::object::ID>(&arg0.maker_treasury_id), 23);
        assert!(arg2 != 0x2::object::id<MakerRootV8<T0>>(arg0), 14);
        assert!(arg2 != arg0.admin_cap_id, 14);
        if (0x1::option::is_some<0x2::object::ID>(&arg0.base_registry_id)) {
            assert!(arg2 != *0x1::option::borrow<0x2::object::ID>(&arg0.base_registry_id), 14);
        };
        arg0.maker_treasury_id = 0x1::option::some<0x2::object::ID>(arg2);
    }

    public(friend) fun finalize_pack_admission_binding_from_core_v8<T0>(arg0: &mut MakerRootV8<T0>, arg1: &MakerAdminCapV8, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: vector<u8>) {
        assert_draft_admin_v8<T0>(arg0, arg1);
        assert!(0x1::option::is_none<PackAdmissionBindingV8>(&arg0.pack_admission_binding), 12);
        assert!(0x1::option::is_some<0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::CertifiedProductReleaseBindingV8>(&arg0.product_release_binding), 11);
        assert!(&arg4 == &arg0.expected_pack_admission_policy_commitment, 3);
        assert!(arg2 != arg3, 14);
        assert!(arg2 != 0x2::object::id<MakerRootV8<T0>>(arg0), 14);
        if (0x1::option::is_some<0x2::object::ID>(&arg0.base_registry_id)) {
            assert!(arg2 != *0x1::option::borrow<0x2::object::ID>(&arg0.base_registry_id), 14);
        };
        assert!(arg2 != arg0.admin_cap_id, 14);
        assert!(arg3 != 0x2::object::id<MakerRootV8<T0>>(arg0), 14);
        if (0x1::option::is_some<0x2::object::ID>(&arg0.base_registry_id)) {
            assert!(arg3 != *0x1::option::borrow<0x2::object::ID>(&arg0.base_registry_id), 14);
        };
        assert!(arg3 != arg0.admin_cap_id, 14);
        let v0 = PackAdmissionCommitmentInputV8{
            domain                  : b"animacraft-v8/pack-admission-binding",
            version                 : 8,
            root_id                 : 0x2::object::id<MakerRootV8<T0>>(arg0),
            root_version_commitment : arg0.version_commitment,
            pack_registry_id        : arg2,
            admission_authority_id  : arg3,
            policy_commitment       : arg4,
        };
        let v1 = 0x1::hash::sha2_256(0x1::bcs::to_bytes<PackAdmissionCommitmentInputV8>(&v0));
        let v2 = PackAdmissionBindingV8{
            pack_registry_id       : arg2,
            admission_authority_id : arg3,
            policy_commitment      : arg4,
            commitment             : v1,
        };
        arg0.pack_admission_binding = 0x1::option::some<PackAdmissionBindingV8>(v2);
        let v3 = PackAdmissionBindingFinalizedV8{
            root_id                : 0x2::object::id<MakerRootV8<T0>>(arg0),
            pack_registry_id       : arg2,
            admission_authority_id : arg3,
            policy_commitment      : arg4,
            binding_commitment     : v1,
        };
        0x2::event::emit<PackAdmissionBindingFinalizedV8>(v3);
    }

    public(friend) fun finalize_pack_admission_binding_v8<T0>(arg0: &mut MakerRootV8<T0>, arg1: &MakerAdminCapV8, arg2: &0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::protocol_config_v8::ProtocolConfigV8, arg3: 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::RuntimePackReadinessV8, arg4: &0x2::tx_context::TxContext) {
        assert_draft_admin_v8<T0>(arg0, arg1);
        assert!(arg0.owner == 0x2::tx_context::sender(arg4), 2);
        assert_current_protocol_config_v8<T0>(arg0, arg2);
        assert!(0x1::option::is_none<PackAdmissionBindingV8>(&arg0.pack_admission_binding), 12);
        assert!(0x1::option::is_some<0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::CertifiedProductReleaseBindingV8>(&arg0.product_release_binding), 11);
        let v0 = 0x1::option::borrow<0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::CertifiedProductReleaseBindingV8>(&arg0.product_release_binding);
        let v1 = 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::certified_binding_v8(v0);
        let (v2, v3, v4, v5, v6, v7, v8, v9) = 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::consume_runtime_pack_readiness_v8(arg3);
        let v10 = v9;
        let v11 = v6;
        let v12 = v3;
        assert!(v2 == 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::certified_catalog_id_v8(v0), 20);
        assert!(&v12 == 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::product_binding_commitment_v8(v1), 20);
        assert_root_identity_v8<T0>(arg0, v4, v5, &v11);
        assert!(&v10 == &arg0.expected_pack_admission_policy_commitment, 3);
        finalize_pack_admission_binding_from_core_v8<T0>(arg0, arg1, v7, v8, v10);
    }

    public fun finalize_product_release_binding_v8<T0>(arg0: &mut MakerRootV8<T0>, arg1: &MakerAdminCapV8, arg2: &0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::protocol_config_v8::ProtocolConfigV8, arg3: 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::ReleaseCatalogWitnessV8, arg4: &0x2::tx_context::TxContext) {
        assert_draft_admin_v8<T0>(arg0, arg1);
        assert!(arg0.owner == 0x2::tx_context::sender(arg4), 2);
        assert!(0x1::option::is_none<0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::CertifiedProductReleaseBindingV8>(&arg0.product_release_binding), 10);
        assert_current_protocol_config_v8<T0>(arg0, arg2);
        let v0 = 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::consume_release_catalog_witness_v8(arg3);
        0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::assert_certified_binding_v8(&v0);
        assert!(0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::certified_protocol_config_id_v8(&v0) == arg0.economics.protocol_config_id, 20);
        assert!(0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::certified_protocol_config_revision_v8(&v0) == arg0.economics.protocol_config_revision, 20);
        assert!(0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::certified_protocol_config_commitment_v8(&v0) == &arg0.economics.protocol_config_commitment, 20);
        let v1 = 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::certified_binding_v8(&v0);
        let v2 = 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::core_binding_v8(v1);
        assert!(0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::original_package_id_v8(v2) == arg0.core_original_package_id, 9);
        assert!(0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::callable_package_id_v8(v2) == arg0.core_callable_package_id, 9);
        let v3 = *0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::product_binding_commitment_v8(v1);
        let v4 = 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::certified_catalog_id_v8(&v0);
        if (arg0.rights.origin == 1) {
            assert!(0x1::option::is_some<0x2::object::ID>(&arg0.rights.certification_catalog_id), 20);
            assert!(0x1::option::is_some<vector<u8>>(&arg0.rights.certification_binding_commitment), 20);
            assert!(*0x1::option::borrow<0x2::object::ID>(&arg0.rights.certification_catalog_id) == v4, 20);
            assert!(0x1::option::borrow<vector<u8>>(&arg0.rights.certification_binding_commitment) == &v3, 20);
        };
        arg0.product_release_binding = 0x1::option::some<0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::CertifiedProductReleaseBindingV8>(v0);
        let v5 = ProductReleaseBindingFinalizedV8{
            root_id            : 0x2::object::id<MakerRootV8<T0>>(arg0),
            catalog_id         : v4,
            binding_commitment : v3,
        };
        0x2::event::emit<ProductReleaseBindingFinalizedV8>(v5);
    }

    public fun issue_successor_authority_v8<T0>(arg0: &mut MakerRootV8<T0>, arg1: &MakerAdminCapV8, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = new_successor_authority<T0>(arg0, arg1, arg2, arg3);
        0x2::transfer::transfer<SuccessorAuthorityV8<T0>>(v0, 0x2::tx_context::sender(arg3));
    }

    public fun lifecycle_active_v8() : u8 {
        1
    }

    public fun lifecycle_archived_v8() : u8 {
        3
    }

    public fun lifecycle_draft_v8() : u8 {
        0
    }

    public fun lifecycle_paused_v8() : u8 {
        2
    }

    public fun new_economics_snapshot_v8<T0>(arg0: &0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::protocol_config_v8::ProtocolConfigV8, arg1: u8, arg2: u64, arg3: u8, arg4: u64, arg5: u64, arg6: u64) : EconomicsSnapshotV8 {
        0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::protocol_config_v8::assert_enabled_for_coin_v8<T0>(arg0);
        assert_valid_access(arg1, arg2);
        assert_valid_complete_policy(arg3, arg4, arg5, arg6);
        let v0 = 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::protocol_config_v8::config_id_v8(arg0);
        let v1 = 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::protocol_config_v8::config_revision_v8(arg0);
        let v2 = *0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::protocol_config_v8::config_commitment_v8(arg0);
        let v3 = *0x1::option::borrow<0x2::object::ID>(0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::protocol_config_v8::config_treasury_id_v8(arg0));
        let v4 = 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::protocol_config_v8::payment_coin_type_name_v8<T0>();
        let v5 = 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::protocol_config_v8::config_primary_content_fee_bps_v8(arg0);
        let v6 = 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::protocol_config_v8::config_fixed_complete_fee_atomic_v8(arg0);
        let v7 = 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::protocol_config_v8::config_maker_market_fee_bps_v8(arg0);
        let v8 = 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::protocol_config_v8::config_soul_market_fee_bps_v8(arg0);
        let v9 = EconomicsCommitmentInputV8{
            domain                     : b"animacraft-v8/economics-snapshot",
            version                    : 8,
            protocol_config_id         : v0,
            protocol_config_revision   : v1,
            protocol_config_commitment : v2,
            protocol_treasury_id       : v3,
            payment_coin_type          : v4,
            maker_access               : arg1,
            maker_price_atomic         : arg2,
            complete_mode              : arg3,
            complete_price_atomic      : arg4,
            complete_per_wallet_quota  : arg5,
            complete_total_cap         : arg6,
            primary_content_fee_bps    : v5,
            fixed_complete_fee_atomic  : v6,
            maker_market_fee_bps       : v7,
            soul_market_fee_bps        : v8,
        };
        EconomicsSnapshotV8{
            protocol_config_id         : v0,
            protocol_config_revision   : v1,
            protocol_config_commitment : v2,
            protocol_treasury_id       : v3,
            payment_coin_type          : v4,
            maker_access               : arg1,
            maker_price_atomic         : arg2,
            complete_mode              : arg3,
            complete_price_atomic      : arg4,
            complete_per_wallet_quota  : arg5,
            complete_total_cap         : arg6,
            primary_content_fee_bps    : v5,
            fixed_complete_fee_atomic  : v6,
            maker_market_fee_bps       : v7,
            soul_market_fee_bps        : v8,
            commitment                 : 0x1::hash::sha2_256(0x1::bcs::to_bytes<EconomicsCommitmentInputV8>(&v9)),
        }
    }

    public(friend) fun new_initial_maker_draft_v8<T0>(arg0: &0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::protocol_config_v8::ProtocolConfigV8, arg1: u64, arg2: vector<u8>, arg3: vector<u8>, arg4: 0x1::string::String, arg5: vector<u8>, arg6: 0x1::string::String, arg7: vector<u8>, arg8: vector<u8>, arg9: EconomicsSnapshotV8, arg10: RightsSnapshotV8, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : (MakerRootV8<T0>, MakerAdminCapV8) {
        new_maker_draft_internal_v8<T0>(arg0, arg1, arg2, arg3, arg4, 1, 0x1::option::none<0x2::object::ID>(), 0x1::option::none<vector<u8>>(), arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12)
    }

    public fun new_license_wrapped_rights_snapshot_v8(arg0: WrappedRightsCertificationV8, arg1: u16, arg2: u16, arg3: u16) : RightsSnapshotV8 {
        let WrappedRightsCertificationV8 {
            creator                    : v0,
            catalog_id                 : v1,
            product_binding_commitment : v2,
            evidence_locator           : v3,
            evidence_blob_id           : v4,
            evidence_sha256            : v5,
            terms_commitment           : v6,
        } = arg0;
        new_rights_snapshot_internal_v8(1, v0, 0x1::option::some<0x2::object::ID>(v1), 0x1::option::some<vector<u8>>(v2), v3, v4, v5, v6, arg1, arg2, arg3)
    }

    fun new_maker_draft_internal_v8<T0>(arg0: &0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::protocol_config_v8::ProtocolConfigV8, arg1: u64, arg2: vector<u8>, arg3: vector<u8>, arg4: 0x1::string::String, arg5: u64, arg6: 0x1::option::Option<0x2::object::ID>, arg7: 0x1::option::Option<vector<u8>>, arg8: vector<u8>, arg9: 0x1::string::String, arg10: vector<u8>, arg11: vector<u8>, arg12: EconomicsSnapshotV8, arg13: RightsSnapshotV8, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) : (MakerRootV8<T0>, MakerAdminCapV8) {
        0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::protocol_config_v8::assert_enabled_for_coin_v8<T0>(arg0);
        assert_non_empty_bounded(&arg4, 128);
        assert!(arg5 > 0, 7);
        assert_non_empty_bounded(&arg9, 512);
        assert_hash(&arg2);
        assert_hash(&arg3);
        assert_hash(&arg8);
        assert_hash(&arg10);
        assert_hash(&arg11);
        assert_lineage(&arg6, &arg7);
        assert_economics_snapshot_v8<T0>(arg0, &arg12);
        assert_rights_snapshot_v8(&arg13);
        assert!(arg13.creator == 0x2::tx_context::sender(arg15), 2);
        let v0 = 0x2::object::new(arg15);
        let v1 = 0x2::tx_context::sender(arg15);
        let v2 = MakerAdminCapV8{
            id            : 0x2::object::new(arg15),
            version       : 8,
            root_id       : 0x2::object::uid_to_inner(&v0),
            owner         : v1,
            control_epoch : 0,
        };
        let v3 = 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::protocol_config_v8::config_core_original_package_id_v8(arg0);
        let v4 = VersionCommitmentInputV8{
            domain                                    : b"animacraft-v8/maker-version",
            version                                   : 8,
            core_original_package_id                  : v3,
            protocol_config_id                        : 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::protocol_config_v8::config_id_v8(arg0),
            protocol_config_revision                  : 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::protocol_config_v8::config_revision_v8(arg0),
            protocol_config_commitment                : *0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::protocol_config_v8::config_commitment_v8(arg0),
            maker_key                                 : arg4,
            maker_version                             : arg5,
            previous_root_id                          : arg6,
            previous_version_commitment               : arg7,
            renderer_commitment                       : arg8,
            manifest_blob_id                          : arg9,
            manifest_sha256                           : arg10,
            content_commitment                        : arg11,
            expected_base_definition_count            : arg1,
            expected_base_registry_commitment         : arg2,
            expected_pack_admission_policy_commitment : arg3,
            economics_commitment                      : arg12.commitment,
            rights_commitment                         : arg13.commitment,
        };
        let v5 = MakerRootV8<T0>{
            id                                        : v0,
            version                                   : 8,
            core_original_package_id                  : v3,
            core_callable_package_id                  : 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::protocol_config_v8::config_core_callable_package_id_v8(arg0),
            creator                                   : v1,
            owner                                     : v1,
            admin_cap_id                              : 0x2::object::id<MakerAdminCapV8>(&v2),
            control_epoch                             : 0,
            lifecycle                                 : 0,
            maker_key                                 : arg4,
            maker_version                             : arg5,
            version_commitment                        : 0x1::hash::sha2_256(0x1::bcs::to_bytes<VersionCommitmentInputV8>(&v4)),
            previous_root_id                          : arg6,
            previous_version_commitment               : arg7,
            successor_authority_id                    : 0x1::option::none<0x2::object::ID>(),
            successor_root_id                         : 0x1::option::none<0x2::object::ID>(),
            renderer_commitment                       : arg8,
            manifest_blob_id                          : arg9,
            manifest_sha256                           : arg10,
            content_commitment                        : arg11,
            base_registry_id                          : 0x1::option::none<0x2::object::ID>(),
            maker_treasury_id                         : 0x1::option::none<0x2::object::ID>(),
            expected_base_definition_count            : arg1,
            expected_base_registry_commitment         : arg2,
            expected_pack_admission_policy_commitment : arg3,
            economics                                 : arg12,
            rights                                    : arg13,
            product_release_binding                   : 0x1::option::none<0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::CertifiedProductReleaseBindingV8>(),
            pack_admission_binding                    : 0x1::option::none<PackAdmissionBindingV8>(),
            capability_registry_binding               : 0x1::option::none<CapabilityRegistryBindingV8>(),
            created_at_ms                             : 0x2::clock::timestamp_ms(arg14),
        };
        (v5, v2)
    }

    public fun new_onchain_native_rights_snapshot_v8(arg0: &0x2::tx_context::TxContext, arg1: u16, arg2: u16, arg3: u16) : RightsSnapshotV8 {
        new_rights_snapshot_internal_v8(0, 0x2::tx_context::sender(arg0), 0x1::option::none<0x2::object::ID>(), 0x1::option::none<vector<u8>>(), 0x1::string::utf8(b""), 0x1::string::utf8(b""), b"", b"", arg1, arg2, arg3)
    }

    fun new_rights_snapshot_internal_v8(arg0: u8, arg1: address, arg2: 0x1::option::Option<0x2::object::ID>, arg3: 0x1::option::Option<vector<u8>>, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: vector<u8>, arg7: vector<u8>, arg8: u16, arg9: u16, arg10: u16) : RightsSnapshotV8 {
        assert!(arg0 == 0 || arg0 == 1, 6);
        assert!(arg1 != @0x0, 6);
        assert_rights_evidence(arg0, &arg2, &arg3, &arg4, &arg5, &arg6, &arg7);
        assert_valid_royalty(arg8);
        assert_valid_royalty(arg9);
        assert_valid_royalty(arg10);
        assert!(arg8 + arg9 <= 1000, 6);
        let v0 = RightsCommitmentInputV8{
            domain                           : b"animacraft-v8/rights-snapshot",
            version                          : 8,
            origin                           : arg0,
            creator                          : arg1,
            creator_confirmed                : true,
            evidence_certified               : arg0 == 1,
            certification_catalog_id         : arg2,
            certification_binding_commitment : arg3,
            evidence_locator                 : arg4,
            evidence_blob_id                 : arg5,
            evidence_sha256                  : arg6,
            terms_commitment                 : arg7,
            soul_creator_royalty_bps         : arg8,
            maker_source_royalty_bps         : arg9,
            maker_resale_royalty_bps         : arg10,
        };
        RightsSnapshotV8{
            origin                           : arg0,
            creator                          : arg1,
            creator_confirmed                : true,
            evidence_certified               : arg0 == 1,
            certification_catalog_id         : arg2,
            certification_binding_commitment : arg3,
            evidence_locator                 : arg4,
            evidence_blob_id                 : arg5,
            evidence_sha256                  : arg6,
            terms_commitment                 : arg7,
            soul_creator_royalty_bps         : arg8,
            maker_source_royalty_bps         : arg9,
            maker_resale_royalty_bps         : arg10,
            commitment                       : 0x1::hash::sha2_256(0x1::bcs::to_bytes<RightsCommitmentInputV8>(&v0)),
        }
    }

    fun new_successor_authority<T0>(arg0: &mut MakerRootV8<T0>, arg1: &MakerAdminCapV8, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : SuccessorAuthorityV8<T0> {
        assert_admin_v8<T0>(arg0, arg1);
        assert!(arg0.owner == 0x2::tx_context::sender(arg3), 2);
        assert!(arg0.control_epoch == arg2, 18);
        assert!(arg0.lifecycle == 3, 19);
        assert!(arg0.maker_version < 18446744073709551615, 19);
        assert!(0x1::option::is_none<0x2::object::ID>(&arg0.successor_root_id), 19);
        assert!(0x1::option::is_none<0x2::object::ID>(&arg0.successor_authority_id), 21);
        let v0 = SuccessorAuthorityV8<T0>{
            id                 : 0x2::object::new(arg3),
            version            : 8,
            previous_root_id   : 0x2::object::id<MakerRootV8<T0>>(arg0),
            maker_key          : arg0.maker_key,
            maker_version      : arg0.maker_version,
            version_commitment : arg0.version_commitment,
            control_epoch      : arg0.control_epoch,
            owner              : arg0.owner,
            allowed_lifecycle  : 3,
        };
        arg0.successor_authority_id = 0x1::option::some<0x2::object::ID>(0x2::object::id<SuccessorAuthorityV8<T0>>(&v0));
        v0
    }

    public(friend) fun new_successor_maker_draft_v8<T0>(arg0: &0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::protocol_config_v8::ProtocolConfigV8, arg1: &mut MakerRootV8<T0>, arg2: &MakerAdminCapV8, arg3: SuccessorAuthorityV8<T0>, arg4: u64, arg5: u64, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<u8>, arg9: 0x1::string::String, arg10: vector<u8>, arg11: vector<u8>, arg12: EconomicsSnapshotV8, arg13: RightsSnapshotV8, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) : (MakerRootV8<T0>, MakerAdminCapV8) {
        assert_admin_v8<T0>(arg1, arg2);
        assert!(arg1.owner == 0x2::tx_context::sender(arg15), 2);
        assert!(arg1.control_epoch == arg4, 18);
        assert!(arg1.lifecycle == 3, 19);
        assert!(arg1.maker_version < 18446744073709551615, 19);
        assert!(0x1::option::is_none<0x2::object::ID>(&arg1.successor_root_id), 19);
        assert_successor_authority<T0>(arg1, &arg3);
        let (v0, v1) = new_maker_draft_internal_v8<T0>(arg0, arg5, arg6, arg7, arg1.maker_key, arg1.maker_version + 1, 0x1::option::some<0x2::object::ID>(0x2::object::id<MakerRootV8<T0>>(arg1)), 0x1::option::some<vector<u8>>(arg1.version_commitment), arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15);
        let v2 = v0;
        let SuccessorAuthorityV8 {
            id                 : v3,
            version            : _,
            previous_root_id   : _,
            maker_key          : _,
            maker_version      : _,
            version_commitment : _,
            control_epoch      : _,
            owner              : _,
            allowed_lifecycle  : _,
        } = arg3;
        0x2::object::delete(v3);
        arg1.successor_authority_id = 0x1::option::none<0x2::object::ID>();
        arg1.successor_root_id = 0x1::option::some<0x2::object::ID>(0x2::object::id<MakerRootV8<T0>>(&v2));
        (v2, v1)
    }

    public fun pack_admission_authority_id_v8(arg0: &PackAdmissionBindingV8) : 0x2::object::ID {
        arg0.admission_authority_id
    }

    public fun pack_admission_binding_commitment_v8(arg0: &PackAdmissionBindingV8) : &vector<u8> {
        &arg0.commitment
    }

    public fun pack_admission_policy_commitment_v8(arg0: &PackAdmissionBindingV8) : &vector<u8> {
        &arg0.policy_commitment
    }

    public fun pack_registry_id_v8(arg0: &PackAdmissionBindingV8) : 0x2::object::ID {
        arg0.pack_registry_id
    }

    public fun resolve_maker_admin_from_market_v8<T0>(arg0: &mut MakerRootV8<T0>, arg1: &0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::ProductReleaseCatalogV8, arg2: &0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::PackageCallCapV8<0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::MarketRoleV8>, arg3: &mut 0x2::object::UID, arg4: 0x2::transfer::Receiving<MakerAdminCapV8>, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        assert_market_executor<T0>(arg0, arg1, arg2);
        let v0 = 0x2::transfer::receive<MakerAdminCapV8>(arg3, arg4);
        assert_admin_v8<T0>(arg0, &v0);
        if (arg5 == arg0.owner) {
            0x2::transfer::transfer<MakerAdminCapV8>(v0, arg5);
        } else {
            assert!(arg0.lifecycle == 2, 0);
            assert!(arg5 == 0x2::tx_context::sender(arg6), 2);
            let v1 = arg0.control_epoch;
            0x2::transfer::transfer<MakerAdminCapV8>(rotate_maker_control_v8<T0>(arg0, v0, v1, arg5, arg6), arg5);
        };
    }

    public fun rights_certification_binding_commitment_v8(arg0: &RightsSnapshotV8) : &0x1::option::Option<vector<u8>> {
        &arg0.certification_binding_commitment
    }

    public fun rights_certification_catalog_id_v8(arg0: &RightsSnapshotV8) : &0x1::option::Option<0x2::object::ID> {
        &arg0.certification_catalog_id
    }

    public fun rights_commitment_v8(arg0: &RightsSnapshotV8) : &vector<u8> {
        &arg0.commitment
    }

    public fun rights_creator_confirmed_v8(arg0: &RightsSnapshotV8) : bool {
        arg0.creator_confirmed
    }

    public fun rights_creator_v8(arg0: &RightsSnapshotV8) : address {
        arg0.creator
    }

    public fun rights_evidence_blob_id_v8(arg0: &RightsSnapshotV8) : &0x1::string::String {
        &arg0.evidence_blob_id
    }

    public fun rights_evidence_certified_v8(arg0: &RightsSnapshotV8) : bool {
        arg0.evidence_certified
    }

    public fun rights_evidence_locator_v8(arg0: &RightsSnapshotV8) : &0x1::string::String {
        &arg0.evidence_locator
    }

    public fun rights_evidence_sha256_v8(arg0: &RightsSnapshotV8) : &vector<u8> {
        &arg0.evidence_sha256
    }

    public fun rights_license_wrapped_v8() : u8 {
        1
    }

    public fun rights_maker_resale_royalty_bps_v8(arg0: &RightsSnapshotV8) : u16 {
        arg0.maker_resale_royalty_bps
    }

    public fun rights_maker_source_royalty_bps_v8(arg0: &RightsSnapshotV8) : u16 {
        arg0.maker_source_royalty_bps
    }

    public fun rights_onchain_native_v8() : u8 {
        0
    }

    public fun rights_origin_v8(arg0: &RightsSnapshotV8) : u8 {
        arg0.origin
    }

    public fun rights_soul_creator_royalty_bps_v8(arg0: &RightsSnapshotV8) : u16 {
        arg0.soul_creator_royalty_bps
    }

    public fun rights_terms_commitment_v8(arg0: &RightsSnapshotV8) : &vector<u8> {
        &arg0.terms_commitment
    }

    public fun root_base_registry_id_v8<T0>(arg0: &MakerRootV8<T0>) : 0x2::object::ID {
        assert!(0x1::option::is_some<0x2::object::ID>(&arg0.base_registry_id), 17);
        *0x1::option::borrow<0x2::object::ID>(&arg0.base_registry_id)
    }

    public fun root_capability_registry_binding_v8<T0>(arg0: &MakerRootV8<T0>) : &CapabilityRegistryBindingV8 {
        assert!(0x1::option::is_some<CapabilityRegistryBindingV8>(&arg0.capability_registry_binding), 27);
        let v0 = 0x1::option::borrow<CapabilityRegistryBindingV8>(&arg0.capability_registry_binding);
        assert_capability_registry_binding<T0>(arg0, v0);
        v0
    }

    public fun root_content_commitment_v8<T0>(arg0: &MakerRootV8<T0>) : &vector<u8> {
        &arg0.content_commitment
    }

    public fun root_control_epoch_v8<T0>(arg0: &MakerRootV8<T0>) : u64 {
        arg0.control_epoch
    }

    public fun root_core_callable_package_id_v8<T0>(arg0: &MakerRootV8<T0>) : 0x2::object::ID {
        arg0.core_callable_package_id
    }

    public fun root_core_original_package_id_v8<T0>(arg0: &MakerRootV8<T0>) : 0x2::object::ID {
        arg0.core_original_package_id
    }

    public fun root_creator_v8<T0>(arg0: &MakerRootV8<T0>) : address {
        arg0.creator
    }

    public fun root_economics_v8<T0>(arg0: &MakerRootV8<T0>) : EconomicsSnapshotV8 {
        arg0.economics
    }

    public fun root_expected_base_definition_count_v8<T0>(arg0: &MakerRootV8<T0>) : u64 {
        arg0.expected_base_definition_count
    }

    public fun root_expected_base_registry_commitment_v8<T0>(arg0: &MakerRootV8<T0>) : &vector<u8> {
        &arg0.expected_base_registry_commitment
    }

    public fun root_expected_pack_admission_policy_commitment_v8<T0>(arg0: &MakerRootV8<T0>) : &vector<u8> {
        &arg0.expected_pack_admission_policy_commitment
    }

    public fun root_id_v8<T0>(arg0: &MakerRootV8<T0>) : 0x2::object::ID {
        0x2::object::id<MakerRootV8<T0>>(arg0)
    }

    public fun root_lifecycle_v8<T0>(arg0: &MakerRootV8<T0>) : u8 {
        arg0.lifecycle
    }

    public fun root_maker_key_v8<T0>(arg0: &MakerRootV8<T0>) : &0x1::string::String {
        &arg0.maker_key
    }

    public fun root_maker_treasury_id_v8<T0>(arg0: &MakerRootV8<T0>) : 0x2::object::ID {
        assert!(0x1::option::is_some<0x2::object::ID>(&arg0.maker_treasury_id), 24);
        *0x1::option::borrow<0x2::object::ID>(&arg0.maker_treasury_id)
    }

    public fun root_maker_version_v8<T0>(arg0: &MakerRootV8<T0>) : u64 {
        arg0.maker_version
    }

    public fun root_native_capability_mask_v8<T0>(arg0: &MakerRootV8<T0>) : u64 {
        let v0 = 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::binding_native_capability_mask_v8(root_product_release_binding_v8<T0>(arg0));
        assert!(v0 == 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::native_capability_mask_v8(), 20);
        v0
    }

    public fun root_owner_v8<T0>(arg0: &MakerRootV8<T0>) : address {
        arg0.owner
    }

    public fun root_pack_admission_binding_v8<T0>(arg0: &MakerRootV8<T0>) : &PackAdmissionBindingV8 {
        assert!(0x1::option::is_some<PackAdmissionBindingV8>(&arg0.pack_admission_binding), 13);
        0x1::option::borrow<PackAdmissionBindingV8>(&arg0.pack_admission_binding)
    }

    public fun root_product_release_binding_v8<T0>(arg0: &MakerRootV8<T0>) : &0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::ProductReleaseBindingV8 {
        assert!(0x1::option::is_some<0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::CertifiedProductReleaseBindingV8>(&arg0.product_release_binding), 11);
        0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::certified_binding_v8(0x1::option::borrow<0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::CertifiedProductReleaseBindingV8>(&arg0.product_release_binding))
    }

    public fun root_product_release_call_cap_set_v8<T0>(arg0: &MakerRootV8<T0>) : &0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::PackageCallCapSetBindingV8 {
        assert!(0x1::option::is_some<0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::CertifiedProductReleaseBindingV8>(&arg0.product_release_binding), 11);
        0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::certified_call_cap_set_v8(0x1::option::borrow<0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::CertifiedProductReleaseBindingV8>(&arg0.product_release_binding))
    }

    public fun root_product_release_catalog_id_v8<T0>(arg0: &MakerRootV8<T0>) : 0x2::object::ID {
        assert!(0x1::option::is_some<0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::CertifiedProductReleaseBindingV8>(&arg0.product_release_binding), 11);
        0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::certified_catalog_id_v8(0x1::option::borrow<0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::CertifiedProductReleaseBindingV8>(&arg0.product_release_binding))
    }

    public fun root_protocol_config_commitment_v8<T0>(arg0: &MakerRootV8<T0>) : &vector<u8> {
        &arg0.economics.protocol_config_commitment
    }

    public fun root_protocol_config_id_v8<T0>(arg0: &MakerRootV8<T0>) : 0x2::object::ID {
        arg0.economics.protocol_config_id
    }

    public fun root_protocol_config_revision_v8<T0>(arg0: &MakerRootV8<T0>) : u64 {
        arg0.economics.protocol_config_revision
    }

    public fun root_protocol_treasury_id_v8<T0>(arg0: &MakerRootV8<T0>) : 0x2::object::ID {
        arg0.economics.protocol_treasury_id
    }

    public fun root_renderer_commitment_v8<T0>(arg0: &MakerRootV8<T0>) : &vector<u8> {
        &arg0.renderer_commitment
    }

    public fun root_rights_v8<T0>(arg0: &MakerRootV8<T0>) : RightsSnapshotV8 {
        arg0.rights
    }

    public fun root_version_commitment_v8<T0>(arg0: &MakerRootV8<T0>) : &vector<u8> {
        &arg0.version_commitment
    }

    public fun root_version_v8<T0>(arg0: &MakerRootV8<T0>) : u64 {
        arg0.version
    }

    fun rotate_maker_control_v8<T0>(arg0: &mut MakerRootV8<T0>, arg1: MakerAdminCapV8, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) : MakerAdminCapV8 {
        assert_admin_v8<T0>(arg0, &arg1);
        assert!(arg0.owner == 0x2::tx_context::sender(arg4) || arg3 == 0x2::tx_context::sender(arg4), 2);
        assert!(arg0.control_epoch == arg2, 18);
        assert!(0x1::option::is_none<0x2::object::ID>(&arg0.successor_authority_id), 21);
        assert!(arg0.control_epoch < 18446744073709551615, 18);
        assert!(arg3 != @0x0 && arg3 != arg0.owner, 2);
        let v0 = arg0.control_epoch;
        let MakerAdminCapV8 {
            id            : v1,
            version       : _,
            root_id       : _,
            owner         : _,
            control_epoch : _,
        } = arg1;
        0x2::object::delete(v1);
        arg0.owner = arg3;
        arg0.control_epoch = v0 + 1;
        let v6 = MakerAdminCapV8{
            id            : 0x2::object::new(arg4),
            version       : 8,
            root_id       : 0x2::object::id<MakerRootV8<T0>>(arg0),
            owner         : arg3,
            control_epoch : arg0.control_epoch,
        };
        arg0.admin_cap_id = 0x2::object::id<MakerAdminCapV8>(&v6);
        let v7 = MakerControlTransferredV8{
            root_id                : 0x2::object::id<MakerRootV8<T0>>(arg0),
            previous_owner         : arg0.owner,
            new_owner              : arg3,
            previous_control_epoch : v0,
            new_control_epoch      : arg0.control_epoch,
            new_admin_cap_id       : arg0.admin_cap_id,
        };
        0x2::event::emit<MakerControlTransferredV8>(v7);
        v6
    }

    public(friend) fun share_maker_root_and_admin_v8<T0>(arg0: MakerRootV8<T0>, arg1: MakerAdminCapV8, arg2: &0x2::tx_context::TxContext) {
        assert_draft_admin_v8<T0>(&arg0, &arg1);
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 2);
        0x2::transfer::share_object<MakerRootV8<T0>>(arg0);
        0x2::transfer::transfer<MakerAdminCapV8>(arg1, 0x2::tx_context::sender(arg2));
    }

    public fun transfer_maker_control_v8<T0>(arg0: &mut MakerRootV8<T0>, arg1: MakerAdminCapV8, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::transfer<MakerAdminCapV8>(rotate_maker_control_v8<T0>(arg0, arg1, arg2, arg3, arg4), arg3);
    }

    public(friend) fun transition_lifecycle_from_core_v8<T0>(arg0: &mut MakerRootV8<T0>, arg1: &MakerAdminCapV8, arg2: u8, arg3: &0x2::tx_context::TxContext) : (u8, u8) {
        assert_admin_v8<T0>(arg0, arg1);
        assert!(arg0.owner == 0x2::tx_context::sender(arg3), 2);
        let v0 = arg0.lifecycle;
        assert!(v0 == 1 && (arg2 == 2 || arg2 == 3) || v0 == 2 && (arg2 == 1 || arg2 == 3), 0);
        arg0.lifecycle = arg2;
        (v0, arg2)
    }

    public fun version_v8() : u64 {
        8
    }

    // decompiled from Move bytecode v7
}

