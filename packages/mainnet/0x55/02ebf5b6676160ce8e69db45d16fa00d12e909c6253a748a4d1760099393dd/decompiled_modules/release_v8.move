module 0x5502ebf5b6676160ce8e69db45d16fa00d12e909c6253a748a4d1760099393dd::release_v8 {
    struct ReleaseOriginalMarkerV8 has drop {
        dummy_field: bool,
    }

    struct ReleaseCallableMarkerV8 has drop {
        dummy_field: bool,
    }

    struct ReleasePackageConfigV8 has key {
        id: 0x2::object::UID,
        version: u64,
        catalog_id: 0x2::object::ID,
        product_binding_commitment: vector<u8>,
        call_cap_set_commitment: vector<u8>,
        release_call_cap: 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::PackageCallCapV8<0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::ReleaseRoleV8>,
    }

    struct ReleaseRenderWitnessV8 {
        root_id: 0x2::object::ID,
        catalog_id: 0x2::object::ID,
        output_registry_id: 0x2::object::ID,
        control_epoch: u64,
        caller: address,
    }

    struct ReleaseTransportWitnessV8 {
        root_id: 0x2::object::ID,
        catalog_id: 0x2::object::ID,
        policy_config_id: 0x2::object::ID,
        caller: address,
    }

    struct MakerV8Activated has copy, drop {
        root_id: 0x2::object::ID,
        version: u64,
        owner: address,
        control_epoch: u64,
        admin_cap_id: 0x2::object::ID,
        maker_key: 0x1::string::String,
        maker_version: u64,
        version_commitment: vector<u8>,
        content_commitment: vector<u8>,
        renderer_commitment: vector<u8>,
        protocol_config_id: 0x2::object::ID,
        protocol_config_revision: u64,
        protocol_config_commitment: vector<u8>,
        protocol_treasury_id: 0x2::object::ID,
        maker_treasury_id: 0x2::object::ID,
        catalog_id: 0x2::object::ID,
        product_binding_commitment: vector<u8>,
        call_cap_set_commitment: vector<u8>,
        native_capability_mask: u64,
        capability_binding_commitment: vector<u8>,
        base_registry_id: 0x2::object::ID,
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
    }

    struct MakerV8LifecycleChanged has copy, drop {
        root_id: 0x2::object::ID,
        catalog_id: 0x2::object::ID,
        maker_version: u64,
        content_commitment: vector<u8>,
        owner: address,
        control_epoch: u64,
        from: u8,
        to: u8,
        capability_binding_commitment: vector<u8>,
    }

    public fun finish_unprotected_complete_v8<T0>(arg0: 0x11f7e562023e3ca046e609a6bafedf3c797c40c4bf1a64d15591f0dce0e24937::output_v8::CompleteSessionV8, arg1: &0x11f7e562023e3ca046e609a6bafedf3c797c40c4bf1a64d15591f0dce0e24937::output_v8::OutputRegistryV8, arg2: &0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::maker_v8::MakerRootV8<T0>, arg3: &0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::ProductReleaseCatalogV8, arg4: &ReleasePackageConfigV8, arg5: &0xac29b0d89cbe51ed9d8112763764e94adc6417d976a4a78178dd1c73f1031087::runtime_v8::MakerLoadoutV8, arg6: 0x1::string::String, arg7: vector<u8>, arg8: vector<u8>, arg9: &mut 0x2::tx_context::TxContext) : 0x11f7e562023e3ca046e609a6bafedf3c797c40c4bf1a64d15591f0dce0e24937::output_v8::SoulMintAuthorizationV8 {
        assert_config(arg3, arg4);
        let v0 = assert_bound_root_catalog<T0>(arg2, arg3, arg4);
        assert!(0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::maker_v8::root_lifecycle_v8<T0>(arg2) == 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::maker_v8::lifecycle_active_v8(), 3);
        assert!(0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::maker_v8::capability_output_registry_id_v8(v0) == 0x2::object::id<0x11f7e562023e3ca046e609a6bafedf3c797c40c4bf1a64d15591f0dce0e24937::output_v8::OutputRegistryV8>(arg1), 1);
        let v1 = 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::maker_v8::root_id_v8<T0>(arg2);
        let v2 = 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::catalog_id_v8(arg3);
        let v3 = 0x2::object::id<0x11f7e562023e3ca046e609a6bafedf3c797c40c4bf1a64d15591f0dce0e24937::output_v8::OutputRegistryV8>(arg1);
        let v4 = 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::maker_v8::root_control_epoch_v8<T0>(arg2);
        let v5 = 0x2::tx_context::sender(arg9);
        let v6 = ReleaseRenderWitnessV8{
            root_id            : v1,
            catalog_id         : v2,
            output_registry_id : v3,
            control_epoch      : v4,
            caller             : v5,
        };
        let (v7, v8) = 0x11f7e562023e3ca046e609a6bafedf3c797c40c4bf1a64d15591f0dce0e24937::output_v8::finish_unprotected_complete_v8<T0, ReleaseOriginalMarkerV8, ReleaseRenderWitnessV8>(v6, arg0, arg1, arg2, arg3, arg5, arg6, arg7, arg8, arg9);
        let ReleaseRenderWitnessV8 {
            root_id            : v9,
            catalog_id         : v10,
            output_registry_id : v11,
            control_epoch      : v12,
            caller             : v13,
        } = v7;
        assert!(v9 == v1, 2);
        assert!(v10 == v2, 2);
        assert!(v11 == v3, 2);
        assert!(v12 == v4, 2);
        assert!(v13 == v5, 2);
        v8
    }

    public fun archive_maker_v8<T0>(arg0: &mut 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::maker_v8::MakerRootV8<T0>, arg1: &0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::maker_v8::MakerAdminCapV8, arg2: &0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::ProductReleaseCatalogV8, arg3: &ReleasePackageConfigV8, arg4: &0x2::tx_context::TxContext) {
        assert_config(arg2, arg3);
        let (v0, v1) = 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::activation_v8::archive_maker_v8<T0, ReleaseOriginalMarkerV8, ReleaseCallableMarkerV8>(arg0, arg1, arg2, &arg3.release_call_cap, arg4);
        emit_lifecycle_after_readback<T0>(arg0, arg1, arg2, arg3, v0, v1, arg4);
    }

    public fun pause_maker_v8<T0>(arg0: &mut 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::maker_v8::MakerRootV8<T0>, arg1: &0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::maker_v8::MakerAdminCapV8, arg2: &0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::ProductReleaseCatalogV8, arg3: &ReleasePackageConfigV8, arg4: &0x2::tx_context::TxContext) {
        assert_config(arg2, arg3);
        let (v0, v1) = 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::activation_v8::pause_maker_v8<T0, ReleaseOriginalMarkerV8, ReleaseCallableMarkerV8>(arg0, arg1, arg2, &arg3.release_call_cap, arg4);
        emit_lifecycle_after_readback<T0>(arg0, arg1, arg2, arg3, v0, v1, arg4);
    }

    public fun resume_maker_v8<T0>(arg0: &mut 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::maker_v8::MakerRootV8<T0>, arg1: &0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::maker_v8::MakerAdminCapV8, arg2: &0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::protocol_config_v8::ProtocolConfigV8, arg3: &0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::ProductReleaseCatalogV8, arg4: &ReleasePackageConfigV8, arg5: &0x2::tx_context::TxContext) {
        assert_config(arg3, arg4);
        let (v0, v1) = 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::activation_v8::resume_maker_v8<T0, ReleaseOriginalMarkerV8, ReleaseCallableMarkerV8>(arg0, arg1, arg2, arg3, &arg4.release_call_cap, arg5);
        0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::maker_v8::assert_current_protocol_config_v8<T0>(arg0, arg2);
        0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::assert_catalog_current_v8(arg2, arg3);
        emit_lifecycle_after_readback<T0>(arg0, arg1, arg3, arg4, v0, v1, arg5);
    }

    public fun finalize_product_release_binding_v8<T0>(arg0: &mut 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::maker_v8::MakerRootV8<T0>, arg1: &0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::maker_v8::MakerAdminCapV8, arg2: &0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::protocol_config_v8::ProtocolConfigV8, arg3: &0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::ProductReleaseCatalogV8, arg4: &ReleasePackageConfigV8, arg5: &0x2::tx_context::TxContext) {
        assert_config(arg3, arg4);
        0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::maker_v8::finalize_product_release_binding_v8<T0>(arg0, arg1, arg2, 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::certify_release_catalog_witness_v8(arg2, arg3, &arg4.release_call_cap), arg5);
        assert_root_product_binding<T0>(arg0, arg3, arg4);
    }

    public fun new_license_wrapped_rights_snapshot_v8(arg0: &0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::protocol_config_v8::ProtocolConfigV8, arg1: &0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::ProductReleaseCatalogV8, arg2: &ReleasePackageConfigV8, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: vector<u8>, arg6: vector<u8>, arg7: u16, arg8: u16, arg9: u16, arg10: &0x2::tx_context::TxContext) : 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::maker_v8::RightsSnapshotV8 {
        assert_config(arg1, arg2);
        0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::maker_v8::new_license_wrapped_rights_snapshot_v8(0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::maker_v8::certify_wrapped_rights_v8(arg0, arg1, &arg2.release_call_cap, arg3, arg4, arg5, arg6, arg10), arg7, arg8, arg9)
    }

    fun assert_bound_root_catalog<T0>(arg0: &0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::maker_v8::MakerRootV8<T0>, arg1: &0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::ProductReleaseCatalogV8, arg2: &ReleasePackageConfigV8) : &0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::maker_v8::CapabilityRegistryBindingV8 {
        assert_root_product_binding<T0>(arg0, arg1, arg2);
        let v0 = 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::maker_v8::root_capability_registry_binding_v8<T0>(arg0);
        assert!(0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::maker_v8::capability_catalog_id_v8(v0) == 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::catalog_id_v8(arg1), 1);
        assert!(0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::maker_v8::capability_protocol_config_id_v8(v0) == 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::maker_v8::root_protocol_config_id_v8<T0>(arg0), 1);
        assert!(0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::maker_v8::capability_base_registry_id_v8(v0) == 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::maker_v8::root_base_registry_id_v8<T0>(arg0), 1);
        assert!(0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::maker_v8::capability_maker_treasury_id_v8(v0) == 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::maker_v8::root_maker_treasury_id_v8<T0>(arg0), 1);
        assert!(0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::maker_v8::capability_protocol_treasury_id_v8(v0) == 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::maker_v8::root_protocol_treasury_id_v8<T0>(arg0), 1);
        assert!(0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::maker_v8::capability_native_capability_mask_v8(v0) == 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::native_capability_mask_v8(), 1);
        0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::assert_same_call_cap_set_v8(0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::maker_v8::capability_call_cap_set_v8(v0), 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::catalog_call_cap_set_v8(arg1));
        v0
    }

    fun assert_config(arg0: &0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::ProductReleaseCatalogV8, arg1: &ReleasePackageConfigV8) {
        assert!(arg1.version == 8, 0);
        assert!(arg1.catalog_id == 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::catalog_id_v8(arg0), 0);
        assert!(&arg1.product_binding_commitment == 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::product_binding_commitment_v8(0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::catalog_binding_v8(arg0)), 0);
        assert!(&arg1.call_cap_set_commitment == 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::call_cap_set_commitment_v8(0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::catalog_call_cap_set_v8(arg0)), 0);
        0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::assert_release_call_cap_v8(arg0, &arg1.release_call_cap);
        assert_release_type_origins(arg0);
    }

    fun assert_control_readback<T0>(arg0: &0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::maker_v8::MakerRootV8<T0>, arg1: &0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::maker_v8::MakerAdminCapV8, arg2: &0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::ProductReleaseCatalogV8, arg3: &ReleasePackageConfigV8, arg4: u8, arg5: &0x2::tx_context::TxContext) : &0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::maker_v8::CapabilityRegistryBindingV8 {
        0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::maker_v8::assert_admin_v8<T0>(arg0, arg1);
        assert!(0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::maker_v8::root_owner_v8<T0>(arg0) == 0x2::tx_context::sender(arg5), 1);
        assert!(0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::maker_v8::root_lifecycle_v8<T0>(arg0) == arg4, 3);
        assert_bound_root_catalog<T0>(arg0, arg2, arg3)
    }

    fun assert_release_type_origins(arg0: &0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::ProductReleaseCatalogV8) {
        0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::assert_type_origins_v8<ReleaseOriginalMarkerV8, ReleaseCallableMarkerV8>(0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::release_binding_v8(0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::catalog_binding_v8(arg0)));
    }

    fun assert_root_product_binding<T0>(arg0: &0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::maker_v8::MakerRootV8<T0>, arg1: &0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::ProductReleaseCatalogV8, arg2: &ReleasePackageConfigV8) {
        assert_config(arg1, arg2);
        0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::assert_catalog_snapshot_v8(arg1, 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::maker_v8::root_protocol_config_id_v8<T0>(arg0), 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::maker_v8::root_protocol_config_revision_v8<T0>(arg0), 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::maker_v8::root_protocol_config_commitment_v8<T0>(arg0));
        assert!(0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::maker_v8::root_product_release_catalog_id_v8<T0>(arg0) == 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::catalog_id_v8(arg1), 1);
        assert!(0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::product_binding_commitment_v8(0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::maker_v8::root_product_release_binding_v8<T0>(arg0)) == 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::product_binding_commitment_v8(0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::catalog_binding_v8(arg1)), 1);
        0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::assert_same_call_cap_set_v8(0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::maker_v8::root_product_release_call_cap_set_v8<T0>(arg0), 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::catalog_call_cap_set_v8(arg1));
    }

    public fun certify_base_ciphertext_v8<T0>(arg0: &0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::protocol_config_v8::ProtocolConfigV8, arg1: &0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::ProductReleaseCatalogV8, arg2: &ReleasePackageConfigV8, arg3: &0xe4c9d55d107eac4e493d15449bd56adf7de52bb4e8f220affbd7666403b1a7cb::seal_v8::SealPolicyConfigV8, arg4: &0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::maker_v8::MakerRootV8<T0>, arg5: 0x1::string::String, arg6: vector<u8>, arg7: 0x1::string::String, arg8: vector<u8>, arg9: 0x1::string::String, arg10: vector<u8>, arg11: vector<u8>, arg12: &0x2::tx_context::TxContext) : 0xe4c9d55d107eac4e493d15449bd56adf7de52bb4e8f220affbd7666403b1a7cb::seal_v8::CiphertextCertificationV8 {
        assert_config(arg1, arg2);
        let v0 = 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::maker_v8::root_id_v8<T0>(arg4);
        let v1 = 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::catalog_id_v8(arg1);
        let v2 = 0xe4c9d55d107eac4e493d15449bd56adf7de52bb4e8f220affbd7666403b1a7cb::seal_v8::policy_id_v8(arg3);
        let v3 = 0x2::tx_context::sender(arg12);
        let v4 = ReleaseTransportWitnessV8{
            root_id          : v0,
            catalog_id       : v1,
            policy_config_id : v2,
            caller           : v3,
        };
        let (v5, v6) = 0xe4c9d55d107eac4e493d15449bd56adf7de52bb4e8f220affbd7666403b1a7cb::seal_v8::certify_ciphertext_v8<T0, ReleaseOriginalMarkerV8, ReleaseTransportWitnessV8>(v4, arg0, arg1, arg3, arg4, 0xe4c9d55d107eac4e493d15449bd56adf7de52bb4e8f220affbd7666403b1a7cb::seal_v8::scope_base_v8(), arg5, arg6, arg7, arg8, arg9, arg10, arg11);
        let ReleaseTransportWitnessV8 {
            root_id          : v7,
            catalog_id       : v8,
            policy_config_id : v9,
            caller           : v10,
        } = v5;
        assert!(v7 == v0, 2);
        assert!(v8 == v1, 2);
        assert!(v9 == v2, 2);
        assert!(v10 == v3, 2);
        v6
    }

    public fun config_call_cap_set_commitment_v8(arg0: &ReleasePackageConfigV8) : &vector<u8> {
        &arg0.call_cap_set_commitment
    }

    public fun config_catalog_id_v8(arg0: &ReleasePackageConfigV8) : 0x2::object::ID {
        arg0.catalog_id
    }

    public fun config_id_v8(arg0: &ReleasePackageConfigV8) : 0x2::object::ID {
        0x2::object::id<ReleasePackageConfigV8>(arg0)
    }

    public fun config_product_binding_commitment_v8(arg0: &ReleasePackageConfigV8) : &vector<u8> {
        &arg0.product_binding_commitment
    }

    fun emit_activation<T0>(arg0: &0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::maker_v8::MakerRootV8<T0>, arg1: &0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::maker_v8::MakerAdminCapV8, arg2: &0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::ProductReleaseCatalogV8, arg3: &0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::maker_v8::CapabilityRegistryBindingV8) {
        let v0 = MakerV8Activated{
            root_id                        : 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::maker_v8::root_id_v8<T0>(arg0),
            version                        : 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::maker_v8::root_version_v8<T0>(arg0),
            owner                          : 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::maker_v8::root_owner_v8<T0>(arg0),
            control_epoch                  : 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::maker_v8::root_control_epoch_v8<T0>(arg0),
            admin_cap_id                   : 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::maker_v8::admin_id_v8(arg1),
            maker_key                      : *0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::maker_v8::root_maker_key_v8<T0>(arg0),
            maker_version                  : 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::maker_v8::root_maker_version_v8<T0>(arg0),
            version_commitment             : *0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::maker_v8::root_version_commitment_v8<T0>(arg0),
            content_commitment             : *0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::maker_v8::root_content_commitment_v8<T0>(arg0),
            renderer_commitment            : *0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::maker_v8::root_renderer_commitment_v8<T0>(arg0),
            protocol_config_id             : 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::maker_v8::root_protocol_config_id_v8<T0>(arg0),
            protocol_config_revision       : 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::maker_v8::root_protocol_config_revision_v8<T0>(arg0),
            protocol_config_commitment     : *0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::maker_v8::root_protocol_config_commitment_v8<T0>(arg0),
            protocol_treasury_id           : 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::maker_v8::root_protocol_treasury_id_v8<T0>(arg0),
            maker_treasury_id              : 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::maker_v8::root_maker_treasury_id_v8<T0>(arg0),
            catalog_id                     : 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::catalog_id_v8(arg2),
            product_binding_commitment     : *0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::product_binding_commitment_v8(0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::catalog_binding_v8(arg2)),
            call_cap_set_commitment        : *0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::call_cap_set_commitment_v8(0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::catalog_call_cap_set_v8(arg2)),
            native_capability_mask         : 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::maker_v8::capability_native_capability_mask_v8(arg3),
            capability_binding_commitment  : *0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::maker_v8::capability_binding_commitment_v8(arg3),
            base_registry_id               : 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::maker_v8::capability_base_registry_id_v8(arg3),
            seal_policy_config_id          : 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::maker_v8::capability_seal_policy_config_id_v8(arg3),
            seal_registry_id               : 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::maker_v8::capability_seal_registry_id_v8(arg3),
            runtime_definition_registry_id : 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::maker_v8::capability_runtime_definition_registry_id_v8(arg3),
            pack_registry_id               : 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::maker_v8::capability_pack_registry_id_v8(arg3),
            admission_authority_id         : 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::maker_v8::capability_admission_authority_id_v8(arg3),
            output_registry_id             : 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::maker_v8::capability_output_registry_id_v8(arg3),
            soul_registry_id               : 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::maker_v8::capability_soul_registry_id_v8(arg3),
            physical_registry_id           : 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::maker_v8::capability_physical_registry_id_v8(arg3),
            market_registry_id             : 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::maker_v8::capability_market_registry_id_v8(arg3),
            market_treasury_id             : 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::maker_v8::capability_market_treasury_id_v8(arg3),
        };
        0x2::event::emit<MakerV8Activated>(v0);
    }

    fun emit_lifecycle_after_readback<T0>(arg0: &0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::maker_v8::MakerRootV8<T0>, arg1: &0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::maker_v8::MakerAdminCapV8, arg2: &0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::ProductReleaseCatalogV8, arg3: &ReleasePackageConfigV8, arg4: u8, arg5: u8, arg6: &0x2::tx_context::TxContext) {
        let v0 = assert_control_readback<T0>(arg0, arg1, arg2, arg3, arg5, arg6);
        assert!(arg4 != arg5, 3);
        let v1 = if (arg4 == 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::maker_v8::lifecycle_active_v8() && arg5 == 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::maker_v8::lifecycle_paused_v8()) {
            true
        } else if (arg4 == 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::maker_v8::lifecycle_paused_v8() && arg5 == 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::maker_v8::lifecycle_active_v8()) {
            true
        } else {
            (arg4 == 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::maker_v8::lifecycle_active_v8() || arg4 == 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::maker_v8::lifecycle_paused_v8()) && arg5 == 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::maker_v8::lifecycle_archived_v8()
        };
        assert!(v1, 3);
        let v2 = MakerV8LifecycleChanged{
            root_id                       : 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::maker_v8::root_id_v8<T0>(arg0),
            catalog_id                    : 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::catalog_id_v8(arg2),
            maker_version                 : 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::maker_v8::root_maker_version_v8<T0>(arg0),
            content_commitment            : *0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::maker_v8::root_content_commitment_v8<T0>(arg0),
            owner                         : 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::maker_v8::root_owner_v8<T0>(arg0),
            control_epoch                 : 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::maker_v8::root_control_epoch_v8<T0>(arg0),
            from                          : arg4,
            to                            : arg5,
            capability_binding_commitment : *0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::maker_v8::capability_binding_commitment_v8(v0),
        };
        0x2::event::emit<MakerV8LifecycleChanged>(v2);
    }

    public fun new_release_package_config_v8(arg0: &0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::ProductReleaseCatalogV8, arg1: 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::PackageCallCapV8<0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::ReleaseRoleV8>, arg2: &mut 0x2::tx_context::TxContext) : ReleasePackageConfigV8 {
        0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::assert_release_call_cap_v8(arg0, &arg1);
        assert_release_type_origins(arg0);
        ReleasePackageConfigV8{
            id                         : 0x2::object::new(arg2),
            version                    : 8,
            catalog_id                 : 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::catalog_id_v8(arg0),
            product_binding_commitment : *0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::product_binding_commitment_v8(0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::catalog_binding_v8(arg0)),
            call_cap_set_commitment    : *0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::call_cap_set_commitment_v8(0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::catalog_call_cap_set_v8(arg0)),
            release_call_cap           : arg1,
        }
    }

    public fun seal_and_activate_maker_v8<T0>(arg0: &mut 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::maker_v8::MakerRootV8<T0>, arg1: &0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::maker_v8::MakerAdminCapV8, arg2: &0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::protocol_config_v8::ProtocolConfigV8, arg3: &0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::ProductReleaseCatalogV8, arg4: &0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::base_registry_v8::BaseDefinitionRegistryV8, arg5: &0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::treasury_v8::MakerTreasuryV8<T0>, arg6: &0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::protocol_config_v8::ProtocolTreasuryV8<T0>, arg7: &ReleasePackageConfigV8, arg8: 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::activation_v8::SealReadinessV8, arg9: 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::activation_v8::RuntimeActivationReadinessV8, arg10: 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::activation_v8::OutputReadinessV8, arg11: 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::activation_v8::PhysicalReadinessV8, arg12: 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::activation_v8::MarketReadinessV8, arg13: &0x2::tx_context::TxContext) {
        assert_config(arg3, arg7);
        0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::activation_v8::activate_maker_v8<T0, ReleaseOriginalMarkerV8, ReleaseCallableMarkerV8>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, &arg7.release_call_cap, arg8, arg9, arg10, arg11, arg12, arg13);
        0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::maker_v8::assert_current_protocol_config_v8<T0>(arg0, arg2);
        0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8::assert_catalog_current_v8(arg2, arg3);
        let v0 = assert_control_readback<T0>(arg0, arg1, arg3, arg7, 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::maker_v8::lifecycle_active_v8(), arg13);
        assert!(0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::maker_v8::capability_base_registry_id_v8(v0) == 0x2::object::id<0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::base_registry_v8::BaseDefinitionRegistryV8>(arg4), 1);
        assert!(0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::maker_v8::capability_maker_treasury_id_v8(v0) == 0x2::object::id<0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::treasury_v8::MakerTreasuryV8<T0>>(arg5), 1);
        assert!(0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::maker_v8::capability_protocol_treasury_id_v8(v0) == 0x2::object::id<0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::protocol_config_v8::ProtocolTreasuryV8<T0>>(arg6), 1);
        emit_activation<T0>(arg0, arg1, arg3, v0);
    }

    public fun share_release_package_config_v8(arg0: ReleasePackageConfigV8) {
        0x2::transfer::share_object<ReleasePackageConfigV8>(arg0);
    }

    public fun version_v8() : u64 {
        8
    }

    // decompiled from Move bytecode v7
}

