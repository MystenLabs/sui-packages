module 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::expansion_pack_v8 {
    struct StyleAssetKeyV8 has copy, drop, store {
        part_key: 0x1::string::String,
        item_key: 0x1::string::String,
        style_key: 0x1::string::String,
    }

    struct StyleAssetRecordV8 has copy, drop, store {
        asset_blob_id: 0x1::string::String,
        asset_sha256: vector<u8>,
        asset_seal_id: vector<u8>,
    }

    struct EntitlementRecordV8 has copy, drop, store {
        paid_atomic: u64,
        issued_at_ms: u64,
        admitted_parent_ownership_epoch: u64,
    }

    struct ExpansionPackSealReleaseScopeV8 has copy, drop, store {
        release_id: 0x2::object::ID,
        content_commitment: vector<u8>,
    }

    struct ExpansionPackReleaseV8 has key {
        id: 0x2::object::UID,
        version: u64,
        parent_root_id: 0x2::object::ID,
        parent_legacy_maker_id: 0x2::object::ID,
        parent_version: 0x1::string::String,
        parent_manifest_blob_id: 0x1::string::String,
        parent_manifest_sha256: vector<u8>,
        pack_id: 0x1::string::String,
        namespace: 0x1::string::String,
        pack_version: 0x1::string::String,
        creator: address,
        manifest_bound: bool,
        manifest_blob_id: 0x1::string::String,
        manifest_sha256: vector<u8>,
        content_commitment: vector<u8>,
        style_registry_commitment: vector<u8>,
        seal_policy_id: 0x1::option::Option<0x2::object::ID>,
        seal_package_id: 0x1::option::Option<0x2::object::ID>,
        seal_release_commitment: vector<u8>,
        access_kind: u8,
        purchase_price_atomic: u64,
        lifecycle: u8,
        admin_cap_id: 0x2::object::ID,
        treasury_id: 0x2::object::ID,
        admitted_by: address,
        admitted_parent_ownership_epoch: u64,
        styles: 0x2::table::Table<StyleAssetKeyV8, StyleAssetRecordV8>,
        seal_assets: 0x2::table::Table<vector<u8>, StyleAssetKeyV8>,
        style_keys: vector<StyleAssetKeyV8>,
        entitlements: 0x2::table::Table<address, EntitlementRecordV8>,
        style_count: u64,
        entitlement_count: u64,
    }

    struct ExpansionPackAdminCapV8 has key {
        id: 0x2::object::UID,
        version: u64,
        release_id: 0x2::object::ID,
        creator: address,
    }

    struct ExpansionPackTreasuryV8<phantom T0> has key {
        id: 0x2::object::UID,
        version: u64,
        release_id: 0x2::object::ID,
        revenue: 0x2::balance::Balance<T0>,
        total_collected: u64,
        total_withdrawn: u64,
    }

    struct ExpansionPackPassV8 has key {
        id: 0x2::object::UID,
        version: u64,
        release_id: 0x2::object::ID,
        parent_root_id: 0x2::object::ID,
        holder: address,
        paid_atomic: u64,
        issued_at_ms: u64,
        admitted_parent_ownership_epoch: u64,
        content_commitment: vector<u8>,
    }

    struct ExpansionPackStyleAccessProofV8 has drop {
        release_id: 0x2::object::ID,
        parent_root_id: 0x2::object::ID,
        holder: address,
        part_key: 0x1::string::String,
        item_key: 0x1::string::String,
        style_key: 0x1::string::String,
        asset_blob_id: 0x1::string::String,
        asset_sha256: vector<u8>,
        asset_seal_id: vector<u8>,
        content_commitment: vector<u8>,
    }

    struct ExpansionPackCreatedV8 has copy, drop {
        release_id: 0x2::object::ID,
        admin_cap_id: 0x2::object::ID,
        treasury_id: 0x2::object::ID,
        parent_root_id: 0x2::object::ID,
        parent_legacy_maker_id: 0x2::object::ID,
        pack_id: 0x1::string::String,
        pack_version: 0x1::string::String,
        creator: address,
        access_kind: u8,
        purchase_price_atomic: u64,
        content_commitment: vector<u8>,
    }

    struct ExpansionPackManifestBoundV8 has copy, drop {
        release_id: 0x2::object::ID,
        manifest_blob_id: 0x1::string::String,
        manifest_sha256: vector<u8>,
    }

    struct ExpansionPackStyleRegisteredV8 has copy, drop {
        release_id: 0x2::object::ID,
        part_key: 0x1::string::String,
        item_key: 0x1::string::String,
        style_key: 0x1::string::String,
        asset_blob_id: 0x1::string::String,
        asset_sha256: vector<u8>,
        asset_seal_id: vector<u8>,
    }

    struct ExpansionPackSealedV8 has copy, drop {
        release_id: 0x2::object::ID,
        style_count: u64,
        style_registry_commitment: vector<u8>,
    }

    struct ExpansionPackSealPolicyBoundV8 has copy, drop {
        release_id: 0x2::object::ID,
        seal_policy_id: 0x2::object::ID,
        seal_package_id: 0x2::object::ID,
        seal_release_commitment: vector<u8>,
    }

    struct ExpansionPackAdmittedV8 has copy, drop {
        release_id: 0x2::object::ID,
        parent_root_id: 0x2::object::ID,
        parent_legacy_maker_id: 0x2::object::ID,
        admitted_by: address,
        parent_ownership_epoch: u64,
        parent_version: 0x1::string::String,
        parent_manifest_blob_id: 0x1::string::String,
        parent_manifest_sha256: vector<u8>,
    }

    struct ExpansionPackLifecycleChangedV8 has copy, drop {
        release_id: 0x2::object::ID,
        previous_lifecycle: u8,
        lifecycle: u8,
    }

    struct ExpansionPackEntitlementGrantedV8 has copy, drop {
        release_id: 0x2::object::ID,
        parent_root_id: 0x2::object::ID,
        holder: address,
        paid_atomic: u64,
        pass_id: 0x2::object::ID,
        admitted_parent_ownership_epoch: u64,
    }

    struct ExpansionPackRevenueWithdrawnV8 has copy, drop {
        release_id: 0x2::object::ID,
        treasury_id: 0x2::object::ID,
        amount: u64,
        recipient: address,
    }

    public fun access_free_v8() : u8 {
        0
    }

    public fun access_paid_once_v8() : u8 {
        1
    }

    public fun activate_expansion_pack_v8(arg0: &mut ExpansionPackReleaseV8, arg1: &ExpansionPackAdminCapV8, arg2: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerRootV5, arg3: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::CommerceProtocolConfigV5, arg4: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg1, arg4);
        assert!(arg0.lifecycle == 2, 3);
        assert_release_root(arg0, arg2);
        assert_current_parent_epoch(arg0, arg2);
        0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::assert_extension_operational_v5(arg2, arg3);
        set_lifecycle(arg0, 3);
    }

    public fun admin_cap_creator_v8(arg0: &ExpansionPackAdminCapV8) : address {
        arg0.creator
    }

    public fun admin_cap_release_id_v8(arg0: &ExpansionPackAdminCapV8) : 0x2::object::ID {
        arg0.release_id
    }

    public fun admit_expansion_pack_v8(arg0: &mut ExpansionPackReleaseV8, arg1: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerRootV5, arg2: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::OCMaker, arg3: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerControlCapV5, arg4: &0x2::tx_context::TxContext) {
        assert!(arg0.lifecycle != 0, 3);
        assert!(arg0.lifecycle != 5, 3);
        assert_parent_binding(arg1, arg2);
        assert_release_parent(arg0, arg1, arg2);
        0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::assert_extension_maker_release_evidence_v5(arg1, arg2, &arg0.parent_version, &arg0.parent_manifest_blob_id, &arg0.parent_manifest_sha256);
        assert!(0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::style_registry_sealed_v5(arg1), 0);
        0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::assert_extension_control_v5(arg1, arg3, arg4);
        if (arg0.access_kind == 1) {
            assert!(0x1::option::is_some<0x2::object::ID>(&arg0.seal_policy_id), 8);
            assert!(0x1::option::is_some<0x2::object::ID>(&arg0.seal_package_id), 8);
            assert!(*0x1::option::borrow<0x2::object::ID>(&arg0.seal_package_id) == current_seal_package_id_v8(), 8);
        };
        let v0 = 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::root_ownership_epoch_v5(arg1);
        assert!(arg0.lifecycle == 1 || arg0.admitted_parent_ownership_epoch != v0, 3);
        arg0.admitted_by = 0x2::tx_context::sender(arg4);
        arg0.admitted_parent_ownership_epoch = v0;
        set_lifecycle(arg0, 2);
        let v1 = ExpansionPackAdmittedV8{
            release_id              : 0x2::object::id<ExpansionPackReleaseV8>(arg0),
            parent_root_id          : 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::root_id_v5(arg1),
            parent_legacy_maker_id  : 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::maker_id(arg2),
            admitted_by             : 0x2::tx_context::sender(arg4),
            parent_ownership_epoch  : v0,
            parent_version          : arg0.parent_version,
            parent_manifest_blob_id : arg0.parent_manifest_blob_id,
            parent_manifest_sha256  : arg0.parent_manifest_sha256,
        };
        0x2::event::emit<ExpansionPackAdmittedV8>(v1);
    }

    public fun archive_expansion_pack_v8(arg0: &mut ExpansionPackReleaseV8, arg1: &ExpansionPackAdminCapV8, arg2: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg1, arg2);
        assert!(arg0.lifecycle != 3, 3);
        assert!(arg0.lifecycle != 5, 3);
        set_lifecycle(arg0, 5);
    }

    fun assert_admin(arg0: &ExpansionPackReleaseV8, arg1: &ExpansionPackAdminCapV8, arg2: &0x2::tx_context::TxContext) {
        assert!(arg1.version == 8, 4);
        assert!(arg1.release_id == 0x2::object::id<ExpansionPackReleaseV8>(arg0), 4);
        assert!(0x2::object::id<ExpansionPackAdminCapV8>(arg1) == arg0.admin_cap_id, 4);
        assert!(arg1.creator == arg0.creator, 4);
        assert!(0x2::tx_context::sender(arg2) == arg0.creator, 4);
    }

    public fun assert_complete_bridge_enabled_v8() {
        abort 17
    }

    fun assert_current_parent_epoch(arg0: &ExpansionPackReleaseV8, arg1: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerRootV5) {
        assert!(arg0.admitted_parent_ownership_epoch == 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::root_ownership_epoch_v5(arg1), 10);
    }

    fun assert_digest(arg0: &vector<u8>) {
        assert!(0x1::vector::length<u8>(arg0) == 32, 1);
    }

    fun assert_non_empty(arg0: &0x1::string::String) {
        assert!(0x1::vector::length<u8>(0x1::string::as_bytes(arg0)) > 0, 0);
    }

    fun assert_parent_binding(arg0: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerRootV5, arg1: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::OCMaker) {
        assert!(0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::root_legacy_maker_id_v5(arg0) == 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::maker_id(arg1), 0);
    }

    public fun assert_physical_bridge_enabled_v8() {
        abort 17
    }

    fun assert_release_operational(arg0: &ExpansionPackReleaseV8, arg1: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerRootV5, arg2: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::CommerceProtocolConfigV5, arg3: address) {
        assert!(arg0.lifecycle == 3, 3);
        assert_release_root(arg0, arg1);
        assert_current_parent_epoch(arg0, arg1);
        assert!(0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::has_base_entitlement_v5(arg1, arg3), 12);
        0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::assert_extension_operational_v5(arg1, arg2);
    }

    fun assert_release_parent(arg0: &ExpansionPackReleaseV8, arg1: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerRootV5, arg2: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::OCMaker) {
        assert_release_root(arg0, arg1);
        assert!(arg0.parent_legacy_maker_id == 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::maker_id(arg2), 0);
    }

    fun assert_release_root(arg0: &ExpansionPackReleaseV8, arg1: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerRootV5) {
        assert!(arg0.parent_root_id == 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::root_id_v5(arg1), 0);
        assert!(arg0.parent_legacy_maker_id == 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::root_legacy_maker_id_v5(arg1), 0);
    }

    fun assert_treasury<T0>(arg0: &ExpansionPackReleaseV8, arg1: &ExpansionPackTreasuryV8<T0>) {
        assert!(arg1.version == 8, 14);
        assert!(arg1.release_id == 0x2::object::id<ExpansionPackReleaseV8>(arg0), 14);
        assert!(0x2::object::id<ExpansionPackTreasuryV8<T0>>(arg1) == arg0.treasury_id, 14);
    }

    fun assert_valid_access(arg0: u8, arg1: u64) {
        assert!(arg0 == 0 && arg1 == 0 || arg0 == 1 && arg1 > 0, 2);
    }

    public fun bind_expansion_pack_manifest_v8(arg0: &mut ExpansionPackReleaseV8, arg1: &ExpansionPackAdminCapV8, arg2: 0x1::string::String, arg3: vector<u8>, arg4: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg1, arg4);
        assert!(arg0.lifecycle == 0, 3);
        assert!(!arg0.manifest_bound, 0);
        assert!(arg0.style_count == 0, 3);
        assert_non_empty(&arg2);
        assert_digest(&arg3);
        arg0.manifest_bound = true;
        arg0.manifest_blob_id = arg2;
        arg0.manifest_sha256 = arg3;
        let v0 = ExpansionPackManifestBoundV8{
            release_id       : 0x2::object::id<ExpansionPackReleaseV8>(arg0),
            manifest_blob_id : arg2,
            manifest_sha256  : arg3,
        };
        0x2::event::emit<ExpansionPackManifestBoundV8>(v0);
    }

    public fun bind_expansion_pack_seal_policy_v8(arg0: &mut ExpansionPackReleaseV8, arg1: &ExpansionPackAdminCapV8, arg2: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg1, arg2);
        assert!(arg0.lifecycle == 1, 3);
        assert!(0x1::option::is_none<0x2::object::ID>(&arg0.seal_policy_id), 9);
        assert!(0x1::option::is_none<0x2::object::ID>(&arg0.seal_package_id), 9);
        let v0 = 0x2::object::id<ExpansionPackReleaseV8>(arg0);
        let v1 = current_seal_package_id_v8();
        let v2 = derive_seal_release_commitment_v8(v0, arg0.content_commitment);
        arg0.seal_policy_id = 0x1::option::some<0x2::object::ID>(v0);
        arg0.seal_package_id = 0x1::option::some<0x2::object::ID>(v1);
        arg0.seal_release_commitment = v2;
        let v3 = ExpansionPackSealPolicyBoundV8{
            release_id              : 0x2::object::id<ExpansionPackReleaseV8>(arg0),
            seal_policy_id          : v0,
            seal_package_id         : v1,
            seal_release_commitment : v2,
        };
        0x2::event::emit<ExpansionPackSealPolicyBoundV8>(v3);
    }

    public fun check_style_seal_access_v8(arg0: vector<u8>, arg1: &ExpansionPackReleaseV8, arg2: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerRootV5, arg3: address) : bool {
        assert_release_root(arg1, arg2);
        if (arg1.lifecycle < 2) {
            return false
        };
        if (0x1::option::is_none<0x2::object::ID>(&arg1.seal_policy_id)) {
            return false
        };
        if (*0x1::option::borrow<0x2::object::ID>(&arg1.seal_policy_id) != 0x2::object::id<ExpansionPackReleaseV8>(arg1)) {
            return false
        };
        if (0x1::option::is_none<0x2::object::ID>(&arg1.seal_package_id)) {
            return false
        };
        if (*0x1::option::borrow<0x2::object::ID>(&arg1.seal_package_id) != current_seal_package_id_v8()) {
            return false
        };
        let v0 = derive_seal_release_commitment_v8(0x2::object::id<ExpansionPackReleaseV8>(arg1), arg1.content_commitment);
        if (arg1.seal_release_commitment != v0) {
            return false
        };
        if (!0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::has_base_entitlement_v5(arg2, arg3)) {
            return false
        };
        if (!0x2::table::contains<address, EntitlementRecordV8>(&arg1.entitlements, arg3)) {
            return false
        };
        if (!0x2::table::contains<vector<u8>, StyleAssetKeyV8>(&arg1.seal_assets, arg0)) {
            return false
        };
        let v1 = 0x2::table::borrow<vector<u8>, StyleAssetKeyV8>(&arg1.seal_assets, arg0);
        let v2 = 0x2::table::borrow<StyleAssetKeyV8, StyleAssetRecordV8>(&arg1.styles, *v1);
        if (v2.asset_seal_id != arg0) {
            return false
        };
        0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::seal_v5::derive_seal_id_v5(v0, 1, v1.part_key, v1.item_key, v1.style_key, arg1.pack_id, v2.asset_sha256) == arg0
    }

    public fun claim_free_expansion_pack_v8(arg0: &mut ExpansionPackReleaseV8, arg1: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerRootV5, arg2: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::CommerceProtocolConfigV5, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_release_operational(arg0, arg1, arg2, 0x2::tx_context::sender(arg4));
        assert!(arg0.access_kind == 0, 2);
        issue_entitlement(arg0, 0, arg3, arg4);
    }

    public fun complete_bridge_enabled_v8() : bool {
        false
    }

    public fun create_expansion_pack_v8<T0>(arg0: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerRootV5, arg1: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::OCMaker, arg2: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::CommerceProtocolConfigV5, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: vector<u8>, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: vector<u8>, arg10: u8, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = payment_coin_type_name<T0>();
        assert!(&v0 == 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::extension_payment_coin_type_v5(arg2), 18);
        let (v1, v2, v3) = new_expansion_pack_objects_v8<T0>(arg0, arg1, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
        0x2::transfer::share_object<ExpansionPackReleaseV8>(v1);
        0x2::transfer::share_object<ExpansionPackTreasuryV8<T0>>(v2);
        0x2::transfer::transfer<ExpansionPackAdminCapV8>(v3, 0x2::tx_context::sender(arg12));
    }

    fun current_seal_package_id_v8() : 0x2::object::ID {
        0x2::object::id_from_address(0x1::type_name::defining_id<ExpansionPackReleaseV8>())
    }

    public fun derive_seal_release_commitment_v8(arg0: 0x2::object::ID, arg1: vector<u8>) : vector<u8> {
        assert_digest(&arg1);
        let v0 = ExpansionPackSealReleaseScopeV8{
            release_id         : arg0,
            content_commitment : arg1,
        };
        0x1::hash::sha2_256(0x1::bcs::to_bytes<ExpansionPackSealReleaseScopeV8>(&v0))
    }

    public fun has_entitlement_v8(arg0: &ExpansionPackReleaseV8, arg1: address) : bool {
        0x2::table::contains<address, EntitlementRecordV8>(&arg0.entitlements, arg1)
    }

    fun issue_entitlement(arg0: &mut ExpansionPackReleaseV8, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::table::contains<address, EntitlementRecordV8>(&arg0.entitlements, 0x2::tx_context::sender(arg3)), 11);
        let v0 = arg0.admitted_parent_ownership_epoch;
        let v1 = EntitlementRecordV8{
            paid_atomic                     : arg1,
            issued_at_ms                    : 0x2::clock::timestamp_ms(arg2),
            admitted_parent_ownership_epoch : v0,
        };
        0x2::table::add<address, EntitlementRecordV8>(&mut arg0.entitlements, 0x2::tx_context::sender(arg3), v1);
        arg0.entitlement_count = arg0.entitlement_count + 1;
        let v2 = ExpansionPackPassV8{
            id                              : 0x2::object::new(arg3),
            version                         : 8,
            release_id                      : 0x2::object::id<ExpansionPackReleaseV8>(arg0),
            parent_root_id                  : arg0.parent_root_id,
            holder                          : 0x2::tx_context::sender(arg3),
            paid_atomic                     : arg1,
            issued_at_ms                    : 0x2::clock::timestamp_ms(arg2),
            admitted_parent_ownership_epoch : v0,
            content_commitment              : arg0.content_commitment,
        };
        let v3 = ExpansionPackEntitlementGrantedV8{
            release_id                      : 0x2::object::id<ExpansionPackReleaseV8>(arg0),
            parent_root_id                  : arg0.parent_root_id,
            holder                          : 0x2::tx_context::sender(arg3),
            paid_atomic                     : arg1,
            pass_id                         : 0x2::object::id<ExpansionPackPassV8>(&v2),
            admitted_parent_ownership_epoch : v0,
        };
        0x2::event::emit<ExpansionPackEntitlementGrantedV8>(v3);
        0x2::transfer::transfer<ExpansionPackPassV8>(v2, 0x2::tx_context::sender(arg3));
    }

    public fun lifecycle_active_v8() : u8 {
        3
    }

    public fun lifecycle_admitted_v8() : u8 {
        2
    }

    public fun lifecycle_archived_v8() : u8 {
        5
    }

    public fun lifecycle_draft_v8() : u8 {
        0
    }

    public fun lifecycle_paused_v8() : u8 {
        4
    }

    public fun lifecycle_sealed_v8() : u8 {
        1
    }

    fun new_expansion_pack_objects_v8<T0>(arg0: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerRootV5, arg1: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::OCMaker, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: vector<u8>, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: vector<u8>, arg9: u8, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) : (ExpansionPackReleaseV8, ExpansionPackTreasuryV8<T0>, ExpansionPackAdminCapV8) {
        assert_parent_binding(arg0, arg1);
        assert!(0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::maker_manifest_blob_id(arg1) == &arg3, 0);
        assert_non_empty(&arg2);
        assert_non_empty(&arg3);
        assert_digest(&arg4);
        0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::assert_extension_maker_release_evidence_v5(arg0, arg1, &arg2, &arg3, &arg4);
        assert_non_empty(&arg5);
        assert_non_empty(&arg6);
        assert_non_empty(&arg7);
        assert_digest(&arg8);
        assert_valid_access(arg9, arg10);
        let v0 = 0x2::tx_context::sender(arg11);
        let v1 = 0x2::object::new(arg11);
        let v2 = 0x2::object::uid_to_inner(&v1);
        let v3 = 0x2::object::new(arg11);
        let v4 = 0x2::object::uid_to_inner(&v3);
        let v5 = 0x2::object::new(arg11);
        let v6 = 0x2::object::uid_to_inner(&v5);
        let v7 = ExpansionPackReleaseV8{
            id                              : v1,
            version                         : 8,
            parent_root_id                  : 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::root_id_v5(arg0),
            parent_legacy_maker_id          : 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::maker_id(arg1),
            parent_version                  : arg2,
            parent_manifest_blob_id         : arg3,
            parent_manifest_sha256          : arg4,
            pack_id                         : arg5,
            namespace                       : arg6,
            pack_version                    : arg7,
            creator                         : v0,
            manifest_bound                  : false,
            manifest_blob_id                : 0x1::string::utf8(b""),
            manifest_sha256                 : b"",
            content_commitment              : arg8,
            style_registry_commitment       : b"",
            seal_policy_id                  : 0x1::option::none<0x2::object::ID>(),
            seal_package_id                 : 0x1::option::none<0x2::object::ID>(),
            seal_release_commitment         : b"",
            access_kind                     : arg9,
            purchase_price_atomic           : arg10,
            lifecycle                       : 0,
            admin_cap_id                    : v6,
            treasury_id                     : v4,
            admitted_by                     : @0x0,
            admitted_parent_ownership_epoch : 0,
            styles                          : 0x2::table::new<StyleAssetKeyV8, StyleAssetRecordV8>(arg11),
            seal_assets                     : 0x2::table::new<vector<u8>, StyleAssetKeyV8>(arg11),
            style_keys                      : 0x1::vector::empty<StyleAssetKeyV8>(),
            entitlements                    : 0x2::table::new<address, EntitlementRecordV8>(arg11),
            style_count                     : 0,
            entitlement_count               : 0,
        };
        let v8 = ExpansionPackTreasuryV8<T0>{
            id              : v3,
            version         : 8,
            release_id      : v2,
            revenue         : 0x2::balance::zero<T0>(),
            total_collected : 0,
            total_withdrawn : 0,
        };
        let v9 = ExpansionPackAdminCapV8{
            id         : v5,
            version    : 8,
            release_id : v2,
            creator    : v0,
        };
        let v10 = ExpansionPackCreatedV8{
            release_id             : v2,
            admin_cap_id           : v6,
            treasury_id            : v4,
            parent_root_id         : 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::root_id_v5(arg0),
            parent_legacy_maker_id : 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::maker_id(arg1),
            pack_id                : arg5,
            pack_version           : arg7,
            creator                : v0,
            access_kind            : arg9,
            purchase_price_atomic  : arg10,
            content_commitment     : arg8,
        };
        0x2::event::emit<ExpansionPackCreatedV8>(v10);
        (v7, v8, v9)
    }

    public fun pass_content_commitment_v8(arg0: &ExpansionPackPassV8) : &vector<u8> {
        &arg0.content_commitment
    }

    public fun pass_holder_v8(arg0: &ExpansionPackPassV8) : address {
        arg0.holder
    }

    public fun pass_issued_at_ms_v8(arg0: &ExpansionPackPassV8) : u64 {
        arg0.issued_at_ms
    }

    public fun pass_paid_atomic_v8(arg0: &ExpansionPackPassV8) : u64 {
        arg0.paid_atomic
    }

    public fun pass_parent_epoch_v8(arg0: &ExpansionPackPassV8) : u64 {
        arg0.admitted_parent_ownership_epoch
    }

    public fun pass_parent_root_id_v8(arg0: &ExpansionPackPassV8) : 0x2::object::ID {
        arg0.parent_root_id
    }

    public fun pass_release_id_v8(arg0: &ExpansionPackPassV8) : 0x2::object::ID {
        arg0.release_id
    }

    public fun pause_expansion_pack_v8(arg0: &mut ExpansionPackReleaseV8, arg1: &ExpansionPackAdminCapV8, arg2: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg1, arg2);
        assert!(arg0.lifecycle == 3, 3);
        set_lifecycle(arg0, 4);
    }

    fun payment_coin_type_name<T0>() : 0x1::string::String {
        0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()))
    }

    public fun physical_bridge_enabled_v8() : bool {
        false
    }

    public fun purchase_expansion_pack_v8<T0>(arg0: &mut ExpansionPackReleaseV8, arg1: &mut ExpansionPackTreasuryV8<T0>, arg2: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerRootV5, arg3: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::CommerceProtocolConfigV5, arg4: &mut 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::CommerceProtocolTreasuryV5<T0>, arg5: 0x2::coin::Coin<T0>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert_release_operational(arg0, arg2, arg3, 0x2::tx_context::sender(arg7));
        assert_treasury<T0>(arg0, arg1);
        assert!(arg0.access_kind == 1, 2);
        assert!(arg0.purchase_price_atomic > 0, 13);
        assert!(!0x2::table::contains<address, EntitlementRecordV8>(&arg0.entitlements, 0x2::tx_context::sender(arg7)), 11);
        let v0 = arg0.purchase_price_atomic;
        assert!(0x2::coin::value<T0>(&arg5) == v0, 13);
        let v1 = 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::collect_extension_primary_payment_v5<T0>(arg2, arg3, arg4, arg5, v0, arg7);
        arg1.total_collected = arg1.total_collected + 0x2::coin::value<T0>(&v1);
        0x2::coin::put<T0>(&mut arg1.revenue, v1);
        issue_entitlement(arg0, v0, arg6, arg7);
    }

    public fun register_style_asset_v8(arg0: &mut ExpansionPackReleaseV8, arg1: &ExpansionPackAdminCapV8, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: vector<u8>, arg7: vector<u8>, arg8: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg1, arg8);
        assert!(arg0.lifecycle == 0, 3);
        assert!(arg0.manifest_bound, 0);
        assert_non_empty(&arg2);
        assert_non_empty(&arg3);
        assert_non_empty(&arg4);
        assert_non_empty(&arg5);
        assert_digest(&arg6);
        if (arg0.access_kind == 1) {
            assert_digest(&arg7);
        } else {
            assert!(0x1::vector::length<u8>(&arg7) == 0, 1);
        };
        let v0 = StyleAssetKeyV8{
            part_key  : arg2,
            item_key  : arg3,
            style_key : arg4,
        };
        assert!(!0x2::table::contains<StyleAssetKeyV8, StyleAssetRecordV8>(&arg0.styles, v0), 5);
        if (0x1::vector::length<u8>(&arg7) == 32) {
            assert!(arg7 == 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::seal_v5::derive_seal_id_v5(derive_seal_release_commitment_v8(0x2::object::id<ExpansionPackReleaseV8>(arg0), arg0.content_commitment), 1, arg2, arg3, arg4, arg0.pack_id, arg6), 1);
            assert!(!0x2::table::contains<vector<u8>, StyleAssetKeyV8>(&arg0.seal_assets, arg7), 5);
            0x2::table::add<vector<u8>, StyleAssetKeyV8>(&mut arg0.seal_assets, arg7, v0);
        };
        let v1 = StyleAssetRecordV8{
            asset_blob_id : arg5,
            asset_sha256  : arg6,
            asset_seal_id : arg7,
        };
        0x2::table::add<StyleAssetKeyV8, StyleAssetRecordV8>(&mut arg0.styles, v0, v1);
        0x1::vector::push_back<StyleAssetKeyV8>(&mut arg0.style_keys, v0);
        arg0.style_count = arg0.style_count + 1;
        let v2 = ExpansionPackStyleRegisteredV8{
            release_id    : 0x2::object::id<ExpansionPackReleaseV8>(arg0),
            part_key      : arg2,
            item_key      : arg3,
            style_key     : arg4,
            asset_blob_id : arg5,
            asset_sha256  : arg6,
            asset_seal_id : arg7,
        };
        0x2::event::emit<ExpansionPackStyleRegisteredV8>(v2);
    }

    public fun release_access_kind_v8(arg0: &ExpansionPackReleaseV8) : u8 {
        arg0.access_kind
    }

    public fun release_admin_cap_id_v8(arg0: &ExpansionPackReleaseV8) : 0x2::object::ID {
        arg0.admin_cap_id
    }

    public fun release_admitted_by_v8(arg0: &ExpansionPackReleaseV8) : address {
        arg0.admitted_by
    }

    public fun release_admitted_parent_epoch_v8(arg0: &ExpansionPackReleaseV8) : u64 {
        arg0.admitted_parent_ownership_epoch
    }

    public fun release_content_commitment_v8(arg0: &ExpansionPackReleaseV8) : &vector<u8> {
        &arg0.content_commitment
    }

    public fun release_creator_v8(arg0: &ExpansionPackReleaseV8) : address {
        arg0.creator
    }

    public fun release_entitlement_count_v8(arg0: &ExpansionPackReleaseV8) : u64 {
        arg0.entitlement_count
    }

    public fun release_entitlements_table_id_v8(arg0: &ExpansionPackReleaseV8) : 0x2::object::ID {
        0x2::object::id<0x2::table::Table<address, EntitlementRecordV8>>(&arg0.entitlements)
    }

    public fun release_id_v8(arg0: &ExpansionPackReleaseV8) : 0x2::object::ID {
        0x2::object::id<ExpansionPackReleaseV8>(arg0)
    }

    public fun release_lifecycle_v8(arg0: &ExpansionPackReleaseV8) : u8 {
        arg0.lifecycle
    }

    public fun release_manifest_blob_id_v8(arg0: &ExpansionPackReleaseV8) : &0x1::string::String {
        &arg0.manifest_blob_id
    }

    public fun release_manifest_bound_v8(arg0: &ExpansionPackReleaseV8) : bool {
        arg0.manifest_bound
    }

    public fun release_manifest_sha256_v8(arg0: &ExpansionPackReleaseV8) : &vector<u8> {
        &arg0.manifest_sha256
    }

    public fun release_namespace_v8(arg0: &ExpansionPackReleaseV8) : &0x1::string::String {
        &arg0.namespace
    }

    public fun release_pack_id_v8(arg0: &ExpansionPackReleaseV8) : &0x1::string::String {
        &arg0.pack_id
    }

    public fun release_pack_version_v8(arg0: &ExpansionPackReleaseV8) : &0x1::string::String {
        &arg0.pack_version
    }

    public fun release_parent_legacy_maker_id_v8(arg0: &ExpansionPackReleaseV8) : 0x2::object::ID {
        arg0.parent_legacy_maker_id
    }

    public fun release_parent_manifest_blob_id_v8(arg0: &ExpansionPackReleaseV8) : &0x1::string::String {
        &arg0.parent_manifest_blob_id
    }

    public fun release_parent_manifest_sha256_v8(arg0: &ExpansionPackReleaseV8) : &vector<u8> {
        &arg0.parent_manifest_sha256
    }

    public fun release_parent_root_id_v8(arg0: &ExpansionPackReleaseV8) : 0x2::object::ID {
        arg0.parent_root_id
    }

    public fun release_parent_version_v8(arg0: &ExpansionPackReleaseV8) : &0x1::string::String {
        &arg0.parent_version
    }

    public fun release_purchase_price_v8(arg0: &ExpansionPackReleaseV8) : u64 {
        arg0.purchase_price_atomic
    }

    public fun release_seal_assets_table_id_v8(arg0: &ExpansionPackReleaseV8) : 0x2::object::ID {
        0x2::object::id<0x2::table::Table<vector<u8>, StyleAssetKeyV8>>(&arg0.seal_assets)
    }

    public fun release_seal_commitment_v8(arg0: &ExpansionPackReleaseV8) : &vector<u8> {
        &arg0.seal_release_commitment
    }

    public fun release_seal_package_id_v8(arg0: &ExpansionPackReleaseV8) : 0x1::option::Option<0x2::object::ID> {
        arg0.seal_package_id
    }

    public fun release_seal_policy_id_v8(arg0: &ExpansionPackReleaseV8) : 0x1::option::Option<0x2::object::ID> {
        arg0.seal_policy_id
    }

    public fun release_style_count_v8(arg0: &ExpansionPackReleaseV8) : u64 {
        arg0.style_count
    }

    public fun release_style_registry_commitment_v8(arg0: &ExpansionPackReleaseV8) : &vector<u8> {
        &arg0.style_registry_commitment
    }

    public fun release_styles_table_id_v8(arg0: &ExpansionPackReleaseV8) : 0x2::object::ID {
        0x2::object::id<0x2::table::Table<StyleAssetKeyV8, StyleAssetRecordV8>>(&arg0.styles)
    }

    public fun release_treasury_id_v8(arg0: &ExpansionPackReleaseV8) : 0x2::object::ID {
        arg0.treasury_id
    }

    public fun resume_expansion_pack_v8(arg0: &mut ExpansionPackReleaseV8, arg1: &ExpansionPackAdminCapV8, arg2: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerRootV5, arg3: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::CommerceProtocolConfigV5, arg4: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg1, arg4);
        assert!(arg0.lifecycle == 4, 3);
        assert_release_root(arg0, arg2);
        assert_current_parent_epoch(arg0, arg2);
        0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::assert_extension_operational_v5(arg2, arg3);
        set_lifecycle(arg0, 3);
    }

    entry fun seal_approve_style_v8(arg0: vector<u8>, arg1: &ExpansionPackReleaseV8, arg2: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerRootV5, arg3: &0x2::tx_context::TxContext) {
        assert!(check_style_seal_access_v8(arg0, arg1, arg2, 0x2::tx_context::sender(arg3)), 12);
    }

    public fun seal_expansion_pack_v8(arg0: &mut ExpansionPackReleaseV8, arg1: &ExpansionPackAdminCapV8, arg2: vector<u8>, arg3: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg1, arg3);
        assert!(arg0.lifecycle == 0, 3);
        assert!(arg0.manifest_bound, 0);
        assert!(arg0.style_count > 0, 7);
        assert_digest(&arg2);
        arg0.style_registry_commitment = arg2;
        set_lifecycle(arg0, 1);
        let v0 = ExpansionPackSealedV8{
            release_id                : 0x2::object::id<ExpansionPackReleaseV8>(arg0),
            style_count               : arg0.style_count,
            style_registry_commitment : arg2,
        };
        0x2::event::emit<ExpansionPackSealedV8>(v0);
    }

    fun set_lifecycle(arg0: &mut ExpansionPackReleaseV8, arg1: u8) {
        arg0.lifecycle = arg1;
        let v0 = ExpansionPackLifecycleChangedV8{
            release_id         : 0x2::object::id<ExpansionPackReleaseV8>(arg0),
            previous_lifecycle : arg0.lifecycle,
            lifecycle          : arg1,
        };
        0x2::event::emit<ExpansionPackLifecycleChangedV8>(v0);
    }

    public fun style_access_proof_blob_id_v8(arg0: &ExpansionPackStyleAccessProofV8) : &0x1::string::String {
        &arg0.asset_blob_id
    }

    public fun style_access_proof_content_commitment_v8(arg0: &ExpansionPackStyleAccessProofV8) : &vector<u8> {
        &arg0.content_commitment
    }

    public fun style_access_proof_holder_v8(arg0: &ExpansionPackStyleAccessProofV8) : address {
        arg0.holder
    }

    public fun style_access_proof_item_key_v8(arg0: &ExpansionPackStyleAccessProofV8) : &0x1::string::String {
        &arg0.item_key
    }

    public fun style_access_proof_parent_root_id_v8(arg0: &ExpansionPackStyleAccessProofV8) : 0x2::object::ID {
        arg0.parent_root_id
    }

    public fun style_access_proof_part_key_v8(arg0: &ExpansionPackStyleAccessProofV8) : &0x1::string::String {
        &arg0.part_key
    }

    public fun style_access_proof_release_id_v8(arg0: &ExpansionPackStyleAccessProofV8) : 0x2::object::ID {
        arg0.release_id
    }

    public fun style_access_proof_seal_id_v8(arg0: &ExpansionPackStyleAccessProofV8) : &vector<u8> {
        &arg0.asset_seal_id
    }

    public fun style_access_proof_sha256_v8(arg0: &ExpansionPackStyleAccessProofV8) : &vector<u8> {
        &arg0.asset_sha256
    }

    public fun style_access_proof_style_key_v8(arg0: &ExpansionPackStyleAccessProofV8) : &0x1::string::String {
        &arg0.style_key
    }

    public fun style_asset_blob_id_v8(arg0: &ExpansionPackReleaseV8, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String) : &0x1::string::String {
        let v0 = StyleAssetKeyV8{
            part_key  : arg1,
            item_key  : arg2,
            style_key : arg3,
        };
        &0x2::table::borrow<StyleAssetKeyV8, StyleAssetRecordV8>(&arg0.styles, v0).asset_blob_id
    }

    public fun style_asset_seal_id_v8(arg0: &ExpansionPackReleaseV8, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String) : &vector<u8> {
        let v0 = StyleAssetKeyV8{
            part_key  : arg1,
            item_key  : arg2,
            style_key : arg3,
        };
        &0x2::table::borrow<StyleAssetKeyV8, StyleAssetRecordV8>(&arg0.styles, v0).asset_seal_id
    }

    public fun style_asset_sha256_v8(arg0: &ExpansionPackReleaseV8, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String) : &vector<u8> {
        let v0 = StyleAssetKeyV8{
            part_key  : arg1,
            item_key  : arg2,
            style_key : arg3,
        };
        &0x2::table::borrow<StyleAssetKeyV8, StyleAssetRecordV8>(&arg0.styles, v0).asset_sha256
    }

    public fun style_exists_v8(arg0: &ExpansionPackReleaseV8, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String) : bool {
        let v0 = StyleAssetKeyV8{
            part_key  : arg1,
            item_key  : arg2,
            style_key : arg3,
        };
        0x2::table::contains<StyleAssetKeyV8, StyleAssetRecordV8>(&arg0.styles, v0)
    }

    public fun treasury_balance_v8<T0>(arg0: &ExpansionPackTreasuryV8<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.revenue)
    }

    public fun treasury_release_id_v8<T0>(arg0: &ExpansionPackTreasuryV8<T0>) : 0x2::object::ID {
        arg0.release_id
    }

    public fun treasury_total_collected_v8<T0>(arg0: &ExpansionPackTreasuryV8<T0>) : u64 {
        arg0.total_collected
    }

    public fun treasury_total_withdrawn_v8<T0>(arg0: &ExpansionPackTreasuryV8<T0>) : u64 {
        arg0.total_withdrawn
    }

    public fun verify_style_access_v8(arg0: &ExpansionPackReleaseV8, arg1: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerRootV5, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &0x2::tx_context::TxContext) : ExpansionPackStyleAccessProofV8 {
        assert_release_root(arg0, arg1);
        assert!(arg0.lifecycle >= 2, 3);
        if (arg0.access_kind == 1) {
            assert!(0x1::option::is_some<0x2::object::ID>(&arg0.seal_package_id), 8);
            assert!(*0x1::option::borrow<0x2::object::ID>(&arg0.seal_package_id) == current_seal_package_id_v8(), 8);
        };
        assert!(0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::has_base_entitlement_v5(arg1, 0x2::tx_context::sender(arg5)), 12);
        assert!(0x2::table::contains<address, EntitlementRecordV8>(&arg0.entitlements, 0x2::tx_context::sender(arg5)), 12);
        let v0 = StyleAssetKeyV8{
            part_key  : arg2,
            item_key  : arg3,
            style_key : arg4,
        };
        assert!(0x2::table::contains<StyleAssetKeyV8, StyleAssetRecordV8>(&arg0.styles, v0), 6);
        let v1 = 0x2::table::borrow<StyleAssetKeyV8, StyleAssetRecordV8>(&arg0.styles, v0);
        ExpansionPackStyleAccessProofV8{
            release_id         : 0x2::object::id<ExpansionPackReleaseV8>(arg0),
            parent_root_id     : 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::root_id_v5(arg1),
            holder             : 0x2::tx_context::sender(arg5),
            part_key           : arg2,
            item_key           : arg3,
            style_key          : arg4,
            asset_blob_id      : v1.asset_blob_id,
            asset_sha256       : v1.asset_sha256,
            asset_seal_id      : v1.asset_seal_id,
            content_commitment : arg0.content_commitment,
        }
    }

    public fun version_v8() : u64 {
        8
    }

    public fun withdraw_expansion_pack_revenue_v8<T0>(arg0: &ExpansionPackReleaseV8, arg1: &mut ExpansionPackTreasuryV8<T0>, arg2: &ExpansionPackAdminCapV8, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg2, arg5);
        assert_treasury<T0>(arg0, arg1);
        assert!(arg4 != @0x0, 15);
        assert!(arg3 > 0 && arg3 <= 0x2::balance::value<T0>(&arg1.revenue), 16);
        arg1.total_withdrawn = arg1.total_withdrawn + arg3;
        let v0 = ExpansionPackRevenueWithdrawnV8{
            release_id  : 0x2::object::id<ExpansionPackReleaseV8>(arg0),
            treasury_id : 0x2::object::id<ExpansionPackTreasuryV8<T0>>(arg1),
            amount      : arg3,
            recipient   : arg4,
        };
        0x2::event::emit<ExpansionPackRevenueWithdrawnV8>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.revenue, arg3, arg5), arg4);
    }

    // decompiled from Move bytecode v7
}

