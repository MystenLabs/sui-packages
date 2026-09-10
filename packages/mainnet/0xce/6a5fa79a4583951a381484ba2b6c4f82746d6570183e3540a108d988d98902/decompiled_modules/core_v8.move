module 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::core_v8 {
    struct LivingContentBindingV8 has copy, drop, store {
        schema_revision: u64,
        creator_defaults_commitment: vector<u8>,
        blob_id: 0x1::string::String,
        sha256: vector<u8>,
        byte_length: u64,
        content_commitment: vector<u8>,
    }

    struct WalrusCertificationPolicyV1 has key {
        id: 0x2::object::UID,
        version: u64,
        catalog_id: 0x2::object::ID,
        package_tuple_commitment: vector<u8>,
        system_id: 0x2::object::ID,
        commitment: vector<u8>,
    }

    struct WalrusCertificationBootstrapKeyV1 has copy, drop, store {
        dummy_field: bool,
    }

    struct WalrusCertificationBootstrapSlotV1 has store {
        policy_id: 0x2::object::ID,
        system_id: 0x2::object::ID,
    }

    struct WalrusStorageProofV1 has copy, drop, store {
        system_id: 0x2::object::ID,
        blob_object_id: 0x2::object::ID,
        blob_id: u256,
        size: u64,
        encoding_type: u8,
        registered_epoch: u32,
        certified_epoch: u32,
        end_epoch: u32,
        checked_epoch: u32,
    }

    struct WalrusStorageProofCommitmentInputV1 has drop {
        domain: 0x1::string::String,
        schema_revision: u64,
        proof: WalrusStorageProofV1,
    }

    struct CertifiedLivingContentV1 has key {
        id: 0x2::object::UID,
        version: u64,
        policy_id: 0x2::object::ID,
        system_id: 0x2::object::ID,
        root_id: 0x2::object::ID,
        maker_version: u64,
        root_content_commitment: vector<u8>,
        binding: LivingContentBindingV8,
        storage_proof: WalrusStorageProofV1,
        storage_proof_commitment: vector<u8>,
        certification_commitment: vector<u8>,
    }

    struct LivingContentUseWitnessV1 {
        certificate_id: 0x2::object::ID,
        root_id: 0x2::object::ID,
        maker_version: u64,
        root_content_commitment: vector<u8>,
        binding: LivingContentBindingV8,
        certification_commitment: vector<u8>,
    }

    struct LivingContentReplayKeyV1 has copy, drop, store {
        root_id: 0x2::object::ID,
        maker_version: u64,
        content_commitment: vector<u8>,
    }

    struct LivingContentReplayMarkerV1 has store {
        dummy_field: bool,
    }

    struct LivingContentBindingCommitmentInputV1 has drop {
        domain: 0x1::string::String,
        schema_revision: u64,
        creator_defaults_commitment: vector<u8>,
        blob_id: 0x1::string::String,
        sha256: vector<u8>,
        byte_length: u64,
        bundle_commitment: vector<u8>,
    }

    struct LivingContentCertificationCommitmentInputV1 has drop {
        domain: 0x1::string::String,
        schema_revision: u64,
        certificate_id: 0x2::object::ID,
        policy_id: 0x2::object::ID,
        system_id: 0x2::object::ID,
        root_id: 0x2::object::ID,
        maker_version: u64,
        root_content_commitment: vector<u8>,
        living_content_binding_commitment: vector<u8>,
        storage_proof_commitment: vector<u8>,
    }

    struct WalrusCertificationPolicyCommitmentInputV1 has drop {
        domain: 0x1::string::String,
        schema_revision: u64,
        policy_id: 0x2::object::ID,
        catalog_id: 0x2::object::ID,
        package_tuple_commitment: vector<u8>,
        system_id: 0x2::object::ID,
    }

    struct WalrusCertificationBootstrapSlotCommitmentInputV1 has drop {
        domain: 0x1::string::String,
        schema_revision: u64,
        catalog_id: 0x2::object::ID,
        slot_key_type_name: 0x1::string::String,
        slot_key_bcs: vector<u8>,
        policy_id: 0x2::object::ID,
        system_id: 0x2::object::ID,
    }

    public fun assert_activation_scaffold_ready_v8<T0>(arg0: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg1: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::base_registry_v8::BaseDefinitionRegistryV8) : (0x2::object::ID, vector<u8>, u64) {
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::assert_activation_scaffold_ready_v8<T0>(arg0);
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::base_registry_v8::assert_activation_ready_v8<T0>(arg1, arg0)
    }

    fun assert_certified_living_content<T0>(arg0: &CertifiedLivingContentV1, arg1: &WalrusCertificationPolicyV1, arg2: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>) {
        assert!(arg0.version == 1, 4);
        assert!(arg0.policy_id == 0x2::object::id<WalrusCertificationPolicyV1>(arg1), 4);
        assert!(arg0.system_id == arg1.system_id, 4);
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::assert_root_identity_v8<T0>(arg2, arg0.root_id, arg0.maker_version, &arg0.root_content_commitment);
        assert!(arg0.binding.creator_defaults_commitment == *0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_creator_defaults_commitment_v1<T0>(arg2), 4);
        let v0 = living_content_binding_commitment_v1(&arg0.binding);
        assert!(&v0 == 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_living_content_binding_commitment_v1<T0>(arg2), 4);
        assert_walrus_storage_proof(&arg0.storage_proof, &arg0.binding, arg1.system_id);
        assert!(derive_walrus_storage_proof_commitment(&arg0.storage_proof) == arg0.storage_proof_commitment, 4);
        let v1 = LivingContentCertificationCommitmentInputV1{
            domain                            : 0x1::string::utf8(b"animacraft-fresh-v8/core/walrus-living-content-certificate/v1"),
            schema_revision                   : 1,
            certificate_id                    : 0x2::object::id<CertifiedLivingContentV1>(arg0),
            policy_id                         : arg0.policy_id,
            system_id                         : arg0.system_id,
            root_id                           : arg0.root_id,
            maker_version                     : arg0.maker_version,
            root_content_commitment           : arg0.root_content_commitment,
            living_content_binding_commitment : v0,
            storage_proof_commitment          : arg0.storage_proof_commitment,
        };
        let v2 = 0x1::hash::sha2_256(0x1::bcs::to_bytes<LivingContentCertificationCommitmentInputV1>(&v1));
        assert!(&v2 == &arg0.certification_commitment, 4);
    }

    public fun assert_certified_living_content_v1<T0>(arg0: &WalrusCertificationPolicyV1, arg1: &CertifiedLivingContentV1, arg2: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg3: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>) {
        assert_certified_living_content<T0>(arg1, arg0, arg3);
        assert_walrus_storage_current(&arg1.storage_proof, arg2);
    }

    fun assert_companion_source_v2<T0>(arg0: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg1: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8, arg2: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ProductReleaseCatalogV8, arg3: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::base_registry_v8::BaseDefinitionRegistryV8, arg4: &WalrusCertificationPolicyV1, arg5: &CertifiedLivingContentV1, arg6: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System) {
        assert_walrus_policy_current_v1(arg1, arg2, arg4);
        assert_certified_living_content_v1<T0>(arg4, arg5, arg6, arg0);
        let (_, v1, _) = 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::base_registry_v8::assert_activation_ready_v8<T0>(arg3, arg0);
        let v3 = v1;
        assert!(&v3 == 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_sealed_base_registry_commitment_v2<T0>(arg0), 4);
    }

    fun assert_hash(arg0: &vector<u8>) {
        assert!(0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::is_nonzero_hash_v2(arg0), 0);
    }

    fun assert_living_content_binding(arg0: &LivingContentBindingV8) {
        assert!(arg0.schema_revision == 1, 0);
        assert_hash(&arg0.creator_defaults_commitment);
        assert!(!0x1::string::is_empty(&arg0.blob_id) && 0x1::string::length(&arg0.blob_id) <= 512, 0);
        assert_hash(&arg0.sha256);
        assert!(arg0.byte_length > 0, 0);
        assert_hash(&arg0.content_commitment);
    }

    fun assert_walrus_policy(arg0: &WalrusCertificationPolicyV1, arg1: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ProductReleaseCatalogV8) {
        assert!(arg0.version == 1, 0);
        assert!(arg0.catalog_id == 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::catalog_id_v8(arg1), 0);
        assert!(&arg0.package_tuple_commitment == 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::product_binding_commitment_v8(0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::catalog_binding_v8(arg1)), 0);
        let v0 = derive_walrus_policy_commitment(0x2::object::id<WalrusCertificationPolicyV1>(arg0), arg0.catalog_id, arg0.package_tuple_commitment, arg0.system_id);
        assert!(&v0 == &arg0.commitment, 0);
        let v1 = WalrusCertificationBootstrapKeyV1{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow<WalrusCertificationBootstrapKeyV1, WalrusCertificationBootstrapSlotV1>(0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::catalog_uid_v2(arg1), v1);
        assert!(v2.policy_id == 0x2::object::id<WalrusCertificationPolicyV1>(arg0) && v2.system_id == arg0.system_id, 4);
    }

    public fun assert_walrus_policy_current_v1(arg0: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8, arg1: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ProductReleaseCatalogV8, arg2: &WalrusCertificationPolicyV1) {
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::assert_catalog_current_v8(arg0, arg1);
        assert_walrus_policy(arg2, arg1);
    }

    fun assert_walrus_storage_current(arg0: &WalrusStorageProofV1, arg1: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System) {
        assert!(0x2::object::id<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System>(arg1) == arg0.system_id, 4);
        let v0 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::epoch(arg1);
        assert!(v0 >= arg0.checked_epoch && v0 < arg0.end_epoch, 0);
    }

    fun assert_walrus_storage_proof(arg0: &WalrusStorageProofV1, arg1: &LivingContentBindingV8, arg2: 0x2::object::ID) {
        let v0 = if (arg0.system_id == arg2) {
            if (arg0.registered_epoch <= arg0.certified_epoch) {
                if (arg0.certified_epoch <= arg0.checked_epoch) {
                    arg0.checked_epoch < arg0.end_epoch
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 0);
        assert!(arg0.size == arg1.byte_length && walrus_blob_id_string_v1(arg0.blob_id) == arg1.blob_id, 4);
    }

    public fun begin_maker_companion_binding_v2<T0>(arg0: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg1: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerAdminCapV8, arg2: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8, arg3: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ProductReleaseCatalogV8, arg4: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::FreshTupleReplacementBindingV2, arg5: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::base_registry_v8::BaseDefinitionRegistryV8, arg6: &WalrusCertificationPolicyV1, arg7: &CertifiedLivingContentV1, arg8: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg9: &0x2::tx_context::TxContext) : 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::companion_binding_v2::MakerRuntimeCompanionBindingBuilderV2<T0> {
        assert_companion_source_v2<T0>(arg0, arg2, arg3, arg5, arg6, arg7, arg8);
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::begin_companion_binding_v2<T0>(arg0, arg1, arg2, arg3, arg4, arg9)
    }

    public fun bootstrap_walrus_certification_policy_v1(arg0: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8, arg1: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolAdminCapV8, arg2: &mut 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ProductReleaseCatalogV8, arg3: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg4: &mut 0x2::tx_context::TxContext) {
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::assert_protocol_admin_v8(arg0, arg1);
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::assert_catalog_current_v8(arg0, arg2);
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::assert_catalog_setup_complete_v2(arg2);
        0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::epoch(arg3);
        let v0 = 0x2::object::new(arg4);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::catalog_id_v8(arg2);
        let v3 = *0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::product_binding_commitment_v8(0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::catalog_binding_v8(arg2));
        let v4 = 0x2::object::id<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System>(arg3);
        let v5 = 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::catalog_uid_mut_v2(arg2);
        let v6 = WalrusCertificationBootstrapKeyV1{dummy_field: false};
        assert!(!0x2::dynamic_field::exists<WalrusCertificationBootstrapKeyV1>(v5, v6), 1);
        let v7 = WalrusCertificationBootstrapKeyV1{dummy_field: false};
        let v8 = WalrusCertificationBootstrapSlotV1{
            policy_id : v1,
            system_id : v4,
        };
        0x2::dynamic_field::add<WalrusCertificationBootstrapKeyV1, WalrusCertificationBootstrapSlotV1>(v5, v7, v8);
        let v9 = WalrusCertificationPolicyV1{
            id                       : v0,
            version                  : 1,
            catalog_id               : v2,
            package_tuple_commitment : v3,
            system_id                : v4,
            commitment               : derive_walrus_policy_commitment(v1, v2, v3, v4),
        };
        0x2::transfer::share_object<WalrusCertificationPolicyV1>(v9);
    }

    public fun certified_living_content_binding_v1(arg0: &CertifiedLivingContentV1) : &LivingContentBindingV8 {
        &arg0.binding
    }

    public fun certified_living_content_commitment_v1(arg0: &CertifiedLivingContentV1) : &vector<u8> {
        &arg0.certification_commitment
    }

    public fun certified_living_content_id_v1(arg0: &CertifiedLivingContentV1) : 0x2::object::ID {
        0x2::object::id<CertifiedLivingContentV1>(arg0)
    }

    public fun certify_walrus_living_content_v1<T0>(arg0: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8, arg1: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ProductReleaseCatalogV8, arg2: &mut WalrusCertificationPolicyV1, arg3: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg4: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerAdminCapV8, arg5: LivingContentBindingV8, arg6: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob, arg7: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg8: &mut 0x2::tx_context::TxContext) : CertifiedLivingContentV1 {
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::assert_catalog_current_v8(arg0, arg1);
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::assert_product_release_catalog_v8<T0>(arg3, arg1);
        assert_walrus_policy(arg2, arg1);
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::assert_draft_admin_v8<T0>(arg3, arg4);
        assert!(0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_owner_v8<T0>(arg3) == 0x2::tx_context::sender(arg8), 2);
        assert!(arg5.creator_defaults_commitment == *0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_creator_defaults_commitment_v1<T0>(arg3), 4);
        let v0 = living_content_binding_commitment_v1(&arg5);
        assert!(&v0 == 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_living_content_binding_commitment_v1<T0>(arg3), 4);
        let v1 = read_walrus_storage_proof(arg2, &arg5, arg6, arg7);
        let v2 = derive_walrus_storage_proof_commitment(&v1);
        let v3 = LivingContentReplayKeyV1{
            root_id            : 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_id_v8<T0>(arg3),
            maker_version      : 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_maker_version_v8<T0>(arg3),
            content_commitment : arg5.content_commitment,
        };
        assert!(!0x2::dynamic_field::exists<LivingContentReplayKeyV1>(&arg2.id, v3), 3);
        let v4 = LivingContentReplayMarkerV1{dummy_field: false};
        0x2::dynamic_field::add<LivingContentReplayKeyV1, LivingContentReplayMarkerV1>(&mut arg2.id, v3, v4);
        let v5 = 0x2::object::new(arg8);
        let v6 = 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_id_v8<T0>(arg3);
        let v7 = 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_maker_version_v8<T0>(arg3);
        let v8 = *0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_content_commitment_v8<T0>(arg3);
        let v9 = LivingContentCertificationCommitmentInputV1{
            domain                            : 0x1::string::utf8(b"animacraft-fresh-v8/core/walrus-living-content-certificate/v1"),
            schema_revision                   : 1,
            certificate_id                    : 0x2::object::uid_to_inner(&v5),
            policy_id                         : 0x2::object::id<WalrusCertificationPolicyV1>(arg2),
            system_id                         : arg2.system_id,
            root_id                           : v6,
            maker_version                     : v7,
            root_content_commitment           : v8,
            living_content_binding_commitment : v0,
            storage_proof_commitment          : v2,
        };
        CertifiedLivingContentV1{
            id                       : v5,
            version                  : 1,
            policy_id                : 0x2::object::id<WalrusCertificationPolicyV1>(arg2),
            system_id                : arg2.system_id,
            root_id                  : v6,
            maker_version            : v7,
            root_content_commitment  : v8,
            binding                  : arg5,
            storage_proof            : v1,
            storage_proof_commitment : v2,
            certification_commitment : 0x1::hash::sha2_256(0x1::bcs::to_bytes<LivingContentCertificationCommitmentInputV1>(&v9)),
        }
    }

    public fun consume_living_content_use_witness_v1<T0>(arg0: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg1: &LivingContentBindingV8, arg2: LivingContentUseWitnessV1) : (0x2::object::ID, vector<u8>) {
        let LivingContentUseWitnessV1 {
            certificate_id           : v0,
            root_id                  : v1,
            maker_version            : v2,
            root_content_commitment  : v3,
            binding                  : v4,
            certification_commitment : v5,
        } = arg2;
        let v6 = v5;
        let v7 = v3;
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::assert_root_identity_v8<T0>(arg0, v1, v2, &v7);
        assert!(v4 == *arg1, 4);
        assert!(living_content_binding_commitment_v1(arg1) == *0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_living_content_binding_commitment_v1<T0>(arg0), 4);
        assert_hash(&v6);
        (v0, v6)
    }

    fun derive_walrus_policy_commitment(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: vector<u8>, arg3: 0x2::object::ID) : vector<u8> {
        let v0 = WalrusCertificationPolicyCommitmentInputV1{
            domain                   : 0x1::string::utf8(b"animacraft-fresh-v8/core/walrus-certification-policy/v1"),
            schema_revision          : 1,
            policy_id                : arg0,
            catalog_id               : arg1,
            package_tuple_commitment : arg2,
            system_id                : arg3,
        };
        0x1::hash::sha2_256(0x1::bcs::to_bytes<WalrusCertificationPolicyCommitmentInputV1>(&v0))
    }

    fun derive_walrus_storage_proof_commitment(arg0: &WalrusStorageProofV1) : vector<u8> {
        let v0 = WalrusStorageProofCommitmentInputV1{
            domain          : 0x1::string::utf8(b"animacraft-fresh-v8/core/walrus-storage-proof/v1"),
            schema_revision : 1,
            proof           : *arg0,
        };
        0x1::hash::sha2_256(0x1::bcs::to_bytes<WalrusStorageProofCommitmentInputV1>(&v0))
    }

    public fun finish_maker_companion_binding_v2<T0>(arg0: 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::companion_binding_v2::MakerRuntimeCompanionBindingBuilderV2<T0>, arg1: &mut 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg2: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerAdminCapV8, arg3: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8, arg4: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ProductReleaseCatalogV8, arg5: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::FreshTupleReplacementBindingV2, arg6: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::base_registry_v8::BaseDefinitionRegistryV8, arg7: &WalrusCertificationPolicyV1, arg8: &CertifiedLivingContentV1, arg9: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg10: &0x2::tx_context::TxContext) {
        assert_companion_source_v2<T0>(arg1, arg3, arg4, arg6, arg7, arg8, arg9);
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::finish_companion_binding_v2<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg10);
    }

    public fun freeze_certified_living_content_v1(arg0: CertifiedLivingContentV1) {
        0x2::transfer::freeze_object<CertifiedLivingContentV1>(arg0);
    }

    public fun issue_living_content_use_witness_v1<T0>(arg0: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8, arg1: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ProductReleaseCatalogV8, arg2: &WalrusCertificationPolicyV1, arg3: &CertifiedLivingContentV1, arg4: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg5: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>) : LivingContentUseWitnessV1 {
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::assert_catalog_current_v8(arg0, arg1);
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::assert_product_release_catalog_v8<T0>(arg5, arg1);
        assert_walrus_policy(arg2, arg1);
        assert_certified_living_content<T0>(arg3, arg2, arg5);
        assert_walrus_storage_current(&arg3.storage_proof, arg4);
        LivingContentUseWitnessV1{
            certificate_id           : 0x2::object::id<CertifiedLivingContentV1>(arg3),
            root_id                  : arg3.root_id,
            maker_version            : arg3.maker_version,
            root_content_commitment  : arg3.root_content_commitment,
            binding                  : arg3.binding,
            certification_commitment : arg3.certification_commitment,
        }
    }

    public fun living_content_binding_commitment_v1(arg0: &LivingContentBindingV8) : vector<u8> {
        assert_living_content_binding(arg0);
        let v0 = LivingContentBindingCommitmentInputV1{
            domain                      : 0x1::string::utf8(b"animacraft-fresh-v8/output/living-content-binding/v1"),
            schema_revision             : 1,
            creator_defaults_commitment : arg0.creator_defaults_commitment,
            blob_id                     : arg0.blob_id,
            sha256                      : arg0.sha256,
            byte_length                 : arg0.byte_length,
            bundle_commitment           : arg0.content_commitment,
        };
        0x1::hash::sha2_256(0x1::bcs::to_bytes<LivingContentBindingCommitmentInputV1>(&v0))
    }

    public fun new_initial_maker_draft_v8<T0>(arg0: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8, arg1: 0x1::string::String, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: 0x1::string::String, arg7: vector<u8>, arg8: vector<u8>, arg9: 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::base_registry_v8::BaseDefinitionCountsV8, arg10: vector<u8>, arg11: vector<u8>, arg12: 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::EconomicsSnapshotV8, arg13: 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::RightsSnapshotV8, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) : (0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::base_registry_v8::BaseDefinitionRegistryV8, 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::treasury_v8::MakerTreasuryV8<T0>, 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerAdminCapV8) {
        let (v0, v1) = 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::new_initial_maker_draft_v8<T0>(arg0, 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::base_registry_v8::definition_count_v2(&arg9), arg10, arg11, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg12, arg13, arg14, arg15);
        let v2 = v1;
        let v3 = v0;
        let v4 = 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::base_registry_v8::new_base_definition_registry_v8<T0>(&v3, &v2, arg9, arg15);
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::finalize_base_registry_binding_v8<T0>(&mut v3, &v2, 0x2::object::id<0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::base_registry_v8::BaseDefinitionRegistryV8>(&v4));
        (v3, v4, 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::treasury_v8::new_maker_treasury_v8<T0>(&mut v3, &v2, arg15), v2)
    }

    public fun new_living_content_binding_v8(arg0: vector<u8>, arg1: 0x1::string::String, arg2: vector<u8>, arg3: u64, arg4: vector<u8>) : LivingContentBindingV8 {
        assert_hash(&arg0);
        assert!(!0x1::string::is_empty(&arg1) && 0x1::string::length(&arg1) <= 512, 0);
        assert_hash(&arg2);
        assert!(arg3 > 0, 0);
        assert_hash(&arg4);
        LivingContentBindingV8{
            schema_revision             : 1,
            creator_defaults_commitment : arg0,
            blob_id                     : arg1,
            sha256                      : arg2,
            byte_length                 : arg3,
            content_commitment          : arg4,
        }
    }

    public fun new_successor_maker_draft_v8<T0>(arg0: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8, arg1: &mut 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg2: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerAdminCapV8, arg3: 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::SuccessorAuthorityV8<T0>, arg4: u64, arg5: vector<u8>, arg6: 0x1::string::String, arg7: vector<u8>, arg8: vector<u8>, arg9: 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::base_registry_v8::BaseDefinitionCountsV8, arg10: vector<u8>, arg11: vector<u8>, arg12: vector<u8>, arg13: vector<u8>, arg14: vector<u8>, arg15: 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::EconomicsSnapshotV8, arg16: 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::RightsSnapshotV8, arg17: &0x2::clock::Clock, arg18: &mut 0x2::tx_context::TxContext) : (0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::base_registry_v8::BaseDefinitionRegistryV8, 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::treasury_v8::MakerTreasuryV8<T0>, 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerAdminCapV8) {
        let (v0, v1) = 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::new_successor_maker_draft_v8<T0>(arg0, arg1, arg2, arg3, arg4, 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::base_registry_v8::definition_count_v2(&arg9), arg10, arg11, arg12, arg13, arg14, arg5, arg6, arg7, arg8, arg15, arg16, arg17, arg18);
        let v2 = v1;
        let v3 = v0;
        let v4 = 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::base_registry_v8::new_base_definition_registry_v8<T0>(&v3, &v2, arg9, arg18);
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::finalize_base_registry_binding_v8<T0>(&mut v3, &v2, 0x2::object::id<0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::base_registry_v8::BaseDefinitionRegistryV8>(&v4));
        (v3, v4, 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::treasury_v8::new_maker_treasury_v8<T0>(&mut v3, &v2, arg18), v2)
    }

    fun read_walrus_storage_proof(arg0: &WalrusCertificationPolicyV1, arg1: &LivingContentBindingV8, arg2: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob, arg3: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System) : WalrusStorageProofV1 {
        assert!(0x2::object::id<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System>(arg3) == arg0.system_id, 4);
        let v0 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::certified_epoch(arg2);
        assert!(0x1::option::is_some<u32>(v0) && !0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::is_deletable(arg2), 0);
        let v1 = WalrusStorageProofV1{
            system_id        : 0x2::object::id<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System>(arg3),
            blob_object_id   : 0x2::object::id<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(arg2),
            blob_id          : 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::blob_id(arg2),
            size             : 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::size(arg2),
            encoding_type    : 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::encoding_type(arg2),
            registered_epoch : 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::registered_epoch(arg2),
            certified_epoch  : *0x1::option::borrow<u32>(v0),
            end_epoch        : 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::end_epoch(arg2),
            checked_epoch    : 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::epoch(arg3),
        };
        assert_walrus_storage_proof(&v1, arg1, arg0.system_id);
        v1
    }

    public fun share_maker_draft_v8<T0>(arg0: 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg1: 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::base_registry_v8::BaseDefinitionRegistryV8, arg2: 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::treasury_v8::MakerTreasuryV8<T0>, arg3: 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerAdminCapV8, arg4: &0x2::tx_context::TxContext) {
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::base_registry_v8::assert_draft_registry_identity_v8<T0>(&arg1, &arg0, &arg3);
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::treasury_v8::assert_maker_treasury_v8<T0>(&arg0, &arg2);
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::base_registry_v8::share_base_definition_registry_v8(arg1);
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::treasury_v8::share_maker_treasury_v8<T0>(arg2);
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::share_maker_root_and_admin_v8<T0>(arg0, arg3, arg4);
    }

    public fun version_v8() : u64 {
        8
    }

    public fun walrus_blob_id_string_v1(arg0: u256) : 0x1::string::String {
        let v0 = 0x1::bcs::to_bytes<u256>(&arg0);
        let v1 = b"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_";
        let v2 = b"";
        let v3 = 0;
        while (v3 < 30) {
            let v4 = *0x1::vector::borrow<u8>(&v0, v3);
            let v5 = *0x1::vector::borrow<u8>(&v0, v3 + 1);
            let v6 = *0x1::vector::borrow<u8>(&v0, v3 + 2);
            0x1::vector::push_back<u8>(&mut v2, *0x1::vector::borrow<u8>(&v1, ((v4 >> 2) as u64)));
            0x1::vector::push_back<u8>(&mut v2, *0x1::vector::borrow<u8>(&v1, (((v4 & 3) << 4 | v5 >> 4) as u64)));
            0x1::vector::push_back<u8>(&mut v2, *0x1::vector::borrow<u8>(&v1, (((v5 & 15) << 2 | v6 >> 6) as u64)));
            0x1::vector::push_back<u8>(&mut v2, *0x1::vector::borrow<u8>(&v1, ((v6 & 63) as u64)));
            v3 = v3 + 3;
        };
        let v7 = *0x1::vector::borrow<u8>(&v0, 30);
        let v8 = *0x1::vector::borrow<u8>(&v0, 31);
        0x1::vector::push_back<u8>(&mut v2, *0x1::vector::borrow<u8>(&v1, ((v7 >> 2) as u64)));
        0x1::vector::push_back<u8>(&mut v2, *0x1::vector::borrow<u8>(&v1, (((v7 & 3) << 4 | v8 >> 4) as u64)));
        0x1::vector::push_back<u8>(&mut v2, *0x1::vector::borrow<u8>(&v1, (((v8 & 15) << 2) as u64)));
        0x1::string::utf8(v2)
    }

    public fun walrus_bootstrap_slot_commitment_v1(arg0: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ProductReleaseCatalogV8) : vector<u8> {
        let v0 = WalrusCertificationBootstrapKeyV1{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow<WalrusCertificationBootstrapKeyV1, WalrusCertificationBootstrapSlotV1>(0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::catalog_uid_v2(arg0), v0);
        let v2 = WalrusCertificationBootstrapSlotCommitmentInputV1{
            domain             : 0x1::string::utf8(b"animacraft-fresh-v8/core/walrus-certification-bootstrap-slot/v1"),
            schema_revision    : 1,
            catalog_id         : 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::catalog_id_v8(arg0),
            slot_key_type_name : 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<WalrusCertificationBootstrapKeyV1>())),
            slot_key_bcs       : 0x1::bcs::to_bytes<WalrusCertificationBootstrapKeyV1>(&v0),
            policy_id          : v1.policy_id,
            system_id          : v1.system_id,
        };
        0x1::hash::sha2_256(0x1::bcs::to_bytes<WalrusCertificationBootstrapSlotCommitmentInputV1>(&v2))
    }

    // decompiled from Move bytecode v7
}

