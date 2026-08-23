module 0xa2d7c3c289d884d5899eb0afdfae8abca7555fb8640b493016502196a7500476::runtime_v8 {
    struct RuntimeOriginalMarkerV8 has drop {
        dummy_field: bool,
    }

    struct RuntimeCallableMarkerV8 has drop {
        dummy_field: bool,
    }

    struct PartProfileKeyV8 has copy, drop, store {
        part_key: 0x1::string::String,
    }

    struct PackStyleKeyV8 has copy, drop, store {
        part_key: 0x1::string::String,
        item_key: 0x1::string::String,
        style_key: 0x1::string::String,
    }

    struct WalletKeyV8 has copy, drop, store {
        wallet: address,
    }

    struct PartProfileV8 has copy, drop, store {
        index: u64,
        part_key: 0x1::string::String,
        core_part_payload_commitment: vector<u8>,
        required: bool,
        wardrobe_mode: u8,
        behavior: u8,
        capacity: u64,
        admission_ceiling: u8,
        profile_commitment: vector<u8>,
    }

    struct RuntimeDefinitionRegistryV8 has key {
        id: 0x2::object::UID,
        version: u64,
        root_id: 0x2::object::ID,
        root_version: u64,
        root_content_commitment: vector<u8>,
        base_registry_id: 0x2::object::ID,
        expected_profile_count: u64,
        observed_profile_count: u64,
        expected_profile_commitment: vector<u8>,
        rolling_profile_commitment: vector<u8>,
        admission_ceiling: u8,
        sealed: bool,
        profile_keys: vector<0x1::string::String>,
        profiles: 0x2::table::Table<PartProfileKeyV8, PartProfileV8>,
    }

    struct PackAdmissionAuthorityV8 has key {
        id: 0x2::object::UID,
        version: u64,
        root_id: 0x2::object::ID,
        root_version: u64,
        root_content_commitment: vector<u8>,
    }

    struct PackAdmissionRecordV8 has copy, drop, store {
        release_id: 0x2::object::ID,
        semantic_pack_id: 0x1::string::String,
        release_content_commitment: vector<u8>,
        admitted_revision: u64,
        admission_state: u8,
    }

    struct ExternalAdmissionRecordV8 has copy, drop, store {
        product_id: 0x2::object::ID,
        compatibility_commitment: vector<u8>,
        product_content_commitment: vector<u8>,
        attestation_commitment: 0x1::option::Option<vector<u8>>,
        admitted_revision: u64,
        admission_state: u8,
    }

    struct PackRegistryV8 has key {
        id: 0x2::object::UID,
        version: u64,
        root_id: 0x2::object::ID,
        root_version: u64,
        root_content_commitment: vector<u8>,
        definition_registry_id: 0x2::object::ID,
        admission_authority_id: 0x2::object::ID,
        admission_policy_commitment: vector<u8>,
        revision: u64,
        release_count: u64,
        external_admission_count: u64,
        releases: 0x2::table::Table<0x2::object::ID, PackAdmissionRecordV8>,
        semantic_releases: 0x2::table::Table<0x1::string::String, 0x2::object::ID>,
        external_admissions: 0x2::table::Table<0x2::object::ID, ExternalAdmissionRecordV8>,
    }

    struct RuntimeActivationReadinessReceiptV8 {
        root_id: 0x2::object::ID,
        root_version: u64,
        root_content_commitment: vector<u8>,
        definition_registry_id: 0x2::object::ID,
        pack_registry_id: 0x2::object::ID,
        admission_authority_id: 0x2::object::ID,
        policy_commitment: vector<u8>,
        companion_commitment: vector<u8>,
    }

    struct PackStyleV8 has copy, drop, store {
        index: u64,
        part_key: 0x1::string::String,
        item_key: 0x1::string::String,
        style_key: 0x1::string::String,
        layer_track_key: 0x1::string::String,
        color_channel_key: 0x1::option::Option<0x1::string::String>,
        default_swatch_key: 0x1::option::Option<0x1::string::String>,
        asset_blob_id: 0x1::string::String,
        asset_sha256: vector<u8>,
        asset_content_commitment: vector<u8>,
        protected: bool,
        seal_binding_commitment: vector<u8>,
        style_commitment: vector<u8>,
    }

    struct PackReleaseV8<phantom T0> has key {
        id: 0x2::object::UID,
        version: u64,
        root_id: 0x2::object::ID,
        root_version: u64,
        root_content_commitment: vector<u8>,
        creator: address,
        owner: address,
        control_epoch: u64,
        admin_cap_id: 0x2::object::ID,
        treasury_id: 0x2::object::ID,
        semantic_pack_id: 0x1::string::String,
        manifest_blob_id: 0x1::string::String,
        manifest_sha256: vector<u8>,
        content_commitment: vector<u8>,
        lifecycle: u8,
        access_kind: u8,
        access_price_atomic: u64,
        complete_mode: u8,
        complete_price_atomic: u64,
        complete_free_quota_per_wallet: u64,
        complete_total_cap: u64,
        expected_style_count: u64,
        observed_style_count: u64,
        expected_style_commitment: vector<u8>,
        rolling_style_commitment: vector<u8>,
        protected_style_count: u64,
        pass_count: u64,
        total_complete_count: u64,
        styles: 0x2::table::Table<PackStyleKeyV8, PackStyleV8>,
        complete_by_wallet: 0x2::table::Table<WalletKeyV8, u64>,
    }

    struct PackAdminCapV8 has key {
        id: 0x2::object::UID,
        version: u64,
        release_id: 0x2::object::ID,
        owner: address,
        control_epoch: u64,
    }

    struct PackTreasuryV8<phantom T0> has key {
        id: 0x2::object::UID,
        version: u64,
        release_id: 0x2::object::ID,
        revenue: 0x2::balance::Balance<T0>,
        total_collected: u64,
        total_withdrawn: u64,
    }

    struct PackPassV8 has key {
        id: 0x2::object::UID,
        version: u64,
        release_id: 0x2::object::ID,
        root_id: 0x2::object::ID,
        root_version: u64,
        root_content_commitment: vector<u8>,
        release_content_commitment: vector<u8>,
        holder: address,
        paid_atomic: u64,
        issued_at_ms: u64,
        commitment: vector<u8>,
    }

    struct PackCompleteLineV8 {
        release_id: 0x2::object::ID,
        root_id: 0x2::object::ID,
        root_version: u64,
        root_content_commitment: vector<u8>,
        release_content_commitment: vector<u8>,
        holder: address,
        ordinal: u64,
        price_atomic: u64,
    }

    struct ExternalItemProductV8 has key {
        id: 0x2::object::UID,
        version: u64,
        root_id: 0x2::object::ID,
        root_version: u64,
        root_content_commitment: vector<u8>,
        creator: address,
        owner: address,
        control_epoch: u64,
        admin_cap_id: 0x2::object::ID,
        lifecycle: u8,
        part_key: 0x1::string::String,
        item_key: 0x1::string::String,
        style_key: 0x1::string::String,
        layer_track_key: 0x1::string::String,
        color_channel_key: 0x1::option::Option<0x1::string::String>,
        default_swatch_key: 0x1::option::Option<0x1::string::String>,
        asset_blob_id: 0x1::string::String,
        asset_sha256: vector<u8>,
        asset_content_commitment: vector<u8>,
        compatibility_commitment: vector<u8>,
        content_commitment: vector<u8>,
        transferable: bool,
        supply: u64,
    }

    struct ExternalItemAdminCapV8 has key {
        id: 0x2::object::UID,
        version: u64,
        product_id: 0x2::object::ID,
        owner: address,
        control_epoch: u64,
    }

    struct EquipLockV8 has copy, drop, store {
        loadout_id: 0x2::object::ID,
        equip_revision: u64,
        selection_index: u64,
    }

    struct OwnedExternalItemV8 has key {
        id: 0x2::object::UID,
        version: u64,
        product_id: 0x2::object::ID,
        product_content_commitment: vector<u8>,
        asset_content_commitment: vector<u8>,
        holder: address,
        ownership_epoch: u64,
        transferable: bool,
        equip_lock: 0x1::option::Option<EquipLockV8>,
    }

    struct ExternalItemAttestationV8 {
        catalog_id: 0x2::object::ID,
        product_id: 0x2::object::ID,
        root_id: 0x2::object::ID,
        root_version: u64,
        root_content_commitment: vector<u8>,
        compatibility_commitment: vector<u8>,
        product_content_commitment: vector<u8>,
        attestation_commitment: vector<u8>,
    }

    struct LoadoutSelectionV8 has copy, drop, store {
        selection_index: u64,
        part_key: 0x1::string::String,
        item_key: 0x1::string::String,
        style_key: 0x1::string::String,
        color_channel_key: 0x1::option::Option<0x1::string::String>,
        swatch_key: 0x1::option::Option<0x1::string::String>,
        layer_track_key: 0x1::string::String,
        asset_blob_id: 0x1::string::String,
        asset_sha256: vector<u8>,
        asset_content_commitment: vector<u8>,
        source_class: u8,
        source_definition_id: 0x2::object::ID,
        source_semantic_id: 0x1::string::String,
        access_subject: 0x2::object::ID,
        source_epoch: u64,
        pricing_commitment: vector<u8>,
        protected: bool,
        seal_binding_commitment: vector<u8>,
    }

    struct MakerLoadoutV8 has key {
        id: 0x2::object::UID,
        version: u64,
        root_id: 0x2::object::ID,
        root_version: u64,
        root_content_commitment: vector<u8>,
        definition_registry_id: 0x2::object::ID,
        pack_registry_id: 0x2::object::ID,
        maker_access_pass_id: 0x2::object::ID,
        maker_access_commitment: vector<u8>,
        holder: address,
        revision: u64,
        selections: vector<0x1::option::Option<LoadoutSelectionV8>>,
        selection_count: u64,
        commitment: vector<u8>,
    }

    struct SelectionAccessProofV8 {
        loadout_id: 0x2::object::ID,
        loadout_revision: u64,
        loadout_commitment: vector<u8>,
        selection_index: u64,
        selection_commitment: vector<u8>,
        source_class: u8,
        source_definition_id: 0x2::object::ID,
        source_semantic_id: 0x1::string::String,
        source_content_commitment: vector<u8>,
        source_epoch: u64,
        pricing_commitment: vector<u8>,
    }

    struct RuntimePhysicalSelectionWitnessV8 {
        loadout_id: 0x2::object::ID,
        root_id: 0x2::object::ID,
        root_version: u64,
        root_content_commitment: vector<u8>,
        holder: address,
        loadout_revision: u64,
        loadout_commitment: vector<u8>,
        selection_index: u64,
        selection_commitment: vector<u8>,
        part_key: 0x1::string::String,
        item_key: 0x1::string::String,
        style_key: 0x1::string::String,
        layer_track_key: 0x1::string::String,
        source_class: u8,
        source_definition_id: 0x2::object::ID,
        source_semantic_id: 0x1::string::String,
        source_content_commitment: vector<u8>,
        source_epoch: u64,
        pricing_commitment: vector<u8>,
        asset_content_commitment: vector<u8>,
    }

    struct RuntimePhysicalPackPolicyWitnessV8 {
        root_id: 0x2::object::ID,
        root_version: u64,
        root_content_commitment: vector<u8>,
        pack_registry_id: 0x2::object::ID,
        pack_registry_revision: u64,
        release_id: 0x2::object::ID,
        semantic_pack_id: 0x1::string::String,
        release_content_commitment: vector<u8>,
        pack_owner: address,
        pack_control_epoch: u64,
        pack_admin_cap_id: 0x2::object::ID,
        pack_treasury_id: 0x2::object::ID,
        style_index: u64,
        part_key: 0x1::string::String,
        item_key: 0x1::string::String,
        style_key: 0x1::string::String,
        layer_track_key: 0x1::string::String,
        color_channel_key: 0x1::option::Option<0x1::string::String>,
        default_swatch_key: 0x1::option::Option<0x1::string::String>,
        asset_blob_id: 0x1::string::String,
        asset_sha256: vector<u8>,
        asset_content_commitment: vector<u8>,
        protected: bool,
        seal_binding_commitment: vector<u8>,
        style_commitment: vector<u8>,
        style_identity_commitment: vector<u8>,
    }

    struct RuntimePhysicalPackAccessWitnessV8 {
        root_id: 0x2::object::ID,
        root_version: u64,
        root_content_commitment: vector<u8>,
        holder: address,
        pack_registry_id: 0x2::object::ID,
        pack_registry_revision: u64,
        release_id: 0x2::object::ID,
        semantic_pack_id: 0x1::string::String,
        release_content_commitment: vector<u8>,
        pack_treasury_id: 0x2::object::ID,
        pack_pass_id: 0x2::object::ID,
        pack_pass_commitment: vector<u8>,
        loadout_id: 0x2::object::ID,
        loadout_revision: u64,
        loadout_commitment: vector<u8>,
        selection_index: u64,
        selection_commitment: vector<u8>,
        pricing_commitment: vector<u8>,
        part_key: 0x1::string::String,
        item_key: 0x1::string::String,
        style_key: 0x1::string::String,
        layer_track_key: 0x1::string::String,
        asset_content_commitment: vector<u8>,
        style_identity_commitment: vector<u8>,
    }

    struct UsedPackV8 has copy, drop, store {
        release_id: 0x2::object::ID,
        semantic_pack_id: 0x1::string::String,
        release_content_commitment: vector<u8>,
        pricing_commitment: vector<u8>,
    }

    struct RuntimeLoadoutAuthorizationV8 {
        loadout_id: 0x2::object::ID,
        root_id: 0x2::object::ID,
        root_version: u64,
        root_content_commitment: vector<u8>,
        loadout_revision: u64,
        loadout_commitment: vector<u8>,
        selection_count: u64,
        ordered_selection_commitments: vector<vector<u8>>,
        ordered_pricing_commitments: vector<vector<u8>>,
        used_packs: vector<UsedPackV8>,
    }

    struct RuntimeBaseEntitlementWitnessV8 {
        loadout_id: 0x2::object::ID,
        loadout_revision: u64,
        selection_index: u64,
        holder: address,
        entitlement_id: 0x2::object::ID,
        entitlement_commitment: vector<u8>,
        asset_content_commitment: vector<u8>,
    }

    struct RuntimePackEntitlementWitnessV8 {
        loadout_id: 0x2::object::ID,
        loadout_revision: u64,
        selection_index: u64,
        holder: address,
        pack_release_id: 0x2::object::ID,
        pack_content_commitment: vector<u8>,
        pack_pass_id: 0x2::object::ID,
        pack_pass_commitment: vector<u8>,
        asset_content_commitment: vector<u8>,
    }

    struct RuntimePackRegistrationWitnessV8 {
        release_id: 0x2::object::ID,
        release_content_commitment: vector<u8>,
        sequence: u64,
        part_key: 0x1::string::String,
        item_key: 0x1::string::String,
        style_key: 0x1::string::String,
        asset_content_commitment: vector<u8>,
    }

    struct PartProfileCommitmentInputV8 has drop {
        domain: vector<u8>,
        version: u64,
        root_content_commitment: vector<u8>,
        sequence: u64,
        previous: vector<u8>,
        part_key: 0x1::string::String,
        core_part_payload_commitment: vector<u8>,
        required: bool,
        wardrobe_mode: u8,
        behavior: u8,
        capacity: u64,
        admission_ceiling: u8,
    }

    struct RuntimePolicyCommitmentInputV8 has drop {
        domain: vector<u8>,
        version: u64,
        root_content_commitment: vector<u8>,
        profile_count: u64,
        profile_commitment: vector<u8>,
        admission_ceiling: u8,
    }

    struct RuntimeReadinessCommitmentInputV8 has drop {
        domain: vector<u8>,
        version: u64,
        root_id: 0x2::object::ID,
        root_version: u64,
        root_content_commitment: vector<u8>,
        definition_registry_id: 0x2::object::ID,
        definition_profile_count: u64,
        definition_profile_commitment: vector<u8>,
        pack_registry_id: 0x2::object::ID,
        pack_registry_revision: u64,
        pack_release_count: u64,
        external_admission_count: u64,
        admission_authority_id: 0x2::object::ID,
        policy_commitment: vector<u8>,
    }

    struct MakerAccessEntitlementCommitmentInputV8 has drop {
        domain: vector<u8>,
        version: u64,
        pass_id: 0x2::object::ID,
        root_id: 0x2::object::ID,
        maker_version: u64,
        root_content_commitment: vector<u8>,
        holder: address,
        paid_atomic: u64,
        issued_at_ms: u64,
    }

    struct EmptyCommitmentInputV8 has drop {
        domain: vector<u8>,
        version: u64,
        root_content_commitment: vector<u8>,
    }

    struct PackEmptyCommitmentInputV8 has drop {
        domain: vector<u8>,
        version: u64,
        root_content_commitment: vector<u8>,
        release_content_commitment: vector<u8>,
    }

    struct PackStyleCommitmentInputV8 has drop {
        domain: vector<u8>,
        version: u64,
        root_content_commitment: vector<u8>,
        release_content_commitment: vector<u8>,
        sequence: u64,
        previous: vector<u8>,
        style: PackStyleV8,
    }

    struct LoadoutCommitmentInputV8 has drop {
        domain: vector<u8>,
        version: u64,
        root_id: 0x2::object::ID,
        root_version: u64,
        root_content_commitment: vector<u8>,
        selections: vector<0x1::option::Option<LoadoutSelectionV8>>,
    }

    struct SelectionCommitmentInputV8 has drop {
        domain: vector<u8>,
        version: u64,
        selection: LoadoutSelectionV8,
    }

    struct PricingCommitmentInputV8 has drop {
        domain: vector<u8>,
        version: u64,
        release_id: 0x2::object::ID,
        release_content_commitment: vector<u8>,
        access_kind: u8,
        access_price_atomic: u64,
        complete_mode: u8,
        complete_price_atomic: u64,
        complete_free_quota_per_wallet: u64,
        complete_total_cap: u64,
    }

    struct ExternalProductCommitmentInputV8 has drop {
        domain: vector<u8>,
        version: u64,
        root_id: 0x2::object::ID,
        root_version: u64,
        root_content_commitment: vector<u8>,
        profile_commitment: vector<u8>,
        part_key: 0x1::string::String,
        item_key: 0x1::string::String,
        style_key: 0x1::string::String,
        layer_track_key: 0x1::string::String,
        color_channel_key: 0x1::option::Option<0x1::string::String>,
        default_swatch_key: 0x1::option::Option<0x1::string::String>,
        asset_blob_id: 0x1::string::String,
        asset_sha256: vector<u8>,
        asset_content_commitment: vector<u8>,
        transferable: bool,
    }

    struct AttestationCommitmentInputV8 has drop {
        domain: vector<u8>,
        version: u64,
        catalog_id: 0x2::object::ID,
        product_id: 0x2::object::ID,
        root_id: 0x2::object::ID,
        root_version: u64,
        root_content_commitment: vector<u8>,
        compatibility_commitment: vector<u8>,
        product_content_commitment: vector<u8>,
    }

    struct ExternalContentCommitmentInputV8 has drop {
        domain: vector<u8>,
        version: u64,
        compatibility_commitment: vector<u8>,
        asset_content_commitment: vector<u8>,
    }

    struct PackPassCommitmentInputV8 has drop {
        domain: vector<u8>,
        version: u64,
        release_id: 0x2::object::ID,
        root_id: 0x2::object::ID,
        root_version: u64,
        root_content_commitment: vector<u8>,
        release_content_commitment: vector<u8>,
        holder: address,
        paid_atomic: u64,
        issued_at_ms: u64,
    }

    struct PhysicalPackStyleIdentityInputV8 has drop {
        domain: vector<u8>,
        version: u64,
        root_id: 0x2::object::ID,
        root_version: u64,
        root_content_commitment: vector<u8>,
        pack_registry_id: 0x2::object::ID,
        release_id: 0x2::object::ID,
        semantic_pack_id: 0x1::string::String,
        release_content_commitment: vector<u8>,
        pack_treasury_id: 0x2::object::ID,
        style: PackStyleV8,
    }

    struct SealBindingCommitmentInputV8 has drop {
        domain: vector<u8>,
        version: u64,
        registry_id: 0x2::object::ID,
        registry_commitment: vector<u8>,
        runtime_revision: u64,
        runtime_commitment: vector<u8>,
        policy_config_id: 0x2::object::ID,
        policy_commitment: vector<u8>,
        root_id: 0x2::object::ID,
        root_version: u64,
        root_content_commitment: vector<u8>,
        scope_kind: u8,
        scope_key: 0x1::string::String,
        scope_commitment: vector<u8>,
        asset_key: 0x1::string::String,
        asset_content_commitment: vector<u8>,
        ciphertext_blob_id: 0x1::string::String,
        ciphertext_sha256: vector<u8>,
        ciphertext_blob_commitment: vector<u8>,
        certification_commitment: vector<u8>,
        seal_id: vector<u8>,
    }

    struct RuntimeRegistriesCreatedV8 has copy, drop {
        root_id: 0x2::object::ID,
        definition_registry_id: 0x2::object::ID,
        pack_registry_id: 0x2::object::ID,
        admission_authority_id: 0x2::object::ID,
    }

    struct PackRegistryRevisionAdvancedV8 has copy, drop {
        root_id: 0x2::object::ID,
        previous_revision: u64,
        revision: u64,
        subject_id: 0x2::object::ID,
        operation: u8,
    }

    struct PackLifecycleChangedV8 has copy, drop {
        release_id: 0x2::object::ID,
        previous_lifecycle: u8,
        lifecycle: u8,
    }

    struct ExternalItemEquipChangedV8 has copy, drop {
        item_id: 0x2::object::ID,
        loadout_id: 0x2::object::ID,
        revision: u64,
        equipped: bool,
    }

    public fun access_free_v8() : u8 {
        0
    }

    public fun access_included_with_maker_v8() : u8 {
        2
    }

    public fun access_paid_v8() : u8 {
        1
    }

    public fun admission_certified_v8() : u8 {
        1
    }

    public fun admission_disabled_v8() : u8 {
        0
    }

    public fun admission_open_v8() : u8 {
        2
    }

    public fun admit_certified_external_product_v8<T0>(arg0: &mut PackRegistryV8, arg1: &PackAdmissionAuthorityV8, arg2: &RuntimeDefinitionRegistryV8, arg3: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerRootV8<T0>, arg4: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerAdminCapV8, arg5: &ExternalItemProductV8, arg6: ExternalItemAttestationV8, arg7: u64, arg8: &0x2::tx_context::TxContext) {
        assert!(arg2.admission_ceiling >= 1, 15);
        let ExternalItemAttestationV8 {
            catalog_id                 : v0,
            product_id                 : v1,
            root_id                    : v2,
            root_version               : v3,
            root_content_commitment    : v4,
            compatibility_commitment   : v5,
            product_content_commitment : v6,
            attestation_commitment     : v7,
        } = arg6;
        assert!(v0 == 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::root_product_release_catalog_id_v8<T0>(arg3), 16);
        assert!(v1 == 0x2::object::id<ExternalItemProductV8>(arg5), 16);
        assert!(v2 == arg5.root_id, 16);
        assert!(v3 == arg5.root_version, 16);
        assert!(v4 == arg5.root_content_commitment, 16);
        assert!(v5 == arg5.compatibility_commitment, 16);
        assert!(v6 == arg5.content_commitment, 16);
        admit_external_product<T0>(arg0, arg1, arg2, arg3, arg4, arg5, 0x1::option::some<vector<u8>>(v7), arg7, arg8);
    }

    fun admit_external_product<T0>(arg0: &mut PackRegistryV8, arg1: &PackAdmissionAuthorityV8, arg2: &RuntimeDefinitionRegistryV8, arg3: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerRootV8<T0>, arg4: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerAdminCapV8, arg5: &ExternalItemProductV8, arg6: 0x1::option::Option<vector<u8>>, arg7: u64, arg8: &0x2::tx_context::TxContext) {
        assert_root_active<T0>(arg3);
        0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::assert_admin_v8<T0>(arg3, arg4);
        assert!(0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::root_owner_v8<T0>(arg3) == 0x2::tx_context::sender(arg8), 29);
        assert_pack_registry_identity<T0>(arg0, arg2, arg3);
        assert_authority_identity<T0>(arg1, arg0, arg3);
        assert!(arg0.revision == arg7, 7);
        assert!(arg5.root_id == arg0.root_id, 0);
        assert!(arg5.root_version == arg0.root_version, 0);
        assert!(arg5.root_content_commitment == arg0.root_content_commitment, 0);
        assert!(arg5.lifecycle == 0, 9);
        let v0 = PartProfileKeyV8{part_key: arg5.part_key};
        let v1 = 0x2::table::borrow<PartProfileKeyV8, PartProfileV8>(&arg2.profiles, v0);
        assert!(v1.wardrobe_mode == 1, 14);
        assert_external_profile_behavior(v1);
        assert!(v1.admission_ceiling == arg2.admission_ceiling, 10);
        if (arg2.admission_ceiling == 1) {
            assert!(0x1::option::is_some<vector<u8>>(&arg6), 16);
        };
        let v2 = 0x2::object::id<ExternalItemProductV8>(arg5);
        assert!(!0x2::table::contains<0x2::object::ID, ExternalAdmissionRecordV8>(&arg0.external_admissions, v2), 27);
        arg0.revision = arg0.revision + 1;
        arg0.external_admission_count = arg0.external_admission_count + 1;
        let v3 = ExternalAdmissionRecordV8{
            product_id                 : v2,
            compatibility_commitment   : arg5.compatibility_commitment,
            product_content_commitment : arg5.content_commitment,
            attestation_commitment     : arg6,
            admitted_revision          : arg0.revision,
            admission_state            : 0,
        };
        0x2::table::add<0x2::object::ID, ExternalAdmissionRecordV8>(&mut arg0.external_admissions, v2, v3);
        let v4 = PackRegistryRevisionAdvancedV8{
            root_id           : arg0.root_id,
            previous_revision : arg7,
            revision          : arg0.revision,
            subject_id        : v2,
            operation         : 2,
        };
        0x2::event::emit<PackRegistryRevisionAdvancedV8>(v4);
    }

    public fun admit_open_external_product_v8<T0>(arg0: &mut PackRegistryV8, arg1: &PackAdmissionAuthorityV8, arg2: &RuntimeDefinitionRegistryV8, arg3: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerRootV8<T0>, arg4: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerAdminCapV8, arg5: &ExternalItemProductV8, arg6: u64, arg7: &0x2::tx_context::TxContext) {
        assert!(arg2.admission_ceiling == 2, 15);
        admit_external_product<T0>(arg0, arg1, arg2, arg3, arg4, arg5, 0x1::option::none<vector<u8>>(), arg6, arg7);
    }

    public fun admit_pack_release_v8<T0>(arg0: &mut PackRegistryV8, arg1: &PackAdmissionAuthorityV8, arg2: &RuntimeDefinitionRegistryV8, arg3: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerRootV8<T0>, arg4: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerAdminCapV8, arg5: &mut PackReleaseV8<T0>, arg6: u64, arg7: &0x2::tx_context::TxContext) {
        assert_root_active<T0>(arg3);
        0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::assert_admin_v8<T0>(arg3, arg4);
        assert!(0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::root_owner_v8<T0>(arg3) == 0x2::tx_context::sender(arg7), 29);
        assert_pack_registry_identity<T0>(arg0, arg2, arg3);
        assert_authority_identity<T0>(arg1, arg0, arg3);
        assert!(arg0.revision == arg6, 7);
        assert_release_compatibility<T0>(arg5, arg0);
        assert!(arg5.lifecycle == 1, 9);
        let v0 = 0x2::object::id<PackReleaseV8<T0>>(arg5);
        assert!(!0x2::table::contains<0x2::object::ID, PackAdmissionRecordV8>(&arg0.releases, v0), 27);
        assert!(!0x2::table::contains<0x1::string::String, 0x2::object::ID>(&arg0.semantic_releases, arg5.semantic_pack_id), 27);
        arg0.revision = arg0.revision + 1;
        arg0.release_count = arg0.release_count + 1;
        let v1 = PackAdmissionRecordV8{
            release_id                 : v0,
            semantic_pack_id           : arg5.semantic_pack_id,
            release_content_commitment : arg5.content_commitment,
            admitted_revision          : arg0.revision,
            admission_state            : 0,
        };
        0x2::table::add<0x2::object::ID, PackAdmissionRecordV8>(&mut arg0.releases, v0, v1);
        0x2::table::add<0x1::string::String, 0x2::object::ID>(&mut arg0.semantic_releases, arg5.semantic_pack_id, v0);
        arg5.lifecycle = 2;
        let v2 = PackRegistryRevisionAdvancedV8{
            root_id           : arg0.root_id,
            previous_revision : arg6,
            revision          : arg0.revision,
            subject_id        : v0,
            operation         : 0,
        };
        0x2::event::emit<PackRegistryRevisionAdvancedV8>(v2);
        let v3 = PackLifecycleChangedV8{
            release_id         : v0,
            previous_lifecycle : 1,
            lifecycle          : 2,
        };
        0x2::event::emit<PackLifecycleChangedV8>(v3);
    }

    public fun advance_pack_style_commitment_v8(arg0: vector<u8>, arg1: vector<u8>, arg2: u64, arg3: vector<u8>, arg4: PackStyleV8) : vector<u8> {
        assert_hash(&arg0);
        assert_hash(&arg1);
        assert_hash(&arg3);
        assert_pack_style(&arg4);
        let v0 = PackStyleCommitmentInputV8{
            domain                     : b"animacraft-v8/runtime/pack-style",
            version                    : 8,
            root_content_commitment    : arg0,
            release_content_commitment : arg1,
            sequence                   : arg2,
            previous                   : arg3,
            style                      : arg4,
        };
        0x1::hash::sha2_256(0x1::bcs::to_bytes<PackStyleCommitmentInputV8>(&v0))
    }

    public fun advance_profile_commitment_v8(arg0: vector<u8>, arg1: u64, arg2: vector<u8>, arg3: 0x1::string::String, arg4: vector<u8>, arg5: bool, arg6: u8, arg7: u8, arg8: u64, arg9: u8) : vector<u8> {
        assert_hash(&arg0);
        assert_hash(&arg2);
        assert_key(&arg3);
        assert_hash(&arg4);
        assert_profile_policy(arg6, arg7, arg8, arg9, arg5);
        let v0 = PartProfileCommitmentInputV8{
            domain                       : b"animacraft-v8/runtime/part-profile",
            version                      : 8,
            root_content_commitment      : arg0,
            sequence                     : arg1,
            previous                     : arg2,
            part_key                     : arg3,
            core_part_payload_commitment : arg4,
            required                     : arg5,
            wardrobe_mode                : arg6,
            behavior                     : arg7,
            capacity                     : arg8,
            admission_ceiling            : arg9,
        };
        0x1::hash::sha2_256(0x1::bcs::to_bytes<PartProfileCommitmentInputV8>(&v0))
    }

    public(friend) fun append_certified_pack_style_v8<T0>(arg0: &mut PackReleaseV8<T0>, arg1: &PackAdminCapV8, arg2: &RuntimeDefinitionRegistryV8, arg3: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::BaseDefinitionRegistryV8, arg4: RuntimePackRegistrationWitnessV8, arg5: 0x1::string::String, arg6: 0x1::option::Option<0x1::string::String>, arg7: 0x1::option::Option<0x1::string::String>, arg8: 0x1::string::String, arg9: vector<u8>, arg10: vector<u8>, arg11: vector<u8>, arg12: vector<u8>, arg13: &0x2::tx_context::TxContext) {
        assert_pack_write<T0>(arg0, arg1, arg13);
        let RuntimePackRegistrationWitnessV8 {
            release_id                 : v0,
            release_content_commitment : v1,
            sequence                   : v2,
            part_key                   : v3,
            item_key                   : v4,
            style_key                  : v5,
            asset_content_commitment   : v6,
        } = arg4;
        let v7 = v3;
        assert!(v0 == 0x2::object::id<PackReleaseV8<T0>>(arg0), 0);
        assert!(v1 == arg0.content_commitment, 0);
        assert!(arg10 == v6, 0);
        assert!(v2 == arg0.observed_style_count, 4);
        let v8 = PartProfileKeyV8{part_key: v7};
        assert!(0x2::table::contains<PartProfileKeyV8, PartProfileV8>(&arg2.profiles, v8), 12);
        assert_pack_style_base_references<T0>(arg2, arg3, arg0, &v7, &arg5, &arg6, &arg7);
        let v9 = PackStyleV8{
            index                    : v2,
            part_key                 : v7,
            item_key                 : v4,
            style_key                : v5,
            layer_track_key          : arg5,
            color_channel_key        : arg6,
            default_swatch_key       : arg7,
            asset_blob_id            : arg8,
            asset_sha256             : arg9,
            asset_content_commitment : arg10,
            protected                : true,
            seal_binding_commitment  : arg11,
            style_commitment         : arg12,
        };
        assert_pack_style(&v9);
        let v10 = PackStyleKeyV8{
            part_key  : v7,
            item_key  : v4,
            style_key : v5,
        };
        assert!(!0x2::table::contains<PackStyleKeyV8, PackStyleV8>(&arg0.styles, v10), 11);
        0x2::table::add<PackStyleKeyV8, PackStyleV8>(&mut arg0.styles, v10, v9);
        arg0.observed_style_count = arg0.observed_style_count + 1;
        arg0.protected_style_count = arg0.protected_style_count + 1;
        arg0.rolling_style_commitment = advance_pack_style_commitment_v8(arg0.root_content_commitment, arg0.content_commitment, v2, arg0.rolling_style_commitment, v9);
    }

    public fun append_part_profile_v8<T0>(arg0: &mut RuntimeDefinitionRegistryV8, arg1: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerRootV8<T0>, arg2: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerAdminCapV8, arg3: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::BaseDefinitionRegistryV8, arg4: u64, arg5: 0x1::string::String, arg6: u8, arg7: u8, arg8: u64) {
        assert_definition_write<T0>(arg0, arg1, arg2, arg3, arg4);
        assert!(arg4 < arg0.expected_profile_count, 3);
        let v0 = 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::borrow_part_v8(arg3, arg5);
        assert!(0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::part_key_v8(v0) == &arg5, 0);
        assert!(0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::part_sequence_v8(v0) == 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::registry_track_count_v8(arg3) + arg4, 13);
        let v1 = 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::part_required_v8(v0);
        assert_profile_policy(arg6, arg7, arg8, arg0.admission_ceiling, v1);
        let v2 = *0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::part_payload_commitment_v8(v0);
        let v3 = advance_profile_commitment_v8(arg0.root_content_commitment, arg4, arg0.rolling_profile_commitment, arg5, v2, v1, arg6, arg7, arg8, arg0.admission_ceiling);
        let v4 = PartProfileKeyV8{part_key: arg5};
        assert!(!0x2::table::contains<PartProfileKeyV8, PartProfileV8>(&arg0.profiles, v4), 11);
        let v5 = PartProfileV8{
            index                        : arg4,
            part_key                     : arg5,
            core_part_payload_commitment : v2,
            required                     : v1,
            wardrobe_mode                : arg6,
            behavior                     : arg7,
            capacity                     : arg8,
            admission_ceiling            : arg0.admission_ceiling,
            profile_commitment           : v3,
        };
        0x2::table::add<PartProfileKeyV8, PartProfileV8>(&mut arg0.profiles, v4, v5);
        0x1::vector::push_back<0x1::string::String>(&mut arg0.profile_keys, arg5);
        arg0.observed_profile_count = arg0.observed_profile_count + 1;
        arg0.rolling_profile_commitment = v3;
    }

    public fun append_unprotected_pack_style_v8<T0>(arg0: &mut PackReleaseV8<T0>, arg1: &PackAdminCapV8, arg2: &RuntimeDefinitionRegistryV8, arg3: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::BaseDefinitionRegistryV8, arg4: u64, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::option::Option<0x1::string::String>, arg10: 0x1::option::Option<0x1::string::String>, arg11: 0x1::string::String, arg12: vector<u8>, arg13: vector<u8>, arg14: vector<u8>, arg15: &0x2::tx_context::TxContext) {
        assert_pack_write<T0>(arg0, arg1, arg15);
        assert!(arg0.lifecycle == 0, 9);
        assert!(arg4 == arg0.observed_style_count, 4);
        assert!(arg4 < arg0.expected_style_count, 3);
        assert!(arg2.root_id == arg0.root_id, 0);
        assert!(arg2.root_version == arg0.root_version, 0);
        assert!(arg2.root_content_commitment == arg0.root_content_commitment, 0);
        assert!(arg2.sealed, 6);
        let v0 = PartProfileKeyV8{part_key: arg5};
        assert!(0x2::table::contains<PartProfileKeyV8, PartProfileV8>(&arg2.profiles, v0), 12);
        assert_pack_style_base_references<T0>(arg2, arg3, arg0, &arg5, &arg8, &arg9, &arg10);
        let v1 = PackStyleV8{
            index                    : arg4,
            part_key                 : arg5,
            item_key                 : arg6,
            style_key                : arg7,
            layer_track_key          : arg8,
            color_channel_key        : arg9,
            default_swatch_key       : arg10,
            asset_blob_id            : arg11,
            asset_sha256             : arg12,
            asset_content_commitment : arg13,
            protected                : false,
            seal_binding_commitment  : b"",
            style_commitment         : arg14,
        };
        assert_pack_style(&v1);
        let v2 = PackStyleKeyV8{
            part_key  : arg5,
            item_key  : arg6,
            style_key : arg7,
        };
        assert!(!0x2::table::contains<PackStyleKeyV8, PackStyleV8>(&arg0.styles, v2), 11);
        0x2::table::add<PackStyleKeyV8, PackStyleV8>(&mut arg0.styles, v2, v1);
        arg0.observed_style_count = arg0.observed_style_count + 1;
        arg0.rolling_style_commitment = advance_pack_style_commitment_v8(arg0.root_content_commitment, arg0.content_commitment, arg4, arg0.rolling_style_commitment, v1);
    }

    public fun archive_external_product_v8(arg0: &mut ExternalItemProductV8, arg1: &ExternalItemAdminCapV8, arg2: &0x2::tx_context::TxContext) {
        assert_product_control(arg0, arg1, arg2);
        assert!(arg0.lifecycle != 2, 9);
        arg0.lifecycle = 2;
    }

    public fun archive_pack_release_v8<T0>(arg0: &mut PackReleaseV8<T0>, arg1: &PackAdminCapV8, arg2: &0x2::tx_context::TxContext) {
        assert_pack_write<T0>(arg0, arg1, arg2);
        assert!(arg0.lifecycle == 2 || arg0.lifecycle == 3, 9);
        set_pack_lifecycle<T0>(arg0, 4);
    }

    fun assert_access_policy(arg0: u8, arg1: u64) {
        let v0 = if (arg0 == 0 && arg1 == 0) {
            true
        } else if (arg0 == 1 && arg1 > 0) {
            true
        } else {
            arg0 == 2 && arg1 == 0
        };
        assert!(v0 && arg1 <= 1000000000000, 10);
    }

    fun assert_active_pack_admission<T0>(arg0: &PackRegistryV8, arg1: &PackReleaseV8<T0>) {
        assert_release_compatibility<T0>(arg1, arg0);
        let v0 = 0x2::table::borrow<0x2::object::ID, PackAdmissionRecordV8>(&arg0.releases, 0x2::object::id<PackReleaseV8<T0>>(arg1));
        assert!(v0.admission_state == 0, 15);
        assert!(&v0.semantic_pack_id == &arg1.semantic_pack_id, 15);
        assert!(*0x2::table::borrow<0x1::string::String, 0x2::object::ID>(&arg0.semantic_releases, arg1.semantic_pack_id) == 0x2::object::id<PackReleaseV8<T0>>(arg1), 15);
        assert!(v0.release_content_commitment == arg1.content_commitment, 15);
    }

    fun assert_admission_ceiling(arg0: u8) {
        assert!(arg0 <= 2, 10);
    }

    fun assert_authority_identity<T0>(arg0: &PackAdmissionAuthorityV8, arg1: &PackRegistryV8, arg2: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerRootV8<T0>) {
        assert!(arg0.version == 8, 0);
        assert!(0x2::object::id<PackAdmissionAuthorityV8>(arg0) == arg1.admission_authority_id, 0);
        0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::assert_root_identity_v8<T0>(arg2, arg0.root_id, arg0.root_version, &arg0.root_content_commitment);
    }

    fun assert_color_pair(arg0: &0x1::option::Option<0x1::string::String>, arg1: &0x1::option::Option<0x1::string::String>) {
        assert!(0x1::option::is_some<0x1::string::String>(arg0) == 0x1::option::is_some<0x1::string::String>(arg1), 0);
        if (0x1::option::is_some<0x1::string::String>(arg0)) {
            assert_key(0x1::option::borrow<0x1::string::String>(arg0));
            assert_key(0x1::option::borrow<0x1::string::String>(arg1));
        };
    }

    fun assert_complete_policy(arg0: u8, arg1: u64, arg2: u64, arg3: u64) {
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
        assert!(v1, 10);
        assert!(arg1 <= 1000000000000 && arg2 <= 1000000000, 10);
        assert!(arg3 <= 1000000000, 10);
        assert!(arg3 == 0 || arg3 >= arg2, 10);
    }

    fun assert_definition_binding<T0>(arg0: &RuntimeDefinitionRegistryV8, arg1: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerRootV8<T0>, arg2: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::BaseDefinitionRegistryV8) {
        assert_definition_identity<T0>(arg0, arg1);
        assert!(arg0.base_registry_id == 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::registry_id_v8(arg2), 0);
        assert!(0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::registry_root_id_v8(arg2) == arg0.root_id, 0);
        assert!(0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::registry_maker_version_v8(arg2) == arg0.root_version, 0);
        assert!(0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::registry_root_content_commitment_v8(arg2) == &arg0.root_content_commitment, 0);
        assert!(0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::registry_sealed_v8(arg2), 6);
    }

    fun assert_definition_identity<T0>(arg0: &RuntimeDefinitionRegistryV8, arg1: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerRootV8<T0>) {
        assert!(arg0.version == 8, 0);
        0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::assert_root_identity_v8<T0>(arg1, arg0.root_id, arg0.root_version, &arg0.root_content_commitment);
    }

    fun assert_definition_write<T0>(arg0: &RuntimeDefinitionRegistryV8, arg1: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerRootV8<T0>, arg2: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerAdminCapV8, arg3: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::BaseDefinitionRegistryV8, arg4: u64) {
        0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::assert_draft_admin_v8<T0>(arg1, arg2);
        assert_definition_binding<T0>(arg0, arg1, arg3);
        assert!(!arg0.sealed, 5);
        assert!(arg4 == arg0.observed_profile_count, 4);
    }

    fun assert_external_access(arg0: &PackRegistryV8, arg1: &ExternalItemProductV8, arg2: &OwnedExternalItemV8, arg3: address) {
        assert!(arg1.lifecycle == 0, 9);
        assert!(arg1.root_id == arg0.root_id, 0);
        assert!(arg1.root_version == arg0.root_version, 0);
        assert!(arg1.root_content_commitment == arg0.root_content_commitment, 0);
        let v0 = 0x2::table::borrow<0x2::object::ID, ExternalAdmissionRecordV8>(&arg0.external_admissions, 0x2::object::id<ExternalItemProductV8>(arg1));
        assert!(v0.admission_state == 0, 15);
        assert!(v0.compatibility_commitment == arg1.compatibility_commitment, 15);
        assert!(v0.product_content_commitment == arg1.content_commitment, 15);
        assert!(arg2.product_id == 0x2::object::id<ExternalItemProductV8>(arg1), 0);
        assert!(arg2.product_content_commitment == arg1.content_commitment, 0);
        assert!(arg2.asset_content_commitment == arg1.asset_content_commitment, 0);
        assert!(arg2.holder == arg3, 8);
    }

    fun assert_external_profile_behavior(arg0: &PartProfileV8) {
        assert!(behavior_accepts_external(arg0.behavior), 15);
    }

    fun assert_hash(arg0: &vector<u8>) {
        assert!(0x1::vector::length<u8>(arg0) == 32, 1);
    }

    fun assert_key(arg0: &0x1::string::String) {
        assert!(0x1::string::length(arg0) > 0 && 0x1::string::length(arg0) <= 128, 2);
        let v0 = 0x1::string::as_bytes(arg0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(v0)) {
            assert!(*0x1::vector::borrow<u8>(v0, v1) != 0 && *0x1::vector::borrow<u8>(v0, v1) != 47, 2);
            v1 = v1 + 1;
        };
    }

    fun assert_loadout_holder_revision(arg0: &MakerLoadoutV8, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.version == 8, 0);
        assert!(arg0.holder == 0x2::tx_context::sender(arg2), 8);
        assert!(arg0.revision == arg1, 7);
    }

    fun assert_loadout_maker_access<T0>(arg0: &MakerLoadoutV8, arg1: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerRootV8<T0>, arg2: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::treasury_v8::MakerAccessPassV8, arg3: &0x2::tx_context::TxContext) {
        0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::treasury_v8::assert_maker_access_pass_v8<T0>(arg1, arg2, 0x2::tx_context::sender(arg3));
        assert_root_compatibility<T0>(arg0.root_id, arg0.root_version, &arg0.root_content_commitment, arg1);
        assert!(arg0.holder == 0x2::tx_context::sender(arg3), 8);
        assert!(arg0.maker_access_pass_id == 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::treasury_v8::maker_access_pass_id_v8(arg2), 21);
        assert!(arg0.maker_access_commitment == maker_access_entitlement_commitment_v8(arg2), 21);
    }

    fun assert_loadout_write<T0>(arg0: &MakerLoadoutV8, arg1: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerRootV8<T0>, arg2: &RuntimeDefinitionRegistryV8, arg3: &PackRegistryV8, arg4: u64, arg5: &0x2::tx_context::TxContext) {
        assert_root_active<T0>(arg1);
        assert_loadout_holder_revision(arg0, arg4, arg5);
        assert_definition_identity<T0>(arg2, arg1);
        assert_pack_registry_identity<T0>(arg3, arg2, arg1);
        assert!(arg0.root_id == arg2.root_id, 0);
        assert!(arg0.root_version == arg2.root_version, 0);
        assert!(arg0.root_content_commitment == arg2.root_content_commitment, 0);
        assert!(arg0.definition_registry_id == 0x2::object::id<RuntimeDefinitionRegistryV8>(arg2), 0);
        assert!(arg0.pack_registry_id == 0x2::object::id<PackRegistryV8>(arg3), 0);
    }

    fun assert_locator(arg0: &0x1::string::String) {
        assert!(0x1::string::length(arg0) > 0 && 0x1::string::length(arg0) <= 512, 2);
    }

    fun assert_owned_holder(arg0: &OwnedExternalItemV8, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.version == 8, 0);
        assert!(arg0.holder == 0x2::tx_context::sender(arg1), 8);
    }

    fun assert_pack_control<T0>(arg0: &PackReleaseV8<T0>, arg1: &PackAdminCapV8, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.version == 8 && arg1.version == 8, 0);
        assert!(0x2::object::id<PackReleaseV8<T0>>(arg0) == arg1.release_id, 29);
        assert!(arg0.admin_cap_id == 0x2::object::id<PackAdminCapV8>(arg1), 29);
        assert!(arg0.owner == 0x2::tx_context::sender(arg2) && arg1.owner == 0x2::tx_context::sender(arg2), 29);
        assert!(arg0.control_epoch == arg1.control_epoch, 29);
    }

    fun assert_pack_pass<T0>(arg0: &PackReleaseV8<T0>, arg1: &PackPassV8, arg2: address) {
        assert!(arg1.version == 8, 23);
        assert!(arg1.release_id == 0x2::object::id<PackReleaseV8<T0>>(arg0), 23);
        assert!(arg1.root_id == arg0.root_id, 23);
        assert!(arg1.root_version == arg0.root_version, 23);
        assert!(arg1.root_content_commitment == arg0.root_content_commitment, 23);
        assert!(arg1.release_content_commitment == arg0.content_commitment, 23);
        assert!(arg1.holder == arg2, 23);
        let v0 = PackPassCommitmentInputV8{
            domain                     : b"animacraft-v8/runtime/pack-pass",
            version                    : 8,
            release_id                 : arg1.release_id,
            root_id                    : arg1.root_id,
            root_version               : arg1.root_version,
            root_content_commitment    : arg1.root_content_commitment,
            release_content_commitment : arg1.release_content_commitment,
            holder                     : arg1.holder,
            paid_atomic                : arg1.paid_atomic,
            issued_at_ms               : arg1.issued_at_ms,
        };
        assert!(arg1.commitment == 0x1::hash::sha2_256(0x1::bcs::to_bytes<PackPassCommitmentInputV8>(&v0)), 23);
    }

    fun assert_pack_registry_identity<T0>(arg0: &PackRegistryV8, arg1: &RuntimeDefinitionRegistryV8, arg2: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerRootV8<T0>) {
        assert_definition_identity<T0>(arg1, arg2);
        assert!(arg0.version == 8, 0);
        assert!(arg0.root_id == arg1.root_id, 0);
        assert!(arg0.root_version == arg1.root_version, 0);
        assert!(arg0.root_content_commitment == arg1.root_content_commitment, 0);
        assert!(arg0.definition_registry_id == 0x2::object::id<RuntimeDefinitionRegistryV8>(arg1), 0);
        assert!(&arg0.admission_policy_commitment == 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::root_expected_pack_admission_policy_commitment_v8<T0>(arg2), 0);
    }

    fun assert_pack_style(arg0: &PackStyleV8) {
        assert_key(&arg0.part_key);
        assert_key(&arg0.item_key);
        assert_key(&arg0.style_key);
        assert_key(&arg0.layer_track_key);
        assert_color_pair(&arg0.color_channel_key, &arg0.default_swatch_key);
        assert_locator(&arg0.asset_blob_id);
        assert_hash(&arg0.asset_sha256);
        assert_hash(&arg0.asset_content_commitment);
        assert_hash(&arg0.style_commitment);
        if (arg0.protected) {
            assert_hash(&arg0.seal_binding_commitment);
        } else {
            assert!(0x1::vector::is_empty<u8>(&arg0.seal_binding_commitment), 1);
        };
    }

    fun assert_pack_style_base_references<T0>(arg0: &RuntimeDefinitionRegistryV8, arg1: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::BaseDefinitionRegistryV8, arg2: &PackReleaseV8<T0>, arg3: &0x1::string::String, arg4: &0x1::string::String, arg5: &0x1::option::Option<0x1::string::String>, arg6: &0x1::option::Option<0x1::string::String>) {
        assert!(arg0.base_registry_id == 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::registry_id_v8(arg1), 0);
        assert!(0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::registry_root_id_v8(arg1) == arg2.root_id, 0);
        assert!(0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::registry_maker_version_v8(arg1) == arg2.root_version, 0);
        assert!(0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::registry_root_content_commitment_v8(arg1) == &arg2.root_content_commitment, 0);
        0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::borrow_part_v8(arg1, *arg3);
        0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::borrow_track_v8(arg1, *arg4);
        assert_color_pair(arg5, arg6);
        if (0x1::option::is_some<0x1::string::String>(arg5)) {
            0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::borrow_color_v8(arg1, *0x1::option::borrow<0x1::string::String>(arg5), *0x1::option::borrow<0x1::string::String>(arg6));
        };
    }

    fun assert_pack_write<T0>(arg0: &PackReleaseV8<T0>, arg1: &PackAdminCapV8, arg2: &0x2::tx_context::TxContext) {
        assert_pack_control<T0>(arg0, arg1, arg2);
        assert!(arg0.lifecycle != 4, 9);
    }

    fun assert_physical_caller<T0, T1, T2>(arg0: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerRootV8<T0>, arg1: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::ProductReleaseCatalogV8, arg2: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::PackageCallCapV8<0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::PhysicalRoleV8>, arg3: &PackRegistryV8) {
        0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::assert_physical_call_cap_v8(arg1, arg2);
        0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::assert_type_origins_v8<T1, T2>(0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::physical_binding_v8(0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::catalog_binding_v8(arg1)));
        0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::assert_active_capability_registry_v8<T0>(arg0);
        let v0 = 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::root_capability_registry_binding_v8<T0>(arg0);
        assert!(0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::capability_catalog_id_v8(v0) == 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::catalog_id_v8(arg1), 0);
        assert!(0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::capability_pack_registry_id_v8(v0) == 0x2::object::id<PackRegistryV8>(arg3), 0);
        assert!(arg3.version == 8, 0);
        0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::assert_root_identity_v8<T0>(arg0, arg3.root_id, arg3.root_version, &arg3.root_content_commitment);
        let v1 = 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::root_pack_admission_binding_v8<T0>(arg0);
        assert!(0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::pack_registry_id_v8(v1) == 0x2::object::id<PackRegistryV8>(arg3), 0);
        assert!(&arg3.admission_policy_commitment == 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::pack_admission_policy_commitment_v8(v1), 0);
    }

    fun assert_product_control(arg0: &ExternalItemProductV8, arg1: &ExternalItemAdminCapV8, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.version == 8 && arg1.version == 8, 0);
        assert!(0x2::object::id<ExternalItemProductV8>(arg0) == arg1.product_id, 29);
        assert!(arg0.admin_cap_id == 0x2::object::id<ExternalItemAdminCapV8>(arg1), 29);
        assert!(arg0.owner == 0x2::tx_context::sender(arg2) && arg1.owner == 0x2::tx_context::sender(arg2), 29);
        assert!(arg0.control_epoch == arg1.control_epoch, 29);
    }

    fun assert_profile_policy(arg0: u8, arg1: u8, arg2: u64, arg3: u8, arg4: bool) {
        assert!(arg0 == 0 || arg0 == 1, 10);
        assert!(arg1 <= 3, 10);
        assert!(arg2 == 1, 10);
        assert_admission_ceiling(arg3);
        if (arg0 == 0) {
            assert!(arg1 == 0, 10);
        } else {
            let v0 = if (arg1 == 1) {
                true
            } else if (arg1 == 2) {
                true
            } else {
                arg1 == 3
            };
            assert!(v0, 10);
        };
        if (arg4) {
            assert!(arg1 != 2, 10);
        };
    }

    fun assert_release_compatibility<T0>(arg0: &PackReleaseV8<T0>, arg1: &PackRegistryV8) {
        assert!(arg0.version == 8, 0);
        assert!(arg0.root_id == arg1.root_id, 0);
        assert!(arg0.root_version == arg1.root_version, 0);
        assert!(arg0.root_content_commitment == arg1.root_content_commitment, 0);
    }

    fun assert_root_active<T0>(arg0: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerRootV8<T0>) {
        assert!(0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::root_lifecycle_v8<T0>(arg0) == 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::lifecycle_active_v8(), 9);
    }

    fun assert_root_compatibility<T0>(arg0: 0x2::object::ID, arg1: u64, arg2: &vector<u8>, arg3: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerRootV8<T0>) {
        assert!(arg0 == 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::root_id_v8<T0>(arg3), 0);
        assert!(arg1 == 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::root_maker_version_v8<T0>(arg3), 0);
        assert!(arg2 == 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::root_content_commitment_v8<T0>(arg3), 0);
    }

    fun assert_slot_empty(arg0: &MakerLoadoutV8, arg1: u64) {
        assert!(arg1 < 0x1::vector::length<0x1::option::Option<LoadoutSelectionV8>>(&arg0.selections), 13);
        assert!(0x1::option::is_none<LoadoutSelectionV8>(0x1::vector::borrow<0x1::option::Option<LoadoutSelectionV8>>(&arg0.selections, arg1)), 11);
    }

    fun assert_treasury<T0>(arg0: &PackReleaseV8<T0>, arg1: &PackTreasuryV8<T0>) {
        assert!(arg1.version == 8, 0);
        assert!(arg1.release_id == 0x2::object::id<PackReleaseV8<T0>>(arg0), 0);
        assert!(arg0.treasury_id == 0x2::object::id<PackTreasuryV8<T0>>(arg1), 0);
    }

    fun assert_used_pack(arg0: &vector<UsedPackV8>, arg1: 0x2::object::ID, arg2: &0x1::string::String, arg3: &vector<u8>, arg4: &vector<u8>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<UsedPackV8>(arg0)) {
            let v1 = 0x1::vector::borrow<UsedPackV8>(arg0, v0);
            if (v1.release_id == arg1) {
                assert!(&v1.semantic_pack_id == arg2, 21);
                assert!(&v1.release_content_commitment == arg3, 21);
                assert!(&v1.pricing_commitment == arg4, 21);
                return
            };
            v0 = v0 + 1;
        };
        abort 21
    }

    public(friend) fun authorize_pack_complete_line_v8<T0>(arg0: &mut PackReleaseV8<T0>, arg1: &PackRegistryV8, arg2: &PackPassV8, arg3: &RuntimeLoadoutAuthorizationV8, arg4: &MakerLoadoutV8, arg5: &0x2::tx_context::TxContext) : PackCompleteLineV8 {
        assert_active_pack_admission<T0>(arg1, arg0);
        assert!(arg0.lifecycle == 2, 9);
        assert_pack_pass<T0>(arg0, arg2, 0x2::tx_context::sender(arg5));
        assert!(arg3.loadout_id == 0x2::object::id<MakerLoadoutV8>(arg4), 21);
        assert!(arg3.loadout_revision == arg4.revision, 21);
        assert!(arg3.loadout_commitment == arg4.commitment, 21);
        assert!(arg4.holder == 0x2::tx_context::sender(arg5), 8);
        let v0 = pack_pricing_commitment<T0>(arg0);
        assert_used_pack(&arg3.used_packs, 0x2::object::id<PackReleaseV8<T0>>(arg0), &arg0.semantic_pack_id, &arg0.content_commitment, &v0);
        let v1 = WalletKeyV8{wallet: 0x2::tx_context::sender(arg5)};
        let v2 = if (0x2::table::contains<WalletKeyV8, u64>(&arg0.complete_by_wallet, v1)) {
            *0x2::table::borrow<WalletKeyV8, u64>(&arg0.complete_by_wallet, v1)
        } else {
            0
        };
        if (arg0.complete_total_cap != 0) {
            assert!(arg0.total_complete_count < arg0.complete_total_cap, 24);
        };
        if (0x2::table::contains<WalletKeyV8, u64>(&arg0.complete_by_wallet, v1)) {
            *0x2::table::borrow_mut<WalletKeyV8, u64>(&mut arg0.complete_by_wallet, v1) = v2 + 1;
        } else {
            0x2::table::add<WalletKeyV8, u64>(&mut arg0.complete_by_wallet, v1, 1);
        };
        arg0.total_complete_count = arg0.total_complete_count + 1;
        PackCompleteLineV8{
            release_id                 : 0x2::object::id<PackReleaseV8<T0>>(arg0),
            root_id                    : arg0.root_id,
            root_version               : arg0.root_version,
            root_content_commitment    : arg0.root_content_commitment,
            release_content_commitment : arg0.content_commitment,
            holder                     : 0x2::tx_context::sender(arg5),
            ordinal                    : v2,
            price_atomic               : complete_price_for_ordinal(arg0.complete_mode, arg0.complete_price_atomic, arg0.complete_free_quota_per_wallet, v2),
        }
    }

    public fun base_item_gate_included_v8() : u8 {
        0
    }

    public fun base_seal_scope_key_v8() : 0x1::string::String {
        0x1::string::utf8(b"maker/base")
    }

    fun behavior_accepts_external(arg0: u8) : bool {
        arg0 == 2 || arg0 == 3
    }

    public fun behavior_fixed_v8() : u8 {
        0
    }

    public fun behavior_hybrid_v8() : u8 {
        3
    }

    public fun behavior_open_v8() : u8 {
        2
    }

    public fun behavior_soul_local_v8() : u8 {
        1
    }

    fun canonical_loadout_commitment(arg0: 0x2::object::ID, arg1: u64, arg2: vector<u8>, arg3: &vector<0x1::option::Option<LoadoutSelectionV8>>) : vector<u8> {
        let v0 = LoadoutCommitmentInputV8{
            domain                  : b"animacraft-v8/runtime/current-loadout",
            version                 : 8,
            root_id                 : arg0,
            root_version            : arg1,
            root_content_commitment : arg2,
            selections              : *arg3,
        };
        0x1::hash::sha2_256(0x1::bcs::to_bytes<LoadoutCommitmentInputV8>(&v0))
    }

    public fun certify_physical_selection_v8(arg0: SelectionAccessProofV8, arg1: &MakerLoadoutV8, arg2: &0x2::tx_context::TxContext) : RuntimePhysicalSelectionWitnessV8 {
        assert!(arg1.holder == 0x2::tx_context::sender(arg2), 8);
        let SelectionAccessProofV8 {
            loadout_id                : v0,
            loadout_revision          : v1,
            loadout_commitment        : v2,
            selection_index           : v3,
            selection_commitment      : v4,
            source_class              : v5,
            source_definition_id      : v6,
            source_semantic_id        : v7,
            source_content_commitment : v8,
            source_epoch              : v9,
            pricing_commitment        : v10,
        } = arg0;
        let v11 = v8;
        assert!(v0 == 0x2::object::id<MakerLoadoutV8>(arg1), 21);
        assert!(v1 == arg1.revision, 21);
        assert!(v2 == arg1.commitment, 21);
        let v12 = 0x1::option::borrow<LoadoutSelectionV8>(0x1::vector::borrow<0x1::option::Option<LoadoutSelectionV8>>(&arg1.selections, v3));
        assert!(v12.selection_index == v3, 21);
        assert!(v4 == selection_commitment_v8(*v12), 21);
        assert!(v5 == v12.source_class, 21);
        assert!(v6 == v12.source_definition_id, 21);
        assert!(v7 == v12.source_semantic_id, 21);
        assert!(v9 == v12.source_epoch, 21);
        assert!(v10 == v12.pricing_commitment, 21);
        assert_hash(&v11);
        RuntimePhysicalSelectionWitnessV8{
            loadout_id                : v0,
            root_id                   : arg1.root_id,
            root_version              : arg1.root_version,
            root_content_commitment   : arg1.root_content_commitment,
            holder                    : arg1.holder,
            loadout_revision          : v1,
            loadout_commitment        : v2,
            selection_index           : v3,
            selection_commitment      : v4,
            part_key                  : v12.part_key,
            item_key                  : v12.item_key,
            style_key                 : v12.style_key,
            layer_track_key           : v12.layer_track_key,
            source_class              : v5,
            source_definition_id      : v6,
            source_semantic_id        : v7,
            source_content_commitment : v11,
            source_epoch              : v9,
            pricing_commitment        : v10,
            asset_content_commitment  : v12.asset_content_commitment,
        }
    }

    public fun clear_non_external_selection_v8(arg0: &mut MakerLoadoutV8, arg1: u64, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert_loadout_holder_revision(arg0, arg2, arg3);
        assert!(0x1::option::borrow<LoadoutSelectionV8>(0x1::vector::borrow<0x1::option::Option<LoadoutSelectionV8>>(&arg0.selections, arg1)).source_class != 2, 18);
        clear_selection(arg0, arg1);
    }

    fun clear_selection(arg0: &mut MakerLoadoutV8, arg1: u64) {
        assert!(0x1::option::is_some<LoadoutSelectionV8>(0x1::vector::borrow<0x1::option::Option<LoadoutSelectionV8>>(&arg0.selections, arg1)), 12);
        0x1::option::extract<LoadoutSelectionV8>(0x1::vector::borrow_mut<0x1::option::Option<LoadoutSelectionV8>>(&mut arg0.selections, arg1));
        arg0.selection_count = arg0.selection_count - 1;
        arg0.revision = arg0.revision + 1;
        recompute_loadout(arg0);
    }

    fun complete_price_for_ordinal(arg0: u8, arg1: u64, arg2: u64, arg3: u64) : u64 {
        if (arg0 == 0) {
            0
        } else if (arg0 == 2) {
            arg1
        } else if (arg3 < arg2) {
            0
        } else {
            assert!(arg0 == 1, 24);
            arg1
        }
    }

    public(friend) fun consume_activation_readiness_v8(arg0: RuntimeActivationReadinessReceiptV8) : (0x2::object::ID, u64, vector<u8>, 0x2::object::ID, 0x2::object::ID, 0x2::object::ID, vector<u8>, vector<u8>) {
        let RuntimeActivationReadinessReceiptV8 {
            root_id                 : v0,
            root_version            : v1,
            root_content_commitment : v2,
            definition_registry_id  : v3,
            pack_registry_id        : v4,
            admission_authority_id  : v5,
            policy_commitment       : v6,
            companion_commitment    : v7,
        } = arg0;
        (v0, v1, v2, v3, v4, v5, v6, v7)
    }

    public(friend) fun consume_base_entitlement_witness(arg0: RuntimeBaseEntitlementWitnessV8) : (0x2::object::ID, u64, u64, address, 0x2::object::ID, vector<u8>, vector<u8>) {
        let RuntimeBaseEntitlementWitnessV8 {
            loadout_id               : v0,
            loadout_revision         : v1,
            selection_index          : v2,
            holder                   : v3,
            entitlement_id           : v4,
            entitlement_commitment   : v5,
            asset_content_commitment : v6,
        } = arg0;
        (v0, v1, v2, v3, v4, v5, v6)
    }

    public fun consume_free_pack_complete_line_v8<T0>(arg0: PackCompleteLineV8, arg1: &PackReleaseV8<T0>, arg2: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerRootV8<T0>, arg3: &0x2::tx_context::TxContext) : (0x2::object::ID, u64) {
        let (v0, v1, v2, v3, v4, v5, v6, v7) = consume_pack_complete_line_v8(arg0);
        let v8 = v3;
        assert!(v0 == 0x2::object::id<PackReleaseV8<T0>>(arg1), 0);
        assert!(v4 == arg1.content_commitment, 0);
        assert!(v5 == 0x2::tx_context::sender(arg3), 8);
        assert!(v7 == 0, 17);
        assert_root_compatibility<T0>(v1, v2, &v8, arg2);
        (v0, v6)
    }

    public fun consume_loadout_authorization_v8(arg0: RuntimeLoadoutAuthorizationV8, arg1: &MakerLoadoutV8) : (0x2::object::ID, 0x2::object::ID, u64, vector<u8>, u64, vector<u8>, u64, vector<vector<u8>>, vector<vector<u8>>, vector<UsedPackV8>) {
        let RuntimeLoadoutAuthorizationV8 {
            loadout_id                    : v0,
            root_id                       : v1,
            root_version                  : v2,
            root_content_commitment       : v3,
            loadout_revision              : v4,
            loadout_commitment            : v5,
            selection_count               : v6,
            ordered_selection_commitments : v7,
            ordered_pricing_commitments   : v8,
            used_packs                    : v9,
        } = arg0;
        assert!(v0 == 0x2::object::id<MakerLoadoutV8>(arg1), 21);
        assert!(v1 == arg1.root_id, 21);
        assert!(v2 == arg1.root_version, 21);
        assert!(v3 == arg1.root_content_commitment, 21);
        assert!(v4 == arg1.revision, 21);
        assert!(v5 == arg1.commitment, 21);
        assert!(v6 == arg1.selection_count, 21);
        (v0, v1, v2, v3, v4, v5, v6, v7, v8, v9)
    }

    public(friend) fun consume_pack_complete_line_v8(arg0: PackCompleteLineV8) : (0x2::object::ID, 0x2::object::ID, u64, vector<u8>, vector<u8>, address, u64, u64) {
        let PackCompleteLineV8 {
            release_id                 : v0,
            root_id                    : v1,
            root_version               : v2,
            root_content_commitment    : v3,
            release_content_commitment : v4,
            holder                     : v5,
            ordinal                    : v6,
            price_atomic               : v7,
        } = arg0;
        (v0, v1, v2, v3, v4, v5, v6, v7)
    }

    public(friend) fun consume_pack_entitlement_witness(arg0: RuntimePackEntitlementWitnessV8) : (0x2::object::ID, u64, u64, address, 0x2::object::ID, vector<u8>, 0x2::object::ID, vector<u8>, vector<u8>) {
        let RuntimePackEntitlementWitnessV8 {
            loadout_id               : v0,
            loadout_revision         : v1,
            selection_index          : v2,
            holder                   : v3,
            pack_release_id          : v4,
            pack_content_commitment  : v5,
            pack_pass_id             : v6,
            pack_pass_commitment     : v7,
            asset_content_commitment : v8,
        } = arg0;
        (v0, v1, v2, v3, v4, v5, v6, v7, v8)
    }

    public fun consume_physical_pack_access_witness_v8<T0, T1>(arg0: RuntimePhysicalPackAccessWitnessV8, arg1: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::ProductReleaseCatalogV8, arg2: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::PackageCallCapV8<0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::PhysicalRoleV8>) : (0x2::object::ID, u64, vector<u8>, address, 0x2::object::ID, u64, 0x2::object::ID, 0x1::string::String, vector<u8>, 0x2::object::ID, 0x2::object::ID, vector<u8>, 0x2::object::ID, u64, vector<u8>, u64, vector<u8>, vector<u8>, 0x1::string::String, 0x1::string::String, 0x1::string::String, 0x1::string::String, vector<u8>, vector<u8>) {
        0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::assert_physical_call_cap_v8(arg1, arg2);
        0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::assert_type_origins_v8<T0, T1>(0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::physical_binding_v8(0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::catalog_binding_v8(arg1)));
        let RuntimePhysicalPackAccessWitnessV8 {
            root_id                    : v0,
            root_version               : v1,
            root_content_commitment    : v2,
            holder                     : v3,
            pack_registry_id           : v4,
            pack_registry_revision     : v5,
            release_id                 : v6,
            semantic_pack_id           : v7,
            release_content_commitment : v8,
            pack_treasury_id           : v9,
            pack_pass_id               : v10,
            pack_pass_commitment       : v11,
            loadout_id                 : v12,
            loadout_revision           : v13,
            loadout_commitment         : v14,
            selection_index            : v15,
            selection_commitment       : v16,
            pricing_commitment         : v17,
            part_key                   : v18,
            item_key                   : v19,
            style_key                  : v20,
            layer_track_key            : v21,
            asset_content_commitment   : v22,
            style_identity_commitment  : v23,
        } = arg0;
        (v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23)
    }

    public fun consume_physical_pack_policy_witness_v8<T0, T1>(arg0: RuntimePhysicalPackPolicyWitnessV8, arg1: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::ProductReleaseCatalogV8, arg2: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::PackageCallCapV8<0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::PhysicalRoleV8>) : (0x2::object::ID, u64, vector<u8>, 0x2::object::ID, u64, 0x2::object::ID, 0x1::string::String, vector<u8>, address, u64, 0x2::object::ID, 0x2::object::ID, u64, 0x1::string::String, 0x1::string::String, 0x1::string::String, 0x1::string::String, 0x1::option::Option<0x1::string::String>, 0x1::option::Option<0x1::string::String>, 0x1::string::String, vector<u8>, vector<u8>, bool, vector<u8>, vector<u8>, vector<u8>) {
        0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::assert_physical_call_cap_v8(arg1, arg2);
        0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::assert_type_origins_v8<T0, T1>(0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::physical_binding_v8(0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::catalog_binding_v8(arg1)));
        let RuntimePhysicalPackPolicyWitnessV8 {
            root_id                    : v0,
            root_version               : v1,
            root_content_commitment    : v2,
            pack_registry_id           : v3,
            pack_registry_revision     : v4,
            release_id                 : v5,
            semantic_pack_id           : v6,
            release_content_commitment : v7,
            pack_owner                 : v8,
            pack_control_epoch         : v9,
            pack_admin_cap_id          : v10,
            pack_treasury_id           : v11,
            style_index                : v12,
            part_key                   : v13,
            item_key                   : v14,
            style_key                  : v15,
            layer_track_key            : v16,
            color_channel_key          : v17,
            default_swatch_key         : v18,
            asset_blob_id              : v19,
            asset_sha256               : v20,
            asset_content_commitment   : v21,
            protected                  : v22,
            seal_binding_commitment    : v23,
            style_commitment           : v24,
            style_identity_commitment  : v25,
        } = arg0;
        (v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23, v24, v25)
    }

    public fun consume_physical_selection_witness_v8(arg0: RuntimePhysicalSelectionWitnessV8, arg1: &MakerLoadoutV8, arg2: &0x2::tx_context::TxContext) : (0x2::object::ID, 0x2::object::ID, u64, vector<u8>, address, u64, vector<u8>, u64, vector<u8>, 0x1::string::String, 0x1::string::String, 0x1::string::String, 0x1::string::String, u8, 0x2::object::ID, 0x1::string::String, vector<u8>, u64, vector<u8>, vector<u8>) {
        let RuntimePhysicalSelectionWitnessV8 {
            loadout_id                : v0,
            root_id                   : v1,
            root_version              : v2,
            root_content_commitment   : v3,
            holder                    : v4,
            loadout_revision          : v5,
            loadout_commitment        : v6,
            selection_index           : v7,
            selection_commitment      : v8,
            part_key                  : v9,
            item_key                  : v10,
            style_key                 : v11,
            layer_track_key           : v12,
            source_class              : v13,
            source_definition_id      : v14,
            source_semantic_id        : v15,
            source_content_commitment : v16,
            source_epoch              : v17,
            pricing_commitment        : v18,
            asset_content_commitment  : v19,
        } = arg0;
        assert!(v4 == 0x2::tx_context::sender(arg2) && v4 == arg1.holder, 8);
        assert!(v0 == 0x2::object::id<MakerLoadoutV8>(arg1), 21);
        assert!(v1 == arg1.root_id, 21);
        assert!(v2 == arg1.root_version, 21);
        assert!(v3 == arg1.root_content_commitment, 21);
        assert!(v5 == arg1.revision, 21);
        assert!(v6 == arg1.commitment, 21);
        let v20 = 0x1::option::borrow<LoadoutSelectionV8>(0x1::vector::borrow<0x1::option::Option<LoadoutSelectionV8>>(&arg1.selections, v7));
        assert!(v20.selection_index == v7, 21);
        assert!(v8 == selection_commitment_v8(*v20), 21);
        assert!(v9 == v20.part_key, 21);
        assert!(v10 == v20.item_key, 21);
        assert!(v11 == v20.style_key, 21);
        assert!(v12 == v20.layer_track_key, 21);
        assert!(v13 == v20.source_class, 21);
        assert!(v14 == v20.source_definition_id, 21);
        assert!(v15 == v20.source_semantic_id, 21);
        assert!(v17 == v20.source_epoch, 21);
        assert!(v18 == v20.pricing_commitment, 21);
        assert!(v19 == v20.asset_content_commitment, 21);
        (v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19)
    }

    public fun create_maker_loadout_v8<T0>(arg0: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerRootV8<T0>, arg1: &RuntimeDefinitionRegistryV8, arg2: &PackRegistryV8, arg3: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::treasury_v8::MakerAccessPassV8, arg4: &mut 0x2::tx_context::TxContext) : MakerLoadoutV8 {
        assert_root_active<T0>(arg0);
        assert_definition_identity<T0>(arg1, arg0);
        assert!(arg1.sealed, 6);
        assert_pack_registry_identity<T0>(arg2, arg1, arg0);
        0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::treasury_v8::assert_maker_access_pass_v8<T0>(arg0, arg3, 0x2::tx_context::sender(arg4));
        let v0 = 0x1::vector::empty<0x1::option::Option<LoadoutSelectionV8>>();
        let v1 = 0;
        while (v1 < arg1.expected_profile_count) {
            0x1::vector::push_back<0x1::option::Option<LoadoutSelectionV8>>(&mut v0, 0x1::option::none<LoadoutSelectionV8>());
            v1 = v1 + 1;
        };
        MakerLoadoutV8{
            id                      : 0x2::object::new(arg4),
            version                 : 8,
            root_id                 : arg1.root_id,
            root_version            : arg1.root_version,
            root_content_commitment : arg1.root_content_commitment,
            definition_registry_id  : 0x2::object::id<RuntimeDefinitionRegistryV8>(arg1),
            pack_registry_id        : 0x2::object::id<PackRegistryV8>(arg2),
            maker_access_pass_id    : 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::treasury_v8::maker_access_pass_id_v8(arg3),
            maker_access_commitment : maker_access_entitlement_commitment_v8(arg3),
            holder                  : 0x2::tx_context::sender(arg4),
            revision                : 0,
            selections              : v0,
            selection_count         : 0,
            commitment              : canonical_loadout_commitment(arg1.root_id, arg1.root_version, arg1.root_content_commitment, &v0),
        }
    }

    public fun definition_profile_count_v8(arg0: &RuntimeDefinitionRegistryV8) : u64 {
        arg0.observed_profile_count
    }

    public fun definition_registry_commitment_v8(arg0: &RuntimeDefinitionRegistryV8) : &vector<u8> {
        &arg0.rolling_profile_commitment
    }

    public fun definition_registry_id_v8(arg0: &RuntimeDefinitionRegistryV8) : 0x2::object::ID {
        0x2::object::id<RuntimeDefinitionRegistryV8>(arg0)
    }

    public fun definition_registry_sealed_v8(arg0: &RuntimeDefinitionRegistryV8) : bool {
        arg0.sealed
    }

    public fun deposit_pack_revenue_v8<T0>(arg0: &PackReleaseV8<T0>, arg1: &mut PackTreasuryV8<T0>, arg2: 0x2::coin::Coin<T0>) {
        assert_treasury<T0>(arg0, arg1);
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 > 0, 17);
        arg1.total_collected = arg1.total_collected + v0;
        0x2::coin::put<T0>(&mut arg1.revenue, arg2);
    }

    public fun empty_pack_style_commitment_v8(arg0: vector<u8>, arg1: vector<u8>) : vector<u8> {
        assert_hash(&arg0);
        assert_hash(&arg1);
        let v0 = PackEmptyCommitmentInputV8{
            domain                     : b"animacraft-v8/runtime/pack-styles-empty",
            version                    : 8,
            root_content_commitment    : arg0,
            release_content_commitment : arg1,
        };
        0x1::hash::sha2_256(0x1::bcs::to_bytes<PackEmptyCommitmentInputV8>(&v0))
    }

    public fun empty_profile_commitment_v8(arg0: vector<u8>) : vector<u8> {
        assert_hash(&arg0);
        let v0 = EmptyCommitmentInputV8{
            domain                  : b"animacraft-v8/runtime/part-profiles-empty",
            version                 : 8,
            root_content_commitment : arg0,
        };
        0x1::hash::sha2_256(0x1::bcs::to_bytes<EmptyCommitmentInputV8>(&v0))
    }

    public fun equip_external_style_v8<T0>(arg0: &mut MakerLoadoutV8, arg1: &mut OwnedExternalItemV8, arg2: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerRootV8<T0>, arg3: &RuntimeDefinitionRegistryV8, arg4: &PackRegistryV8, arg5: &ExternalItemProductV8, arg6: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::treasury_v8::MakerAccessPassV8, arg7: u64, arg8: &0x2::tx_context::TxContext) {
        assert_loadout_write<T0>(arg0, arg2, arg3, arg4, arg7, arg8);
        assert_loadout_maker_access<T0>(arg0, arg2, arg6, arg8);
        assert_external_access(arg4, arg5, arg1, 0x2::tx_context::sender(arg8));
        let v0 = PartProfileKeyV8{part_key: arg5.part_key};
        let v1 = 0x2::table::borrow<PartProfileKeyV8, PartProfileV8>(&arg3.profiles, v0);
        assert!(v1.wardrobe_mode == 1, 14);
        assert_external_profile_behavior(v1);
        assert_slot_empty(arg0, v1.index);
        assert!(0x1::option::is_none<EquipLockV8>(&arg1.equip_lock), 18);
        let v2 = arg0.revision + 1;
        let v3 = LoadoutSelectionV8{
            selection_index          : v1.index,
            part_key                 : arg5.part_key,
            item_key                 : arg5.item_key,
            style_key                : arg5.style_key,
            color_channel_key        : arg5.color_channel_key,
            swatch_key               : arg5.default_swatch_key,
            layer_track_key          : arg5.layer_track_key,
            asset_blob_id            : arg5.asset_blob_id,
            asset_sha256             : arg5.asset_sha256,
            asset_content_commitment : arg5.asset_content_commitment,
            source_class             : 2,
            source_definition_id     : 0x2::object::id<ExternalItemProductV8>(arg5),
            source_semantic_id       : 0x1::string::utf8(b""),
            access_subject           : 0x2::object::id<OwnedExternalItemV8>(arg1),
            source_epoch             : arg1.ownership_epoch,
            pricing_commitment       : 0x1::hash::sha2_256(b"animacraft-v8/runtime/external-pricing"),
            protected                : false,
            seal_binding_commitment  : b"",
        };
        install_selection(arg0, v1.index, v3);
        let v4 = EquipLockV8{
            loadout_id      : 0x2::object::id<MakerLoadoutV8>(arg0),
            equip_revision  : v2,
            selection_index : v1.index,
        };
        arg1.equip_lock = 0x1::option::some<EquipLockV8>(v4);
        let v5 = ExternalItemEquipChangedV8{
            item_id    : 0x2::object::id<OwnedExternalItemV8>(arg1),
            loadout_id : 0x2::object::id<MakerLoadoutV8>(arg0),
            revision   : v2,
            equipped   : true,
        };
        0x2::event::emit<ExternalItemEquipChangedV8>(v5);
    }

    fun exact_pack_swatch(arg0: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::BaseDefinitionRegistryV8, arg1: &PackStyleV8, arg2: 0x1::option::Option<0x1::string::String>) : 0x1::option::Option<0x1::string::String> {
        assert!(0x1::option::is_some<0x1::string::String>(&arg1.color_channel_key) == 0x1::option::is_some<0x1::string::String>(&arg2), 0);
        if (0x1::option::is_some<0x1::string::String>(&arg2)) {
            0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::borrow_color_v8(arg0, *0x1::option::borrow<0x1::string::String>(&arg1.color_channel_key), *0x1::option::borrow<0x1::string::String>(&arg2));
        };
        arg2
    }

    fun exact_selected_swatch(arg0: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::BaseDefinitionRegistryV8, arg1: &0x1::option::Option<0x1::string::String>, arg2: 0x1::option::Option<0x1::string::String>) : 0x1::option::Option<0x1::string::String> {
        assert!(0x1::option::is_some<0x1::string::String>(arg1) == 0x1::option::is_some<0x1::string::String>(&arg2), 0);
        if (0x1::option::is_some<0x1::string::String>(arg1)) {
            0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::borrow_color_v8(arg0, *0x1::option::borrow<0x1::string::String>(arg1), *0x1::option::borrow<0x1::string::String>(&arg2));
        };
        arg2
    }

    fun install_selection(arg0: &mut MakerLoadoutV8, arg1: u64, arg2: LoadoutSelectionV8) {
        assert!(arg2.selection_index == arg1, 13);
        assert_slot_empty(arg0, arg1);
        *0x1::vector::borrow_mut<0x1::option::Option<LoadoutSelectionV8>>(&mut arg0.selections, arg1) = 0x1::option::some<LoadoutSelectionV8>(arg2);
        arg0.selection_count = arg0.selection_count + 1;
        arg0.revision = arg0.revision + 1;
        recompute_loadout(arg0);
    }

    public fun issue_free_pack_pass_v8<T0>(arg0: &mut PackReleaseV8<T0>, arg1: &PackRegistryV8, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : PackPassV8 {
        assert_active_pack_admission<T0>(arg1, arg0);
        assert!(arg0.lifecycle == 2, 9);
        assert!(arg0.access_kind == 0, 10);
        new_pack_pass<T0>(arg0, 0, 0x2::clock::timestamp_ms(arg2), arg3)
    }

    public fun issue_included_pack_pass_v8<T0>(arg0: &mut PackReleaseV8<T0>, arg1: &PackRegistryV8, arg2: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerRootV8<T0>, arg3: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::treasury_v8::MakerAccessPassV8, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : PackPassV8 {
        assert_active_pack_admission<T0>(arg1, arg0);
        assert!(arg0.lifecycle == 2, 9);
        assert!(arg0.access_kind == 2, 10);
        assert_root_compatibility<T0>(arg0.root_id, arg0.root_version, &arg0.root_content_commitment, arg2);
        0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::treasury_v8::assert_maker_access_pass_v8<T0>(arg2, arg3, 0x2::tx_context::sender(arg5));
        new_pack_pass<T0>(arg0, 0, 0x2::clock::timestamp_ms(arg4), arg5)
    }

    public fun loadout_commitment_v8(arg0: &MakerLoadoutV8) : &vector<u8> {
        &arg0.commitment
    }

    public fun loadout_id_v8(arg0: &MakerLoadoutV8) : 0x2::object::ID {
        0x2::object::id<MakerLoadoutV8>(arg0)
    }

    public fun loadout_revision_v8(arg0: &MakerLoadoutV8) : u64 {
        arg0.revision
    }

    public fun loadout_selection_count_v8(arg0: &MakerLoadoutV8) : u64 {
        arg0.selection_count
    }

    public fun loadout_selection_v8(arg0: &MakerLoadoutV8, arg1: u64) : &0x1::option::Option<LoadoutSelectionV8> {
        0x1::vector::borrow<0x1::option::Option<LoadoutSelectionV8>>(&arg0.selections, arg1)
    }

    public fun maker_access_entitlement_commitment_v8(arg0: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::treasury_v8::MakerAccessPassV8) : vector<u8> {
        let v0 = MakerAccessEntitlementCommitmentInputV8{
            domain                  : b"animacraft-v8/runtime/maker-access-entitlement",
            version                 : 8,
            pass_id                 : 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::treasury_v8::maker_access_pass_id_v8(arg0),
            root_id                 : 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::treasury_v8::maker_access_pass_root_id_v8(arg0),
            maker_version           : 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::treasury_v8::maker_access_pass_maker_version_v8(arg0),
            root_content_commitment : *0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::treasury_v8::maker_access_pass_root_content_commitment_v8(arg0),
            holder                  : 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::treasury_v8::maker_access_pass_holder_v8(arg0),
            paid_atomic             : 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::treasury_v8::maker_access_pass_paid_atomic_v8(arg0),
            issued_at_ms            : 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::treasury_v8::maker_access_pass_issued_at_ms_v8(arg0),
        };
        0x1::hash::sha2_256(0x1::bcs::to_bytes<MakerAccessEntitlementCommitmentInputV8>(&v0))
    }

    public fun mint_owned_external_item_v8(arg0: &mut ExternalItemProductV8, arg1: &ExternalItemAdminCapV8, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : OwnedExternalItemV8 {
        assert_product_control(arg0, arg1, arg3);
        assert!(arg0.lifecycle == 0, 9);
        assert!(arg2 != @0x0, 26);
        arg0.supply = arg0.supply + 1;
        OwnedExternalItemV8{
            id                         : 0x2::object::new(arg3),
            version                    : 8,
            product_id                 : 0x2::object::id<ExternalItemProductV8>(arg0),
            product_content_commitment : arg0.content_commitment,
            asset_content_commitment   : arg0.asset_content_commitment,
            holder                     : arg2,
            ownership_epoch            : 0,
            transferable               : arg0.transferable,
            equip_lock                 : 0x1::option::none<EquipLockV8>(),
        }
    }

    public(friend) fun new_base_entitlement_witness_v8<T0>(arg0: &MakerLoadoutV8, arg1: &RuntimeDefinitionRegistryV8, arg2: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::BaseDefinitionRegistryV8, arg3: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerRootV8<T0>, arg4: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::treasury_v8::MakerAccessPassV8, arg5: u64, arg6: vector<u8>, arg7: &0x2::tx_context::TxContext) : RuntimeBaseEntitlementWitnessV8 {
        0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::treasury_v8::assert_maker_access_pass_v8<T0>(arg3, arg4, 0x2::tx_context::sender(arg7));
        assert!(arg0.maker_access_pass_id == 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::treasury_v8::maker_access_pass_id_v8(arg4), 21);
        assert!(arg0.maker_access_commitment == maker_access_entitlement_commitment_v8(arg4), 21);
        assert!(arg0.holder == 0x2::tx_context::sender(arg7), 8);
        assert!(arg0.definition_registry_id == 0x2::object::id<RuntimeDefinitionRegistryV8>(arg1), 0);
        assert!(arg1.base_registry_id == 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::registry_id_v8(arg2), 0);
        assert_root_compatibility<T0>(arg0.root_id, arg0.root_version, &arg0.root_content_commitment, arg3);
        let v0 = 0x1::option::borrow<LoadoutSelectionV8>(0x1::vector::borrow<0x1::option::Option<LoadoutSelectionV8>>(&arg0.selections, arg5));
        assert!(v0.source_class == 0 && v0.protected, 21);
        assert!(v0.access_subject == arg0.maker_access_pass_id, 21);
        assert!(v0.pricing_commitment == arg0.maker_access_commitment, 21);
        assert!(v0.seal_binding_commitment == arg6, 21);
        assert!(0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::item_gate_kind_v8(0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::borrow_item_v8(arg2, v0.part_key, v0.item_key)) == 0, 10);
        let v1 = 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::borrow_style_v8(arg2, v0.part_key, v0.item_key, v0.style_key);
        assert!(0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::style_protected_v8(v1), 21);
        assert!(0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::style_payload_commitment_v8(v1) == &v0.asset_content_commitment, 21);
        RuntimeBaseEntitlementWitnessV8{
            loadout_id               : 0x2::object::id<MakerLoadoutV8>(arg0),
            loadout_revision         : arg0.revision,
            selection_index          : arg5,
            holder                   : 0x2::tx_context::sender(arg7),
            entitlement_id           : 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::treasury_v8::maker_access_pass_id_v8(arg4),
            entitlement_commitment   : maker_access_entitlement_commitment_v8(arg4),
            asset_content_commitment : v0.asset_content_commitment,
        }
    }

    public(friend) fun new_external_item_attestation_v8(arg0: 0x2::object::ID, arg1: &ExternalItemProductV8) : ExternalItemAttestationV8 {
        let v0 = AttestationCommitmentInputV8{
            domain                     : b"animacraft-v8/runtime/external-attestation",
            version                    : 8,
            catalog_id                 : arg0,
            product_id                 : 0x2::object::id<ExternalItemProductV8>(arg1),
            root_id                    : arg1.root_id,
            root_version               : arg1.root_version,
            root_content_commitment    : arg1.root_content_commitment,
            compatibility_commitment   : arg1.compatibility_commitment,
            product_content_commitment : arg1.content_commitment,
        };
        ExternalItemAttestationV8{
            catalog_id                 : arg0,
            product_id                 : 0x2::object::id<ExternalItemProductV8>(arg1),
            root_id                    : arg1.root_id,
            root_version               : arg1.root_version,
            root_content_commitment    : arg1.root_content_commitment,
            compatibility_commitment   : arg1.compatibility_commitment,
            product_content_commitment : arg1.content_commitment,
            attestation_commitment     : 0x1::hash::sha2_256(0x1::bcs::to_bytes<AttestationCommitmentInputV8>(&v0)),
        }
    }

    public fun new_external_item_product_v8<T0>(arg0: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerRootV8<T0>, arg1: &RuntimeDefinitionRegistryV8, arg2: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::BaseDefinitionRegistryV8, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::option::Option<0x1::string::String>, arg8: 0x1::option::Option<0x1::string::String>, arg9: 0x1::string::String, arg10: vector<u8>, arg11: vector<u8>, arg12: bool, arg13: &mut 0x2::tx_context::TxContext) : (ExternalItemProductV8, ExternalItemAdminCapV8) {
        assert_root_active<T0>(arg0);
        assert_definition_binding<T0>(arg1, arg0, arg2);
        assert!(arg1.sealed, 6);
        let v0 = PartProfileKeyV8{part_key: arg3};
        let v1 = 0x2::table::borrow<PartProfileKeyV8, PartProfileV8>(&arg1.profiles, v0);
        assert!(v1.wardrobe_mode == 1, 14);
        assert_external_profile_behavior(v1);
        assert!(v1.admission_ceiling != 0, 15);
        assert_key(&arg4);
        assert_key(&arg5);
        assert_key(&arg6);
        0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::borrow_track_v8(arg2, arg6);
        assert_color_pair(&arg7, &arg8);
        if (0x1::option::is_some<0x1::string::String>(&arg7)) {
            0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::borrow_color_v8(arg2, *0x1::option::borrow<0x1::string::String>(&arg7), *0x1::option::borrow<0x1::string::String>(&arg8));
        };
        assert_locator(&arg9);
        assert_hash(&arg10);
        assert_hash(&arg11);
        let v2 = ExternalProductCommitmentInputV8{
            domain                   : b"animacraft-v8/runtime/external-compatibility",
            version                  : 8,
            root_id                  : arg1.root_id,
            root_version             : arg1.root_version,
            root_content_commitment  : arg1.root_content_commitment,
            profile_commitment       : v1.profile_commitment,
            part_key                 : arg3,
            item_key                 : arg4,
            style_key                : arg5,
            layer_track_key          : arg6,
            color_channel_key        : arg7,
            default_swatch_key       : arg8,
            asset_blob_id            : arg9,
            asset_sha256             : arg10,
            asset_content_commitment : arg11,
            transferable             : arg12,
        };
        let v3 = 0x1::hash::sha2_256(0x1::bcs::to_bytes<ExternalProductCommitmentInputV8>(&v2));
        let v4 = ExternalContentCommitmentInputV8{
            domain                   : b"animacraft-v8/runtime/external-product",
            version                  : 8,
            compatibility_commitment : v3,
            asset_content_commitment : arg11,
        };
        let v5 = 0x2::object::new(arg13);
        let v6 = 0x2::object::new(arg13);
        let v7 = ExternalItemProductV8{
            id                       : v5,
            version                  : 8,
            root_id                  : arg1.root_id,
            root_version             : arg1.root_version,
            root_content_commitment  : arg1.root_content_commitment,
            creator                  : 0x2::tx_context::sender(arg13),
            owner                    : 0x2::tx_context::sender(arg13),
            control_epoch            : 0,
            admin_cap_id             : 0x2::object::uid_to_inner(&v6),
            lifecycle                : 0,
            part_key                 : arg3,
            item_key                 : arg4,
            style_key                : arg5,
            layer_track_key          : arg6,
            color_channel_key        : arg7,
            default_swatch_key       : arg8,
            asset_blob_id            : arg9,
            asset_sha256             : arg10,
            asset_content_commitment : arg11,
            compatibility_commitment : v3,
            content_commitment       : 0x1::hash::sha2_256(0x1::bcs::to_bytes<ExternalContentCommitmentInputV8>(&v4)),
            transferable             : arg12,
            supply                   : 0,
        };
        let v8 = ExternalItemAdminCapV8{
            id            : v6,
            version       : 8,
            product_id    : 0x2::object::uid_to_inner(&v5),
            owner         : 0x2::tx_context::sender(arg13),
            control_epoch : 0,
        };
        (v7, v8)
    }

    public(friend) fun new_pack_entitlement_witness_v8<T0>(arg0: &MakerLoadoutV8, arg1: &PackRegistryV8, arg2: &PackReleaseV8<T0>, arg3: &PackPassV8, arg4: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerRootV8<T0>, arg5: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::treasury_v8::MakerAccessPassV8, arg6: u64, arg7: vector<u8>, arg8: &0x2::tx_context::TxContext) : RuntimePackEntitlementWitnessV8 {
        assert!(arg0.holder == 0x2::tx_context::sender(arg8), 8);
        assert_loadout_maker_access<T0>(arg0, arg4, arg5, arg8);
        assert!(0x2::object::id<PackRegistryV8>(arg1) == arg0.pack_registry_id, 0);
        assert_active_pack_admission<T0>(arg1, arg2);
        assert!(arg2.lifecycle == 2, 9);
        assert_pack_pass<T0>(arg2, arg3, 0x2::tx_context::sender(arg8));
        let v0 = 0x1::option::borrow<LoadoutSelectionV8>(0x1::vector::borrow<0x1::option::Option<LoadoutSelectionV8>>(&arg0.selections, arg6));
        assert!(v0.source_class == 1, 21);
        assert!(v0.source_definition_id == 0x2::object::id<PackReleaseV8<T0>>(arg2), 21);
        assert!(&v0.source_semantic_id == &arg2.semantic_pack_id, 21);
        assert!(v0.access_subject == 0x2::object::id<PackPassV8>(arg3), 21);
        assert!(v0.protected, 21);
        assert!(v0.source_epoch == 0, 21);
        assert!(v0.pricing_commitment == pack_pricing_commitment<T0>(arg2), 21);
        assert!(v0.seal_binding_commitment == arg7, 21);
        let v1 = PackStyleKeyV8{
            part_key  : v0.part_key,
            item_key  : v0.item_key,
            style_key : v0.style_key,
        };
        let v2 = 0x2::table::borrow<PackStyleKeyV8, PackStyleV8>(&arg2.styles, v1);
        assert!(v2.protected, 21);
        assert!(v2.seal_binding_commitment == arg7, 21);
        assert!(v2.asset_content_commitment == v0.asset_content_commitment, 21);
        RuntimePackEntitlementWitnessV8{
            loadout_id               : 0x2::object::id<MakerLoadoutV8>(arg0),
            loadout_revision         : arg0.revision,
            selection_index          : arg6,
            holder                   : 0x2::tx_context::sender(arg8),
            pack_release_id          : 0x2::object::id<PackReleaseV8<T0>>(arg2),
            pack_content_commitment  : arg2.content_commitment,
            pack_pass_id             : 0x2::object::id<PackPassV8>(arg3),
            pack_pass_commitment     : arg3.commitment,
            asset_content_commitment : v0.asset_content_commitment,
        }
    }

    fun new_pack_pass<T0>(arg0: &mut PackReleaseV8<T0>, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : PackPassV8 {
        arg0.pass_count = arg0.pass_count + 1;
        let v0 = PackPassCommitmentInputV8{
            domain                     : b"animacraft-v8/runtime/pack-pass",
            version                    : 8,
            release_id                 : 0x2::object::id<PackReleaseV8<T0>>(arg0),
            root_id                    : arg0.root_id,
            root_version               : arg0.root_version,
            root_content_commitment    : arg0.root_content_commitment,
            release_content_commitment : arg0.content_commitment,
            holder                     : 0x2::tx_context::sender(arg3),
            paid_atomic                : arg1,
            issued_at_ms               : arg2,
        };
        PackPassV8{
            id                         : 0x2::object::new(arg3),
            version                    : 8,
            release_id                 : 0x2::object::id<PackReleaseV8<T0>>(arg0),
            root_id                    : arg0.root_id,
            root_version               : arg0.root_version,
            root_content_commitment    : arg0.root_content_commitment,
            release_content_commitment : arg0.content_commitment,
            holder                     : 0x2::tx_context::sender(arg3),
            paid_atomic                : arg1,
            issued_at_ms               : arg2,
            commitment                 : 0x1::hash::sha2_256(0x1::bcs::to_bytes<PackPassCommitmentInputV8>(&v0)),
        }
    }

    public(friend) fun new_pack_registration_witness_v8<T0>(arg0: &PackReleaseV8<T0>, arg1: &PackAdminCapV8, arg2: &RuntimeDefinitionRegistryV8, arg3: u64, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: vector<u8>, arg8: &0x2::tx_context::TxContext) : RuntimePackRegistrationWitnessV8 {
        assert_pack_write<T0>(arg0, arg1, arg8);
        assert!(arg0.lifecycle == 0, 9);
        assert!(arg3 == arg0.observed_style_count, 4);
        assert!(arg3 < arg0.expected_style_count, 3);
        assert!(arg2.root_id == arg0.root_id, 0);
        assert!(arg2.root_version == arg0.root_version, 0);
        assert!(arg2.root_content_commitment == arg0.root_content_commitment, 0);
        assert!(arg2.sealed, 6);
        let v0 = PartProfileKeyV8{part_key: arg4};
        assert!(0x2::table::contains<PartProfileKeyV8, PartProfileV8>(&arg2.profiles, v0), 12);
        assert_key(&arg5);
        assert_key(&arg6);
        assert_hash(&arg7);
        RuntimePackRegistrationWitnessV8{
            release_id                 : 0x2::object::id<PackReleaseV8<T0>>(arg0),
            release_content_commitment : arg0.content_commitment,
            sequence                   : arg3,
            part_key                   : arg4,
            item_key                   : arg5,
            style_key                  : arg6,
            asset_content_commitment   : arg7,
        }
    }

    public fun new_pack_release_v8<T0>(arg0: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerRootV8<T0>, arg1: &RuntimeDefinitionRegistryV8, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: vector<u8>, arg5: vector<u8>, arg6: u8, arg7: u64, arg8: u8, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: vector<u8>, arg14: &mut 0x2::tx_context::TxContext) : (PackReleaseV8<T0>, PackAdminCapV8, PackTreasuryV8<T0>) {
        assert_root_active<T0>(arg0);
        assert_definition_identity<T0>(arg1, arg0);
        assert!(arg1.sealed, 6);
        assert_key(&arg2);
        assert_locator(&arg3);
        assert_hash(&arg4);
        assert_hash(&arg5);
        assert_access_policy(arg6, arg7);
        assert_complete_policy(arg8, arg9, arg10, arg11);
        assert!(arg12 > 0 && arg12 <= 10000, 3);
        assert_hash(&arg13);
        let v0 = 0x2::object::new(arg14);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = 0x2::object::new(arg14);
        let v3 = 0x2::object::new(arg14);
        let v4 = *0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::root_content_commitment_v8<T0>(arg0);
        let v5 = PackReleaseV8<T0>{
            id                             : v0,
            version                        : 8,
            root_id                        : 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::root_id_v8<T0>(arg0),
            root_version                   : 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::root_maker_version_v8<T0>(arg0),
            root_content_commitment        : v4,
            creator                        : 0x2::tx_context::sender(arg14),
            owner                          : 0x2::tx_context::sender(arg14),
            control_epoch                  : 0,
            admin_cap_id                   : 0x2::object::uid_to_inner(&v2),
            treasury_id                    : 0x2::object::uid_to_inner(&v3),
            semantic_pack_id               : arg2,
            manifest_blob_id               : arg3,
            manifest_sha256                : arg4,
            content_commitment             : arg5,
            lifecycle                      : 0,
            access_kind                    : arg6,
            access_price_atomic            : arg7,
            complete_mode                  : arg8,
            complete_price_atomic          : arg9,
            complete_free_quota_per_wallet : arg10,
            complete_total_cap             : arg11,
            expected_style_count           : arg12,
            observed_style_count           : 0,
            expected_style_commitment      : arg13,
            rolling_style_commitment       : empty_pack_style_commitment_v8(v4, arg5),
            protected_style_count          : 0,
            pass_count                     : 0,
            total_complete_count           : 0,
            styles                         : 0x2::table::new<PackStyleKeyV8, PackStyleV8>(arg14),
            complete_by_wallet             : 0x2::table::new<WalletKeyV8, u64>(arg14),
        };
        let v6 = PackAdminCapV8{
            id            : v2,
            version       : 8,
            release_id    : v1,
            owner         : 0x2::tx_context::sender(arg14),
            control_epoch : 0,
        };
        let v7 = PackTreasuryV8<T0>{
            id              : v3,
            version         : 8,
            release_id      : v1,
            revenue         : 0x2::balance::zero<T0>(),
            total_collected : 0,
            total_withdrawn : 0,
        };
        (v5, v6, v7)
    }

    public fun new_physical_pack_access_witness_v8<T0, T1, T2>(arg0: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerRootV8<T0>, arg1: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::ProductReleaseCatalogV8, arg2: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::PackageCallCapV8<0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::PhysicalRoleV8>, arg3: &PackRegistryV8, arg4: &PackReleaseV8<T0>, arg5: &PackTreasuryV8<T0>, arg6: &PackPassV8, arg7: &MakerLoadoutV8, arg8: u64, arg9: &0x2::tx_context::TxContext) : RuntimePhysicalPackAccessWitnessV8 {
        assert_physical_caller<T0, T1, T2>(arg0, arg1, arg2, arg3);
        assert_active_pack_admission<T0>(arg3, arg4);
        assert!(arg4.lifecycle == 2, 9);
        assert_treasury<T0>(arg4, arg5);
        assert_pack_pass<T0>(arg4, arg6, 0x2::tx_context::sender(arg9));
        assert!(arg7.version == 8, 0);
        assert!(arg7.holder == 0x2::tx_context::sender(arg9), 8);
        assert_root_compatibility<T0>(arg7.root_id, arg7.root_version, &arg7.root_content_commitment, arg0);
        assert!(arg7.pack_registry_id == 0x2::object::id<PackRegistryV8>(arg3), 0);
        let v0 = 0x1::option::borrow<LoadoutSelectionV8>(0x1::vector::borrow<0x1::option::Option<LoadoutSelectionV8>>(&arg7.selections, arg8));
        assert!(v0.selection_index == arg8, 21);
        assert!(v0.source_class == 1, 21);
        assert!(v0.source_definition_id == 0x2::object::id<PackReleaseV8<T0>>(arg4), 21);
        assert!(&v0.source_semantic_id == &arg4.semantic_pack_id, 21);
        assert!(v0.access_subject == 0x2::object::id<PackPassV8>(arg6), 21);
        assert!(v0.source_epoch == 0, 21);
        let v1 = pack_pricing_commitment<T0>(arg4);
        assert!(v0.pricing_commitment == v1, 21);
        let v2 = PackStyleKeyV8{
            part_key  : v0.part_key,
            item_key  : v0.item_key,
            style_key : v0.style_key,
        };
        let v3 = 0x2::table::borrow<PackStyleKeyV8, PackStyleV8>(&arg4.styles, v2);
        assert!(v3.layer_track_key == v0.layer_track_key, 21);
        assert!(v3.asset_content_commitment == v0.asset_content_commitment, 21);
        RuntimePhysicalPackAccessWitnessV8{
            root_id                    : arg4.root_id,
            root_version               : arg4.root_version,
            root_content_commitment    : arg4.root_content_commitment,
            holder                     : 0x2::tx_context::sender(arg9),
            pack_registry_id           : 0x2::object::id<PackRegistryV8>(arg3),
            pack_registry_revision     : arg3.revision,
            release_id                 : 0x2::object::id<PackReleaseV8<T0>>(arg4),
            semantic_pack_id           : arg4.semantic_pack_id,
            release_content_commitment : arg4.content_commitment,
            pack_treasury_id           : 0x2::object::id<PackTreasuryV8<T0>>(arg5),
            pack_pass_id               : 0x2::object::id<PackPassV8>(arg6),
            pack_pass_commitment       : arg6.commitment,
            loadout_id                 : 0x2::object::id<MakerLoadoutV8>(arg7),
            loadout_revision           : arg7.revision,
            loadout_commitment         : arg7.commitment,
            selection_index            : arg8,
            selection_commitment       : selection_commitment_v8(*v0),
            pricing_commitment         : v1,
            part_key                   : v0.part_key,
            item_key                   : v0.item_key,
            style_key                  : v0.style_key,
            layer_track_key            : v0.layer_track_key,
            asset_content_commitment   : v0.asset_content_commitment,
            style_identity_commitment  : physical_pack_style_identity<T0>(arg3, arg4, arg5, v3),
        }
    }

    public fun new_physical_pack_policy_witness_v8<T0, T1, T2>(arg0: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerRootV8<T0>, arg1: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::ProductReleaseCatalogV8, arg2: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::PackageCallCapV8<0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::PhysicalRoleV8>, arg3: &PackRegistryV8, arg4: &PackReleaseV8<T0>, arg5: &PackAdminCapV8, arg6: &PackTreasuryV8<T0>, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: &0x2::tx_context::TxContext) : RuntimePhysicalPackPolicyWitnessV8 {
        assert_physical_caller<T0, T1, T2>(arg0, arg1, arg2, arg3);
        assert_active_pack_admission<T0>(arg3, arg4);
        assert!(arg4.lifecycle == 2, 9);
        assert_pack_control<T0>(arg4, arg5, arg10);
        assert_treasury<T0>(arg4, arg6);
        let v0 = PackStyleKeyV8{
            part_key  : arg7,
            item_key  : arg8,
            style_key : arg9,
        };
        let v1 = 0x2::table::borrow<PackStyleKeyV8, PackStyleV8>(&arg4.styles, v0);
        RuntimePhysicalPackPolicyWitnessV8{
            root_id                    : arg4.root_id,
            root_version               : arg4.root_version,
            root_content_commitment    : arg4.root_content_commitment,
            pack_registry_id           : 0x2::object::id<PackRegistryV8>(arg3),
            pack_registry_revision     : arg3.revision,
            release_id                 : 0x2::object::id<PackReleaseV8<T0>>(arg4),
            semantic_pack_id           : arg4.semantic_pack_id,
            release_content_commitment : arg4.content_commitment,
            pack_owner                 : arg4.owner,
            pack_control_epoch         : arg4.control_epoch,
            pack_admin_cap_id          : 0x2::object::id<PackAdminCapV8>(arg5),
            pack_treasury_id           : 0x2::object::id<PackTreasuryV8<T0>>(arg6),
            style_index                : v1.index,
            part_key                   : v1.part_key,
            item_key                   : v1.item_key,
            style_key                  : v1.style_key,
            layer_track_key            : v1.layer_track_key,
            color_channel_key          : v1.color_channel_key,
            default_swatch_key         : v1.default_swatch_key,
            asset_blob_id              : v1.asset_blob_id,
            asset_sha256               : v1.asset_sha256,
            asset_content_commitment   : v1.asset_content_commitment,
            protected                  : v1.protected,
            seal_binding_commitment    : v1.seal_binding_commitment,
            style_commitment           : v1.style_commitment,
            style_identity_commitment  : physical_pack_style_identity<T0>(arg3, arg4, arg6, v1),
        }
    }

    public fun new_runtime_registries_v8<T0>(arg0: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerRootV8<T0>, arg1: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerAdminCapV8, arg2: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::BaseDefinitionRegistryV8, arg3: u64, arg4: vector<u8>, arg5: u8, arg6: &mut 0x2::tx_context::TxContext) : (RuntimeDefinitionRegistryV8, PackRegistryV8, PackAdmissionAuthorityV8) {
        0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::assert_draft_admin_v8<T0>(arg0, arg1);
        0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::assert_base_registry_identity_v8<T0>(arg0, 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::registry_id_v8(arg2), 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::registry_root_id_v8(arg2), 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::registry_maker_version_v8(arg2), 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::registry_root_content_commitment_v8(arg2));
        assert!(0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::registry_sealed_v8(arg2), 6);
        assert!(arg3 == 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::registry_part_count_v8(arg2), 3);
        assert!(arg3 > 0 && arg3 <= 750, 3);
        assert_admission_ceiling(arg5);
        assert_hash(&arg4);
        let v0 = 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::root_id_v8<T0>(arg0);
        let v1 = 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::root_maker_version_v8<T0>(arg0);
        let v2 = *0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::root_content_commitment_v8<T0>(arg0);
        let v3 = runtime_policy_commitment_v8(v2, arg3, arg4, arg5);
        assert!(&v3 == 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::root_expected_pack_admission_policy_commitment_v8<T0>(arg0), 1);
        let v4 = 0x2::object::new(arg6);
        let v5 = 0x2::object::uid_to_inner(&v4);
        let v6 = 0x2::object::new(arg6);
        let v7 = 0x2::object::uid_to_inner(&v6);
        let v8 = 0x2::object::new(arg6);
        let v9 = RuntimeDefinitionRegistryV8{
            id                          : v4,
            version                     : 8,
            root_id                     : v0,
            root_version                : v1,
            root_content_commitment     : v2,
            base_registry_id            : 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::registry_id_v8(arg2),
            expected_profile_count      : arg3,
            observed_profile_count      : 0,
            expected_profile_commitment : arg4,
            rolling_profile_commitment  : empty_profile_commitment_v8(v2),
            admission_ceiling           : arg5,
            sealed                      : false,
            profile_keys                : 0x1::vector::empty<0x1::string::String>(),
            profiles                    : 0x2::table::new<PartProfileKeyV8, PartProfileV8>(arg6),
        };
        let v10 = PackRegistryV8{
            id                          : v8,
            version                     : 8,
            root_id                     : v0,
            root_version                : v1,
            root_content_commitment     : v2,
            definition_registry_id      : v5,
            admission_authority_id      : v7,
            admission_policy_commitment : v3,
            revision                    : 0,
            release_count               : 0,
            external_admission_count    : 0,
            releases                    : 0x2::table::new<0x2::object::ID, PackAdmissionRecordV8>(arg6),
            semantic_releases           : 0x2::table::new<0x1::string::String, 0x2::object::ID>(arg6),
            external_admissions         : 0x2::table::new<0x2::object::ID, ExternalAdmissionRecordV8>(arg6),
        };
        let v11 = PackAdmissionAuthorityV8{
            id                      : v6,
            version                 : 8,
            root_id                 : v0,
            root_version            : v1,
            root_content_commitment : v2,
        };
        let v12 = RuntimeRegistriesCreatedV8{
            root_id                : v0,
            definition_registry_id : v5,
            pack_registry_id       : 0x2::object::uid_to_inner(&v8),
            admission_authority_id : v7,
        };
        0x2::event::emit<RuntimeRegistriesCreatedV8>(v12);
        (v9, v10, v11)
    }

    fun new_selection_proof(arg0: &MakerLoadoutV8, arg1: &LoadoutSelectionV8, arg2: vector<u8>) : SelectionAccessProofV8 {
        assert_hash(&arg2);
        SelectionAccessProofV8{
            loadout_id                : 0x2::object::id<MakerLoadoutV8>(arg0),
            loadout_revision          : arg0.revision,
            loadout_commitment        : arg0.commitment,
            selection_index           : arg1.selection_index,
            selection_commitment      : selection_commitment_v8(*arg1),
            source_class              : arg1.source_class,
            source_definition_id      : arg1.source_definition_id,
            source_semantic_id        : arg1.source_semantic_id,
            source_content_commitment : arg2,
            source_epoch              : arg1.source_epoch,
            pricing_commitment        : arg1.pricing_commitment,
        }
    }

    public fun owned_item_locked_v8(arg0: &OwnedExternalItemV8) : bool {
        0x1::option::is_some<EquipLockV8>(&arg0.equip_lock)
    }

    public fun pack_active_v8() : u8 {
        2
    }

    public fun pack_archived_v8() : u8 {
        4
    }

    public fun pack_draft_v8() : u8 {
        0
    }

    public fun pack_pass_commitment_v8(arg0: &PackPassV8) : vector<u8> {
        arg0.commitment
    }

    public fun pack_paused_v8() : u8 {
        3
    }

    fun pack_pricing_commitment<T0>(arg0: &PackReleaseV8<T0>) : vector<u8> {
        let v0 = PricingCommitmentInputV8{
            domain                         : b"animacraft-v8/runtime/pack-pricing",
            version                        : 8,
            release_id                     : 0x2::object::id<PackReleaseV8<T0>>(arg0),
            release_content_commitment     : arg0.content_commitment,
            access_kind                    : arg0.access_kind,
            access_price_atomic            : arg0.access_price_atomic,
            complete_mode                  : arg0.complete_mode,
            complete_price_atomic          : arg0.complete_price_atomic,
            complete_free_quota_per_wallet : arg0.complete_free_quota_per_wallet,
            complete_total_cap             : arg0.complete_total_cap,
        };
        0x1::hash::sha2_256(0x1::bcs::to_bytes<PricingCommitmentInputV8>(&v0))
    }

    public fun pack_registry_external_count_v8(arg0: &PackRegistryV8) : u64 {
        arg0.external_admission_count
    }

    public fun pack_registry_id_v8(arg0: &PackRegistryV8) : 0x2::object::ID {
        0x2::object::id<PackRegistryV8>(arg0)
    }

    public fun pack_registry_release_count_v8(arg0: &PackRegistryV8) : u64 {
        arg0.release_count
    }

    public fun pack_registry_revision_v8(arg0: &PackRegistryV8) : u64 {
        arg0.revision
    }

    public fun pack_release_content_commitment_v8<T0>(arg0: &PackReleaseV8<T0>) : &vector<u8> {
        &arg0.content_commitment
    }

    public fun pack_release_id_v8<T0>(arg0: &PackReleaseV8<T0>) : 0x2::object::ID {
        0x2::object::id<PackReleaseV8<T0>>(arg0)
    }

    public fun pack_release_lifecycle_v8<T0>(arg0: &PackReleaseV8<T0>) : u8 {
        arg0.lifecycle
    }

    public fun pack_release_root_id_v8<T0>(arg0: &PackReleaseV8<T0>) : 0x2::object::ID {
        arg0.root_id
    }

    public fun pack_release_root_version_v8<T0>(arg0: &PackReleaseV8<T0>) : u64 {
        arg0.root_version
    }

    public fun pack_release_semantic_id_v8<T0>(arg0: &PackReleaseV8<T0>) : &0x1::string::String {
        &arg0.semantic_pack_id
    }

    public fun pack_seal_scope_key_v8(arg0: 0x1::string::String) : 0x1::string::String {
        assert_key(&arg0);
        let v0 = b"pack/";
        0x1::vector::append<u8>(&mut v0, 0x1::string::into_bytes(arg0));
        0x1::string::utf8(v0)
    }

    public fun pack_sealed_v8() : u8 {
        1
    }

    public fun pack_treasury_balance_v8<T0>(arg0: &PackTreasuryV8<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.revenue)
    }

    public fun part_profile_admission_ceiling_v8(arg0: &PartProfileV8) : u8 {
        arg0.admission_ceiling
    }

    public fun part_profile_behavior_v8(arg0: &PartProfileV8) : u8 {
        arg0.behavior
    }

    public fun part_profile_capacity_v8(arg0: &PartProfileV8) : u64 {
        arg0.capacity
    }

    public fun part_profile_commitment_v8(arg0: &PartProfileV8) : &vector<u8> {
        &arg0.profile_commitment
    }

    public fun part_profile_index_v8(arg0: &PartProfileV8) : u64 {
        arg0.index
    }

    public fun part_profile_required_v8(arg0: &PartProfileV8) : bool {
        arg0.required
    }

    public fun part_profile_v8(arg0: &RuntimeDefinitionRegistryV8, arg1: 0x1::string::String) : &PartProfileV8 {
        let v0 = PartProfileKeyV8{part_key: arg1};
        0x2::table::borrow<PartProfileKeyV8, PartProfileV8>(&arg0.profiles, v0)
    }

    public fun part_profile_wardrobe_mode_v8(arg0: &PartProfileV8) : u8 {
        arg0.wardrobe_mode
    }

    public fun pause_external_product_v8(arg0: &mut ExternalItemProductV8, arg1: &ExternalItemAdminCapV8, arg2: &0x2::tx_context::TxContext) {
        assert_product_control(arg0, arg1, arg2);
        assert!(arg0.lifecycle == 0, 9);
        arg0.lifecycle = 1;
    }

    public fun pause_pack_release_v8<T0>(arg0: &mut PackReleaseV8<T0>, arg1: &PackAdminCapV8, arg2: &0x2::tx_context::TxContext) {
        assert_pack_write<T0>(arg0, arg1, arg2);
        assert!(arg0.lifecycle == 2, 9);
        set_pack_lifecycle<T0>(arg0, 3);
    }

    fun physical_pack_style_identity<T0>(arg0: &PackRegistryV8, arg1: &PackReleaseV8<T0>, arg2: &PackTreasuryV8<T0>, arg3: &PackStyleV8) : vector<u8> {
        let v0 = PhysicalPackStyleIdentityInputV8{
            domain                     : b"animacraft-v8/runtime/physical-pack-style",
            version                    : 8,
            root_id                    : arg1.root_id,
            root_version               : arg1.root_version,
            root_content_commitment    : arg1.root_content_commitment,
            pack_registry_id           : 0x2::object::id<PackRegistryV8>(arg0),
            release_id                 : 0x2::object::id<PackReleaseV8<T0>>(arg1),
            semantic_pack_id           : arg1.semantic_pack_id,
            release_content_commitment : arg1.content_commitment,
            pack_treasury_id           : 0x2::object::id<PackTreasuryV8<T0>>(arg2),
            style                      : *arg3,
        };
        0x1::hash::sha2_256(0x1::bcs::to_bytes<PhysicalPackStyleIdentityInputV8>(&v0))
    }

    fun prepare_owned_item_transfer(arg0: &mut OwnedExternalItemV8, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_owned_holder(arg0, arg2);
        assert!(arg0.transferable, 15);
        assert!(0x1::option::is_none<EquipLockV8>(&arg0.equip_lock), 18);
        assert!(arg1 != @0x0, 26);
        arg0.holder = arg1;
        arg0.ownership_epoch = arg0.ownership_epoch + 1;
    }

    fun protocol_share(arg0: u64, arg1: u16) : u64 {
        assert!(arg1 <= 10000, 10);
        let v0 = (arg0 as u128) * (arg1 as u128) / 10000;
        assert!(arg1 == 0 || v0 > 0, 17);
        let v1 = (v0 as u64);
        assert!(v1 < arg0, 17);
        v1
    }

    public fun prove_base_selection_v8<T0>(arg0: &MakerLoadoutV8, arg1: &RuntimeDefinitionRegistryV8, arg2: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::BaseDefinitionRegistryV8, arg3: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerRootV8<T0>, arg4: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::treasury_v8::MakerAccessPassV8, arg5: u64, arg6: &0x2::tx_context::TxContext) : SelectionAccessProofV8 {
        assert!(arg0.holder == 0x2::tx_context::sender(arg6), 8);
        assert_loadout_maker_access<T0>(arg0, arg3, arg4, arg6);
        assert!(arg0.definition_registry_id == 0x2::object::id<RuntimeDefinitionRegistryV8>(arg1), 0);
        assert!(arg1.base_registry_id == 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::registry_id_v8(arg2), 0);
        assert!(0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::registry_root_id_v8(arg2) == arg0.root_id, 0);
        assert!(0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::registry_maker_version_v8(arg2) == arg0.root_version, 0);
        assert!(0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::registry_root_content_commitment_v8(arg2) == &arg0.root_content_commitment, 0);
        let v0 = 0x1::option::borrow<LoadoutSelectionV8>(0x1::vector::borrow<0x1::option::Option<LoadoutSelectionV8>>(&arg0.selections, arg5));
        assert!(v0.source_class == 0, 21);
        assert!(v0.access_subject == arg0.maker_access_pass_id, 21);
        assert!(v0.pricing_commitment == arg0.maker_access_commitment, 21);
        assert!(0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::item_gate_kind_v8(0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::borrow_item_v8(arg2, v0.part_key, v0.item_key)) == 0, 10);
        let v1 = 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::borrow_style_v8(arg2, v0.part_key, v0.item_key, v0.style_key);
        assert!(0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::style_layer_track_key_v8(v1) == &v0.layer_track_key, 21);
        assert!(0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::style_asset_blob_id_v8(v1) == &v0.asset_blob_id, 21);
        assert!(0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::style_asset_sha256_v8(v1) == &v0.asset_sha256, 21);
        assert!(0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::style_payload_commitment_v8(v1) == &v0.asset_content_commitment, 21);
        assert!(!v0.protected && !0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::style_protected_v8(v1), 28);
        new_selection_proof(arg0, v0, arg0.root_content_commitment)
    }

    public fun prove_external_selection_v8<T0>(arg0: &MakerLoadoutV8, arg1: &PackRegistryV8, arg2: &ExternalItemProductV8, arg3: &OwnedExternalItemV8, arg4: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerRootV8<T0>, arg5: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::treasury_v8::MakerAccessPassV8, arg6: u64, arg7: &0x2::tx_context::TxContext) : SelectionAccessProofV8 {
        assert!(arg0.holder == 0x2::tx_context::sender(arg7), 8);
        assert_loadout_maker_access<T0>(arg0, arg4, arg5, arg7);
        assert!(0x2::object::id<PackRegistryV8>(arg1) == arg0.pack_registry_id, 0);
        assert_external_access(arg1, arg2, arg3, 0x2::tx_context::sender(arg7));
        let v0 = 0x1::option::borrow<EquipLockV8>(&arg3.equip_lock);
        assert!(v0.loadout_id == 0x2::object::id<MakerLoadoutV8>(arg0), 19);
        assert!(v0.selection_index == arg6, 19);
        let v1 = 0x1::option::borrow<LoadoutSelectionV8>(0x1::vector::borrow<0x1::option::Option<LoadoutSelectionV8>>(&arg0.selections, arg6));
        assert!(v1.source_class == 2, 21);
        assert!(v1.source_definition_id == 0x2::object::id<ExternalItemProductV8>(arg2), 21);
        assert!(v1.access_subject == 0x2::object::id<OwnedExternalItemV8>(arg3), 21);
        assert!(v1.source_epoch == arg3.ownership_epoch, 21);
        assert!(v1.asset_content_commitment == arg3.asset_content_commitment, 21);
        new_selection_proof(arg0, v1, arg2.content_commitment)
    }

    public fun prove_pack_selection_v8<T0>(arg0: &MakerLoadoutV8, arg1: &PackRegistryV8, arg2: &PackReleaseV8<T0>, arg3: &PackPassV8, arg4: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerRootV8<T0>, arg5: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::treasury_v8::MakerAccessPassV8, arg6: u64, arg7: &0x2::tx_context::TxContext) : SelectionAccessProofV8 {
        assert!(arg0.holder == 0x2::tx_context::sender(arg7), 8);
        assert_loadout_maker_access<T0>(arg0, arg4, arg5, arg7);
        assert!(0x2::object::id<PackRegistryV8>(arg1) == arg0.pack_registry_id, 0);
        assert_active_pack_admission<T0>(arg1, arg2);
        assert!(arg2.lifecycle == 2, 9);
        assert_pack_pass<T0>(arg2, arg3, 0x2::tx_context::sender(arg7));
        let v0 = 0x1::option::borrow<LoadoutSelectionV8>(0x1::vector::borrow<0x1::option::Option<LoadoutSelectionV8>>(&arg0.selections, arg6));
        assert!(v0.source_class == 1, 21);
        assert!(v0.source_definition_id == 0x2::object::id<PackReleaseV8<T0>>(arg2), 21);
        assert!(&v0.source_semantic_id == &arg2.semantic_pack_id, 21);
        assert!(v0.access_subject == 0x2::object::id<PackPassV8>(arg3), 21);
        assert!(v0.source_epoch == 0, 21);
        assert!(v0.pricing_commitment == pack_pricing_commitment<T0>(arg2), 21);
        let v1 = PackStyleKeyV8{
            part_key  : v0.part_key,
            item_key  : v0.item_key,
            style_key : v0.style_key,
        };
        let v2 = 0x2::table::borrow<PackStyleKeyV8, PackStyleV8>(&arg2.styles, v1);
        assert!(v2.asset_content_commitment == v0.asset_content_commitment, 21);
        assert!(v2.layer_track_key == v0.layer_track_key, 21);
        assert!(!v2.protected, 28);
        new_selection_proof(arg0, v0, arg2.content_commitment)
    }

    public(friend) fun prove_protected_base_selection_after_seal_v8<T0>(arg0: &MakerLoadoutV8, arg1: &RuntimeDefinitionRegistryV8, arg2: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::BaseDefinitionRegistryV8, arg3: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerRootV8<T0>, arg4: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::treasury_v8::MakerAccessPassV8, arg5: u64, arg6: vector<u8>, arg7: &0x2::tx_context::TxContext) : SelectionAccessProofV8 {
        assert!(arg0.holder == 0x2::tx_context::sender(arg7), 8);
        assert_loadout_maker_access<T0>(arg0, arg3, arg4, arg7);
        assert!(arg0.definition_registry_id == 0x2::object::id<RuntimeDefinitionRegistryV8>(arg1), 0);
        assert!(arg1.base_registry_id == 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::registry_id_v8(arg2), 0);
        let v0 = 0x1::option::borrow<LoadoutSelectionV8>(0x1::vector::borrow<0x1::option::Option<LoadoutSelectionV8>>(&arg0.selections, arg5));
        assert!(v0.source_class == 0 && v0.protected, 21);
        assert!(v0.access_subject == arg0.maker_access_pass_id, 21);
        assert!(v0.pricing_commitment == arg0.maker_access_commitment, 21);
        assert!(v0.seal_binding_commitment == arg6, 21);
        assert!(0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::item_gate_kind_v8(0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::borrow_item_v8(arg2, v0.part_key, v0.item_key)) == 0, 10);
        let v1 = 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::borrow_style_v8(arg2, v0.part_key, v0.item_key, v0.style_key);
        assert!(0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::style_protected_v8(v1), 21);
        assert!(0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::style_layer_track_key_v8(v1) == &v0.layer_track_key, 21);
        assert!(0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::style_asset_blob_id_v8(v1) == &v0.asset_blob_id, 21);
        assert!(0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::style_asset_sha256_v8(v1) == &v0.asset_sha256, 21);
        assert!(0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::style_payload_commitment_v8(v1) == &v0.asset_content_commitment, 21);
        new_selection_proof(arg0, v0, arg0.root_content_commitment)
    }

    public(friend) fun prove_protected_pack_selection_after_seal_v8<T0>(arg0: &MakerLoadoutV8, arg1: &PackRegistryV8, arg2: &PackReleaseV8<T0>, arg3: &PackPassV8, arg4: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerRootV8<T0>, arg5: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::treasury_v8::MakerAccessPassV8, arg6: u64, arg7: vector<u8>, arg8: &0x2::tx_context::TxContext) : SelectionAccessProofV8 {
        assert!(arg0.holder == 0x2::tx_context::sender(arg8), 8);
        assert_loadout_maker_access<T0>(arg0, arg4, arg5, arg8);
        assert!(0x2::object::id<PackRegistryV8>(arg1) == arg0.pack_registry_id, 0);
        assert_active_pack_admission<T0>(arg1, arg2);
        assert!(arg2.lifecycle == 2, 9);
        assert_pack_pass<T0>(arg2, arg3, 0x2::tx_context::sender(arg8));
        let v0 = 0x1::option::borrow<LoadoutSelectionV8>(0x1::vector::borrow<0x1::option::Option<LoadoutSelectionV8>>(&arg0.selections, arg6));
        assert!(v0.source_class == 1, 21);
        assert!(v0.source_definition_id == 0x2::object::id<PackReleaseV8<T0>>(arg2), 21);
        assert!(&v0.source_semantic_id == &arg2.semantic_pack_id, 21);
        assert!(v0.access_subject == 0x2::object::id<PackPassV8>(arg3), 21);
        assert!(v0.source_epoch == 0, 21);
        assert!(v0.pricing_commitment == pack_pricing_commitment<T0>(arg2), 21);
        let v1 = PackStyleKeyV8{
            part_key  : v0.part_key,
            item_key  : v0.item_key,
            style_key : v0.style_key,
        };
        let v2 = 0x2::table::borrow<PackStyleKeyV8, PackStyleV8>(&arg2.styles, v1);
        assert!(v2.protected && v0.protected, 21);
        assert!(v2.seal_binding_commitment == arg7, 21);
        assert!(v0.seal_binding_commitment == arg7, 21);
        assert!(v2.asset_content_commitment == v0.asset_content_commitment, 21);
        assert!(v2.layer_track_key == v0.layer_track_key, 21);
        new_selection_proof(arg0, v0, arg2.content_commitment)
    }

    public fun purchase_pack_pass_v8<T0>(arg0: &mut PackReleaseV8<T0>, arg1: &PackRegistryV8, arg2: &mut PackTreasuryV8<T0>, arg3: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerRootV8<T0>, arg4: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::protocol_config_v8::ProtocolConfigV8, arg5: &mut 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::protocol_config_v8::ProtocolTreasuryV8<T0>, arg6: 0x2::coin::Coin<T0>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : PackPassV8 {
        assert_active_pack_admission<T0>(arg1, arg0);
        assert!(arg0.lifecycle == 2, 9);
        assert!(arg0.access_kind == 1, 10);
        assert_root_compatibility<T0>(arg0.root_id, arg0.root_version, &arg0.root_content_commitment, arg3);
        0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::assert_current_protocol_config_v8<T0>(arg3, arg4);
        assert_treasury<T0>(arg0, arg2);
        let v0 = arg0.access_price_atomic;
        assert!(v0 > 0 && 0x2::coin::value<T0>(&arg6) == v0, 17);
        let v1 = 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::root_economics_v8<T0>(arg3);
        let v2 = protocol_share(v0, 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::economics_primary_content_fee_bps_v8(&v1));
        if (v2 > 0) {
            0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::protocol_config_v8::deposit_protocol_revenue_v8<T0>(arg4, arg5, 0x2::coin::split<T0>(&mut arg6, v2, arg8));
        };
        assert!(0x2::coin::value<T0>(&arg6) == v0 - v2, 17);
        deposit_pack_revenue_v8<T0>(arg0, arg2, arg6);
        new_pack_pass<T0>(arg0, v0, 0x2::clock::timestamp_ms(arg7), arg8)
    }

    fun recompute_loadout(arg0: &mut MakerLoadoutV8) {
        arg0.commitment = canonical_loadout_commitment(arg0.root_id, arg0.root_version, arg0.root_content_commitment, &arg0.selections);
    }

    public fun resume_external_product_v8(arg0: &mut ExternalItemProductV8, arg1: &ExternalItemAdminCapV8, arg2: &0x2::tx_context::TxContext) {
        assert_product_control(arg0, arg1, arg2);
        assert!(arg0.lifecycle == 1, 9);
        arg0.lifecycle = 0;
    }

    public fun resume_pack_release_v8<T0>(arg0: &mut PackReleaseV8<T0>, arg1: &PackAdminCapV8, arg2: &PackRegistryV8, arg3: &0x2::tx_context::TxContext) {
        assert_pack_write<T0>(arg0, arg1, arg3);
        assert!(arg0.lifecycle == 3, 9);
        assert_active_pack_admission<T0>(arg2, arg0);
        set_pack_lifecycle<T0>(arg0, 2);
    }

    public fun revoke_external_product_v8<T0>(arg0: &mut PackRegistryV8, arg1: &PackAdmissionAuthorityV8, arg2: &RuntimeDefinitionRegistryV8, arg3: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerRootV8<T0>, arg4: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerAdminCapV8, arg5: 0x2::object::ID, arg6: u64, arg7: &0x2::tx_context::TxContext) {
        0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::assert_admin_v8<T0>(arg3, arg4);
        assert!(0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::root_owner_v8<T0>(arg3) == 0x2::tx_context::sender(arg7), 29);
        assert_pack_registry_identity<T0>(arg0, arg2, arg3);
        assert_authority_identity<T0>(arg1, arg0, arg3);
        assert!(arg0.revision == arg6, 7);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, ExternalAdmissionRecordV8>(&mut arg0.external_admissions, arg5);
        assert!(v0.admission_state == 0, 15);
        v0.admission_state = 1;
        arg0.revision = arg0.revision + 1;
        let v1 = PackRegistryRevisionAdvancedV8{
            root_id           : arg0.root_id,
            previous_revision : arg6,
            revision          : arg0.revision,
            subject_id        : arg5,
            operation         : 3,
        };
        0x2::event::emit<PackRegistryRevisionAdvancedV8>(v1);
    }

    public fun revoke_pack_admission_v8<T0>(arg0: &mut PackRegistryV8, arg1: &PackAdmissionAuthorityV8, arg2: &RuntimeDefinitionRegistryV8, arg3: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerRootV8<T0>, arg4: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerAdminCapV8, arg5: 0x2::object::ID, arg6: u64, arg7: &0x2::tx_context::TxContext) {
        0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::assert_admin_v8<T0>(arg3, arg4);
        assert!(0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::root_owner_v8<T0>(arg3) == 0x2::tx_context::sender(arg7), 29);
        assert_pack_registry_identity<T0>(arg0, arg2, arg3);
        assert_authority_identity<T0>(arg1, arg0, arg3);
        assert!(arg0.revision == arg6, 7);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, PackAdmissionRecordV8>(&mut arg0.releases, arg5);
        assert!(v0.admission_state == 0, 15);
        v0.admission_state = 1;
        arg0.revision = arg0.revision + 1;
        let v1 = PackRegistryRevisionAdvancedV8{
            root_id           : arg0.root_id,
            previous_revision : arg6,
            revision          : arg0.revision,
            subject_id        : arg5,
            operation         : 1,
        };
        0x2::event::emit<PackRegistryRevisionAdvancedV8>(v1);
    }

    public fun runtime_activation_readiness_v8<T0>(arg0: &RuntimeDefinitionRegistryV8, arg1: &PackRegistryV8, arg2: &PackAdmissionAuthorityV8, arg3: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerRootV8<T0>) : RuntimeActivationReadinessReceiptV8 {
        0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::assert_draft_v8<T0>(arg3);
        assert_definition_identity<T0>(arg0, arg3);
        assert!(arg0.sealed, 6);
        assert_pack_registry_identity<T0>(arg1, arg0, arg3);
        assert_authority_identity<T0>(arg2, arg1, arg3);
        assert!(arg1.revision == 0, 28);
        assert!(arg1.release_count == 0, 28);
        assert!(arg1.external_admission_count == 0, 28);
        let v0 = 0x2::object::id<RuntimeDefinitionRegistryV8>(arg0);
        let v1 = 0x2::object::id<PackRegistryV8>(arg1);
        let v2 = 0x2::object::id<PackAdmissionAuthorityV8>(arg2);
        let v3 = RuntimeReadinessCommitmentInputV8{
            domain                        : b"animacraft-v8/runtime/activation-readiness",
            version                       : 8,
            root_id                       : arg1.root_id,
            root_version                  : arg1.root_version,
            root_content_commitment       : arg1.root_content_commitment,
            definition_registry_id        : v0,
            definition_profile_count      : arg0.observed_profile_count,
            definition_profile_commitment : arg0.rolling_profile_commitment,
            pack_registry_id              : v1,
            pack_registry_revision        : arg1.revision,
            pack_release_count            : arg1.release_count,
            external_admission_count      : arg1.external_admission_count,
            admission_authority_id        : v2,
            policy_commitment             : arg1.admission_policy_commitment,
        };
        RuntimeActivationReadinessReceiptV8{
            root_id                 : arg1.root_id,
            root_version            : arg1.root_version,
            root_content_commitment : arg1.root_content_commitment,
            definition_registry_id  : v0,
            pack_registry_id        : v1,
            admission_authority_id  : v2,
            policy_commitment       : arg1.admission_policy_commitment,
            companion_commitment    : 0x1::hash::sha2_256(0x1::bcs::to_bytes<RuntimeReadinessCommitmentInputV8>(&v3)),
        }
    }

    public fun runtime_policy_commitment_v8(arg0: vector<u8>, arg1: u64, arg2: vector<u8>, arg3: u8) : vector<u8> {
        assert_hash(&arg0);
        assert!(arg1 > 0 && arg1 <= 750, 3);
        assert_hash(&arg2);
        assert_admission_ceiling(arg3);
        let v0 = RuntimePolicyCommitmentInputV8{
            domain                  : b"animacraft-v8/runtime/admission-policy",
            version                 : 8,
            root_content_commitment : arg0,
            profile_count           : arg1,
            profile_commitment      : arg2,
            admission_ceiling       : arg3,
        };
        0x1::hash::sha2_256(0x1::bcs::to_bytes<RuntimePolicyCommitmentInputV8>(&v0))
    }

    public fun seal_binding_commitment_v8(arg0: 0x2::object::ID, arg1: vector<u8>, arg2: u64, arg3: vector<u8>, arg4: 0x2::object::ID, arg5: vector<u8>, arg6: 0x2::object::ID, arg7: u64, arg8: vector<u8>, arg9: u8, arg10: 0x1::string::String, arg11: vector<u8>, arg12: 0x1::string::String, arg13: vector<u8>, arg14: 0x1::string::String, arg15: vector<u8>, arg16: vector<u8>, arg17: vector<u8>, arg18: vector<u8>) : vector<u8> {
        let v0 = SealBindingCommitmentInputV8{
            domain                     : b"animacraft-v8/runtime/seal-binding",
            version                    : 8,
            registry_id                : arg0,
            registry_commitment        : arg1,
            runtime_revision           : arg2,
            runtime_commitment         : arg3,
            policy_config_id           : arg4,
            policy_commitment          : arg5,
            root_id                    : arg6,
            root_version               : arg7,
            root_content_commitment    : arg8,
            scope_kind                 : arg9,
            scope_key                  : arg10,
            scope_commitment           : arg11,
            asset_key                  : arg12,
            asset_content_commitment   : arg13,
            ciphertext_blob_id         : arg14,
            ciphertext_sha256          : arg15,
            ciphertext_blob_commitment : arg16,
            certification_commitment   : arg17,
            seal_id                    : arg18,
        };
        0x1::hash::sha2_256(0x1::bcs::to_bytes<SealBindingCommitmentInputV8>(&v0))
    }

    public fun seal_ordered_selection_proofs_v8(arg0: &MakerLoadoutV8, arg1: &RuntimeDefinitionRegistryV8, arg2: vector<SelectionAccessProofV8>, arg3: &0x2::tx_context::TxContext) : RuntimeLoadoutAuthorizationV8 {
        assert!(arg0.holder == 0x2::tx_context::sender(arg3), 8);
        assert!(arg0.definition_registry_id == 0x2::object::id<RuntimeDefinitionRegistryV8>(arg1), 0);
        assert!(arg1.sealed, 6);
        assert!(0x1::vector::length<SelectionAccessProofV8>(&arg2) == arg0.selection_count, 22);
        0x1::vector::reverse<SelectionAccessProofV8>(&mut arg2);
        let v0 = vector[];
        let v1 = vector[];
        let v2 = 0x1::vector::empty<UsedPackV8>();
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x1::option::Option<LoadoutSelectionV8>>(&arg0.selections)) {
            let v4 = 0x1::vector::borrow<0x1::option::Option<LoadoutSelectionV8>>(&arg0.selections, v3);
            let v5 = PartProfileKeyV8{part_key: *0x1::vector::borrow<0x1::string::String>(&arg1.profile_keys, v3)};
            if (0x2::table::borrow<PartProfileKeyV8, PartProfileV8>(&arg1.profiles, v5).required) {
                assert!(0x1::option::is_some<LoadoutSelectionV8>(v4), 20);
            };
            if (0x1::option::is_some<LoadoutSelectionV8>(v4)) {
                let v6 = 0x1::option::borrow<LoadoutSelectionV8>(v4);
                let SelectionAccessProofV8 {
                    loadout_id                : v7,
                    loadout_revision          : v8,
                    loadout_commitment        : v9,
                    selection_index           : v10,
                    selection_commitment      : v11,
                    source_class              : v12,
                    source_definition_id      : v13,
                    source_semantic_id        : v14,
                    source_content_commitment : v15,
                    source_epoch              : v16,
                    pricing_commitment        : v17,
                } = 0x1::vector::pop_back<SelectionAccessProofV8>(&mut arg2);
                assert!(v7 == 0x2::object::id<MakerLoadoutV8>(arg0), 21);
                assert!(v8 == arg0.revision, 21);
                assert!(v9 == arg0.commitment, 21);
                assert!(v10 == v3, 22);
                assert!(v12 == v6.source_class, 21);
                assert!(v13 == v6.source_definition_id, 21);
                assert!(v14 == v6.source_semantic_id, 21);
                assert!(v16 == v6.source_epoch, 21);
                assert!(v17 == v6.pricing_commitment, 21);
                assert!(v11 == selection_commitment_v8(*v6), 21);
                0x1::vector::push_back<vector<u8>>(&mut v0, v11);
                0x1::vector::push_back<vector<u8>>(&mut v1, v17);
                if (v12 == 1 && !used_pack_contains(&v2, v13)) {
                    let v18 = UsedPackV8{
                        release_id                 : v13,
                        semantic_pack_id           : v14,
                        release_content_commitment : v15,
                        pricing_commitment         : v17,
                    };
                    0x1::vector::push_back<UsedPackV8>(&mut v2, v18);
                };
            };
            v3 = v3 + 1;
        };
        assert!(0x1::vector::is_empty<SelectionAccessProofV8>(&arg2), 22);
        0x1::vector::destroy_empty<SelectionAccessProofV8>(arg2);
        RuntimeLoadoutAuthorizationV8{
            loadout_id                    : 0x2::object::id<MakerLoadoutV8>(arg0),
            root_id                       : arg0.root_id,
            root_version                  : arg0.root_version,
            root_content_commitment       : arg0.root_content_commitment,
            loadout_revision              : arg0.revision,
            loadout_commitment            : arg0.commitment,
            selection_count               : arg0.selection_count,
            ordered_selection_commitments : v0,
            ordered_pricing_commitments   : v1,
            used_packs                    : v2,
        }
    }

    public fun seal_pack_release_v8<T0>(arg0: &mut PackReleaseV8<T0>, arg1: &PackAdminCapV8, arg2: &0x2::tx_context::TxContext) {
        assert_pack_write<T0>(arg0, arg1, arg2);
        assert!(arg0.lifecycle == 0, 9);
        assert!(arg0.observed_style_count == arg0.expected_style_count, 3);
        assert!(arg0.rolling_style_commitment == arg0.expected_style_commitment, 1);
        arg0.lifecycle = 1;
        let v0 = PackLifecycleChangedV8{
            release_id         : 0x2::object::id<PackReleaseV8<T0>>(arg0),
            previous_lifecycle : 0,
            lifecycle          : 1,
        };
        0x2::event::emit<PackLifecycleChangedV8>(v0);
    }

    public fun seal_runtime_definitions_v8<T0>(arg0: &mut RuntimeDefinitionRegistryV8, arg1: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerRootV8<T0>, arg2: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerAdminCapV8, arg3: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::BaseDefinitionRegistryV8) {
        0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::assert_draft_admin_v8<T0>(arg1, arg2);
        assert_definition_binding<T0>(arg0, arg1, arg3);
        assert!(!arg0.sealed, 5);
        assert!(arg0.observed_profile_count == arg0.expected_profile_count, 3);
        assert!(0x1::vector::length<0x1::string::String>(&arg0.profile_keys) == arg0.expected_profile_count, 3);
        assert!(arg0.rolling_profile_commitment == arg0.expected_profile_commitment, 1);
        arg0.sealed = true;
    }

    public fun select_base_style_v8<T0>(arg0: &mut MakerLoadoutV8, arg1: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerRootV8<T0>, arg2: &RuntimeDefinitionRegistryV8, arg3: &PackRegistryV8, arg4: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::BaseDefinitionRegistryV8, arg5: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::treasury_v8::MakerAccessPassV8, arg6: u64, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: 0x1::option::Option<0x1::string::String>, arg11: &0x2::tx_context::TxContext) {
        assert_loadout_write<T0>(arg0, arg1, arg2, arg3, arg6, arg11);
        assert_loadout_maker_access<T0>(arg0, arg1, arg5, arg11);
        assert_definition_binding<T0>(arg2, arg1, arg4);
        let v0 = PartProfileKeyV8{part_key: arg7};
        let v1 = 0x2::table::borrow<PartProfileKeyV8, PartProfileV8>(&arg2.profiles, v0);
        assert_slot_empty(arg0, v1.index);
        assert!(0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::item_gate_kind_v8(0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::borrow_item_v8(arg4, arg7, arg8)) == 0, 10);
        let v2 = 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::borrow_style_v8(arg4, arg7, arg8, arg9);
        let v3 = *0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::style_layer_track_key_v8(v2);
        0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::borrow_track_v8(arg4, v3);
        let v4 = *0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::style_color_channel_key_v8(v2);
        let v5 = LoadoutSelectionV8{
            selection_index          : v1.index,
            part_key                 : arg7,
            item_key                 : arg8,
            style_key                : arg9,
            color_channel_key        : v4,
            swatch_key               : exact_selected_swatch(arg4, &v4, arg10),
            layer_track_key          : v3,
            asset_blob_id            : *0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::style_asset_blob_id_v8(v2),
            asset_sha256             : *0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::style_asset_sha256_v8(v2),
            asset_content_commitment : *0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::style_payload_commitment_v8(v2),
            source_class             : 0,
            source_definition_id     : arg0.root_id,
            source_semantic_id       : 0x1::string::utf8(b""),
            access_subject           : arg0.maker_access_pass_id,
            source_epoch             : 0,
            pricing_commitment       : arg0.maker_access_commitment,
            protected                : 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::style_protected_v8(v2),
            seal_binding_commitment  : b"",
        };
        assert!(!v5.protected, 28);
        install_selection(arg0, v1.index, v5);
    }

    public fun select_pack_style_v8<T0>(arg0: &mut MakerLoadoutV8, arg1: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerRootV8<T0>, arg2: &RuntimeDefinitionRegistryV8, arg3: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::BaseDefinitionRegistryV8, arg4: &PackRegistryV8, arg5: &PackReleaseV8<T0>, arg6: &PackPassV8, arg7: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::treasury_v8::MakerAccessPassV8, arg8: u64, arg9: 0x1::string::String, arg10: 0x1::string::String, arg11: 0x1::string::String, arg12: 0x1::option::Option<0x1::string::String>, arg13: &0x2::tx_context::TxContext) {
        assert_loadout_write<T0>(arg0, arg1, arg2, arg4, arg8, arg13);
        assert_loadout_maker_access<T0>(arg0, arg1, arg7, arg13);
        assert_active_pack_admission<T0>(arg4, arg5);
        assert!(arg5.lifecycle == 2, 9);
        assert_pack_pass<T0>(arg5, arg6, 0x2::tx_context::sender(arg13));
        let v0 = PartProfileKeyV8{part_key: arg9};
        let v1 = 0x2::table::borrow<PartProfileKeyV8, PartProfileV8>(&arg2.profiles, v0);
        assert_slot_empty(arg0, v1.index);
        let v2 = PackStyleKeyV8{
            part_key  : arg9,
            item_key  : arg10,
            style_key : arg11,
        };
        let v3 = 0x2::table::borrow<PackStyleKeyV8, PackStyleV8>(&arg5.styles, v2);
        assert_definition_binding<T0>(arg2, arg1, arg3);
        let v4 = LoadoutSelectionV8{
            selection_index          : v1.index,
            part_key                 : arg9,
            item_key                 : arg10,
            style_key                : arg11,
            color_channel_key        : v3.color_channel_key,
            swatch_key               : exact_pack_swatch(arg3, v3, arg12),
            layer_track_key          : v3.layer_track_key,
            asset_blob_id            : v3.asset_blob_id,
            asset_sha256             : v3.asset_sha256,
            asset_content_commitment : v3.asset_content_commitment,
            source_class             : 1,
            source_definition_id     : 0x2::object::id<PackReleaseV8<T0>>(arg5),
            source_semantic_id       : arg5.semantic_pack_id,
            access_subject           : 0x2::object::id<PackPassV8>(arg6),
            source_epoch             : 0,
            pricing_commitment       : pack_pricing_commitment<T0>(arg5),
            protected                : v3.protected,
            seal_binding_commitment  : v3.seal_binding_commitment,
        };
        install_selection(arg0, v1.index, v4);
    }

    public(friend) fun select_protected_base_style_after_seal_v8<T0>(arg0: &mut MakerLoadoutV8, arg1: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerRootV8<T0>, arg2: &RuntimeDefinitionRegistryV8, arg3: &PackRegistryV8, arg4: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::BaseDefinitionRegistryV8, arg5: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::treasury_v8::MakerAccessPassV8, arg6: u64, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: 0x1::option::Option<0x1::string::String>, arg11: vector<u8>, arg12: &0x2::tx_context::TxContext) {
        assert_loadout_write<T0>(arg0, arg1, arg2, arg3, arg6, arg12);
        assert_loadout_maker_access<T0>(arg0, arg1, arg5, arg12);
        assert_definition_binding<T0>(arg2, arg1, arg4);
        assert_hash(&arg11);
        let v0 = PartProfileKeyV8{part_key: arg7};
        let v1 = 0x2::table::borrow<PartProfileKeyV8, PartProfileV8>(&arg2.profiles, v0);
        assert_slot_empty(arg0, v1.index);
        assert!(0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::item_gate_kind_v8(0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::borrow_item_v8(arg4, arg7, arg8)) == 0, 10);
        let v2 = 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::borrow_style_v8(arg4, arg7, arg8, arg9);
        assert!(0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::style_protected_v8(v2), 21);
        let v3 = *0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::style_layer_track_key_v8(v2);
        0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::borrow_track_v8(arg4, v3);
        let v4 = *0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::style_color_channel_key_v8(v2);
        let v5 = LoadoutSelectionV8{
            selection_index          : v1.index,
            part_key                 : arg7,
            item_key                 : arg8,
            style_key                : arg9,
            color_channel_key        : v4,
            swatch_key               : exact_selected_swatch(arg4, &v4, arg10),
            layer_track_key          : v3,
            asset_blob_id            : *0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::style_asset_blob_id_v8(v2),
            asset_sha256             : *0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::style_asset_sha256_v8(v2),
            asset_content_commitment : *0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::style_payload_commitment_v8(v2),
            source_class             : 0,
            source_definition_id     : arg0.root_id,
            source_semantic_id       : 0x1::string::utf8(b""),
            access_subject           : arg0.maker_access_pass_id,
            source_epoch             : 0,
            pricing_commitment       : arg0.maker_access_commitment,
            protected                : true,
            seal_binding_commitment  : arg11,
        };
        install_selection(arg0, v1.index, v5);
    }

    public fun selection_commitment_v8(arg0: LoadoutSelectionV8) : vector<u8> {
        let v0 = SelectionCommitmentInputV8{
            domain    : b"animacraft-v8/runtime/selection",
            version   : 8,
            selection : arg0,
        };
        0x1::hash::sha2_256(0x1::bcs::to_bytes<SelectionCommitmentInputV8>(&v0))
    }

    fun set_pack_lifecycle<T0>(arg0: &mut PackReleaseV8<T0>, arg1: u8) {
        arg0.lifecycle = arg1;
        let v0 = PackLifecycleChangedV8{
            release_id         : 0x2::object::id<PackReleaseV8<T0>>(arg0),
            previous_lifecycle : arg0.lifecycle,
            lifecycle          : arg1,
        };
        0x2::event::emit<PackLifecycleChangedV8>(v0);
    }

    public fun settle_paid_pack_complete_line_v8<T0>(arg0: PackCompleteLineV8, arg1: &PackReleaseV8<T0>, arg2: &mut PackTreasuryV8<T0>, arg3: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerRootV8<T0>, arg4: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::protocol_config_v8::ProtocolConfigV8, arg5: &mut 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::protocol_config_v8::ProtocolTreasuryV8<T0>, arg6: 0x2::coin::Coin<T0>, arg7: &mut 0x2::tx_context::TxContext) : (0x2::object::ID, u64) {
        let (v0, v1, v2, v3, v4, v5, v6, v7) = consume_pack_complete_line_v8(arg0);
        let v8 = v3;
        assert!(v0 == 0x2::object::id<PackReleaseV8<T0>>(arg1), 0);
        assert!(v4 == arg1.content_commitment, 0);
        assert!(v5 == 0x2::tx_context::sender(arg7), 8);
        assert_root_compatibility<T0>(v1, v2, &v8, arg3);
        0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::assert_current_protocol_config_v8<T0>(arg3, arg4);
        assert_treasury<T0>(arg1, arg2);
        assert!(v7 > 0 && 0x2::coin::value<T0>(&arg6) == v7, 17);
        let v9 = 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::root_economics_v8<T0>(arg3);
        let v10 = protocol_share(v7, 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::economics_primary_content_fee_bps_v8(&v9));
        if (v10 > 0) {
            0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::protocol_config_v8::deposit_protocol_revenue_v8<T0>(arg4, arg5, 0x2::coin::split<T0>(&mut arg6, v10, arg7));
        };
        assert!(0x2::coin::value<T0>(&arg6) == v7 - v10, 17);
        deposit_pack_revenue_v8<T0>(arg1, arg2, arg6);
        (v0, v6)
    }

    public fun share_external_item_product_v8(arg0: ExternalItemProductV8) {
        0x2::transfer::share_object<ExternalItemProductV8>(arg0);
    }

    public fun share_pack_registry_v8(arg0: PackRegistryV8) {
        0x2::transfer::share_object<PackRegistryV8>(arg0);
    }

    public fun share_pack_release_v8<T0>(arg0: PackReleaseV8<T0>) {
        0x2::transfer::share_object<PackReleaseV8<T0>>(arg0);
    }

    public fun share_pack_treasury_v8<T0>(arg0: PackTreasuryV8<T0>) {
        0x2::transfer::share_object<PackTreasuryV8<T0>>(arg0);
    }

    public fun share_runtime_definition_registry_v8(arg0: RuntimeDefinitionRegistryV8) {
        0x2::transfer::share_object<RuntimeDefinitionRegistryV8>(arg0);
    }

    public fun source_base_v8() : u8 {
        0
    }

    public fun source_external_v8() : u8 {
        2
    }

    public fun source_pack_v8() : u8 {
        1
    }

    public fun style_seal_asset_key_v8(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String) : 0x1::string::String {
        assert_key(&arg0);
        assert_key(&arg1);
        assert_key(&arg2);
        let v0 = 0x1::string::into_bytes(arg0);
        0x1::vector::push_back<u8>(&mut v0, 47);
        0x1::vector::append<u8>(&mut v0, 0x1::string::into_bytes(arg1));
        0x1::vector::push_back<u8>(&mut v0, 47);
        0x1::vector::append<u8>(&mut v0, 0x1::string::into_bytes(arg2));
        0x1::string::utf8(v0)
    }

    public fun transfer_external_item_admin_cap_v8(arg0: ExternalItemAdminCapV8, arg1: address) {
        assert!(arg1 != @0x0 && arg0.owner == arg1, 29);
        0x2::transfer::transfer<ExternalItemAdminCapV8>(arg0, arg1);
    }

    public fun transfer_external_item_control_v8(arg0: &mut ExternalItemProductV8, arg1: ExternalItemAdminCapV8, arg2: address, arg3: &0x2::tx_context::TxContext) {
        assert_product_control(arg0, &arg1, arg3);
        assert!(arg2 != @0x0 && arg2 != arg0.owner, 26);
        arg0.owner = arg2;
        arg0.control_epoch = arg0.control_epoch + 1;
        arg1.owner = arg2;
        arg1.control_epoch = arg0.control_epoch;
        0x2::transfer::transfer<ExternalItemAdminCapV8>(arg1, arg2);
    }

    public fun transfer_maker_loadout_to_holder_v8(arg0: MakerLoadoutV8) {
        0x2::transfer::transfer<MakerLoadoutV8>(arg0, arg0.holder);
    }

    public fun transfer_new_owned_item_to_holder_v8(arg0: OwnedExternalItemV8) {
        0x2::transfer::transfer<OwnedExternalItemV8>(arg0, arg0.holder);
    }

    public fun transfer_owned_external_item_v8(arg0: OwnedExternalItemV8, arg1: address, arg2: &0x2::tx_context::TxContext) {
        let v0 = &mut arg0;
        prepare_owned_item_transfer(v0, arg1, arg2);
        0x2::transfer::transfer<OwnedExternalItemV8>(arg0, arg1);
    }

    public fun transfer_pack_admin_cap_v8(arg0: PackAdminCapV8, arg1: address) {
        assert!(arg1 != @0x0, 26);
        assert!(arg0.owner == arg1, 29);
        0x2::transfer::transfer<PackAdminCapV8>(arg0, arg1);
    }

    public fun transfer_pack_admission_authority_v8(arg0: PackAdmissionAuthorityV8, arg1: address) {
        assert!(arg1 != @0x0, 26);
        0x2::transfer::transfer<PackAdmissionAuthorityV8>(arg0, arg1);
    }

    public fun transfer_pack_control_v8<T0>(arg0: &mut PackReleaseV8<T0>, arg1: PackAdminCapV8, arg2: address, arg3: &0x2::tx_context::TxContext) {
        assert_pack_control<T0>(arg0, &arg1, arg3);
        assert!(arg2 != @0x0 && arg2 != arg0.owner, 26);
        arg0.owner = arg2;
        arg0.control_epoch = arg0.control_epoch + 1;
        arg1.owner = arg2;
        arg1.control_epoch = arg0.control_epoch;
        0x2::transfer::transfer<PackAdminCapV8>(arg1, arg2);
    }

    public fun transfer_pack_pass_to_holder_v8(arg0: PackPassV8) {
        0x2::transfer::transfer<PackPassV8>(arg0, arg0.holder);
    }

    public fun unequip_external_style_v8(arg0: &mut MakerLoadoutV8, arg1: &mut OwnedExternalItemV8, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert_loadout_holder_revision(arg0, arg2, arg3);
        assert_owned_holder(arg1, arg3);
        let v0 = 0x1::option::destroy_some<EquipLockV8>(arg1.equip_lock);
        assert!(v0.loadout_id == 0x2::object::id<MakerLoadoutV8>(arg0), 19);
        let v1 = 0x1::option::borrow<LoadoutSelectionV8>(0x1::vector::borrow<0x1::option::Option<LoadoutSelectionV8>>(&arg0.selections, v0.selection_index));
        assert!(v1.source_class == 2, 19);
        assert!(v1.access_subject == 0x2::object::id<OwnedExternalItemV8>(arg1), 19);
        clear_selection(arg0, v0.selection_index);
        let v2 = ExternalItemEquipChangedV8{
            item_id    : 0x2::object::id<OwnedExternalItemV8>(arg1),
            loadout_id : 0x2::object::id<MakerLoadoutV8>(arg0),
            revision   : arg0.revision,
            equipped   : false,
        };
        0x2::event::emit<ExternalItemEquipChangedV8>(v2);
    }

    fun used_pack_contains(arg0: &vector<UsedPackV8>, arg1: 0x2::object::ID) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<UsedPackV8>(arg0)) {
            if (0x1::vector::borrow<UsedPackV8>(arg0, v0).release_id == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun used_pack_content_commitment_v8(arg0: &UsedPackV8) : &vector<u8> {
        &arg0.release_content_commitment
    }

    public fun used_pack_pricing_commitment_v8(arg0: &UsedPackV8) : &vector<u8> {
        &arg0.pricing_commitment
    }

    public fun used_pack_release_id_v8(arg0: &UsedPackV8) : 0x2::object::ID {
        arg0.release_id
    }

    public fun used_pack_semantic_id_v8(arg0: &UsedPackV8) : &0x1::string::String {
        &arg0.semantic_pack_id
    }

    public fun version_v8() : u64 {
        8
    }

    public fun wardrobe_fixed_v8() : u8 {
        0
    }

    public fun wardrobe_slot_v8() : u8 {
        1
    }

    public fun withdraw_pack_revenue_v8<T0>(arg0: &PackReleaseV8<T0>, arg1: &PackAdminCapV8, arg2: &mut PackTreasuryV8<T0>, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert_pack_control<T0>(arg0, arg1, arg5);
        assert_treasury<T0>(arg0, arg2);
        assert!(arg4 != @0x0, 26);
        assert!(arg3 > 0 && arg3 <= 0x2::balance::value<T0>(&arg2.revenue), 25);
        arg2.total_withdrawn = arg2.total_withdrawn + arg3;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg2.revenue, arg3, arg5), arg4);
    }

    // decompiled from Move bytecode v7
}

