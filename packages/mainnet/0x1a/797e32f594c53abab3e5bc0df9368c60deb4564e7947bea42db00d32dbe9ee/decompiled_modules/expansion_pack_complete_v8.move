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
        abort 17
    }

    public fun authenticate_expansion_pack_complete_v8(arg0: ExpansionPackCompleteAuthorizationV8, arg1: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::CommerceV5SoulMintAuthorization, arg2: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerRootV5, arg3: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::CommerceProtocolConfigV5, arg4: &0x2::tx_context::TxContext) : ExpansionPackCompleteSoulBindingV8 {
        abort 17
    }

    public fun authorization_pack_selection_commitment_v8(arg0: &ExpansionPackCompleteAuthorizationV8) : &vector<u8> {
        &arg0.pack_selection_commitment
    }

    public fun authorization_selection_count_v8(arg0: &ExpansionPackCompleteAuthorizationV8) : u64 {
        0x1::vector::length<ExpansionPackCompleteStyleSelectionV8>(&arg0.selections)
    }

    public fun begin_expansion_pack_complete_authorization_v8(arg0: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerRootV5, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) : ExpansionPackCompleteAuthorizationV8 {
        abort 17
    }

    public fun bind_expansion_pack_complete_to_soul_v8<T0: drop>(arg0: ExpansionPackCompleteSoulBindingV8, arg1: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::CommerceProtocolConfigV5, arg2: 0x2::object::ID, arg3: T0, arg4: &mut 0x2::tx_context::TxContext) : T0 {
        abort 17
    }

    public fun companion_proof_available_v8() : bool {
        false
    }

    public fun companion_proof_version_v8() : u64 {
        8
    }

    public fun seal_expansion_pack_complete_authorization_v8(arg0: &mut ExpansionPackCompleteAuthorizationV8) {
        abort 17
    }

    // decompiled from Move bytecode v7
}

