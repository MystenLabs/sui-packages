module 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::package_binding_v8 {
    struct PackageCommitmentsV8 has copy, drop, store {
        source_commitment: vector<u8>,
        package_commitment: vector<u8>,
        abi_commitment: vector<u8>,
    }

    struct ExactPackageBindingV8 has copy, drop, store {
        original_package_id: 0x2::object::ID,
        callable_package_id: 0x2::object::ID,
        source_commitment: vector<u8>,
        package_commitment: vector<u8>,
        abi_commitment: vector<u8>,
        commitment: vector<u8>,
    }

    struct ProductReleaseBindingV8 has copy, drop, store {
        version: u64,
        native_capability_mask: u64,
        core: ExactPackageBindingV8,
        seal: ExactPackageBindingV8,
        runtime: ExactPackageBindingV8,
        output: ExactPackageBindingV8,
        physical: ExactPackageBindingV8,
        market: ExactPackageBindingV8,
        release: ExactPackageBindingV8,
        commitment: vector<u8>,
    }

    struct ProductReleaseCatalogV8 has key {
        id: 0x2::object::UID,
        version: u64,
        protocol_config_id: 0x2::object::ID,
        protocol_config_revision: u64,
        protocol_config_commitment: vector<u8>,
        binding: ProductReleaseBindingV8,
        call_cap_set: PackageCallCapSetBindingV8,
        seal_call_cap: 0x1::option::Option<PackageCallCapV8<SealRoleV8>>,
        runtime_call_cap: 0x1::option::Option<PackageCallCapV8<RuntimeRoleV8>>,
        output_call_cap: 0x1::option::Option<PackageCallCapV8<OutputRoleV8>>,
        physical_call_cap: 0x1::option::Option<PackageCallCapV8<PhysicalRoleV8>>,
        market_call_cap: 0x1::option::Option<PackageCallCapV8<MarketRoleV8>>,
        release_call_cap: 0x1::option::Option<PackageCallCapV8<ReleaseRoleV8>>,
    }

    struct CertifiedProductReleaseBindingV8 has copy, drop, store {
        catalog_id: 0x2::object::ID,
        protocol_config_id: 0x2::object::ID,
        protocol_config_revision: u64,
        protocol_config_commitment: vector<u8>,
        binding: ProductReleaseBindingV8,
        call_cap_set: PackageCallCapSetBindingV8,
    }

    struct ReleaseCatalogWitnessV8 {
        certified: CertifiedProductReleaseBindingV8,
    }

    struct PackageCallCapV8<phantom T0> has store {
        version: u64,
        authority_id: 0x2::object::ID,
        catalog_id: 0x2::object::ID,
        product_binding_commitment: vector<u8>,
        role_binding_commitment: vector<u8>,
        call_cap_set_commitment: vector<u8>,
    }

    struct PackageCallCapSetBindingV8 has copy, drop, store {
        version: u64,
        catalog_id: 0x2::object::ID,
        product_binding_commitment: vector<u8>,
        seal_authority_id: 0x2::object::ID,
        runtime_authority_id: 0x2::object::ID,
        output_authority_id: 0x2::object::ID,
        physical_authority_id: 0x2::object::ID,
        market_authority_id: 0x2::object::ID,
        release_authority_id: 0x2::object::ID,
        commitment: vector<u8>,
    }

    struct SealRoleV8 has drop {
        dummy_field: bool,
    }

    struct RuntimeRoleV8 has drop {
        dummy_field: bool,
    }

    struct OutputRoleV8 has drop {
        dummy_field: bool,
    }

    struct PhysicalRoleV8 has drop {
        dummy_field: bool,
    }

    struct MarketRoleV8 has drop {
        dummy_field: bool,
    }

    struct ReleaseRoleV8 has drop {
        dummy_field: bool,
    }

    struct RuntimePackReadinessV8 {
        catalog_id: 0x2::object::ID,
        product_binding_commitment: vector<u8>,
        root_id: 0x2::object::ID,
        root_version: u64,
        root_content_commitment: vector<u8>,
        pack_registry_id: 0x2::object::ID,
        admission_authority_id: 0x2::object::ID,
        policy_commitment: vector<u8>,
    }

    struct ExactPackageBindingCommitmentInputV8 has drop {
        domain: vector<u8>,
        version: u64,
        original_package_id: 0x2::object::ID,
        callable_package_id: 0x2::object::ID,
        source_commitment: vector<u8>,
        package_commitment: vector<u8>,
        abi_commitment: vector<u8>,
    }

    struct ProductReleaseBindingCommitmentInputV8 has drop {
        domain: vector<u8>,
        version: u64,
        native_capability_mask: u64,
        core: ExactPackageBindingV8,
        seal: ExactPackageBindingV8,
        runtime: ExactPackageBindingV8,
        output: ExactPackageBindingV8,
        physical: ExactPackageBindingV8,
        market: ExactPackageBindingV8,
        release: ExactPackageBindingV8,
    }

    struct PackageCallCapSetCommitmentInputV8 has drop {
        domain: vector<u8>,
        version: u64,
        catalog_id: 0x2::object::ID,
        product_binding_commitment: vector<u8>,
        seal_authority_id: 0x2::object::ID,
        runtime_authority_id: 0x2::object::ID,
        output_authority_id: 0x2::object::ID,
        physical_authority_id: 0x2::object::ID,
        market_authority_id: 0x2::object::ID,
        release_authority_id: 0x2::object::ID,
    }

    public fun abi_commitment_v8(arg0: &ExactPackageBindingV8) : &vector<u8> {
        &arg0.abi_commitment
    }

    fun assert_binding_well_formed(arg0: &ExactPackageBindingV8) {
        assert_hash(&arg0.source_commitment);
        assert_hash(&arg0.package_commitment);
        assert_hash(&arg0.abi_commitment);
        let v0 = ExactPackageBindingCommitmentInputV8{
            domain              : b"animacraft-v8/exact-package-binding",
            version             : 8,
            original_package_id : arg0.original_package_id,
            callable_package_id : arg0.callable_package_id,
            source_commitment   : arg0.source_commitment,
            package_commitment  : arg0.package_commitment,
            abi_commitment      : arg0.abi_commitment,
        };
        let v1 = 0x1::hash::sha2_256(0x1::bcs::to_bytes<ExactPackageBindingCommitmentInputV8>(&v0));
        assert!(&v1 == &arg0.commitment, 3);
    }

    fun assert_call_cap<T0>(arg0: &ProductReleaseCatalogV8, arg1: &PackageCallCapV8<T0>, arg2: &ExactPackageBindingV8, arg3: 0x2::object::ID) {
        assert_catalog_well_formed(arg0);
        assert!(arg1.version == 8, 9);
        assert!(arg1.authority_id == arg3, 9);
        assert!(arg1.catalog_id == 0x2::object::id<ProductReleaseCatalogV8>(arg0), 9);
        assert!(&arg1.product_binding_commitment == &arg0.binding.commitment, 9);
        assert!(&arg1.role_binding_commitment == &arg2.commitment, 9);
        assert!(&arg1.call_cap_set_commitment == &arg0.call_cap_set.commitment, 9);
    }

    fun assert_call_cap_set_well_formed(arg0: &PackageCallCapSetBindingV8, arg1: 0x2::object::ID, arg2: vector<u8>) {
        assert!(arg0.version == 8, 9);
        assert!(arg0.catalog_id == arg1, 9);
        assert!(&arg0.product_binding_commitment == &arg2, 9);
        let v0 = PackageCallCapSetCommitmentInputV8{
            domain                     : b"animacraft-v8/package-call-cap-set",
            version                    : arg0.version,
            catalog_id                 : arg0.catalog_id,
            product_binding_commitment : arg0.product_binding_commitment,
            seal_authority_id          : arg0.seal_authority_id,
            runtime_authority_id       : arg0.runtime_authority_id,
            output_authority_id        : arg0.output_authority_id,
            physical_authority_id      : arg0.physical_authority_id,
            market_authority_id        : arg0.market_authority_id,
            release_authority_id       : arg0.release_authority_id,
        };
        let v1 = 0x1::hash::sha2_256(0x1::bcs::to_bytes<PackageCallCapSetCommitmentInputV8>(&v0));
        assert!(&v1 == &arg0.commitment, 9);
    }

    public fun assert_catalog_current_v8(arg0: &0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::protocol_config_v8::ProtocolConfigV8, arg1: &ProductReleaseCatalogV8) {
        0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::protocol_config_v8::assert_enabled_v8(arg0);
        assert_catalog_well_formed(arg1);
        assert!(arg1.protocol_config_id == 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::protocol_config_v8::config_id_v8(arg0), 5);
        assert!(arg1.protocol_config_revision == 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::protocol_config_v8::config_revision_v8(arg0), 5);
        assert!(&arg1.protocol_config_commitment == 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::protocol_config_v8::config_commitment_v8(arg0), 5);
    }

    fun assert_catalog_setup_admin(arg0: &0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::protocol_config_v8::ProtocolConfigV8, arg1: &0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::protocol_config_v8::ProtocolAdminCapV8, arg2: &ProductReleaseCatalogV8) {
        0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::protocol_config_v8::assert_protocol_admin_v8(arg0, arg1);
        assert_catalog_current_v8(arg0, arg2);
    }

    public fun assert_catalog_snapshot_v8(arg0: &ProductReleaseCatalogV8, arg1: 0x2::object::ID, arg2: u64, arg3: &vector<u8>) {
        assert_catalog_well_formed(arg0);
        assert!(arg0.protocol_config_id == arg1, 5);
        assert!(arg0.protocol_config_revision == arg2, 5);
        assert!(&arg0.protocol_config_commitment == arg3, 5);
    }

    fun assert_catalog_well_formed(arg0: &ProductReleaseCatalogV8) {
        assert!(arg0.version == 8, 5);
        assert_hash(&arg0.protocol_config_commitment);
        assert_product_release_binding_well_formed_v8(&arg0.binding);
        assert_call_cap_set_well_formed(&arg0.call_cap_set, 0x2::object::id<ProductReleaseCatalogV8>(arg0), arg0.binding.commitment);
    }

    public fun assert_certified_binding_v8(arg0: &CertifiedProductReleaseBindingV8) {
        assert_product_release_binding_well_formed_v8(&arg0.binding);
        assert_hash(&arg0.protocol_config_commitment);
        assert_call_cap_set_well_formed(&arg0.call_cap_set, arg0.catalog_id, arg0.binding.commitment);
    }

    fun assert_distinct_package_roles(arg0: &ExactPackageBindingV8, arg1: &ExactPackageBindingV8, arg2: &ExactPackageBindingV8, arg3: &ExactPackageBindingV8, arg4: &ExactPackageBindingV8, arg5: &ExactPackageBindingV8, arg6: &ExactPackageBindingV8) {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x2::object::ID>(v1, arg0.original_package_id);
        0x1::vector::push_back<0x2::object::ID>(v1, arg1.original_package_id);
        0x1::vector::push_back<0x2::object::ID>(v1, arg2.original_package_id);
        0x1::vector::push_back<0x2::object::ID>(v1, arg3.original_package_id);
        0x1::vector::push_back<0x2::object::ID>(v1, arg4.original_package_id);
        0x1::vector::push_back<0x2::object::ID>(v1, arg5.original_package_id);
        0x1::vector::push_back<0x2::object::ID>(v1, arg6.original_package_id);
        let v2 = 0x1::vector::empty<0x2::object::ID>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x2::object::ID>(v3, arg0.callable_package_id);
        0x1::vector::push_back<0x2::object::ID>(v3, arg1.callable_package_id);
        0x1::vector::push_back<0x2::object::ID>(v3, arg2.callable_package_id);
        0x1::vector::push_back<0x2::object::ID>(v3, arg3.callable_package_id);
        0x1::vector::push_back<0x2::object::ID>(v3, arg4.callable_package_id);
        0x1::vector::push_back<0x2::object::ID>(v3, arg5.callable_package_id);
        0x1::vector::push_back<0x2::object::ID>(v3, arg6.callable_package_id);
        let v4 = 0;
        while (v4 < 0x1::vector::length<0x2::object::ID>(&v0)) {
            let v5 = v4 + 1;
            while (v5 < 0x1::vector::length<0x2::object::ID>(&v0)) {
                assert!(0x1::vector::borrow<0x2::object::ID>(&v0, v4) != 0x1::vector::borrow<0x2::object::ID>(&v0, v5), 2);
                assert!(0x1::vector::borrow<0x2::object::ID>(&v2, v4) != 0x1::vector::borrow<0x2::object::ID>(&v2, v5), 2);
                assert!(0x1::vector::borrow<0x2::object::ID>(&v0, v4) != 0x1::vector::borrow<0x2::object::ID>(&v2, v5), 2);
                assert!(0x1::vector::borrow<0x2::object::ID>(&v2, v4) != 0x1::vector::borrow<0x2::object::ID>(&v0, v5), 2);
                v5 = v5 + 1;
            };
            v4 = v4 + 1;
        };
    }

    fun assert_hash(arg0: &vector<u8>) {
        assert!(0x1::vector::length<u8>(arg0) == 32, 0);
        let v0 = false;
        let v1 = 0;
        while (v1 < 32) {
            if (*0x1::vector::borrow<u8>(arg0, v1) != 0) {
                v0 = true;
            };
            v1 = v1 + 1;
        };
        assert!(v0, 0);
    }

    public fun assert_market_call_cap_v8(arg0: &ProductReleaseCatalogV8, arg1: &PackageCallCapV8<MarketRoleV8>) {
        assert_call_cap<MarketRoleV8>(arg0, arg1, &arg0.binding.market, arg0.call_cap_set.market_authority_id);
    }

    public fun assert_native_capability_mask_v8(arg0: &ProductReleaseBindingV8) {
        assert!(arg0.native_capability_mask == 127, 6);
    }

    public fun assert_output_call_cap_v8(arg0: &ProductReleaseCatalogV8, arg1: &PackageCallCapV8<OutputRoleV8>) {
        assert_call_cap<OutputRoleV8>(arg0, arg1, &arg0.binding.output, arg0.call_cap_set.output_authority_id);
    }

    public fun assert_physical_call_cap_v8(arg0: &ProductReleaseCatalogV8, arg1: &PackageCallCapV8<PhysicalRoleV8>) {
        assert_call_cap<PhysicalRoleV8>(arg0, arg1, &arg0.binding.physical, arg0.call_cap_set.physical_authority_id);
    }

    public fun assert_product_release_binding_well_formed_v8(arg0: &ProductReleaseBindingV8) {
        assert!(arg0.version == 8, 3);
        assert!(arg0.native_capability_mask == 127, 6);
        assert_binding_well_formed(&arg0.core);
        assert_binding_well_formed(&arg0.seal);
        assert_binding_well_formed(&arg0.runtime);
        assert_binding_well_formed(&arg0.output);
        assert_binding_well_formed(&arg0.physical);
        assert_binding_well_formed(&arg0.market);
        assert_binding_well_formed(&arg0.release);
        assert_distinct_package_roles(&arg0.core, &arg0.seal, &arg0.runtime, &arg0.output, &arg0.physical, &arg0.market, &arg0.release);
        let v0 = ProductReleaseBindingCommitmentInputV8{
            domain                 : b"animacraft-v8/product-release-binding",
            version                : arg0.version,
            native_capability_mask : arg0.native_capability_mask,
            core                   : arg0.core,
            seal                   : arg0.seal,
            runtime                : arg0.runtime,
            output                 : arg0.output,
            physical               : arg0.physical,
            market                 : arg0.market,
            release                : arg0.release,
        };
        let v1 = 0x1::hash::sha2_256(0x1::bcs::to_bytes<ProductReleaseBindingCommitmentInputV8>(&v0));
        assert!(&v1 == &arg0.commitment, 3);
    }

    public fun assert_release_call_cap_v8(arg0: &ProductReleaseCatalogV8, arg1: &PackageCallCapV8<ReleaseRoleV8>) {
        assert_call_cap<ReleaseRoleV8>(arg0, arg1, &arg0.binding.release, arg0.call_cap_set.release_authority_id);
    }

    public fun assert_runtime_call_cap_v8(arg0: &ProductReleaseCatalogV8, arg1: &PackageCallCapV8<RuntimeRoleV8>) {
        assert_call_cap<RuntimeRoleV8>(arg0, arg1, &arg0.binding.runtime, arg0.call_cap_set.runtime_authority_id);
    }

    public fun assert_same_call_cap_set_v8(arg0: &PackageCallCapSetBindingV8, arg1: &PackageCallCapSetBindingV8) {
        assert_call_cap_set_well_formed(arg0, arg0.catalog_id, arg0.product_binding_commitment);
        assert_call_cap_set_well_formed(arg1, arg1.catalog_id, arg1.product_binding_commitment);
        assert!(arg0.version == arg1.version, 9);
        assert!(arg0.catalog_id == arg1.catalog_id, 9);
        assert!(&arg0.product_binding_commitment == &arg1.product_binding_commitment, 9);
        assert!(arg0.seal_authority_id == arg1.seal_authority_id, 9);
        assert!(arg0.runtime_authority_id == arg1.runtime_authority_id, 9);
        assert!(arg0.output_authority_id == arg1.output_authority_id, 9);
        assert!(arg0.physical_authority_id == arg1.physical_authority_id, 9);
        assert!(arg0.market_authority_id == arg1.market_authority_id, 9);
        assert!(arg0.release_authority_id == arg1.release_authority_id, 9);
        assert!(&arg0.commitment == &arg1.commitment, 9);
    }

    fun assert_same_lineage<T0, T1>() {
        assert!(0x1::type_name::original_id<T0>() == 0x1::type_name::original_id<T1>(), 4);
    }

    public fun assert_seal_call_cap_v8(arg0: &ProductReleaseCatalogV8, arg1: &PackageCallCapV8<SealRoleV8>) {
        assert_call_cap<SealRoleV8>(arg0, arg1, &arg0.binding.seal, arg0.call_cap_set.seal_authority_id);
    }

    public fun assert_type_original_v8<T0>(arg0: &ExactPackageBindingV8) {
        assert_binding_well_formed(arg0);
        assert!(arg0.original_package_id == 0x2::object::id_from_address(0x1::type_name::original_id<T0>()), 1);
    }

    public fun assert_type_origins_v8<T0, T1>(arg0: &ExactPackageBindingV8) {
        assert_same_lineage<T0, T1>();
        assert_binding_well_formed(arg0);
        assert!(arg0.original_package_id == 0x2::object::id_from_address(0x1::type_name::original_id<T0>()), 1);
        assert!(arg0.callable_package_id == 0x2::object::id_from_address(0x1::type_name::defining_id<T1>()), 1);
    }

    public fun binding_native_capability_mask_v8(arg0: &ProductReleaseBindingV8) : u64 {
        arg0.native_capability_mask
    }

    public fun call_cap_authority_id_v8<T0>(arg0: &PackageCallCapV8<T0>) : 0x2::object::ID {
        arg0.authority_id
    }

    public fun call_cap_set_commitment_v8(arg0: &PackageCallCapSetBindingV8) : &vector<u8> {
        &arg0.commitment
    }

    public fun callable_package_id_v8(arg0: &ExactPackageBindingV8) : 0x2::object::ID {
        arg0.callable_package_id
    }

    public fun catalog_binding_v8(arg0: &ProductReleaseCatalogV8) : &ProductReleaseBindingV8 {
        &arg0.binding
    }

    public fun catalog_call_cap_set_v8(arg0: &ProductReleaseCatalogV8) : &PackageCallCapSetBindingV8 {
        &arg0.call_cap_set
    }

    public fun catalog_id_v8(arg0: &ProductReleaseCatalogV8) : 0x2::object::ID {
        0x2::object::id<ProductReleaseCatalogV8>(arg0)
    }

    public fun catalog_protocol_config_commitment_v8(arg0: &ProductReleaseCatalogV8) : &vector<u8> {
        &arg0.protocol_config_commitment
    }

    public fun catalog_protocol_config_id_v8(arg0: &ProductReleaseCatalogV8) : 0x2::object::ID {
        arg0.protocol_config_id
    }

    public fun catalog_protocol_config_revision_v8(arg0: &ProductReleaseCatalogV8) : u64 {
        arg0.protocol_config_revision
    }

    public fun certified_binding_v8(arg0: &CertifiedProductReleaseBindingV8) : &ProductReleaseBindingV8 {
        &arg0.binding
    }

    public fun certified_call_cap_set_v8(arg0: &CertifiedProductReleaseBindingV8) : &PackageCallCapSetBindingV8 {
        &arg0.call_cap_set
    }

    public fun certified_catalog_id_v8(arg0: &CertifiedProductReleaseBindingV8) : 0x2::object::ID {
        arg0.catalog_id
    }

    public fun certified_protocol_config_commitment_v8(arg0: &CertifiedProductReleaseBindingV8) : &vector<u8> {
        &arg0.protocol_config_commitment
    }

    public fun certified_protocol_config_id_v8(arg0: &CertifiedProductReleaseBindingV8) : 0x2::object::ID {
        arg0.protocol_config_id
    }

    public fun certified_protocol_config_revision_v8(arg0: &CertifiedProductReleaseBindingV8) : u64 {
        arg0.protocol_config_revision
    }

    fun certified_snapshot(arg0: &ProductReleaseCatalogV8) : CertifiedProductReleaseBindingV8 {
        CertifiedProductReleaseBindingV8{
            catalog_id                 : 0x2::object::id<ProductReleaseCatalogV8>(arg0),
            protocol_config_id         : arg0.protocol_config_id,
            protocol_config_revision   : arg0.protocol_config_revision,
            protocol_config_commitment : arg0.protocol_config_commitment,
            binding                    : arg0.binding,
            call_cap_set               : arg0.call_cap_set,
        }
    }

    public fun certify_product_release_catalog_v8<T0, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13>(arg0: &0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::protocol_config_v8::ProtocolConfigV8, arg1: &0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::protocol_config_v8::ProtocolAdminCapV8, arg2: PackageCommitmentsV8, arg3: PackageCommitmentsV8, arg4: PackageCommitmentsV8, arg5: PackageCommitmentsV8, arg6: PackageCommitmentsV8, arg7: PackageCommitmentsV8, arg8: PackageCommitmentsV8, arg9: &mut 0x2::tx_context::TxContext) : ProductReleaseCatalogV8 {
        0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::protocol_config_v8::assert_protocol_admin_v8(arg0, arg1);
        0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::protocol_config_v8::assert_enabled_v8(arg0);
        let v0 = new_exact_package_binding<T0, T1>(arg2);
        assert!(v0.original_package_id == 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::protocol_config_v8::config_core_original_package_id_v8(arg0), 5);
        assert!(v0.callable_package_id == 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::protocol_config_v8::config_core_callable_package_id_v8(arg0), 5);
        let v1 = new_product_release_binding(v0, new_exact_package_binding<T2, T3>(arg3), new_exact_package_binding<T4, T5>(arg4), new_exact_package_binding<T6, T7>(arg5), new_exact_package_binding<T8, T9>(arg6), new_exact_package_binding<T10, T11>(arg7), new_exact_package_binding<T12, T13>(arg8));
        let v2 = 0x2::object::new(arg9);
        let v3 = 0x2::object::uid_to_inner(&v2);
        let v4 = v1.commitment;
        let v5 = fresh_authority_id(arg9);
        let v6 = fresh_authority_id(arg9);
        let v7 = fresh_authority_id(arg9);
        let v8 = fresh_authority_id(arg9);
        let v9 = fresh_authority_id(arg9);
        let v10 = fresh_authority_id(arg9);
        let v11 = new_call_cap_set_binding(v3, v4, v5, v6, v7, v8, v9, v10);
        let v12 = v11.commitment;
        let v13 = PackageCallCapV8<SealRoleV8>{
            version                    : 8,
            authority_id               : v5,
            catalog_id                 : v3,
            product_binding_commitment : v4,
            role_binding_commitment    : v1.seal.commitment,
            call_cap_set_commitment    : v12,
        };
        let v14 = PackageCallCapV8<RuntimeRoleV8>{
            version                    : 8,
            authority_id               : v6,
            catalog_id                 : v3,
            product_binding_commitment : v4,
            role_binding_commitment    : v1.runtime.commitment,
            call_cap_set_commitment    : v12,
        };
        let v15 = PackageCallCapV8<OutputRoleV8>{
            version                    : 8,
            authority_id               : v7,
            catalog_id                 : v3,
            product_binding_commitment : v4,
            role_binding_commitment    : v1.output.commitment,
            call_cap_set_commitment    : v12,
        };
        let v16 = PackageCallCapV8<PhysicalRoleV8>{
            version                    : 8,
            authority_id               : v8,
            catalog_id                 : v3,
            product_binding_commitment : v4,
            role_binding_commitment    : v1.physical.commitment,
            call_cap_set_commitment    : v12,
        };
        let v17 = PackageCallCapV8<MarketRoleV8>{
            version                    : 8,
            authority_id               : v9,
            catalog_id                 : v3,
            product_binding_commitment : v4,
            role_binding_commitment    : v1.market.commitment,
            call_cap_set_commitment    : v12,
        };
        let v18 = PackageCallCapV8<ReleaseRoleV8>{
            version                    : 8,
            authority_id               : v10,
            catalog_id                 : v3,
            product_binding_commitment : v4,
            role_binding_commitment    : v1.release.commitment,
            call_cap_set_commitment    : v12,
        };
        ProductReleaseCatalogV8{
            id                         : v2,
            version                    : 8,
            protocol_config_id         : 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::protocol_config_v8::config_id_v8(arg0),
            protocol_config_revision   : 0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::protocol_config_v8::config_revision_v8(arg0),
            protocol_config_commitment : *0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::protocol_config_v8::config_commitment_v8(arg0),
            binding                    : v1,
            call_cap_set               : v11,
            seal_call_cap              : 0x1::option::some<PackageCallCapV8<SealRoleV8>>(v13),
            runtime_call_cap           : 0x1::option::some<PackageCallCapV8<RuntimeRoleV8>>(v14),
            output_call_cap            : 0x1::option::some<PackageCallCapV8<OutputRoleV8>>(v15),
            physical_call_cap          : 0x1::option::some<PackageCallCapV8<PhysicalRoleV8>>(v16),
            market_call_cap            : 0x1::option::some<PackageCallCapV8<MarketRoleV8>>(v17),
            release_call_cap           : 0x1::option::some<PackageCallCapV8<ReleaseRoleV8>>(v18),
        }
    }

    public fun certify_release_catalog_witness_v8(arg0: &0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::protocol_config_v8::ProtocolConfigV8, arg1: &ProductReleaseCatalogV8, arg2: &PackageCallCapV8<ReleaseRoleV8>) : ReleaseCatalogWitnessV8 {
        assert_catalog_current_v8(arg0, arg1);
        assert_release_call_cap_v8(arg1, arg2);
        ReleaseCatalogWitnessV8{certified: certified_snapshot(arg1)}
    }

    public(friend) fun certify_runtime_pack_readiness_v8(arg0: &ProductReleaseCatalogV8, arg1: &PackageCallCapV8<RuntimeRoleV8>, arg2: 0x2::object::ID, arg3: u64, arg4: vector<u8>, arg5: 0x2::object::ID, arg6: 0x2::object::ID, arg7: vector<u8>) : RuntimePackReadinessV8 {
        assert_runtime_call_cap_v8(arg0, arg1);
        assert_hash(&arg4);
        assert_hash(&arg7);
        RuntimePackReadinessV8{
            catalog_id                 : 0x2::object::id<ProductReleaseCatalogV8>(arg0),
            product_binding_commitment : arg0.binding.commitment,
            root_id                    : arg2,
            root_version               : arg3,
            root_content_commitment    : arg4,
            pack_registry_id           : arg5,
            admission_authority_id     : arg6,
            policy_commitment          : arg7,
        }
    }

    public(friend) fun consume_release_catalog_witness_v8(arg0: ReleaseCatalogWitnessV8) : CertifiedProductReleaseBindingV8 {
        let ReleaseCatalogWitnessV8 { certified: v0 } = arg0;
        assert_certified_binding_v8(&v0);
        v0
    }

    public(friend) fun consume_runtime_pack_readiness_v8(arg0: RuntimePackReadinessV8) : (0x2::object::ID, vector<u8>, 0x2::object::ID, u64, vector<u8>, 0x2::object::ID, 0x2::object::ID, vector<u8>) {
        let RuntimePackReadinessV8 {
            catalog_id                 : v0,
            product_binding_commitment : v1,
            root_id                    : v2,
            root_version               : v3,
            root_content_commitment    : v4,
            pack_registry_id           : v5,
            admission_authority_id     : v6,
            policy_commitment          : v7,
        } = arg0;
        (v0, v1, v2, v3, v4, v5, v6, v7)
    }

    public fun core_binding_v8(arg0: &ProductReleaseBindingV8) : &ExactPackageBindingV8 {
        &arg0.core
    }

    public fun exact_binding_commitment_v8(arg0: &ExactPackageBindingV8) : &vector<u8> {
        &arg0.commitment
    }

    fun fresh_authority_id(arg0: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::object::new(arg0);
        0x2::object::delete(v0);
        0x2::object::uid_to_inner(&v0)
    }

    public fun market_authority_id_v8(arg0: &PackageCallCapSetBindingV8) : 0x2::object::ID {
        arg0.market_authority_id
    }

    public fun market_binding_v8(arg0: &ProductReleaseBindingV8) : &ExactPackageBindingV8 {
        &arg0.market
    }

    public fun native_capability_mask_v8() : u64 {
        127
    }

    fun new_binding(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>) : ExactPackageBindingV8 {
        assert_hash(&arg2);
        assert_hash(&arg3);
        assert_hash(&arg4);
        let v0 = ExactPackageBindingCommitmentInputV8{
            domain              : b"animacraft-v8/exact-package-binding",
            version             : 8,
            original_package_id : arg0,
            callable_package_id : arg1,
            source_commitment   : arg2,
            package_commitment  : arg3,
            abi_commitment      : arg4,
        };
        ExactPackageBindingV8{
            original_package_id : arg0,
            callable_package_id : arg1,
            source_commitment   : arg2,
            package_commitment  : arg3,
            abi_commitment      : arg4,
            commitment          : 0x1::hash::sha2_256(0x1::bcs::to_bytes<ExactPackageBindingCommitmentInputV8>(&v0)),
        }
    }

    fun new_call_cap_set_binding(arg0: 0x2::object::ID, arg1: vector<u8>, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: 0x2::object::ID, arg6: 0x2::object::ID, arg7: 0x2::object::ID) : PackageCallCapSetBindingV8 {
        let v0 = PackageCallCapSetCommitmentInputV8{
            domain                     : b"animacraft-v8/package-call-cap-set",
            version                    : 8,
            catalog_id                 : arg0,
            product_binding_commitment : arg1,
            seal_authority_id          : arg2,
            runtime_authority_id       : arg3,
            output_authority_id        : arg4,
            physical_authority_id      : arg5,
            market_authority_id        : arg6,
            release_authority_id       : arg7,
        };
        PackageCallCapSetBindingV8{
            version                    : 8,
            catalog_id                 : arg0,
            product_binding_commitment : arg1,
            seal_authority_id          : arg2,
            runtime_authority_id       : arg3,
            output_authority_id        : arg4,
            physical_authority_id      : arg5,
            market_authority_id        : arg6,
            release_authority_id       : arg7,
            commitment                 : 0x1::hash::sha2_256(0x1::bcs::to_bytes<PackageCallCapSetCommitmentInputV8>(&v0)),
        }
    }

    fun new_exact_package_binding<T0, T1>(arg0: PackageCommitmentsV8) : ExactPackageBindingV8 {
        assert_same_lineage<T0, T1>();
        new_binding(0x2::object::id_from_address(0x1::type_name::original_id<T0>()), 0x2::object::id_from_address(0x1::type_name::defining_id<T1>()), arg0.source_commitment, arg0.package_commitment, arg0.abi_commitment)
    }

    public fun new_package_commitments_v8(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>) : PackageCommitmentsV8 {
        assert_hash(&arg0);
        assert_hash(&arg1);
        assert_hash(&arg2);
        PackageCommitmentsV8{
            source_commitment  : arg0,
            package_commitment : arg1,
            abi_commitment     : arg2,
        }
    }

    fun new_product_release_binding(arg0: ExactPackageBindingV8, arg1: ExactPackageBindingV8, arg2: ExactPackageBindingV8, arg3: ExactPackageBindingV8, arg4: ExactPackageBindingV8, arg5: ExactPackageBindingV8, arg6: ExactPackageBindingV8) : ProductReleaseBindingV8 {
        assert_binding_well_formed(&arg0);
        assert_binding_well_formed(&arg1);
        assert_binding_well_formed(&arg2);
        assert_binding_well_formed(&arg3);
        assert_binding_well_formed(&arg4);
        assert_binding_well_formed(&arg5);
        assert_binding_well_formed(&arg6);
        assert_distinct_package_roles(&arg0, &arg1, &arg2, &arg3, &arg4, &arg5, &arg6);
        let v0 = ProductReleaseBindingCommitmentInputV8{
            domain                 : b"animacraft-v8/product-release-binding",
            version                : 8,
            native_capability_mask : 127,
            core                   : arg0,
            seal                   : arg1,
            runtime                : arg2,
            output                 : arg3,
            physical               : arg4,
            market                 : arg5,
            release                : arg6,
        };
        ProductReleaseBindingV8{
            version                : 8,
            native_capability_mask : 127,
            core                   : arg0,
            seal                   : arg1,
            runtime                : arg2,
            output                 : arg3,
            physical               : arg4,
            market                 : arg5,
            release                : arg6,
            commitment             : 0x1::hash::sha2_256(0x1::bcs::to_bytes<ProductReleaseBindingCommitmentInputV8>(&v0)),
        }
    }

    public fun original_package_id_v8(arg0: &ExactPackageBindingV8) : 0x2::object::ID {
        arg0.original_package_id
    }

    public fun output_authority_id_v8(arg0: &PackageCallCapSetBindingV8) : 0x2::object::ID {
        arg0.output_authority_id
    }

    public fun output_binding_v8(arg0: &ProductReleaseBindingV8) : &ExactPackageBindingV8 {
        &arg0.output
    }

    public fun package_commitment_v8(arg0: &ExactPackageBindingV8) : &vector<u8> {
        &arg0.package_commitment
    }

    public fun physical_authority_id_v8(arg0: &PackageCallCapSetBindingV8) : 0x2::object::ID {
        arg0.physical_authority_id
    }

    public fun physical_binding_v8(arg0: &ProductReleaseBindingV8) : &ExactPackageBindingV8 {
        &arg0.physical
    }

    public fun product_binding_commitment_v8(arg0: &ProductReleaseBindingV8) : &vector<u8> {
        &arg0.commitment
    }

    public fun release_authority_id_v8(arg0: &PackageCallCapSetBindingV8) : 0x2::object::ID {
        arg0.release_authority_id
    }

    public fun release_binding_v8(arg0: &ProductReleaseBindingV8) : &ExactPackageBindingV8 {
        &arg0.release
    }

    public fun runtime_authority_id_v8(arg0: &PackageCallCapSetBindingV8) : 0x2::object::ID {
        arg0.runtime_authority_id
    }

    public fun runtime_binding_v8(arg0: &ProductReleaseBindingV8) : &ExactPackageBindingV8 {
        &arg0.runtime
    }

    public fun seal_authority_id_v8(arg0: &PackageCallCapSetBindingV8) : 0x2::object::ID {
        arg0.seal_authority_id
    }

    public fun seal_binding_v8(arg0: &ProductReleaseBindingV8) : &ExactPackageBindingV8 {
        &arg0.seal
    }

    public fun share_product_release_catalog_v8(arg0: ProductReleaseCatalogV8) {
        assert!(0x1::option::is_none<PackageCallCapV8<SealRoleV8>>(&arg0.seal_call_cap), 10);
        assert!(0x1::option::is_none<PackageCallCapV8<RuntimeRoleV8>>(&arg0.runtime_call_cap), 10);
        assert!(0x1::option::is_none<PackageCallCapV8<OutputRoleV8>>(&arg0.output_call_cap), 10);
        assert!(0x1::option::is_none<PackageCallCapV8<PhysicalRoleV8>>(&arg0.physical_call_cap), 10);
        assert!(0x1::option::is_none<PackageCallCapV8<MarketRoleV8>>(&arg0.market_call_cap), 10);
        assert!(0x1::option::is_none<PackageCallCapV8<ReleaseRoleV8>>(&arg0.release_call_cap), 10);
        0x2::transfer::share_object<ProductReleaseCatalogV8>(arg0);
    }

    public fun source_commitment_v8(arg0: &ExactPackageBindingV8) : &vector<u8> {
        &arg0.source_commitment
    }

    public fun take_market_call_cap_v8(arg0: &0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::protocol_config_v8::ProtocolConfigV8, arg1: &0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::protocol_config_v8::ProtocolAdminCapV8, arg2: &mut ProductReleaseCatalogV8) : PackageCallCapV8<MarketRoleV8> {
        assert_catalog_setup_admin(arg0, arg1, arg2);
        assert!(0x1::option::is_some<PackageCallCapV8<MarketRoleV8>>(&arg2.market_call_cap), 8);
        0x1::option::extract<PackageCallCapV8<MarketRoleV8>>(&mut arg2.market_call_cap)
    }

    public fun take_output_call_cap_v8(arg0: &0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::protocol_config_v8::ProtocolConfigV8, arg1: &0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::protocol_config_v8::ProtocolAdminCapV8, arg2: &mut ProductReleaseCatalogV8) : PackageCallCapV8<OutputRoleV8> {
        assert_catalog_setup_admin(arg0, arg1, arg2);
        assert!(0x1::option::is_some<PackageCallCapV8<OutputRoleV8>>(&arg2.output_call_cap), 8);
        0x1::option::extract<PackageCallCapV8<OutputRoleV8>>(&mut arg2.output_call_cap)
    }

    public fun take_physical_call_cap_v8(arg0: &0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::protocol_config_v8::ProtocolConfigV8, arg1: &0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::protocol_config_v8::ProtocolAdminCapV8, arg2: &mut ProductReleaseCatalogV8) : PackageCallCapV8<PhysicalRoleV8> {
        assert_catalog_setup_admin(arg0, arg1, arg2);
        assert!(0x1::option::is_some<PackageCallCapV8<PhysicalRoleV8>>(&arg2.physical_call_cap), 8);
        0x1::option::extract<PackageCallCapV8<PhysicalRoleV8>>(&mut arg2.physical_call_cap)
    }

    public fun take_release_call_cap_v8(arg0: &0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::protocol_config_v8::ProtocolConfigV8, arg1: &0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::protocol_config_v8::ProtocolAdminCapV8, arg2: &mut ProductReleaseCatalogV8) : PackageCallCapV8<ReleaseRoleV8> {
        assert_catalog_setup_admin(arg0, arg1, arg2);
        assert!(0x1::option::is_some<PackageCallCapV8<ReleaseRoleV8>>(&arg2.release_call_cap), 8);
        0x1::option::extract<PackageCallCapV8<ReleaseRoleV8>>(&mut arg2.release_call_cap)
    }

    public fun take_runtime_call_cap_v8(arg0: &0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::protocol_config_v8::ProtocolConfigV8, arg1: &0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::protocol_config_v8::ProtocolAdminCapV8, arg2: &mut ProductReleaseCatalogV8) : PackageCallCapV8<RuntimeRoleV8> {
        assert_catalog_setup_admin(arg0, arg1, arg2);
        assert!(0x1::option::is_some<PackageCallCapV8<RuntimeRoleV8>>(&arg2.runtime_call_cap), 8);
        0x1::option::extract<PackageCallCapV8<RuntimeRoleV8>>(&mut arg2.runtime_call_cap)
    }

    public fun take_seal_call_cap_v8(arg0: &0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::protocol_config_v8::ProtocolConfigV8, arg1: &0x3a1a925cde44bfb9029bc81968aa0aa141f6fd62e4f5b79f13406fc6c1314dfc::protocol_config_v8::ProtocolAdminCapV8, arg2: &mut ProductReleaseCatalogV8) : PackageCallCapV8<SealRoleV8> {
        assert_catalog_setup_admin(arg0, arg1, arg2);
        assert!(0x1::option::is_some<PackageCallCapV8<SealRoleV8>>(&arg2.seal_call_cap), 8);
        0x1::option::extract<PackageCallCapV8<SealRoleV8>>(&mut arg2.seal_call_cap)
    }

    public fun version_v8() : u64 {
        8
    }

    // decompiled from Move bytecode v7
}

