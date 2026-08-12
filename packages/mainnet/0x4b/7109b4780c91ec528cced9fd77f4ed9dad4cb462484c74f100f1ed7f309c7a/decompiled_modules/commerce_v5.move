module 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5 {
    struct CommerceProtocolConfigV5 has key {
        id: 0x2::object::UID,
        version: u64,
        legacy_config_id: 0x2::object::ID,
        legacy_admin_cap_id: 0x2::object::ID,
        treasury_id: 0x2::object::ID,
        payment_coin_type: 0x1::string::String,
        primary_protocol_fee_bps: u16,
        fixed_complete_fee_atomic: u64,
        maker_market_fee_bps: u16,
        logical_auxiliary_blob_id: 0x1::option::Option<0x1::string::String>,
        soul_binding_proof_type: 0x1::option::Option<0x1::string::String>,
        enabled: bool,
    }

    struct CommerceProtocolTreasuryV5<phantom T0> has key {
        id: 0x2::object::UID,
        version: u64,
        config_id: 0x2::object::ID,
        revenue: 0x2::balance::Balance<T0>,
        total_primary_collected: u64,
        total_fixed_collected: u64,
        total_market_collected: u64,
        total_withdrawn: u64,
    }

    struct CompletionPolicyV5 has copy, drop, store {
        mode: u8,
        free_quota_per_wallet: u64,
        price_atomic: u64,
        total_cap: u64,
    }

    struct PackKeyV5 has copy, drop, store {
        name: 0x1::string::String,
    }

    struct PackRecordV5 has copy, drop, store {
        key: 0x1::string::String,
        label: 0x1::string::String,
        access_kind: u8,
        purchase_price_atomic: u64,
        complete_policy: CompletionPolicyV5,
        active: bool,
        entitlement_count: u64,
        complete_count: u64,
        style_count: u64,
        protected_style_count: u64,
    }

    struct StyleBindingKeyV5 has copy, drop, store {
        part_key: 0x1::string::String,
        item_key: 0x1::string::String,
        style_key: 0x1::string::String,
    }

    struct StyleProductRecordV5 has copy, drop, store {
        pack_key: 0x1::option::Option<0x1::string::String>,
        asset_blob_id: 0x1::string::String,
        row_kind: u8,
        seal_protected: bool,
    }

    struct StyleSelectionV5 has copy, drop, store {
        part_key: 0x1::string::String,
        item_key: 0x1::string::String,
        style_key: 0x1::string::String,
    }

    struct CompleteSelectionHashInputV5 has copy, drop, store {
        recipe: vector<0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::RecipeSlot>,
        style_selections: vector<StyleSelectionV5>,
    }

    struct EntitlementKeyV5 has copy, drop, store {
        pack_key: 0x1::string::String,
        wallet: address,
    }

    struct EntitlementRecordV5 has copy, drop, store {
        granted_at_ms: u64,
        paid_atomic: u64,
        ownership_epoch: u64,
    }

    struct CompletionCountKeyV5 has copy, drop, store {
        wallet: address,
        product_kind: u8,
        product_key: 0x1::string::String,
    }

    struct CompleteOutputRecordV5 has copy, drop, store {
        seal_id: vector<u8>,
        payer: address,
        recipe_hash: vector<u8>,
        output_nonce: vector<u8>,
        output_digest: vector<u8>,
        ciphertext_blob_id: 0x1::string::String,
        bound_soul_id: 0x1::option::Option<0x2::object::ID>,
    }

    struct CompleteOutputIdentityV5 has copy, drop, store {
        root_id: 0x2::object::ID,
        payer: address,
        recipe_hash: vector<u8>,
        output_nonce: vector<u8>,
        output_digest: vector<u8>,
    }

    struct CompleteOutputSoulBindingV5 {
        root_id: 0x2::object::ID,
        seal_id: vector<u8>,
    }

    struct MakerRootReleaseStateV5 has store {
        pack_count: u64,
        paid_pack_count: u64,
        style_count: u64,
        style_registry_sealed: bool,
        protected_style_count: u64,
        seal_policy_id: 0x1::option::Option<0x2::object::ID>,
        seal_release_commitment: vector<u8>,
        complete_output_count: u64,
        total_completes: u64,
    }

    struct MakerReleaseEvidenceV5 has copy, drop, store {
        parent_version: 0x1::string::String,
        manifest_blob_id: 0x1::string::String,
        manifest_sha256: vector<u8>,
    }

    struct MakerRootV5 has key {
        id: 0x2::object::UID,
        version: u64,
        legacy_maker_id: 0x2::object::ID,
        legacy_treasury_id: 0x2::object::ID,
        control_vault_id: 0x2::object::ID,
        treasury_id: 0x2::object::ID,
        protocol_config_id: 0x2::object::ID,
        payment_coin_type: 0x1::string::String,
        original_creator: address,
        current_owner: address,
        rights_origin: u8,
        lifecycle: u8,
        ownership_epoch: u64,
        current_control_cap_id: 0x1::option::Option<0x2::object::ID>,
        active_listing_id: 0x1::option::Option<0x2::object::ID>,
        soul_creator_royalty_bps: u16,
        maker_resale_royalty_bps: u16,
        base_access_kind: u8,
        base_purchase_price_atomic: u64,
        base_policy: CompletionPolicyV5,
        packs: 0x2::table::Table<PackKeyV5, PackRecordV5>,
        pack_keys: vector<0x1::string::String>,
        style_registry: 0x2::table::Table<StyleBindingKeyV5, StyleProductRecordV5>,
        style_keys: vector<StyleBindingKeyV5>,
        logical_auxiliary_blob_id: 0x1::string::String,
        base_entitlement_registry: 0x2::table::Table<address, EntitlementRecordV5>,
        entitlement_registry: 0x2::table::Table<EntitlementKeyV5, EntitlementRecordV5>,
        completion_counts: 0x2::table::Table<CompletionCountKeyV5, u64>,
        complete_outputs: 0x2::table::Table<vector<u8>, CompleteOutputRecordV5>,
        release: MakerRootReleaseStateV5,
    }

    struct MakerTreasuryV5<phantom T0> has key {
        id: 0x2::object::UID,
        version: u64,
        root_id: 0x2::object::ID,
        revenue: 0x2::balance::Balance<T0>,
        total_pack_collected: u64,
        total_complete_collected: u64,
        total_withdrawn: u64,
    }

    struct MakerControlVaultV5 has key {
        id: 0x2::object::UID,
        version: u64,
        root_id: 0x2::object::ID,
        legacy_maker_id: 0x2::object::ID,
        legacy_admin_cap: 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::MakerAdminCap,
    }

    struct MakerControlCapV5 has key {
        id: 0x2::object::UID,
        version: u64,
        root_id: 0x2::object::ID,
        ownership_epoch: u64,
    }

    struct MakerAccessPassV5 has key {
        id: 0x2::object::UID,
        version: u64,
        root_id: 0x2::object::ID,
        holder: address,
        issued_at_ms: u64,
        ownership_epoch: u64,
    }

    struct PackPassV5 has key {
        id: 0x2::object::UID,
        version: u64,
        root_id: 0x2::object::ID,
        pack_key: 0x1::string::String,
        holder: address,
        issued_at_ms: u64,
        ownership_epoch: u64,
    }

    struct MakerListingV5 has key {
        id: 0x2::object::UID,
        version: u64,
        root_id: 0x2::object::ID,
        seller: address,
        price_atomic: u64,
        ownership_epoch: u64,
        protocol_fee_bps: u16,
        maker_resale_royalty_bps: u16,
        active: bool,
    }

    struct CompleteQuoteV5 has copy, drop, store {
        creator_charge_atomic: u64,
        protocol_percentage_atomic: u64,
        fixed_protocol_fee_atomic: u64,
        maker_receives_atomic: u64,
        total_due_atomic: u64,
        used_pack_count: u64,
    }

    struct CommerceV5SoulMintAuthorization {
        canonical: 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::CanonicalSoulMintAuthorization,
        soul_creator_royalty_bps: u16,
        output_binding: CompleteOutputSoulBindingV5,
    }

    struct CommerceProtocolV5Initialized has copy, drop {
        config_id: 0x2::object::ID,
        treasury_id: 0x2::object::ID,
        legacy_config_id: 0x2::object::ID,
        payment_coin_type: 0x1::string::String,
        enabled: bool,
    }

    struct LogicalAuxiliaryBlobBoundV5 has copy, drop {
        config_id: 0x2::object::ID,
        blob_id: 0x1::string::String,
    }

    struct SoulBindingProofTypeBoundV5 has copy, drop {
        config_id: 0x2::object::ID,
        proof_type: 0x1::string::String,
    }

    struct LegacyMakerMigratedToV5 has copy, drop {
        root_id: 0x2::object::ID,
        legacy_maker_id: 0x2::object::ID,
        legacy_treasury_id: 0x2::object::ID,
        treasury_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        control_cap_id: 0x2::object::ID,
        owner: address,
        rights_origin: u8,
        soul_creator_royalty_bps: u16,
        maker_resale_royalty_bps: u16,
    }

    struct MakerLifecycleChangedV5 has copy, drop {
        root_id: 0x2::object::ID,
        owner: address,
        previous: u8,
        current: u8,
        ownership_epoch: u64,
    }

    struct PackConfiguredV5 has copy, drop {
        root_id: 0x2::object::ID,
        pack_key: 0x1::string::String,
        access_kind: u8,
        active: bool,
    }

    struct PackEntitlementGrantedV5 has copy, drop {
        root_id: 0x2::object::ID,
        pack_key: 0x1::string::String,
        holder: address,
        paid_atomic: u64,
        pack_pass_id: 0x2::object::ID,
    }

    struct MakerAccessGrantedV5 has copy, drop {
        root_id: 0x2::object::ID,
        holder: address,
        paid_atomic: u64,
        access_pass_id: 0x2::object::ID,
    }

    struct CompleteAuthorizedV5 has copy, drop {
        root_id: 0x2::object::ID,
        legacy_maker_id: 0x2::object::ID,
        payer: address,
        creator_charge_atomic: u64,
        protocol_percentage_atomic: u64,
        fixed_protocol_fee_atomic: u64,
        total_paid_atomic: u64,
        ownership_epoch: u64,
        output_seal_id: vector<u8>,
        output_nonce: vector<u8>,
        output_digest: vector<u8>,
        ciphertext_blob_id: 0x1::string::String,
    }

    struct CompleteOutputBoundToSoulV5 has copy, drop {
        root_id: 0x2::object::ID,
        seal_id: vector<u8>,
        soul_id: 0x2::object::ID,
        payer: address,
    }

    struct MakerListingOpenedV5 has copy, drop {
        root_id: 0x2::object::ID,
        listing_id: 0x2::object::ID,
        seller: address,
        price_atomic: u64,
        ownership_epoch: u64,
    }

    struct MakerListingCancelledV5 has copy, drop {
        root_id: 0x2::object::ID,
        listing_id: 0x2::object::ID,
        seller: address,
        control_cap_id: 0x2::object::ID,
    }

    struct MakerPurchasedV5 has copy, drop {
        root_id: 0x2::object::ID,
        listing_id: 0x2::object::ID,
        seller: address,
        buyer: address,
        price_atomic: u64,
        protocol_fee_atomic: u64,
        original_creator_royalty_atomic: u64,
        ownership_epoch: u64,
        control_cap_id: 0x2::object::ID,
    }

    struct MakerReleaseEvidenceBoundV5 has copy, drop {
        root_id: 0x2::object::ID,
        legacy_maker_id: 0x2::object::ID,
        parent_version: 0x1::string::String,
        manifest_blob_id: 0x1::string::String,
        manifest_sha256: vector<u8>,
        newly_bound: bool,
    }

    public fun activate_maker_v5(arg0: &mut MakerRootV5, arg1: &MakerControlCapV5, arg2: &0x2::tx_context::TxContext) {
        assert_control(arg0, arg1, arg2);
        assert!(arg0.lifecycle == 1 || arg0.lifecycle == 2, 1);
        assert!(arg0.release.style_registry_sealed, 34);
        if (requires_seal_policy(arg0)) {
            assert!(0x1::option::is_some<0x2::object::ID>(&arg0.release.seal_policy_id) && 0x1::vector::length<u8>(&arg0.release.seal_release_commitment) == 32, 36);
        };
        set_lifecycle(arg0, 0);
    }

    public fun add_pack_v5(arg0: &mut MakerRootV5, arg1: &MakerControlCapV5, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u8, arg5: u64, arg6: CompletionPolicyV5, arg7: &0x2::tx_context::TxContext) {
        assert_control(arg0, arg1, arg7);
        assert_configurable(arg0);
        assert_release_terms_mutable(arg0);
        assert_non_empty(&arg2);
        assert_non_empty(&arg3);
        assert_valid_pack_access(arg4, arg5);
        assert_valid_policy(&arg6);
        let v0 = PackKeyV5{name: arg2};
        assert!(!0x2::table::contains<PackKeyV5, PackRecordV5>(&arg0.packs, v0), 13);
        let v1 = PackRecordV5{
            key                   : arg2,
            label                 : arg3,
            access_kind           : arg4,
            purchase_price_atomic : arg5,
            complete_policy       : arg6,
            active                : true,
            entitlement_count     : 0,
            complete_count        : 0,
            style_count           : 0,
            protected_style_count : 0,
        };
        0x2::table::add<PackKeyV5, PackRecordV5>(&mut arg0.packs, v0, v1);
        0x1::vector::push_back<0x1::string::String>(&mut arg0.pack_keys, arg2);
        arg0.release.pack_count = arg0.release.pack_count + 1;
        if (arg4 == 1) {
            arg0.release.paid_pack_count = arg0.release.paid_pack_count + 1;
        };
        let v2 = PackConfiguredV5{
            root_id     : 0x2::object::id<MakerRootV5>(arg0),
            pack_key    : arg2,
            access_kind : arg4,
            active      : true,
        };
        0x2::event::emit<PackConfiguredV5>(v2);
    }

    public fun archive_maker_v5(arg0: &mut MakerRootV5, arg1: &MakerControlCapV5, arg2: &0x2::tx_context::TxContext) {
        assert_control(arg0, arg1, arg2);
        assert!(arg0.lifecycle == 0 || arg0.lifecycle == 1, 1);
        set_lifecycle(arg0, 2);
    }

    fun assert_base_access(arg0: &MakerRootV5, arg1: address) {
        if (arg0.base_access_kind == 1) {
            assert!(0x2::table::contains<address, EntitlementRecordV5>(&arg0.base_entitlement_registry, arg1), 17);
        };
    }

    fun assert_complete_metadata(arg0: &0x1::string::String, arg1: &0x1::string::String, arg2: &0x1::string::String, arg3: &0x1::string::String, arg4: &vector<u8>, arg5: &vector<0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::RecipeSlot>, arg6: &vector<StyleSelectionV5>) {
        assert_non_empty(arg0);
        assert_non_empty(arg1);
        assert_non_empty(arg2);
        assert_non_empty(arg3);
        assert!(0x1::vector::length<0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::RecipeSlot>(arg5) > 0, 29);
        assert!(0x1::vector::length<u8>(arg4) == 32, 29);
        let v0 = hash_complete_selection_v5(arg5, arg6);
        assert!(arg4 == &v0, 29);
    }

    fun assert_complete_output_metadata(arg0: &MakerRootV5, arg1: address, arg2: &vector<u8>, arg3: &0x1::string::String, arg4: &vector<u8>, arg5: &vector<u8>, arg6: &vector<u8>) {
        assert_non_empty(arg3);
        let v0 = if (0x1::vector::length<u8>(arg4) == 32) {
            if (0x1::vector::length<u8>(arg5) == 32) {
                if (0x1::vector::length<u8>(arg6) == 32) {
                    0x1::vector::length<u8>(arg2) == 32
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 41);
        assert!(*arg4 == derive_complete_output_seal_id_v5(0x2::object::id<MakerRootV5>(arg0), arg1, *arg2, *arg5, *arg6), 41);
        assert!(!0x2::table::contains<vector<u8>, CompleteOutputRecordV5>(&arg0.complete_outputs, *arg4), 42);
    }

    fun assert_configurable(arg0: &MakerRootV5) {
        assert!(arg0.lifecycle == 1 || arg0.lifecycle == 2, 1);
        assert!(0x1::option::is_none<0x2::object::ID>(&arg0.active_listing_id), 1);
    }

    fun assert_control(arg0: &MakerRootV5, arg1: &MakerControlCapV5, arg2: &0x2::tx_context::TxContext) {
        assert!(arg1.root_id == 0x2::object::id<MakerRootV5>(arg0), 9);
        assert!(arg1.ownership_epoch == arg0.ownership_epoch, 9);
        assert!(0x1::option::is_some<0x2::object::ID>(&arg0.current_control_cap_id), 9);
        assert!(*0x1::option::borrow<0x2::object::ID>(&arg0.current_control_cap_id) == 0x2::object::id<MakerControlCapV5>(arg1), 9);
        assert!(arg0.current_owner == 0x2::tx_context::sender(arg2), 10);
    }

    public fun assert_extension_control_v5(arg0: &MakerRootV5, arg1: &MakerControlCapV5, arg2: &0x2::tx_context::TxContext) {
        assert_control(arg0, arg1, arg2);
    }

    public(friend) fun assert_extension_maker_release_evidence_v5(arg0: &MakerRootV5, arg1: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::OCMaker, arg2: &0x1::string::String, arg3: &0x1::string::String, arg4: &vector<u8>) {
        assert_legacy_maker(arg0, arg1);
        assert!(0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::maker_manifest_blob_id(arg1) == arg3, 51);
        let v0 = root_maker_release_evidence_v5(arg0);
        let v1 = if (&v0.parent_version == arg2) {
            if (&v0.manifest_blob_id == arg3) {
                &v0.manifest_sha256 == arg4
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 51);
    }

    public fun assert_extension_operational_v5(arg0: &MakerRootV5, arg1: &CommerceProtocolConfigV5) {
        assert_operational(arg0, arg1);
    }

    public(friend) fun assert_extension_protocol_admin_v5(arg0: &CommerceProtocolConfigV5, arg1: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::ProtocolFeeAdminCap) {
        assert_protocol_admin(arg0, arg1);
    }

    public fun assert_extension_protocol_enabled_v5(arg0: &CommerceProtocolConfigV5) {
        assert!(arg0.enabled, 6);
        assert_protocol_dependencies_bound(arg0);
    }

    public(friend) fun assert_extension_soul_binding_proof_type_v5<T0: drop>(arg0: &CommerceProtocolConfigV5) {
        assert!(0x1::option::is_some<0x1::string::String>(&arg0.soul_binding_proof_type), 49);
        let v0 = defining_type_name<T0>();
        assert!(&v0 == 0x1::option::borrow<0x1::string::String>(&arg0.soul_binding_proof_type), 50);
    }

    fun assert_legacy_maker(arg0: &MakerRootV5, arg1: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::OCMaker) {
        assert!(arg0.legacy_maker_id == 0x2::object::id<0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::OCMaker>(arg1), 7);
    }

    fun assert_listing(arg0: &MakerRootV5, arg1: &MakerListingV5) {
        assert!(arg0.lifecycle == 3, 1);
        assert!(arg1.root_id == 0x2::object::id<MakerRootV5>(arg0), 23);
        assert!(arg1.ownership_epoch == arg0.ownership_epoch, 23);
        assert!(0x1::option::is_some<0x2::object::ID>(&arg0.active_listing_id), 23);
        assert!(*0x1::option::borrow<0x2::object::ID>(&arg0.active_listing_id) == 0x2::object::id<MakerListingV5>(arg1), 23);
    }

    fun assert_maker_treasury<T0>(arg0: &MakerRootV5, arg1: &MakerTreasuryV5<T0>) {
        assert!(0x2::object::id<MakerTreasuryV5<T0>>(arg1) == arg0.treasury_id && arg1.root_id == 0x2::object::id<MakerRootV5>(arg0), 11);
        let v0 = payment_coin_type_name<T0>();
        assert!(&v0 == &arg0.payment_coin_type, 8);
    }

    fun assert_non_empty(arg0: &0x1::string::String) {
        assert!(0x1::vector::length<u8>(0x1::string::as_bytes(arg0)) > 0, 4);
    }

    fun assert_operational(arg0: &MakerRootV5, arg1: &CommerceProtocolConfigV5) {
        assert!(arg0.lifecycle == 0, 1);
        assert!(arg1.enabled, 6);
        assert_protocol_dependencies_bound(arg1);
        assert!(arg0.protocol_config_id == 0x2::object::id<CommerceProtocolConfigV5>(arg1), 7);
        assert!(&arg0.payment_coin_type == &arg1.payment_coin_type, 8);
    }

    fun assert_payment_linkage<T0>(arg0: &MakerRootV5, arg1: &MakerTreasuryV5<T0>, arg2: &CommerceProtocolConfigV5, arg3: &CommerceProtocolTreasuryV5<T0>) {
        assert_maker_treasury<T0>(arg0, arg1);
        assert_protocol_treasury<T0>(arg2, arg3);
        assert!(arg0.protocol_config_id == 0x2::object::id<CommerceProtocolConfigV5>(arg2), 7);
        assert!(&arg0.payment_coin_type == &arg2.payment_coin_type, 8);
    }

    fun assert_policy_total_capacity(arg0: &CompletionPolicyV5, arg1: u64) {
        if (arg0.total_cap > 0) {
            assert!(arg1 < arg0.total_cap, 19);
        };
    }

    fun assert_protocol_admin(arg0: &CommerceProtocolConfigV5, arg1: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::ProtocolFeeAdminCap) {
        assert!(0x2::object::id<0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::ProtocolFeeAdminCap>(arg1) == arg0.legacy_admin_cap_id && 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::protocol_fee_admin_config_id(arg1) == arg0.legacy_config_id, 5);
    }

    fun assert_protocol_dependencies_bound(arg0: &CommerceProtocolConfigV5) {
        assert!(0x1::option::is_some<0x1::string::String>(&arg0.logical_auxiliary_blob_id) && 0x1::option::is_some<0x1::string::String>(&arg0.soul_binding_proof_type), 49);
    }

    fun assert_protocol_treasury<T0>(arg0: &CommerceProtocolConfigV5, arg1: &CommerceProtocolTreasuryV5<T0>) {
        assert!(0x2::object::id<CommerceProtocolTreasuryV5<T0>>(arg1) == arg0.treasury_id && arg1.config_id == 0x2::object::id<CommerceProtocolConfigV5>(arg0), 7);
        let v0 = payment_coin_type_name<T0>();
        assert!(&v0 == &arg0.payment_coin_type, 8);
    }

    fun assert_release_terms_mutable(arg0: &MakerRootV5) {
        assert!(!arg0.release.style_registry_sealed && arg0.release.style_count == 0, 30);
    }

    fun assert_style_row_identity(arg0: &0x1::string::String, arg1: &0x1::string::String, arg2: &0x1::string::String, arg3: &0x1::option::Option<0x1::string::String>, arg4: u8) {
        assert_valid_style_row_kind(arg4);
        let v0 = 0x1::string::utf8(b"__animacraft_none__");
        let v1 = 0x1::string::utf8(b"__animacraft_color__:");
        if (arg4 == 0) {
            let v2 = if (arg1 != arg0) {
                if (!(arg2 == &v0)) {
                    !has_non_empty_string_prefix(arg2, &v1)
                } else {
                    false
                }
            } else {
                false
            };
            assert!(v2, 47);
        } else {
            assert!(0x1::option::is_none<0x1::string::String>(arg3) && arg1 == arg0, 47);
            if (arg4 == 1) {
                assert!(arg2 == &v0, 47);
            } else {
                assert!(has_non_empty_string_prefix(arg2, &v1), 47);
            };
        };
    }

    fun assert_style_selection_alignment(arg0: &MakerRootV5, arg1: &vector<0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::RecipeSlot>, arg2: &vector<StyleSelectionV5>) {
        assert!(arg0.release.style_registry_sealed, 34);
        assert!(0x1::vector::length<StyleSelectionV5>(arg2) == 0x1::vector::length<0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::RecipeSlot>(arg1), 33);
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::RecipeSlot>(arg1)) {
            let v1 = 0x1::vector::borrow<0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::RecipeSlot>(arg1, v0);
            let v2 = 0x1::vector::borrow<StyleSelectionV5>(arg2, v0);
            assert!(0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::recipe_slot_part_key(v1) == &v2.part_key && 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::recipe_slot_item_key(v1) == &v2.item_key, 33);
            let v3 = StyleBindingKeyV5{
                part_key  : v2.part_key,
                item_key  : v2.item_key,
                style_key : v2.style_key,
            };
            assert!(0x2::table::contains<StyleBindingKeyV5, StyleProductRecordV5>(&arg0.style_registry, v3), 32);
            v0 = v0 + 1;
        };
    }

    fun assert_valid_completion_policy(arg0: u8, arg1: u64, arg2: u64) {
        assert!(arg0 <= 3, 2);
        if (arg0 == 0) {
            assert!(arg1 == 0 && arg2 == 0, 2);
        } else if (arg0 == 1) {
            assert!(arg1 > 0 && arg2 > 0, 2);
        } else if (arg0 == 2) {
            assert!(arg1 == 0 && arg2 > 0, 2);
        } else {
            assert!(arg1 > 0 && arg2 == 0, 2);
        };
    }

    fun assert_valid_maker_resale_royalty(arg0: u16) {
        assert!(arg0 <= 500 && arg0 % 50 == 0, 26);
    }

    fun assert_valid_pack_access(arg0: u8, arg1: u64) {
        assert!(arg0 <= 1, 3);
        if (arg0 == 0) {
            assert!(arg1 == 0, 3);
        } else {
            assert!(arg1 > 0, 3);
        };
    }

    fun assert_valid_policy(arg0: &CompletionPolicyV5) {
        assert_valid_completion_policy(arg0.mode, arg0.free_quota_per_wallet, arg0.price_atomic);
    }

    fun assert_valid_rights_origin(arg0: u8) {
        assert!(arg0 == 0 || arg0 == 1, 0);
    }

    fun assert_valid_soul_creator_royalty(arg0: u16) {
        assert!(arg0 <= 500 && arg0 % 50 == 0, 26);
    }

    fun assert_valid_style_row_kind(arg0: u8) {
        let v0 = if (arg0 == 0) {
            true
        } else if (arg0 == 1) {
            true
        } else {
            arg0 == 2
        };
        assert!(v0, 46);
    }

    public fun authorize_complete_free_v5(arg0: &mut MakerRootV5, arg1: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::OCMaker, arg2: &CommerceProtocolConfigV5, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: vector<u8>, arg8: vector<u8>, arg9: vector<u8>, arg10: vector<u8>, arg11: vector<0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::RecipeSlot>, arg12: vector<StyleSelectionV5>, arg13: &0x2::clock::Clock, arg14: &0x2::tx_context::TxContext) : CommerceV5SoulMintAuthorization {
        assert_operational(arg0, arg2);
        assert_complete_metadata(&arg3, &arg4, &arg5, &arg6, &arg10, &arg11, &arg12);
        assert_complete_output_metadata(arg0, 0x2::tx_context::sender(arg14), &arg10, &arg5, &arg7, &arg8, &arg9);
        let (v0, v1) = build_complete_quote(arg0, arg1, arg2, &arg11, &arg12, 0x2::tx_context::sender(arg14));
        let v2 = v1;
        let v3 = v0;
        assert!(v3.total_due_atomic == 0, 21);
        record_complete(arg0, 0x2::tx_context::sender(arg14), &v2);
        record_complete_output(arg0, 0x2::tx_context::sender(arg14), &arg10, arg7, arg8, arg9, &arg5);
        new_complete_authorization(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg10, arg11, v3, arg7, arg8, arg9, arg13, arg14)
    }

    public fun authorize_complete_paid_v5<T0>(arg0: &mut MakerRootV5, arg1: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::OCMaker, arg2: &mut MakerTreasuryV5<T0>, arg3: &CommerceProtocolConfigV5, arg4: &mut CommerceProtocolTreasuryV5<T0>, arg5: 0x2::coin::Coin<T0>, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: vector<u8>, arg11: vector<u8>, arg12: vector<u8>, arg13: vector<u8>, arg14: vector<0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::RecipeSlot>, arg15: vector<StyleSelectionV5>, arg16: &0x2::clock::Clock, arg17: &mut 0x2::tx_context::TxContext) : CommerceV5SoulMintAuthorization {
        assert_operational(arg0, arg3);
        assert_payment_linkage<T0>(arg0, arg2, arg3, arg4);
        assert_complete_metadata(&arg6, &arg7, &arg8, &arg9, &arg13, &arg14, &arg15);
        assert_complete_output_metadata(arg0, 0x2::tx_context::sender(arg17), &arg13, &arg8, &arg10, &arg11, &arg12);
        let (v0, v1) = build_complete_quote(arg0, arg1, arg3, &arg14, &arg15, 0x2::tx_context::sender(arg17));
        let v2 = v1;
        let v3 = v0;
        assert!(v3.total_due_atomic > 0, 22);
        assert!(0x2::coin::value<T0>(&arg5) == v3.total_due_atomic, 18);
        collect_primary_payment<T0>(arg2, arg4, arg5, v3.creator_charge_atomic, v3.fixed_protocol_fee_atomic, arg17);
        arg2.total_complete_collected = arg2.total_complete_collected + v3.maker_receives_atomic;
        record_complete(arg0, 0x2::tx_context::sender(arg17), &v2);
        record_complete_output(arg0, 0x2::tx_context::sender(arg17), &arg13, arg10, arg11, arg12, &arg8);
        new_complete_authorization(arg0, arg1, arg3, arg6, arg7, arg8, arg9, arg13, arg14, v3, arg10, arg11, arg12, arg16, arg17)
    }

    public fun base_access_kind_v5(arg0: &MakerRootV5) : u8 {
        arg0.base_access_kind
    }

    public fun base_purchase_price_v5(arg0: &MakerRootV5) : u64 {
        arg0.base_purchase_price_atomic
    }

    public fun bind_complete_output_to_soul_v5<T0: drop>(arg0: &mut MakerRootV5, arg1: &CommerceProtocolConfigV5, arg2: CompleteOutputSoulBindingV5, arg3: 0x2::object::ID, arg4: T0) {
        assert!(arg0.protocol_config_id == 0x2::object::id<CommerceProtocolConfigV5>(arg1), 7);
        assert!(0x1::option::is_some<0x1::string::String>(&arg1.soul_binding_proof_type), 49);
        let v0 = defining_type_name<T0>();
        assert!(&v0 == 0x1::option::borrow<0x1::string::String>(&arg1.soul_binding_proof_type), 50);
        let CompleteOutputSoulBindingV5 {
            root_id : v1,
            seal_id : v2,
        } = arg2;
        let v3 = v2;
        let v4 = if (v1 == 0x2::object::id<MakerRootV5>(arg0)) {
            if (0x1::vector::length<u8>(&v3) == 32) {
                0x2::table::contains<vector<u8>, CompleteOutputRecordV5>(&arg0.complete_outputs, v3)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v4, 44);
        assert!(arg3 != 0x2::object::id_from_address(@0x0), 45);
        let v5 = 0x2::table::borrow_mut<vector<u8>, CompleteOutputRecordV5>(&mut arg0.complete_outputs, v3);
        assert!(v5.seal_id == v3, 44);
        assert!(0x1::option::is_none<0x2::object::ID>(&v5.bound_soul_id), 43);
        v5.bound_soul_id = 0x1::option::some<0x2::object::ID>(arg3);
        let v6 = CompleteOutputBoundToSoulV5{
            root_id : v1,
            seal_id : v3,
            soul_id : arg3,
            payer   : v5.payer,
        };
        0x2::event::emit<CompleteOutputBoundToSoulV5>(v6);
    }

    public fun bind_logical_auxiliary_blob_v5(arg0: &mut CommerceProtocolConfigV5, arg1: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::ProtocolFeeAdminCap, arg2: 0x1::string::String) {
        assert_protocol_admin(arg0, arg1);
        assert!(!arg0.enabled, 48);
        assert!(0x1::option::is_none<0x1::string::String>(&arg0.logical_auxiliary_blob_id), 48);
        assert_non_empty(&arg2);
        arg0.logical_auxiliary_blob_id = 0x1::option::some<0x1::string::String>(arg2);
        let v0 = LogicalAuxiliaryBlobBoundV5{
            config_id : 0x2::object::id<CommerceProtocolConfigV5>(arg0),
            blob_id   : arg2,
        };
        0x2::event::emit<LogicalAuxiliaryBlobBoundV5>(v0);
    }

    public fun bind_maker_release_evidence_v5(arg0: &mut MakerRootV5, arg1: &MakerControlCapV5, arg2: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::OCMaker, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: vector<u8>, arg6: &0x2::tx_context::TxContext) {
        assert_control(arg0, arg1, arg6);
        assert_legacy_maker(arg0, arg2);
        assert_non_empty(&arg3);
        assert_non_empty(&arg4);
        assert!(0x1::vector::length<u8>(&arg5) == 32, 51);
        assert!(0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::maker_manifest_blob_id(arg2) == &arg4, 51);
        let v0 = maker_release_evidence_key_v5();
        let v1 = !0x2::dynamic_field::exists<0x1::string::String>(&arg0.id, v0);
        if (v1) {
            let v2 = MakerReleaseEvidenceV5{
                parent_version   : arg3,
                manifest_blob_id : arg4,
                manifest_sha256  : arg5,
            };
            0x2::dynamic_field::add<0x1::string::String, MakerReleaseEvidenceV5>(&mut arg0.id, v0, v2);
        } else {
            let v3 = 0x2::dynamic_field::borrow<0x1::string::String, MakerReleaseEvidenceV5>(&arg0.id, v0);
            let v4 = if (&v3.parent_version == &arg3) {
                if (&v3.manifest_blob_id == &arg4) {
                    &v3.manifest_sha256 == &arg5
                } else {
                    false
                }
            } else {
                false
            };
            assert!(v4, 51);
        };
        let v5 = MakerReleaseEvidenceBoundV5{
            root_id          : 0x2::object::id<MakerRootV5>(arg0),
            legacy_maker_id  : 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::maker_id(arg2),
            parent_version   : arg3,
            manifest_blob_id : arg4,
            manifest_sha256  : arg5,
            newly_bound      : v1,
        };
        0x2::event::emit<MakerReleaseEvidenceBoundV5>(v5);
    }

    public(friend) fun bind_seal_policy_v5(arg0: &mut MakerRootV5, arg1: 0x2::object::ID, arg2: vector<u8>, arg3: u64) {
        assert_configurable(arg0);
        assert!(arg0.release.style_registry_sealed, 34);
        assert!(requires_seal_policy(arg0), 37);
        assert!(0x1::option::is_none<0x2::object::ID>(&arg0.release.seal_policy_id), 35);
        assert!(0x1::vector::length<u8>(&arg2) == 32, 38);
        assert!(arg3 > 0 && arg3 == arg0.release.protected_style_count, 40);
        arg0.release.seal_policy_id = 0x1::option::some<0x2::object::ID>(arg1);
        arg0.release.seal_release_commitment = arg2;
    }

    public fun bind_soul_binding_proof_type_v5<T0: drop>(arg0: &mut CommerceProtocolConfigV5, arg1: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::ProtocolFeeAdminCap) {
        assert_protocol_admin(arg0, arg1);
        assert!(!arg0.enabled, 48);
        assert!(0x1::option::is_none<0x1::string::String>(&arg0.soul_binding_proof_type), 48);
        let v0 = defining_type_name<T0>();
        arg0.soul_binding_proof_type = 0x1::option::some<0x1::string::String>(v0);
        let v1 = SoulBindingProofTypeBoundV5{
            config_id  : 0x2::object::id<CommerceProtocolConfigV5>(arg0),
            proof_type : v0,
        };
        0x2::event::emit<SoulBindingProofTypeBoundV5>(v1);
    }

    fun bps_amount(arg0: u64, arg1: u16) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (10000 as u128)) as u64)
    }

    fun build_complete_quote(arg0: &MakerRootV5, arg1: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::OCMaker, arg2: &CommerceProtocolConfigV5, arg3: &vector<0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::RecipeSlot>, arg4: &vector<StyleSelectionV5>, arg5: address) : (CompleteQuoteV5, vector<0x1::string::String>) {
        assert_operational(arg0, arg2);
        assert_base_access(arg0, arg5);
        assert_legacy_maker(arg0, arg1);
        0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::assert_valid_recipe_for_v5(arg1, arg3);
        assert_style_selection_alignment(arg0, arg3, arg4);
        let v0 = CompletionCountKeyV5{
            wallet       : arg5,
            product_kind : 0,
            product_key  : 0x1::string::utf8(b""),
        };
        assert_policy_total_capacity(&arg0.base_policy, arg0.release.total_completes);
        let v1 = policy_charge(&arg0.base_policy, completion_count(arg0, v0));
        let v2 = derive_used_pack_keys(arg0, arg4, arg5);
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x1::string::String>(&v2)) {
            let v4 = *0x1::vector::borrow<0x1::string::String>(&v2, v3);
            let v5 = PackKeyV5{name: v4};
            let v6 = 0x2::table::borrow<PackKeyV5, PackRecordV5>(&arg0.packs, v5);
            assert!(v6.active, 15);
            let v7 = CompletionCountKeyV5{
                wallet       : arg5,
                product_kind : 1,
                product_key  : v4,
            };
            assert_policy_total_capacity(&v6.complete_policy, v6.complete_count);
            v1 = checked_add(v1, policy_charge(&v6.complete_policy, completion_count(arg0, v7)));
            v3 = v3 + 1;
        };
        let v8 = bps_amount(v1, 1000);
        let v9 = CompleteQuoteV5{
            creator_charge_atomic      : v1,
            protocol_percentage_atomic : v8,
            fixed_protocol_fee_atomic  : arg2.fixed_complete_fee_atomic,
            maker_receives_atomic      : v1 - v8,
            total_due_atomic           : checked_add(v1, arg2.fixed_complete_fee_atomic),
            used_pack_count            : 0x1::vector::length<0x1::string::String>(&v2),
        };
        (v9, v2)
    }

    public fun buy_maker_v5<T0>(arg0: &mut MakerRootV5, arg1: &MakerTreasuryV5<T0>, arg2: &mut MakerListingV5, arg3: &CommerceProtocolConfigV5, arg4: &mut CommerceProtocolTreasuryV5<T0>, arg5: 0x2::coin::Coin<T0>, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg3.enabled, 6);
        assert_listing(arg0, arg2);
        assert!(arg2.active, 24);
        assert!(0x2::tx_context::sender(arg6) != arg2.seller, 10);
        assert!(0x2::balance::value<T0>(&arg1.revenue) == 0, 12);
        assert_maker_treasury<T0>(arg0, arg1);
        assert_protocol_treasury<T0>(arg3, arg4);
        assert!(arg0.protocol_config_id == 0x2::object::id<CommerceProtocolConfigV5>(arg3), 7);
        let v0 = payment_coin_type_name<T0>();
        assert!(&v0 == &arg0.payment_coin_type && &arg0.payment_coin_type == &arg3.payment_coin_type, 8);
        let v1 = arg2.price_atomic;
        assert!(0x2::coin::value<T0>(&arg5) == v1, 18);
        let v2 = bps_amount(v1, arg2.protocol_fee_bps);
        let v3 = bps_amount(v1, arg2.maker_resale_royalty_bps);
        assert!((v2 as u128) + (v3 as u128) <= (v1 as u128), 20);
        if (v2 > 0) {
            0x2::coin::put<T0>(&mut arg4.revenue, 0x2::coin::split<T0>(&mut arg5, v2, arg6));
            arg4.total_market_collected = arg4.total_market_collected + v2;
        };
        if (v3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg5, v3, arg6), arg0.original_creator);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg5, arg2.seller);
        arg2.active = false;
        arg0.current_owner = 0x2::tx_context::sender(arg6);
        arg0.ownership_epoch = arg0.ownership_epoch + 1;
        arg0.active_listing_id = 0x1::option::none<0x2::object::ID>();
        arg0.lifecycle = 1;
        let v4 = mint_current_control_cap(arg0, arg6);
        let v5 = MakerPurchasedV5{
            root_id                         : 0x2::object::id<MakerRootV5>(arg0),
            listing_id                      : 0x2::object::id<MakerListingV5>(arg2),
            seller                          : arg2.seller,
            buyer                           : 0x2::tx_context::sender(arg6),
            price_atomic                    : v1,
            protocol_fee_atomic             : v2,
            original_creator_royalty_atomic : v3,
            ownership_epoch                 : arg0.ownership_epoch,
            control_cap_id                  : 0x2::object::id<MakerControlCapV5>(&v4),
        };
        0x2::event::emit<MakerPurchasedV5>(v5);
        0x2::transfer::transfer<MakerControlCapV5>(v4, 0x2::tx_context::sender(arg6));
    }

    public fun cancel_maker_listing_v5(arg0: &mut MakerRootV5, arg1: &mut MakerListingV5, arg2: &mut 0x2::tx_context::TxContext) {
        assert_listing(arg0, arg1);
        assert!(arg1.active, 24);
        assert!(0x2::tx_context::sender(arg2) == arg1.seller, 25);
        assert!(0x2::tx_context::sender(arg2) == arg0.current_owner, 10);
        arg1.active = false;
        arg0.active_listing_id = 0x1::option::none<0x2::object::ID>();
        arg0.lifecycle = 1;
        let v0 = mint_current_control_cap(arg0, arg2);
        let v1 = MakerListingCancelledV5{
            root_id        : 0x2::object::id<MakerRootV5>(arg0),
            listing_id     : 0x2::object::id<MakerListingV5>(arg1),
            seller         : 0x2::tx_context::sender(arg2),
            control_cap_id : 0x2::object::id<MakerControlCapV5>(&v0),
        };
        0x2::event::emit<MakerListingCancelledV5>(v1);
        0x2::transfer::transfer<MakerControlCapV5>(v0, 0x2::tx_context::sender(arg2));
    }

    fun checked_add(arg0: u64, arg1: u64) : u64 {
        let v0 = (arg0 as u128) + (arg1 as u128);
        assert!(v0 <= 18446744073709551615, 20);
        (v0 as u64)
    }

    public fun claim_free_pack_v5(arg0: &mut MakerRootV5, arg1: &CommerceProtocolConfigV5, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_operational(arg0, arg1);
        assert_base_access(arg0, 0x2::tx_context::sender(arg4));
        let v0 = PackKeyV5{name: arg2};
        let v1 = 0x2::table::borrow_mut<PackKeyV5, PackRecordV5>(&mut arg0.packs, v0);
        assert!(v1.active, 15);
        assert!(v1.access_kind == 0, 3);
        issue_pack_entitlement(arg0, arg2, 0, arg3, arg4);
    }

    public(friend) fun collect_extension_primary_payment_v5<T0>(arg0: &MakerRootV5, arg1: &CommerceProtocolConfigV5, arg2: &mut CommerceProtocolTreasuryV5<T0>, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_operational(arg0, arg1);
        assert_protocol_treasury<T0>(arg1, arg2);
        assert!(arg0.protocol_config_id == 0x2::object::id<CommerceProtocolConfigV5>(arg1), 7);
        assert!(&arg0.payment_coin_type == &arg1.payment_coin_type, 8);
        assert!(arg4 > 0 && 0x2::coin::value<T0>(&arg3) == arg4, 18);
        let v0 = bps_amount(arg4, 1000);
        if (v0 > 0) {
            0x2::coin::put<T0>(&mut arg2.revenue, 0x2::coin::split<T0>(&mut arg3, v0, arg5));
            arg2.total_primary_collected = arg2.total_primary_collected + v0;
        };
        arg3
    }

    fun collect_primary_payment<T0>(arg0: &mut MakerTreasuryV5<T0>, arg1: &mut CommerceProtocolTreasuryV5<T0>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg2) == checked_add(arg3, arg4), 18);
        let v0 = bps_amount(arg3, 1000);
        let v1 = checked_add(v0, arg4);
        if (v1 > 0) {
            0x2::coin::put<T0>(&mut arg1.revenue, 0x2::coin::split<T0>(&mut arg2, v1, arg5));
            arg1.total_primary_collected = arg1.total_primary_collected + v0;
            arg1.total_fixed_collected = arg1.total_fixed_collected + arg4;
        };
        0x2::coin::put<T0>(&mut arg0.revenue, arg2);
    }

    public fun complete_authorization_output_seal_id_v5(arg0: &CommerceV5SoulMintAuthorization) : &vector<u8> {
        &arg0.output_binding.seal_id
    }

    public fun complete_authorization_payer_v5(arg0: &CommerceV5SoulMintAuthorization) : address {
        0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::canonical_soul_mint_authorization_payer(&arg0.canonical)
    }

    public fun complete_authorization_recipe_hash_v5(arg0: &CommerceV5SoulMintAuthorization) : &vector<u8> {
        0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::canonical_soul_mint_authorization_recipe_hash(&arg0.canonical)
    }

    public fun complete_authorization_root_id_v5(arg0: &CommerceV5SoulMintAuthorization) : 0x2::object::ID {
        arg0.output_binding.root_id
    }

    public fun complete_output_bound_soul_id_v5(arg0: &CompleteOutputRecordV5) : &0x1::option::Option<0x2::object::ID> {
        &arg0.bound_soul_id
    }

    public fun complete_output_ciphertext_blob_id_v5(arg0: &CompleteOutputRecordV5) : &0x1::string::String {
        &arg0.ciphertext_blob_id
    }

    public fun complete_output_digest_v5(arg0: &CompleteOutputRecordV5) : &vector<u8> {
        &arg0.output_digest
    }

    public fun complete_output_exists_v5(arg0: &MakerRootV5, arg1: vector<u8>) : bool {
        0x2::table::contains<vector<u8>, CompleteOutputRecordV5>(&arg0.complete_outputs, arg1)
    }

    public fun complete_output_is_soul_bound_v5(arg0: &CompleteOutputRecordV5) : bool {
        0x1::option::is_some<0x2::object::ID>(&arg0.bound_soul_id)
    }

    public fun complete_output_nonce_v5(arg0: &CompleteOutputRecordV5) : &vector<u8> {
        &arg0.output_nonce
    }

    public fun complete_output_payer_v5(arg0: &CompleteOutputRecordV5) : address {
        arg0.payer
    }

    public fun complete_output_recipe_hash_v5(arg0: &CompleteOutputRecordV5) : &vector<u8> {
        &arg0.recipe_hash
    }

    public fun complete_output_record_v5(arg0: &MakerRootV5, arg1: vector<u8>) : &CompleteOutputRecordV5 {
        0x2::table::borrow<vector<u8>, CompleteOutputRecordV5>(&arg0.complete_outputs, arg1)
    }

    public fun complete_output_seal_id_v5(arg0: &CompleteOutputRecordV5) : &vector<u8> {
        &arg0.seal_id
    }

    public fun complete_output_soul_binding_root_id_v5(arg0: &CompleteOutputSoulBindingV5) : 0x2::object::ID {
        arg0.root_id
    }

    public fun complete_output_soul_binding_seal_id_v5(arg0: &CompleteOutputSoulBindingV5) : &vector<u8> {
        &arg0.seal_id
    }

    fun completion_count(arg0: &MakerRootV5, arg1: CompletionCountKeyV5) : u64 {
        if (0x2::table::contains<CompletionCountKeyV5, u64>(&arg0.completion_counts, arg1)) {
            *0x2::table::borrow<CompletionCountKeyV5, u64>(&arg0.completion_counts, arg1)
        } else {
            0
        }
    }

    public fun completion_policy_free_quota(arg0: &CompletionPolicyV5) : u64 {
        arg0.free_quota_per_wallet
    }

    public fun completion_policy_mode(arg0: &CompletionPolicyV5) : u8 {
        arg0.mode
    }

    public fun completion_policy_price(arg0: &CompletionPolicyV5) : u64 {
        arg0.price_atomic
    }

    public fun completion_policy_total_cap(arg0: &CompletionPolicyV5) : u64 {
        arg0.total_cap
    }

    public fun consume_commerce_v5_soul_mint_authorization(arg0: CommerceV5SoulMintAuthorization) : (0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::CanonicalSoulMintAuthorization, u16, CompleteOutputSoulBindingV5) {
        let CommerceV5SoulMintAuthorization {
            canonical                : v0,
            soul_creator_royalty_bps : v1,
            output_binding           : v2,
        } = arg0;
        (v0, v1, v2)
    }

    fun defining_type_name<T0>() : 0x1::string::String {
        0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()))
    }

    public fun derive_complete_output_seal_id_v5(arg0: 0x2::object::ID, arg1: address, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>) : vector<u8> {
        let v0 = if (0x1::vector::length<u8>(&arg2) == 32) {
            if (0x1::vector::length<u8>(&arg3) == 32) {
                0x1::vector::length<u8>(&arg4) == 32
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 41);
        let v1 = CompleteOutputIdentityV5{
            root_id       : arg0,
            payer         : arg1,
            recipe_hash   : arg2,
            output_nonce  : arg3,
            output_digest : arg4,
        };
        0x1::hash::sha2_256(0x1::bcs::to_bytes<CompleteOutputIdentityV5>(&v1))
    }

    fun derive_used_pack_keys(arg0: &MakerRootV5, arg1: &vector<StyleSelectionV5>, arg2: address) : vector<0x1::string::String> {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<StyleSelectionV5>(arg1)) {
            let v2 = 0x1::vector::borrow<StyleSelectionV5>(arg1, v1);
            let v3 = StyleBindingKeyV5{
                part_key  : v2.part_key,
                item_key  : v2.item_key,
                style_key : v2.style_key,
            };
            let v4 = 0x2::table::borrow<StyleBindingKeyV5, StyleProductRecordV5>(&arg0.style_registry, v3);
            if (0x1::option::is_some<0x1::string::String>(&v4.pack_key)) {
                let v5 = *0x1::option::borrow<0x1::string::String>(&v4.pack_key);
                let v6 = PackKeyV5{name: v5};
                if (0x2::table::borrow<PackKeyV5, PackRecordV5>(&arg0.packs, v6).access_kind == 1) {
                    let v7 = EntitlementKeyV5{
                        pack_key : v5,
                        wallet   : arg2,
                    };
                    assert!(0x2::table::contains<EntitlementKeyV5, EntitlementRecordV5>(&arg0.entitlement_registry, v7), 17);
                };
                if (!string_vector_contains(&v0, &v5)) {
                    0x1::vector::push_back<0x1::string::String>(&mut v0, v5);
                };
            };
            v1 = v1 + 1;
        };
        v0
    }

    public(friend) fun extension_payment_coin_type_v5(arg0: &CommerceProtocolConfigV5) : &0x1::string::String {
        &arg0.payment_coin_type
    }

    public fun fixed_complete_fee_v5(arg0: &CommerceProtocolConfigV5) : u64 {
        arg0.fixed_complete_fee_atomic
    }

    public fun has_base_entitlement_v5(arg0: &MakerRootV5, arg1: address) : bool {
        arg0.base_access_kind == 0 || 0x2::table::contains<address, EntitlementRecordV5>(&arg0.base_entitlement_registry, arg1)
    }

    fun has_non_empty_string_prefix(arg0: &0x1::string::String, arg1: &0x1::string::String) : bool {
        let v0 = 0x1::string::as_bytes(arg0);
        let v1 = 0x1::string::as_bytes(arg1);
        if (0x1::vector::length<u8>(v0) <= 0x1::vector::length<u8>(v1)) {
            return false
        };
        let v2 = 0;
        while (v2 < 0x1::vector::length<u8>(v1)) {
            if (*0x1::vector::borrow<u8>(v0, v2) != *0x1::vector::borrow<u8>(v1, v2)) {
                return false
            };
            v2 = v2 + 1;
        };
        true
    }

    public fun has_pack_entitlement_v5(arg0: &MakerRootV5, arg1: 0x1::string::String, arg2: address) : bool {
        let v0 = PackKeyV5{name: arg1};
        if (0x2::table::borrow<PackKeyV5, PackRecordV5>(&arg0.packs, v0).access_kind == 0) {
            true
        } else {
            let v2 = EntitlementKeyV5{
                pack_key : arg1,
                wallet   : arg2,
            };
            0x2::table::contains<EntitlementKeyV5, EntitlementRecordV5>(&arg0.entitlement_registry, v2)
        }
    }

    public fun hash_complete_selection_v5(arg0: &vector<0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::RecipeSlot>, arg1: &vector<StyleSelectionV5>) : vector<u8> {
        let v0 = CompleteSelectionHashInputV5{
            recipe           : *arg0,
            style_selections : *arg1,
        };
        0x1::hash::sha2_256(0x1::bcs::to_bytes<CompleteSelectionHashInputV5>(&v0))
    }

    fun increment_completion_count(arg0: &mut MakerRootV5, arg1: CompletionCountKeyV5) {
        if (0x2::table::contains<CompletionCountKeyV5, u64>(&arg0.completion_counts, arg1)) {
            let v0 = 0x2::table::borrow_mut<CompletionCountKeyV5, u64>(&mut arg0.completion_counts, arg1);
            *v0 = *v0 + 1;
        } else {
            0x2::table::add<CompletionCountKeyV5, u64>(&mut arg0.completion_counts, arg1, 1);
        };
    }

    public fun initialize_commerce_protocol_v5<T0>(arg0: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::ProtocolFeeConfig, arg1: &mut 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::ProtocolFeeAdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = new_protocol_objects<T0>(arg0, arg1, arg2);
        let v2 = v1;
        let v3 = v0;
        let v4 = CommerceProtocolV5Initialized{
            config_id         : 0x2::object::id<CommerceProtocolConfigV5>(&v3),
            treasury_id       : 0x2::object::id<CommerceProtocolTreasuryV5<T0>>(&v2),
            legacy_config_id  : 0x2::object::id<0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::ProtocolFeeConfig>(arg0),
            payment_coin_type : payment_coin_type_name<T0>(),
            enabled           : false,
        };
        0x2::event::emit<CommerceProtocolV5Initialized>(v4);
        0x2::transfer::share_object<CommerceProtocolConfigV5>(v3);
        0x2::transfer::share_object<CommerceProtocolTreasuryV5<T0>>(v2);
    }

    fun issue_pack_entitlement(arg0: &mut MakerRootV5, arg1: 0x1::string::String, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = EntitlementKeyV5{
            pack_key : arg1,
            wallet   : v0,
        };
        assert!(!0x2::table::contains<EntitlementKeyV5, EntitlementRecordV5>(&arg0.entitlement_registry, v1), 16);
        let v2 = EntitlementRecordV5{
            granted_at_ms   : 0x2::clock::timestamp_ms(arg3),
            paid_atomic     : arg2,
            ownership_epoch : arg0.ownership_epoch,
        };
        0x2::table::add<EntitlementKeyV5, EntitlementRecordV5>(&mut arg0.entitlement_registry, v1, v2);
        let v3 = PackKeyV5{name: arg1};
        let v4 = 0x2::table::borrow_mut<PackKeyV5, PackRecordV5>(&mut arg0.packs, v3);
        v4.entitlement_count = v4.entitlement_count + 1;
        let v5 = PackPassV5{
            id              : 0x2::object::new(arg4),
            version         : 5,
            root_id         : 0x2::object::id<MakerRootV5>(arg0),
            pack_key        : arg1,
            holder          : v0,
            issued_at_ms    : 0x2::clock::timestamp_ms(arg3),
            ownership_epoch : arg0.ownership_epoch,
        };
        let v6 = PackEntitlementGrantedV5{
            root_id      : 0x2::object::id<MakerRootV5>(arg0),
            pack_key     : arg1,
            holder       : v0,
            paid_atomic  : arg2,
            pack_pass_id : 0x2::object::id<PackPassV5>(&v5),
        };
        0x2::event::emit<PackEntitlementGrantedV5>(v6);
        0x2::transfer::transfer<PackPassV5>(v5, v0);
    }

    public fun lifecycle_active() : u8 {
        0
    }

    public fun lifecycle_archived() : u8 {
        2
    }

    public fun lifecycle_paused() : u8 {
        1
    }

    public fun lifecycle_sale_pending() : u8 {
        3
    }

    public fun list_maker_for_sale_v5<T0>(arg0: &mut MakerRootV5, arg1: &MakerTreasuryV5<T0>, arg2: MakerControlCapV5, arg3: &CommerceProtocolConfigV5, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<MakerListingV5>(new_maker_listing_v5<T0>(arg0, arg1, arg2, arg3, arg4, arg5));
    }

    public fun listing_active_v5(arg0: &MakerListingV5) : bool {
        arg0.active
    }

    public fun listing_price_v5(arg0: &MakerListingV5) : u64 {
        arg0.price_atomic
    }

    public fun listing_protocol_fee_bps_v5(arg0: &MakerListingV5) : u16 {
        arg0.protocol_fee_bps
    }

    public fun listing_seller_v5(arg0: &MakerListingV5) : address {
        arg0.seller
    }

    public fun maker_access_pass_holder_v5(arg0: &MakerAccessPassV5) : address {
        arg0.holder
    }

    public fun maker_access_pass_root_id_v5(arg0: &MakerAccessPassV5) : 0x2::object::ID {
        arg0.root_id
    }

    public fun maker_market_fee_bps_v5(arg0: &CommerceProtocolConfigV5) : u16 {
        arg0.maker_market_fee_bps
    }

    fun maker_receives(arg0: u64) : u64 {
        arg0 - bps_amount(arg0, 1000)
    }

    fun maker_release_evidence_key_v5() : 0x1::string::String {
        0x1::string::utf8(b"animacraft.maker-release-evidence.v5")
    }

    public fun maker_release_manifest_blob_id_v5(arg0: &MakerReleaseEvidenceV5) : &0x1::string::String {
        &arg0.manifest_blob_id
    }

    public fun maker_release_manifest_sha256_v5(arg0: &MakerReleaseEvidenceV5) : &vector<u8> {
        &arg0.manifest_sha256
    }

    public fun maker_release_parent_version_v5(arg0: &MakerReleaseEvidenceV5) : &0x1::string::String {
        &arg0.parent_version
    }

    public fun maker_treasury_balance_v5<T0>(arg0: &MakerTreasuryV5<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.revenue)
    }

    public fun max_maker_resale_royalty_bps_v5() : u16 {
        500
    }

    public fun migrate_legacy_maker_v5<T0>(arg0: &mut 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::OCMaker, arg1: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::MakerTreasury<T0>, arg2: 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::MakerAdminCap, arg3: &CommerceProtocolConfigV5, arg4: u8, arg5: CompletionPolicyV5, arg6: u16, arg7: u16, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = new_migrated_maker_objects_v5<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
        0x2::transfer::share_object<MakerRootV5>(v0);
        0x2::transfer::share_object<MakerTreasuryV5<T0>>(v1);
        0x2::transfer::share_object<MakerControlVaultV5>(v2);
        0x2::transfer::transfer<MakerControlCapV5>(v3, 0x2::tx_context::sender(arg9));
    }

    fun mint_current_control_cap(arg0: &mut MakerRootV5, arg1: &mut 0x2::tx_context::TxContext) : MakerControlCapV5 {
        assert!(0x1::option::is_none<0x2::object::ID>(&arg0.current_control_cap_id), 9);
        let v0 = MakerControlCapV5{
            id              : 0x2::object::new(arg1),
            version         : 5,
            root_id         : 0x2::object::id<MakerRootV5>(arg0),
            ownership_epoch : arg0.ownership_epoch,
        };
        arg0.current_control_cap_id = 0x1::option::some<0x2::object::ID>(0x2::object::id<MakerControlCapV5>(&v0));
        v0
    }

    fun new_complete_authorization(arg0: &MakerRootV5, arg1: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::OCMaker, arg2: &CommerceProtocolConfigV5, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: vector<u8>, arg8: vector<0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::RecipeSlot>, arg9: CompleteQuoteV5, arg10: vector<u8>, arg11: vector<u8>, arg12: vector<u8>, arg13: &0x2::clock::Clock, arg14: &0x2::tx_context::TxContext) : CommerceV5SoulMintAuthorization {
        let v0 = CompleteAuthorizedV5{
            root_id                    : 0x2::object::id<MakerRootV5>(arg0),
            legacy_maker_id            : 0x2::object::id<0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::OCMaker>(arg1),
            payer                      : 0x2::tx_context::sender(arg14),
            creator_charge_atomic      : arg9.creator_charge_atomic,
            protocol_percentage_atomic : arg9.protocol_percentage_atomic,
            fixed_protocol_fee_atomic  : arg9.fixed_protocol_fee_atomic,
            total_paid_atomic          : arg9.total_due_atomic,
            ownership_epoch            : arg0.ownership_epoch,
            output_seal_id             : arg10,
            output_nonce               : arg11,
            output_digest              : arg12,
            ciphertext_blob_id         : arg5,
        };
        0x2::event::emit<CompleteAuthorizedV5>(v0);
        let v1 = CompleteOutputSoulBindingV5{
            root_id : 0x2::object::id<MakerRootV5>(arg0),
            seal_id : arg10,
        };
        CommerceV5SoulMintAuthorization{
            canonical                : 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::new_canonical_commerce_v5_authorization(0x2::object::id<MakerRootV5>(arg0), arg0.treasury_id, arg0.original_creator, 0x2::tx_context::sender(arg14), arg1, arg3, arg4, arg5, arg6, arg7, arg0.payment_coin_type, arg9.total_due_atomic, arg8, 0x2::object::id<CommerceProtocolConfigV5>(arg2), arg2.treasury_id, arg2.primary_protocol_fee_bps, checked_add(arg9.protocol_percentage_atomic, arg9.fixed_protocol_fee_atomic), arg13),
            soul_creator_royalty_bps : arg0.soul_creator_royalty_bps,
            output_binding           : v1,
        }
    }

    public fun new_completion_policy(arg0: u8, arg1: u64, arg2: u64) : CompletionPolicyV5 {
        new_completion_policy_with_cap(arg0, arg1, arg2, 0)
    }

    public fun new_completion_policy_with_cap(arg0: u8, arg1: u64, arg2: u64, arg3: u64) : CompletionPolicyV5 {
        assert_valid_completion_policy(arg0, arg1, arg2);
        CompletionPolicyV5{
            mode                  : arg0,
            free_quota_per_wallet : arg1,
            price_atomic          : arg2,
            total_cap             : arg3,
        }
    }

    fun new_maker_listing_v5<T0>(arg0: &mut MakerRootV5, arg1: &MakerTreasuryV5<T0>, arg2: MakerControlCapV5, arg3: &CommerceProtocolConfigV5, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : MakerListingV5 {
        assert_control(arg0, &arg2, arg5);
        assert_maker_treasury<T0>(arg0, arg1);
        assert!(arg3.enabled, 6);
        assert!(arg0.protocol_config_id == 0x2::object::id<CommerceProtocolConfigV5>(arg3), 7);
        assert!(&arg0.payment_coin_type == &arg3.payment_coin_type, 8);
        assert!(arg0.lifecycle == 1, 1);
        assert!(0x2::balance::value<T0>(&arg1.revenue) == 0, 12);
        assert!(arg4 > 0, 18);
        assert!(0x1::option::is_none<0x2::object::ID>(&arg0.active_listing_id), 1);
        let MakerControlCapV5 {
            id              : v0,
            version         : _,
            root_id         : _,
            ownership_epoch : _,
        } = arg2;
        0x2::object::delete(v0);
        let v4 = MakerListingV5{
            id                       : 0x2::object::new(arg5),
            version                  : 5,
            root_id                  : 0x2::object::id<MakerRootV5>(arg0),
            seller                   : 0x2::tx_context::sender(arg5),
            price_atomic             : arg4,
            ownership_epoch          : arg0.ownership_epoch,
            protocol_fee_bps         : arg3.maker_market_fee_bps,
            maker_resale_royalty_bps : arg0.maker_resale_royalty_bps,
            active                   : true,
        };
        let v5 = 0x2::object::id<MakerListingV5>(&v4);
        arg0.current_control_cap_id = 0x1::option::none<0x2::object::ID>();
        arg0.active_listing_id = 0x1::option::some<0x2::object::ID>(v5);
        arg0.lifecycle = 3;
        let v6 = MakerListingOpenedV5{
            root_id         : 0x2::object::id<MakerRootV5>(arg0),
            listing_id      : v5,
            seller          : 0x2::tx_context::sender(arg5),
            price_atomic    : arg4,
            ownership_epoch : arg0.ownership_epoch,
        };
        0x2::event::emit<MakerListingOpenedV5>(v6);
        v4
    }

    fun new_migrated_maker_objects_v5<T0>(arg0: &mut 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::OCMaker, arg1: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::MakerTreasury<T0>, arg2: 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::MakerAdminCap, arg3: &CommerceProtocolConfigV5, arg4: u8, arg5: CompletionPolicyV5, arg6: u16, arg7: u16, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (MakerRootV5, MakerTreasuryV5<T0>, MakerControlVaultV5, MakerControlCapV5) {
        assert_valid_rights_origin(arg4);
        assert_valid_policy(&arg5);
        assert_valid_soul_creator_royalty(arg6);
        assert_valid_maker_resale_royalty(arg7);
        assert_protocol_dependencies_bound(arg3);
        let v0 = payment_coin_type_name<T0>();
        assert!(&v0 == &arg3.payment_coin_type, 8);
        assert!(0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::treasury_balance<T0>(arg1) == 0, 12);
        let v1 = 0x2::object::new(arg9);
        let v2 = 0x2::object::uid_to_inner(&v1);
        let v3 = MakerTreasuryV5<T0>{
            id                       : 0x2::object::new(arg9),
            version                  : 5,
            root_id                  : v2,
            revenue                  : 0x2::balance::zero<T0>(),
            total_pack_collected     : 0,
            total_complete_collected : 0,
            total_withdrawn          : 0,
        };
        let v4 = MakerControlVaultV5{
            id               : 0x2::object::new(arg9),
            version          : 5,
            root_id          : v2,
            legacy_maker_id  : 0x2::object::id<0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::OCMaker>(arg0),
            legacy_admin_cap : 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::disable_legacy_minting_for_v5<T0>(arg2, arg0, arg1, arg8, arg9),
        };
        let v5 = MakerControlCapV5{
            id              : 0x2::object::new(arg9),
            version         : 5,
            root_id         : v2,
            ownership_epoch : 0,
        };
        let v6 = 0x2::object::id<MakerControlCapV5>(&v5);
        let v7 = MakerRootReleaseStateV5{
            pack_count              : 0,
            paid_pack_count         : 0,
            style_count             : 0,
            style_registry_sealed   : false,
            protected_style_count   : 0,
            seal_policy_id          : 0x1::option::none<0x2::object::ID>(),
            seal_release_commitment : b"",
            complete_output_count   : 0,
            total_completes         : 0,
        };
        let v8 = MakerRootV5{
            id                         : v1,
            version                    : 5,
            legacy_maker_id            : 0x2::object::id<0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::OCMaker>(arg0),
            legacy_treasury_id         : 0x2::object::id<0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::MakerTreasury<T0>>(arg1),
            control_vault_id           : 0x2::object::id<MakerControlVaultV5>(&v4),
            treasury_id                : 0x2::object::id<MakerTreasuryV5<T0>>(&v3),
            protocol_config_id         : 0x2::object::id<CommerceProtocolConfigV5>(arg3),
            payment_coin_type          : payment_coin_type_name<T0>(),
            original_creator           : 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::maker_creator(arg0),
            current_owner              : 0x2::tx_context::sender(arg9),
            rights_origin              : arg4,
            lifecycle                  : 1,
            ownership_epoch            : 0,
            current_control_cap_id     : 0x1::option::some<0x2::object::ID>(v6),
            active_listing_id          : 0x1::option::none<0x2::object::ID>(),
            soul_creator_royalty_bps   : arg6,
            maker_resale_royalty_bps   : arg7,
            base_access_kind           : 0,
            base_purchase_price_atomic : 0,
            base_policy                : arg5,
            packs                      : 0x2::table::new<PackKeyV5, PackRecordV5>(arg9),
            pack_keys                  : 0x1::vector::empty<0x1::string::String>(),
            style_registry             : 0x2::table::new<StyleBindingKeyV5, StyleProductRecordV5>(arg9),
            style_keys                 : 0x1::vector::empty<StyleBindingKeyV5>(),
            logical_auxiliary_blob_id  : *0x1::option::borrow<0x1::string::String>(&arg3.logical_auxiliary_blob_id),
            base_entitlement_registry  : 0x2::table::new<address, EntitlementRecordV5>(arg9),
            entitlement_registry       : 0x2::table::new<EntitlementKeyV5, EntitlementRecordV5>(arg9),
            completion_counts          : 0x2::table::new<CompletionCountKeyV5, u64>(arg9),
            complete_outputs           : 0x2::table::new<vector<u8>, CompleteOutputRecordV5>(arg9),
            release                    : v7,
        };
        let v9 = LegacyMakerMigratedToV5{
            root_id                  : v2,
            legacy_maker_id          : 0x2::object::id<0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::OCMaker>(arg0),
            legacy_treasury_id       : 0x2::object::id<0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::MakerTreasury<T0>>(arg1),
            treasury_id              : 0x2::object::id<MakerTreasuryV5<T0>>(&v3),
            vault_id                 : 0x2::object::id<MakerControlVaultV5>(&v4),
            control_cap_id           : v6,
            owner                    : 0x2::tx_context::sender(arg9),
            rights_origin            : arg4,
            soul_creator_royalty_bps : arg6,
            maker_resale_royalty_bps : arg7,
        };
        0x2::event::emit<LegacyMakerMigratedToV5>(v9);
        (v8, v3, v4, v5)
    }

    fun new_protocol_objects<T0>(arg0: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::ProtocolFeeConfig, arg1: &mut 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::ProtocolFeeAdminCap, arg2: &mut 0x2::tx_context::TxContext) : (CommerceProtocolConfigV5, CommerceProtocolTreasuryV5<T0>) {
        0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::claim_commerce_v5_initializer(arg0, arg1);
        let v0 = 0x2::object::new(arg2);
        let v1 = CommerceProtocolTreasuryV5<T0>{
            id                      : 0x2::object::new(arg2),
            version                 : 5,
            config_id               : 0x2::object::uid_to_inner(&v0),
            revenue                 : 0x2::balance::zero<T0>(),
            total_primary_collected : 0,
            total_fixed_collected   : 0,
            total_market_collected  : 0,
            total_withdrawn         : 0,
        };
        let v2 = CommerceProtocolConfigV5{
            id                        : v0,
            version                   : 5,
            legacy_config_id          : 0x2::object::id<0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::ProtocolFeeConfig>(arg0),
            legacy_admin_cap_id       : 0x2::object::id<0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::ProtocolFeeAdminCap>(arg1),
            treasury_id               : 0x2::object::id<CommerceProtocolTreasuryV5<T0>>(&v1),
            payment_coin_type         : payment_coin_type_name<T0>(),
            primary_protocol_fee_bps  : 1000,
            fixed_complete_fee_atomic : 0,
            maker_market_fee_bps      : 250,
            logical_auxiliary_blob_id : 0x1::option::none<0x1::string::String>(),
            soul_binding_proof_type   : 0x1::option::none<0x1::string::String>(),
            enabled                   : false,
        };
        (v2, v1)
    }

    public fun new_style_selection_v5(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String) : StyleSelectionV5 {
        assert_non_empty(&arg0);
        assert_non_empty(&arg1);
        assert_non_empty(&arg2);
        StyleSelectionV5{
            part_key  : arg0,
            item_key  : arg1,
            style_key : arg2,
        }
    }

    public fun pack_access_free() : u8 {
        0
    }

    public fun pack_access_kind_v5(arg0: &PackRecordV5) : u8 {
        arg0.access_kind
    }

    public fun pack_access_paid_once() : u8 {
        1
    }

    public fun pack_active_v5(arg0: &PackRecordV5) : bool {
        arg0.active
    }

    public fun pack_label_v5(arg0: &PackRecordV5) : &0x1::string::String {
        &arg0.label
    }

    public fun pack_pass_holder_v5(arg0: &PackPassV5) : address {
        arg0.holder
    }

    public fun pack_pass_key_v5(arg0: &PackPassV5) : &0x1::string::String {
        &arg0.pack_key
    }

    public fun pack_pass_root_id_v5(arg0: &PackPassV5) : 0x2::object::ID {
        arg0.root_id
    }

    public fun pack_purchase_price_v5(arg0: &PackRecordV5) : u64 {
        arg0.purchase_price_atomic
    }

    public fun pack_record_v5(arg0: &MakerRootV5, arg1: 0x1::string::String) : &PackRecordV5 {
        let v0 = PackKeyV5{name: arg1};
        0x2::table::borrow<PackKeyV5, PackRecordV5>(&arg0.packs, v0)
    }

    public fun pause_maker_v5(arg0: &mut MakerRootV5, arg1: &MakerControlCapV5, arg2: &0x2::tx_context::TxContext) {
        assert_control(arg0, arg1, arg2);
        assert!(arg0.lifecycle == 0, 1);
        set_lifecycle(arg0, 1);
    }

    fun payment_coin_type_name<T0>() : 0x1::string::String {
        defining_type_name<T0>()
    }

    fun policy_charge(arg0: &CompletionPolicyV5, arg1: u64) : u64 {
        if (arg0.mode == 0) {
            0
        } else if (arg0.mode == 1) {
            if (arg1 < arg0.free_quota_per_wallet) {
                0
            } else {
                arg0.price_atomic
            }
        } else if (arg0.mode == 2) {
            arg0.price_atomic
        } else {
            assert!(arg1 < arg0.free_quota_per_wallet, 19);
            0
        }
    }

    public fun policy_free_quota_then_block() : u8 {
        3
    }

    public fun policy_free_quota_then_paid() : u8 {
        1
    }

    public fun policy_paid_every_time() : u8 {
        2
    }

    public fun policy_unlimited_free() : u8 {
        0
    }

    public fun primary_protocol_fee_bps_v5(arg0: &CommerceProtocolConfigV5) : u16 {
        arg0.primary_protocol_fee_bps
    }

    public fun protocol_config_id_v5(arg0: &CommerceProtocolConfigV5) : 0x2::object::ID {
        0x2::object::id<CommerceProtocolConfigV5>(arg0)
    }

    public fun protocol_enabled_v5(arg0: &CommerceProtocolConfigV5) : bool {
        arg0.enabled
    }

    public fun protocol_logical_auxiliary_blob_id_v5(arg0: &CommerceProtocolConfigV5) : &0x1::option::Option<0x1::string::String> {
        &arg0.logical_auxiliary_blob_id
    }

    public fun protocol_soul_binding_proof_type_v5(arg0: &CommerceProtocolConfigV5) : &0x1::option::Option<0x1::string::String> {
        &arg0.soul_binding_proof_type
    }

    public fun protocol_treasury_balance_v5<T0>(arg0: &CommerceProtocolTreasuryV5<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.revenue)
    }

    public fun protocol_version() : u64 {
        5
    }

    public fun purchase_base_access_v5<T0>(arg0: &mut MakerRootV5, arg1: &mut MakerTreasuryV5<T0>, arg2: &CommerceProtocolConfigV5, arg3: &mut CommerceProtocolTreasuryV5<T0>, arg4: 0x2::coin::Coin<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert_operational(arg0, arg2);
        assert_payment_linkage<T0>(arg0, arg1, arg2, arg3);
        assert!(arg0.base_access_kind == 1, 3);
        assert!(!0x2::table::contains<address, EntitlementRecordV5>(&arg0.base_entitlement_registry, 0x2::tx_context::sender(arg6)), 16);
        let v0 = arg0.base_purchase_price_atomic;
        assert!(v0 > 0 && 0x2::coin::value<T0>(&arg4) == v0, 18);
        collect_primary_payment<T0>(arg1, arg3, arg4, v0, 0, arg6);
        arg1.total_pack_collected = arg1.total_pack_collected + maker_receives(v0);
        let v1 = EntitlementRecordV5{
            granted_at_ms   : 0x2::clock::timestamp_ms(arg5),
            paid_atomic     : v0,
            ownership_epoch : arg0.ownership_epoch,
        };
        0x2::table::add<address, EntitlementRecordV5>(&mut arg0.base_entitlement_registry, 0x2::tx_context::sender(arg6), v1);
        let v2 = MakerAccessPassV5{
            id              : 0x2::object::new(arg6),
            version         : 5,
            root_id         : 0x2::object::id<MakerRootV5>(arg0),
            holder          : 0x2::tx_context::sender(arg6),
            issued_at_ms    : 0x2::clock::timestamp_ms(arg5),
            ownership_epoch : arg0.ownership_epoch,
        };
        let v3 = MakerAccessGrantedV5{
            root_id        : 0x2::object::id<MakerRootV5>(arg0),
            holder         : 0x2::tx_context::sender(arg6),
            paid_atomic    : v0,
            access_pass_id : 0x2::object::id<MakerAccessPassV5>(&v2),
        };
        0x2::event::emit<MakerAccessGrantedV5>(v3);
        0x2::transfer::transfer<MakerAccessPassV5>(v2, 0x2::tx_context::sender(arg6));
    }

    public fun purchase_pack_v5<T0>(arg0: &mut MakerRootV5, arg1: &mut MakerTreasuryV5<T0>, arg2: &CommerceProtocolConfigV5, arg3: &mut CommerceProtocolTreasuryV5<T0>, arg4: 0x1::string::String, arg5: 0x2::coin::Coin<T0>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert_operational(arg0, arg2);
        assert_base_access(arg0, 0x2::tx_context::sender(arg7));
        assert_payment_linkage<T0>(arg0, arg1, arg2, arg3);
        let v0 = PackKeyV5{name: arg4};
        let v1 = 0x2::table::borrow<PackKeyV5, PackRecordV5>(&arg0.packs, v0);
        assert!(v1.active, 15);
        assert!(v1.access_kind == 1, 3);
        let v2 = v1.purchase_price_atomic;
        assert!(v2 > 0 && 0x2::coin::value<T0>(&arg5) == v2, 18);
        let v3 = EntitlementKeyV5{
            pack_key : arg4,
            wallet   : 0x2::tx_context::sender(arg7),
        };
        assert!(!0x2::table::contains<EntitlementKeyV5, EntitlementRecordV5>(&arg0.entitlement_registry, v3), 16);
        collect_primary_payment<T0>(arg1, arg3, arg5, v2, 0, arg7);
        arg1.total_pack_collected = arg1.total_pack_collected + maker_receives(v2);
        issue_pack_entitlement(arg0, arg4, v2, arg6, arg7);
    }

    public fun quote_complete_v5(arg0: &MakerRootV5, arg1: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::OCMaker, arg2: &CommerceProtocolConfigV5, arg3: &vector<0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::RecipeSlot>, arg4: &vector<StyleSelectionV5>, arg5: address) : CompleteQuoteV5 {
        let (v0, _) = build_complete_quote(arg0, arg1, arg2, arg3, arg4, arg5);
        v0
    }

    public fun quote_creator_charge_v5(arg0: &CompleteQuoteV5) : u64 {
        arg0.creator_charge_atomic
    }

    public fun quote_fixed_fee_v5(arg0: &CompleteQuoteV5) : u64 {
        arg0.fixed_protocol_fee_atomic
    }

    public fun quote_maker_receives_v5(arg0: &CompleteQuoteV5) : u64 {
        arg0.maker_receives_atomic
    }

    public fun quote_protocol_percentage_v5(arg0: &CompleteQuoteV5) : u64 {
        arg0.protocol_percentage_atomic
    }

    public fun quote_total_due_v5(arg0: &CompleteQuoteV5) : u64 {
        arg0.total_due_atomic
    }

    public fun quote_used_pack_count_v5(arg0: &CompleteQuoteV5) : u64 {
        arg0.used_pack_count
    }

    fun record_complete(arg0: &mut MakerRootV5, arg1: address, arg2: &vector<0x1::string::String>) {
        let v0 = CompletionCountKeyV5{
            wallet       : arg1,
            product_kind : 0,
            product_key  : 0x1::string::utf8(b""),
        };
        increment_completion_count(arg0, v0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::string::String>(arg2)) {
            let v2 = *0x1::vector::borrow<0x1::string::String>(arg2, v1);
            let v3 = CompletionCountKeyV5{
                wallet       : arg1,
                product_kind : 1,
                product_key  : v2,
            };
            increment_completion_count(arg0, v3);
            let v4 = PackKeyV5{name: v2};
            let v5 = 0x2::table::borrow_mut<PackKeyV5, PackRecordV5>(&mut arg0.packs, v4);
            v5.complete_count = v5.complete_count + 1;
            v1 = v1 + 1;
        };
        arg0.release.total_completes = arg0.release.total_completes + 1;
    }

    fun record_complete_output(arg0: &mut MakerRootV5, arg1: address, arg2: &vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: &0x1::string::String) {
        let v0 = if (0x1::vector::length<u8>(&arg3) == 32) {
            if (0x1::vector::length<u8>(&arg4) == 32) {
                if (0x1::vector::length<u8>(&arg5) == 32) {
                    if (0x1::vector::length<u8>(arg2) == 32) {
                        !0x1::string::is_empty(arg6)
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
        assert!(v0, 41);
        assert!(!0x2::table::contains<vector<u8>, CompleteOutputRecordV5>(&arg0.complete_outputs, arg3), 42);
        let v1 = CompleteOutputRecordV5{
            seal_id            : arg3,
            payer              : arg1,
            recipe_hash        : *arg2,
            output_nonce       : arg4,
            output_digest      : arg5,
            ciphertext_blob_id : *arg6,
            bound_soul_id      : 0x1::option::none<0x2::object::ID>(),
        };
        0x2::table::add<vector<u8>, CompleteOutputRecordV5>(&mut arg0.complete_outputs, arg3, v1);
        arg0.release.complete_output_count = arg0.release.complete_output_count + 1;
    }

    public fun register_base_logical_style_v5(arg0: &mut MakerRootV5, arg1: &MakerControlCapV5, arg2: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::OCMaker, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u8, arg7: &0x2::tx_context::TxContext) {
        assert!(arg6 == 1 || arg6 == 2, 46);
        register_style_row_v5(arg0, arg1, arg2, arg3, arg4, arg5, 0x1::option::none<0x1::string::String>(), arg6, arg7);
    }

    public fun register_base_style_v5(arg0: &mut MakerRootV5, arg1: &MakerControlCapV5, arg2: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::OCMaker, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &0x2::tx_context::TxContext) {
        register_style_row_v5(arg0, arg1, arg2, arg3, arg4, arg5, 0x1::option::none<0x1::string::String>(), 0, arg6);
    }

    public fun register_pack_style_v5(arg0: &mut MakerRootV5, arg1: &MakerControlCapV5, arg2: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::OCMaker, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: &0x2::tx_context::TxContext) {
        register_style_row_v5(arg0, arg1, arg2, arg3, arg4, arg5, 0x1::option::some<0x1::string::String>(arg6), 0, arg7);
    }

    fun register_style_row_v5(arg0: &mut MakerRootV5, arg1: &MakerControlCapV5, arg2: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::OCMaker, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::option::Option<0x1::string::String>, arg7: u8, arg8: &0x2::tx_context::TxContext) {
        assert_control(arg0, arg1, arg8);
        assert_configurable(arg0);
        assert!(!arg0.release.style_registry_sealed, 30);
        assert_legacy_maker(arg0, arg2);
        assert_non_empty(&arg5);
        assert_valid_style_row_kind(arg7);
        if (0x1::option::is_some<0x1::string::String>(&arg6)) {
            let v0 = PackKeyV5{name: *0x1::option::borrow<0x1::string::String>(&arg6)};
            assert!(0x2::table::contains<PackKeyV5, PackRecordV5>(&arg0.packs, v0), 14);
        };
        0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::assert_item_exists_for_v5(arg2, &arg3, &arg4);
        let v1 = 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::item_blob_id_for_v5(arg2, &arg3, &arg4);
        assert_style_row_identity(&arg0.logical_auxiliary_blob_id, &v1, &arg5, &arg6, arg7);
        let v2 = if (arg7 == 0) {
            if (arg0.base_access_kind == 1) {
                true
            } else if (0x1::option::is_some<0x1::string::String>(&arg6)) {
                let v3 = PackKeyV5{name: *0x1::option::borrow<0x1::string::String>(&arg6)};
                0x2::table::borrow<PackKeyV5, PackRecordV5>(&arg0.packs, v3).access_kind == 1
            } else {
                false
            }
        } else {
            false
        };
        let v4 = StyleBindingKeyV5{
            part_key  : arg3,
            item_key  : arg4,
            style_key : arg5,
        };
        assert!(!0x2::table::contains<StyleBindingKeyV5, StyleProductRecordV5>(&arg0.style_registry, v4), 31);
        0x1::vector::push_back<StyleBindingKeyV5>(&mut arg0.style_keys, v4);
        let v5 = StyleProductRecordV5{
            pack_key       : arg6,
            asset_blob_id  : v1,
            row_kind       : arg7,
            seal_protected : v2,
        };
        0x2::table::add<StyleBindingKeyV5, StyleProductRecordV5>(&mut arg0.style_registry, v4, v5);
        arg0.release.style_count = arg0.release.style_count + 1;
        if (0x1::option::is_some<0x1::string::String>(&arg6)) {
            let v6 = PackKeyV5{name: *0x1::option::borrow<0x1::string::String>(&arg6)};
            let v7 = 0x2::table::borrow_mut<PackKeyV5, PackRecordV5>(&mut arg0.packs, v6);
            v7.style_count = v7.style_count + 1;
            if (v2) {
                v7.protected_style_count = v7.protected_style_count + 1;
            };
        };
        if (v2) {
            arg0.release.protected_style_count = arg0.release.protected_style_count + 1;
        };
    }

    fun requires_seal_policy(arg0: &MakerRootV5) : bool {
        arg0.base_access_kind == 1 || arg0.release.paid_pack_count > 0
    }

    public fun rights_license_wrapped() : u8 {
        1
    }

    public fun rights_onchain_native() : u8 {
        0
    }

    public fun root_complete_output_count_v5(arg0: &MakerRootV5) : u64 {
        arg0.release.complete_output_count
    }

    public fun root_complete_outputs_table_id_v5(arg0: &MakerRootV5) : 0x2::object::ID {
        0x2::object::id<0x2::table::Table<vector<u8>, CompleteOutputRecordV5>>(&arg0.complete_outputs)
    }

    public fun root_current_owner_v5(arg0: &MakerRootV5) : address {
        arg0.current_owner
    }

    public fun root_id_v5(arg0: &MakerRootV5) : 0x2::object::ID {
        0x2::object::id<MakerRootV5>(arg0)
    }

    public fun root_legacy_maker_id_v5(arg0: &MakerRootV5) : 0x2::object::ID {
        arg0.legacy_maker_id
    }

    public fun root_legacy_treasury_id_v5(arg0: &MakerRootV5) : 0x2::object::ID {
        arg0.legacy_treasury_id
    }

    public fun root_lifecycle_v5(arg0: &MakerRootV5) : u8 {
        arg0.lifecycle
    }

    public fun root_maker_release_evidence_bound_v5(arg0: &MakerRootV5) : bool {
        0x2::dynamic_field::exists<0x1::string::String>(&arg0.id, maker_release_evidence_key_v5())
    }

    public fun root_maker_release_evidence_v5(arg0: &MakerRootV5) : &MakerReleaseEvidenceV5 {
        let v0 = maker_release_evidence_key_v5();
        assert!(0x2::dynamic_field::exists<0x1::string::String>(&arg0.id, v0), 52);
        0x2::dynamic_field::borrow<0x1::string::String, MakerReleaseEvidenceV5>(&arg0.id, v0)
    }

    public fun root_maker_resale_royalty_bps_v5(arg0: &MakerRootV5) : u16 {
        arg0.maker_resale_royalty_bps
    }

    public fun root_original_creator_v5(arg0: &MakerRootV5) : address {
        arg0.original_creator
    }

    public fun root_ownership_epoch_v5(arg0: &MakerRootV5) : u64 {
        arg0.ownership_epoch
    }

    public fun root_pack_count_v5(arg0: &MakerRootV5) : u64 {
        arg0.release.pack_count
    }

    public fun root_paid_pack_count_v5(arg0: &MakerRootV5) : u64 {
        arg0.release.paid_pack_count
    }

    public fun root_protected_style_count_v5(arg0: &MakerRootV5) : u64 {
        arg0.release.protected_style_count
    }

    public fun root_requires_seal_policy_v5(arg0: &MakerRootV5) : bool {
        requires_seal_policy(arg0)
    }

    public fun root_rights_origin_v5(arg0: &MakerRootV5) : u8 {
        arg0.rights_origin
    }

    public fun root_seal_policy_bound_v5(arg0: &MakerRootV5) : bool {
        0x1::option::is_some<0x2::object::ID>(&arg0.release.seal_policy_id)
    }

    public fun root_seal_policy_id_v5(arg0: &MakerRootV5) : 0x1::option::Option<0x2::object::ID> {
        arg0.release.seal_policy_id
    }

    public fun root_seal_release_commitment_v5(arg0: &MakerRootV5) : &vector<u8> {
        &arg0.release.seal_release_commitment
    }

    public fun root_soul_creator_royalty_bps_v5(arg0: &MakerRootV5) : u16 {
        arg0.soul_creator_royalty_bps
    }

    public fun root_total_completes_v5(arg0: &MakerRootV5) : u64 {
        arg0.release.total_completes
    }

    public fun root_treasury_id_v5(arg0: &MakerRootV5) : 0x2::object::ID {
        arg0.treasury_id
    }

    public fun seal_style_registry_v5(arg0: &mut MakerRootV5, arg1: &MakerControlCapV5, arg2: &0x2::tx_context::TxContext) {
        assert_control(arg0, arg1, arg2);
        assert_configurable(arg0);
        assert!(!arg0.release.style_registry_sealed, 30);
        assert!(arg0.release.style_count > 0, 32);
        assert!(0x1::vector::length<StyleBindingKeyV5>(&arg0.style_keys) == arg0.release.style_count, 32);
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<StyleBindingKeyV5>(&arg0.style_keys)) {
            let v2 = *0x1::vector::borrow<StyleBindingKeyV5>(&arg0.style_keys, v1);
            let v3 = 0x2::table::borrow<StyleBindingKeyV5, StyleProductRecordV5>(&arg0.style_registry, v2);
            assert_style_row_identity(&arg0.logical_auxiliary_blob_id, &v3.asset_blob_id, &v2.style_key, &v3.pack_key, v3.row_kind);
            let v4 = if (v3.row_kind == 0) {
                if (arg0.base_access_kind == 1) {
                    true
                } else if (0x1::option::is_some<0x1::string::String>(&v3.pack_key)) {
                    let v5 = PackKeyV5{name: *0x1::option::borrow<0x1::string::String>(&v3.pack_key)};
                    0x2::table::borrow<PackKeyV5, PackRecordV5>(&arg0.packs, v5).access_kind == 1
                } else {
                    false
                }
            } else {
                false
            };
            assert!(v3.seal_protected == v4, 39);
            if (v3.seal_protected) {
                v0 = v0 + 1;
            };
            v1 = v1 + 1;
        };
        assert!(v0 == arg0.release.protected_style_count, 40);
        if (arg0.base_access_kind == 1) {
            assert!(arg0.release.protected_style_count > 0, 39);
        };
        let v6 = 0;
        while (v6 < 0x1::vector::length<0x1::string::String>(&arg0.pack_keys)) {
            let v7 = PackKeyV5{name: *0x1::vector::borrow<0x1::string::String>(&arg0.pack_keys, v6)};
            let v8 = 0x2::table::borrow<PackKeyV5, PackRecordV5>(&arg0.packs, v7);
            if (v8.access_kind == 1) {
                assert!(v8.protected_style_count > 0 && v8.protected_style_count == v8.style_count, 39);
            };
            v6 = v6 + 1;
        };
        arg0.release.style_registry_sealed = true;
    }

    fun set_lifecycle(arg0: &mut MakerRootV5, arg1: u8) {
        arg0.lifecycle = arg1;
        let v0 = MakerLifecycleChangedV5{
            root_id         : 0x2::object::id<MakerRootV5>(arg0),
            owner           : arg0.current_owner,
            previous        : arg0.lifecycle,
            current         : arg1,
            ownership_epoch : arg0.ownership_epoch,
        };
        0x2::event::emit<MakerLifecycleChangedV5>(v0);
    }

    fun string_vector_contains(arg0: &vector<0x1::string::String>, arg1: &0x1::string::String) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::string::String>(arg0)) {
            if (0x1::vector::borrow<0x1::string::String>(arg0, v0) == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun style_count_v5(arg0: &MakerRootV5) : u64 {
        arg0.release.style_count
    }

    public fun style_product_asset_blob_id_v5(arg0: &MakerRootV5, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String) : 0x1::string::String {
        let v0 = StyleBindingKeyV5{
            part_key  : arg1,
            item_key  : arg2,
            style_key : arg3,
        };
        0x2::table::borrow<StyleBindingKeyV5, StyleProductRecordV5>(&arg0.style_registry, v0).asset_blob_id
    }

    public fun style_product_pack_key_v5(arg0: &MakerRootV5, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String) : 0x1::option::Option<0x1::string::String> {
        let v0 = StyleBindingKeyV5{
            part_key  : arg1,
            item_key  : arg2,
            style_key : arg3,
        };
        let v1 = 0x2::table::borrow<StyleBindingKeyV5, StyleProductRecordV5>(&arg0.style_registry, v0);
        if (0x1::option::is_some<0x1::string::String>(&v1.pack_key)) {
            0x1::option::some<0x1::string::String>(*0x1::option::borrow<0x1::string::String>(&v1.pack_key))
        } else {
            0x1::option::none<0x1::string::String>()
        }
    }

    public fun style_product_row_kind_v5(arg0: &MakerRootV5, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String) : u8 {
        let v0 = StyleBindingKeyV5{
            part_key  : arg1,
            item_key  : arg2,
            style_key : arg3,
        };
        0x2::table::borrow<StyleBindingKeyV5, StyleProductRecordV5>(&arg0.style_registry, v0).row_kind
    }

    public fun style_product_seal_protected_v5(arg0: &MakerRootV5, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String) : bool {
        let v0 = StyleBindingKeyV5{
            part_key  : arg1,
            item_key  : arg2,
            style_key : arg3,
        };
        0x2::table::borrow<StyleBindingKeyV5, StyleProductRecordV5>(&arg0.style_registry, v0).seal_protected
    }

    public fun style_registry_sealed_v5(arg0: &MakerRootV5) : bool {
        arg0.release.style_registry_sealed
    }

    public fun style_row_logical_color_v5() : u8 {
        2
    }

    public fun style_row_logical_none_v5() : u8 {
        1
    }

    public fun style_row_visual_v5() : u8 {
        0
    }

    public fun style_selection_item_key_v5(arg0: &StyleSelectionV5) : &0x1::string::String {
        &arg0.item_key
    }

    public fun style_selection_part_key_v5(arg0: &StyleSelectionV5) : &0x1::string::String {
        &arg0.part_key
    }

    public fun style_selection_style_key_v5(arg0: &StyleSelectionV5) : &0x1::string::String {
        &arg0.style_key
    }

    public fun update_base_access_v5(arg0: &mut MakerRootV5, arg1: &MakerControlCapV5, arg2: u8, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        assert_control(arg0, arg1, arg4);
        assert_configurable(arg0);
        assert_release_terms_mutable(arg0);
        assert_valid_pack_access(arg2, arg3);
        arg0.base_access_kind = arg2;
        arg0.base_purchase_price_atomic = arg3;
    }

    public fun update_base_policy_v5(arg0: &mut MakerRootV5, arg1: &MakerControlCapV5, arg2: CompletionPolicyV5, arg3: &0x2::tx_context::TxContext) {
        assert_control(arg0, arg1, arg3);
        assert_configurable(arg0);
        assert_release_terms_mutable(arg0);
        assert_valid_policy(&arg2);
        arg0.base_policy = arg2;
    }

    public fun update_fixed_complete_fee_v5(arg0: &mut CommerceProtocolConfigV5, arg1: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::ProtocolFeeAdminCap, arg2: u64) {
        assert_protocol_admin(arg0, arg1);
        arg0.fixed_complete_fee_atomic = arg2;
    }

    public fun update_maker_market_fee_bps_v5(arg0: &mut CommerceProtocolConfigV5, arg1: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::ProtocolFeeAdminCap, arg2: u16) {
        assert_protocol_admin(arg0, arg1);
        assert!(arg2 <= 1000, 5);
        arg0.maker_market_fee_bps = arg2;
    }

    public fun update_maker_resale_royalty_v5(arg0: &mut MakerRootV5, arg1: &MakerControlCapV5, arg2: u16, arg3: &0x2::tx_context::TxContext) {
        assert_control(arg0, arg1, arg3);
        assert_configurable(arg0);
        assert_release_terms_mutable(arg0);
        assert_valid_maker_resale_royalty(arg2);
        arg0.maker_resale_royalty_bps = arg2;
    }

    public fun update_pack_v5(arg0: &mut MakerRootV5, arg1: &MakerControlCapV5, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u8, arg5: u64, arg6: CompletionPolicyV5, arg7: bool, arg8: &0x2::tx_context::TxContext) {
        assert_control(arg0, arg1, arg8);
        assert_configurable(arg0);
        assert_release_terms_mutable(arg0);
        assert_non_empty(&arg3);
        assert_valid_pack_access(arg4, arg5);
        assert_valid_policy(&arg6);
        let v0 = PackKeyV5{name: arg2};
        let v1 = 0x2::table::borrow_mut<PackKeyV5, PackRecordV5>(&mut arg0.packs, v0);
        let v2 = v1.access_kind == 1;
        let v3 = arg4 == 1;
        if (v2 && !v3) {
            arg0.release.paid_pack_count = arg0.release.paid_pack_count - 1;
        } else if (!v2 && v3) {
            arg0.release.paid_pack_count = arg0.release.paid_pack_count + 1;
        };
        v1.label = arg3;
        v1.access_kind = arg4;
        v1.purchase_price_atomic = arg5;
        v1.complete_policy = arg6;
        v1.active = arg7;
        let v4 = PackConfiguredV5{
            root_id     : 0x2::object::id<MakerRootV5>(arg0),
            pack_key    : arg2,
            access_kind : arg4,
            active      : arg7,
        };
        0x2::event::emit<PackConfiguredV5>(v4);
    }

    public fun update_protocol_enabled_v5(arg0: &mut CommerceProtocolConfigV5, arg1: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::ProtocolFeeAdminCap, arg2: bool) {
        assert_protocol_admin(arg0, arg1);
        if (arg2) {
            assert_protocol_dependencies_bound(arg0);
        };
        arg0.enabled = arg2;
    }

    public fun withdraw_maker_revenue_v5<T0>(arg0: &MakerRootV5, arg1: &mut MakerTreasuryV5<T0>, arg2: &MakerControlCapV5, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert_control(arg0, arg2, arg5);
        assert_maker_treasury<T0>(arg0, arg1);
        assert!(arg4 != @0x0, 27);
        assert!(arg3 > 0 && arg3 <= 0x2::balance::value<T0>(&arg1.revenue), 28);
        arg1.total_withdrawn = arg1.total_withdrawn + arg3;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.revenue, arg3, arg5), arg4);
    }

    public fun withdraw_protocol_revenue_v5<T0>(arg0: &CommerceProtocolConfigV5, arg1: &mut CommerceProtocolTreasuryV5<T0>, arg2: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::ProtocolFeeAdminCap, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert_protocol_admin(arg0, arg2);
        assert_protocol_treasury<T0>(arg0, arg1);
        assert!(arg4 != @0x0, 27);
        assert!(arg3 > 0 && arg3 <= 0x2::balance::value<T0>(&arg1.revenue), 28);
        arg1.total_withdrawn = arg1.total_withdrawn + arg3;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.revenue, arg3, arg5), arg4);
    }

    // decompiled from Move bytecode v7
}

