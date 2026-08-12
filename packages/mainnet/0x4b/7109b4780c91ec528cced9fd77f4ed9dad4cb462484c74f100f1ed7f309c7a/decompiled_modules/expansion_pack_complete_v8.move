module 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::expansion_pack_complete_v8 {
    struct ExpansionPackCompleteStyleSelectionV8 has copy, drop, store {
        release_id: 0x2::object::ID,
        pack_id: 0x1::string::String,
        namespace: 0x1::string::String,
        pack_version: 0x1::string::String,
        manifest_blob_id: 0x1::string::String,
        manifest_sha256: vector<u8>,
        content_commitment: vector<u8>,
        style_registry_commitment: vector<u8>,
        part_key: 0x1::string::String,
        item_key: 0x1::string::String,
        style_key: 0x1::string::String,
        asset_blob_id: 0x1::string::String,
        asset_sha256: vector<u8>,
        asset_seal_id: vector<u8>,
    }

    struct ExpansionPackSelectionHashInputV8 has copy, drop, store {
        version: u64,
        parent_root_id: 0x2::object::ID,
        payer: address,
        base_recipe_hash: vector<u8>,
        selections: vector<ExpansionPackCompleteStyleSelectionV8>,
    }

    struct ExpansionPackCompleteHashInputV8 has copy, drop, store {
        version: u64,
        commerce_config_id: 0x2::object::ID,
        parent_root_id: 0x2::object::ID,
        payer: address,
        base_recipe_hash: vector<u8>,
        complete_output_seal_id: vector<u8>,
        pack_selection_commitment: vector<u8>,
    }

    struct ExpansionPackCompleteAuthorizationV8 {
        version: u64,
        parent_root_id: 0x2::object::ID,
        payer: address,
        base_recipe_hash: vector<u8>,
        selections: vector<ExpansionPackCompleteStyleSelectionV8>,
        pack_selection_commitment: vector<u8>,
        sealed: bool,
    }

    struct ExpansionPackCompleteSoulBindingV8 {
        version: u64,
        commerce_config_id: 0x2::object::ID,
        parent_root_id: 0x2::object::ID,
        payer: address,
        base_recipe_hash: vector<u8>,
        complete_output_seal_id: vector<u8>,
        pack_selection_commitment: vector<u8>,
        complete_authorization_commitment: vector<u8>,
        selections: vector<ExpansionPackCompleteStyleSelectionV8>,
    }

    struct ExpansionPackCompleteProvenanceV8 has key {
        id: 0x2::object::UID,
        version: u64,
        commerce_config_id: 0x2::object::ID,
        parent_root_id: 0x2::object::ID,
        soul_id: 0x2::object::ID,
        payer: address,
        base_recipe_hash: vector<u8>,
        complete_output_seal_id: vector<u8>,
        pack_selection_commitment: vector<u8>,
        complete_authorization_commitment: vector<u8>,
        selections: vector<ExpansionPackCompleteStyleSelectionV8>,
    }

    struct ExpansionPackCompleteAuthenticatedV8 has copy, drop {
        parent_root_id: 0x2::object::ID,
        payer: address,
        complete_output_seal_id: vector<u8>,
        pack_selection_commitment: vector<u8>,
        complete_authorization_commitment: vector<u8>,
        selection_count: u64,
    }

    struct ExpansionPackCompleteBoundToSoulV8 has copy, drop {
        provenance_id: 0x2::object::ID,
        parent_root_id: 0x2::object::ID,
        soul_id: 0x2::object::ID,
        payer: address,
        complete_output_seal_id: vector<u8>,
        pack_selection_commitment: vector<u8>,
        complete_authorization_commitment: vector<u8>,
        selection_count: u64,
    }

    public fun append_expansion_pack_complete_style_v8(arg0: &mut ExpansionPackCompleteAuthorizationV8, arg1: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::expansion_pack_v8::ExpansionPackReleaseV8, arg2: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerRootV5, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &0x2::tx_context::TxContext) {
        assert!(!arg0.sealed, 3);
        assert!(arg0.version == 8, 0);
        assert!(arg0.parent_root_id == 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::root_id_v5(arg2), 1);
        assert!(arg0.payer == 0x2::tx_context::sender(arg6), 2);
        assert!(0x1::vector::length<ExpansionPackCompleteStyleSelectionV8>(&arg0.selections) < 750, 6);
        let v0 = 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::expansion_pack_v8::verify_style_access_v8(arg1, arg2, arg3, arg4, arg5, arg6);
        let v1 = 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::expansion_pack_v8::style_access_proof_release_id_v8(&v0);
        assert!(v1 == 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::expansion_pack_v8::release_id_v8(arg1), 1);
        assert!(0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::expansion_pack_v8::style_access_proof_parent_root_id_v8(&v0) == arg0.parent_root_id, 1);
        assert!(0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::expansion_pack_v8::style_access_proof_holder_v8(&v0) == arg0.payer, 2);
        assert!(!selection_exists(&arg0.selections, v1, &arg3, &arg4, &arg5), 5);
        let v2 = *0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::expansion_pack_v8::release_manifest_sha256_v8(arg1);
        let v3 = *0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::expansion_pack_v8::release_content_commitment_v8(arg1);
        let v4 = *0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::expansion_pack_v8::release_style_registry_commitment_v8(arg1);
        let v5 = *0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::expansion_pack_v8::style_access_proof_sha256_v8(&v0);
        assert_hash(&v2);
        assert_hash(&v3);
        assert_hash(&v4);
        assert_hash(&v5);
        let v6 = *0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::expansion_pack_v8::style_access_proof_seal_id_v8(&v0);
        assert!(0x1::vector::length<u8>(&v6) == 0 || 0x1::vector::length<u8>(&v6) == 32, 0);
        let v7 = ExpansionPackCompleteStyleSelectionV8{
            release_id                : v1,
            pack_id                   : *0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::expansion_pack_v8::release_pack_id_v8(arg1),
            namespace                 : *0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::expansion_pack_v8::release_namespace_v8(arg1),
            pack_version              : *0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::expansion_pack_v8::release_pack_version_v8(arg1),
            manifest_blob_id          : *0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::expansion_pack_v8::release_manifest_blob_id_v8(arg1),
            manifest_sha256           : v2,
            content_commitment        : v3,
            style_registry_commitment : v4,
            part_key                  : arg3,
            item_key                  : arg4,
            style_key                 : arg5,
            asset_blob_id             : *0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::expansion_pack_v8::style_access_proof_blob_id_v8(&v0),
            asset_sha256              : v5,
            asset_seal_id             : v6,
        };
        0x1::vector::push_back<ExpansionPackCompleteStyleSelectionV8>(&mut arg0.selections, v7);
    }

    fun assert_hash(arg0: &vector<u8>) {
        assert!(0x1::vector::length<u8>(arg0) == 32, 0);
    }

    public fun authenticate_expansion_pack_complete_v8(arg0: ExpansionPackCompleteAuthorizationV8, arg1: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::CommerceV5SoulMintAuthorization, arg2: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerRootV5, arg3: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::CommerceProtocolConfigV5, arg4: &0x2::tx_context::TxContext) : ExpansionPackCompleteSoulBindingV8 {
        0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::assert_extension_operational_v5(arg2, arg3);
        let ExpansionPackCompleteAuthorizationV8 {
            version                   : v0,
            parent_root_id            : v1,
            payer                     : v2,
            base_recipe_hash          : v3,
            selections                : v4,
            pack_selection_commitment : v5,
            sealed                    : v6,
        } = arg0;
        let v7 = v5;
        let v8 = v4;
        let v9 = v3;
        assert!(v0 == 8 && v6, 3);
        assert!(v1 == 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::root_id_v5(arg2), 1);
        assert!(0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::complete_authorization_root_id_v5(arg1) == v1, 8);
        assert!(v2 == 0x2::tx_context::sender(arg4), 2);
        assert!(0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::complete_authorization_payer_v5(arg1) == v2, 8);
        assert!(0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::complete_authorization_recipe_hash_v5(arg1) == &v9, 8);
        assert!(0x1::vector::length<ExpansionPackCompleteStyleSelectionV8>(&v8) > 0, 4);
        assert!(v7 == selection_commitment(v0, v1, v2, &v9, &v8), 0);
        let v10 = *0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::complete_authorization_output_seal_id_v5(arg1);
        assert_hash(&v10);
        let v11 = 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::protocol_config_id_v5(arg3);
        let v12 = complete_commitment(v0, v11, v1, v2, &v9, &v10, &v7);
        let v13 = ExpansionPackCompleteAuthenticatedV8{
            parent_root_id                    : v1,
            payer                             : v2,
            complete_output_seal_id           : v10,
            pack_selection_commitment         : v7,
            complete_authorization_commitment : v12,
            selection_count                   : 0x1::vector::length<ExpansionPackCompleteStyleSelectionV8>(&v8),
        };
        0x2::event::emit<ExpansionPackCompleteAuthenticatedV8>(v13);
        ExpansionPackCompleteSoulBindingV8{
            version                           : v0,
            commerce_config_id                : v11,
            parent_root_id                    : v1,
            payer                             : v2,
            base_recipe_hash                  : v9,
            complete_output_seal_id           : v10,
            pack_selection_commitment         : v7,
            complete_authorization_commitment : v12,
            selections                        : v8,
        }
    }

    public fun authorization_pack_selection_commitment_v8(arg0: &ExpansionPackCompleteAuthorizationV8) : &vector<u8> {
        &arg0.pack_selection_commitment
    }

    public fun authorization_selection_count_v8(arg0: &ExpansionPackCompleteAuthorizationV8) : u64 {
        0x1::vector::length<ExpansionPackCompleteStyleSelectionV8>(&arg0.selections)
    }

    public fun begin_expansion_pack_complete_authorization_v8(arg0: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerRootV5, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) : ExpansionPackCompleteAuthorizationV8 {
        0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::expansion_pack_v8::assert_complete_bridge_enabled_v8();
        assert_hash(&arg1);
        ExpansionPackCompleteAuthorizationV8{
            version                   : 8,
            parent_root_id            : 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::root_id_v5(arg0),
            payer                     : 0x2::tx_context::sender(arg2),
            base_recipe_hash          : arg1,
            selections                : 0x1::vector::empty<ExpansionPackCompleteStyleSelectionV8>(),
            pack_selection_commitment : b"",
            sealed                    : false,
        }
    }

    public fun bind_expansion_pack_complete_to_soul_v8<T0: drop>(arg0: ExpansionPackCompleteSoulBindingV8, arg1: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::CommerceProtocolConfigV5, arg2: 0x2::object::ID, arg3: T0, arg4: &mut 0x2::tx_context::TxContext) : T0 {
        let (v0, v1) = new_bound_provenance<T0>(arg0, arg1, arg2, arg3, arg4);
        0x2::transfer::share_object<ExpansionPackCompleteProvenanceV8>(v0);
        v1
    }

    public fun companion_proof_available_v8() : bool {
        false
    }

    public fun companion_proof_version_v8() : u64 {
        8
    }

    fun complete_commitment(arg0: u64, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: address, arg4: &vector<u8>, arg5: &vector<u8>, arg6: &vector<u8>) : vector<u8> {
        let v0 = ExpansionPackCompleteHashInputV8{
            version                   : arg0,
            commerce_config_id        : arg1,
            parent_root_id            : arg2,
            payer                     : arg3,
            base_recipe_hash          : *arg4,
            complete_output_seal_id   : *arg5,
            pack_selection_commitment : *arg6,
        };
        0x1::hash::sha2_256(0x1::bcs::to_bytes<ExpansionPackCompleteHashInputV8>(&v0))
    }

    fun new_bound_provenance<T0: drop>(arg0: ExpansionPackCompleteSoulBindingV8, arg1: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::CommerceProtocolConfigV5, arg2: 0x2::object::ID, arg3: T0, arg4: &mut 0x2::tx_context::TxContext) : (ExpansionPackCompleteProvenanceV8, T0) {
        0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::assert_extension_soul_binding_proof_type_v5<T0>(arg1);
        let ExpansionPackCompleteSoulBindingV8 {
            version                           : v0,
            commerce_config_id                : v1,
            parent_root_id                    : v2,
            payer                             : v3,
            base_recipe_hash                  : v4,
            complete_output_seal_id           : v5,
            pack_selection_commitment         : v6,
            complete_authorization_commitment : v7,
            selections                        : v8,
        } = arg0;
        let v9 = v8;
        let v10 = v6;
        let v11 = v5;
        let v12 = v4;
        assert!(v0 == 8, 0);
        assert!(v1 == 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::protocol_config_id_v5(arg1), 1);
        assert!(v3 == 0x2::tx_context::sender(arg4), 2);
        assert!(0x2::object::id_to_address(&arg2) != @0x0, 7);
        assert_hash(&v12);
        assert_hash(&v11);
        assert_hash(&v10);
        assert!(0x1::vector::length<ExpansionPackCompleteStyleSelectionV8>(&v9) > 0, 4);
        assert!(v7 == complete_commitment(v0, v1, v2, v3, &v12, &v11, &v10), 0);
        let v13 = ExpansionPackCompleteProvenanceV8{
            id                                : 0x2::object::new(arg4),
            version                           : v0,
            commerce_config_id                : v1,
            parent_root_id                    : v2,
            soul_id                           : arg2,
            payer                             : v3,
            base_recipe_hash                  : v12,
            complete_output_seal_id           : v11,
            pack_selection_commitment         : v10,
            complete_authorization_commitment : v7,
            selections                        : v9,
        };
        let v14 = ExpansionPackCompleteBoundToSoulV8{
            provenance_id                     : 0x2::object::id<ExpansionPackCompleteProvenanceV8>(&v13),
            parent_root_id                    : v2,
            soul_id                           : arg2,
            payer                             : v3,
            complete_output_seal_id           : v11,
            pack_selection_commitment         : v10,
            complete_authorization_commitment : v7,
            selection_count                   : 0x1::vector::length<ExpansionPackCompleteStyleSelectionV8>(&v13.selections),
        };
        0x2::event::emit<ExpansionPackCompleteBoundToSoulV8>(v14);
        (v13, arg3)
    }

    public fun seal_expansion_pack_complete_authorization_v8(arg0: &mut ExpansionPackCompleteAuthorizationV8) {
        assert!(!arg0.sealed, 3);
        assert!(0x1::vector::length<ExpansionPackCompleteStyleSelectionV8>(&arg0.selections) > 0, 4);
        arg0.pack_selection_commitment = selection_commitment(arg0.version, arg0.parent_root_id, arg0.payer, &arg0.base_recipe_hash, &arg0.selections);
        arg0.sealed = true;
    }

    fun selection_commitment(arg0: u64, arg1: 0x2::object::ID, arg2: address, arg3: &vector<u8>, arg4: &vector<ExpansionPackCompleteStyleSelectionV8>) : vector<u8> {
        let v0 = ExpansionPackSelectionHashInputV8{
            version          : arg0,
            parent_root_id   : arg1,
            payer            : arg2,
            base_recipe_hash : *arg3,
            selections       : *arg4,
        };
        0x1::hash::sha2_256(0x1::bcs::to_bytes<ExpansionPackSelectionHashInputV8>(&v0))
    }

    fun selection_exists(arg0: &vector<ExpansionPackCompleteStyleSelectionV8>, arg1: 0x2::object::ID, arg2: &0x1::string::String, arg3: &0x1::string::String, arg4: &0x1::string::String) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<ExpansionPackCompleteStyleSelectionV8>(arg0)) {
            let v1 = 0x1::vector::borrow<ExpansionPackCompleteStyleSelectionV8>(arg0, v0);
            let v2 = if (v1.release_id == arg1) {
                if (&v1.part_key == arg2) {
                    if (&v1.item_key == arg3) {
                        &v1.style_key == arg4
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            };
            if (v2) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    // decompiled from Move bytecode v7
}

