module 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::seal_v5 {
    struct SealIdentityV5 has copy, drop, store {
        release_commitment: vector<u8>,
        product_kind: u8,
        part_key: 0x1::string::String,
        item_key: 0x1::string::String,
        style_key: 0x1::string::String,
        pack_key: 0x1::string::String,
        asset_digest: vector<u8>,
    }

    struct PaidStyleAssetV5 has copy, drop, store {
        seal_id: vector<u8>,
        product_kind: u8,
        part_key: 0x1::string::String,
        item_key: 0x1::string::String,
        style_key: 0x1::string::String,
        pack_key: 0x1::string::String,
        ciphertext_blob_id: 0x1::string::String,
        asset_digest: vector<u8>,
    }

    struct StyleProductIdentityV5 has copy, drop, store {
        product_kind: u8,
        part_key: 0x1::string::String,
        item_key: 0x1::string::String,
        style_key: 0x1::string::String,
        pack_key: 0x1::string::String,
    }

    struct MakerSealPolicyV5 has key {
        id: 0x2::object::UID,
        version: u64,
        root_id: 0x2::object::ID,
        release_commitment: vector<u8>,
        registered_assets: 0x2::table::Table<vector<u8>, PaidStyleAssetV5>,
        registered_style_products: 0x2::table::Table<vector<u8>, bool>,
        asset_count: u64,
        sealed: bool,
    }

    struct MakerSealPolicyCreatedV5 has copy, drop {
        policy_id: 0x2::object::ID,
        root_id: 0x2::object::ID,
        release_commitment: vector<u8>,
    }

    struct PaidStyleAssetRegisteredV5 has copy, drop {
        policy_id: 0x2::object::ID,
        root_id: 0x2::object::ID,
        seal_id: vector<u8>,
        product_kind: u8,
        part_key: 0x1::string::String,
        item_key: 0x1::string::String,
        style_key: 0x1::string::String,
        pack_key: 0x1::string::String,
        ciphertext_blob_id: 0x1::string::String,
        asset_digest: vector<u8>,
    }

    struct MakerSealPolicySealedV5 has copy, drop {
        policy_id: 0x2::object::ID,
        root_id: 0x2::object::ID,
        asset_count: u64,
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
        assert!(v0, 18);
        0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::derive_complete_output_seal_id_v5(arg0, arg1, arg2, arg3, arg4)
    }

    fun assert_policy_root(arg0: &MakerSealPolicyV5, arg1: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerRootV5) {
        assert!(arg0.root_id == 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::root_id_v5(arg1), 2);
    }

    fun assert_root_owner(arg0: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerRootV5, arg1: &0x2::tx_context::TxContext) {
        assert!(0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::root_current_owner_v5(arg0) == 0x2::tx_context::sender(arg1), 1);
    }

    public fun check_complete_output_access_v5(arg0: vector<u8>, arg1: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerRootV5, arg2: address) : bool {
        if (0x1::vector::length<u8>(&arg0) != 32 || !0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::complete_output_exists_v5(arg1, arg0)) {
            return false
        };
        let v0 = 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::complete_output_record_v5(arg1, arg0);
        let v1 = if (0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::complete_output_is_soul_bound_v5(v0)) {
            true
        } else if (0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::complete_output_seal_id_v5(v0) != &arg0) {
            true
        } else if (0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::complete_output_payer_v5(v0) != arg2) {
            true
        } else {
            0x1::string::is_empty(0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::complete_output_ciphertext_blob_id_v5(v0))
        };
        if (v1) {
            return false
        };
        derive_complete_output_seal_id_v5(0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::root_id_v5(arg1), 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::complete_output_payer_v5(v0), *0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::complete_output_recipe_hash_v5(v0), *0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::complete_output_nonce_v5(v0), *0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::complete_output_digest_v5(v0)) == arg0
    }

    public fun check_paid_style_access_v5(arg0: vector<u8>, arg1: &MakerSealPolicyV5, arg2: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerRootV5, arg3: address) : bool {
        assert_policy_root(arg1, arg2);
        assert!(arg1.version == 1, 13);
        assert!(arg1.sealed, 4);
        assert!(0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::style_registry_sealed_v5(arg2), 5);
        if (!0x2::table::contains<vector<u8>, PaidStyleAssetV5>(&arg1.registered_assets, arg0)) {
            return false
        };
        let v0 = 0x2::table::borrow<vector<u8>, PaidStyleAssetV5>(&arg1.registered_assets, arg0);
        if (v0.seal_id != arg0) {
            return false
        };
        if (derive_seal_id_v5(arg1.release_commitment, v0.product_kind, v0.part_key, v0.item_key, v0.style_key, v0.pack_key, v0.asset_digest) != arg0) {
            return false
        };
        let v1 = 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::style_product_pack_key_v5(arg2, v0.part_key, v0.item_key, v0.style_key);
        if (v0.product_kind == 0) {
            if (0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::base_access_kind_v5(arg2) != 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::pack_access_paid_once()) {
                return false
            };
            if (0x1::option::is_none<0x1::string::String>(&v1)) {
                if (!0x1::string::is_empty(&v0.pack_key)) {
                    return false
                };
            } else {
                if (*0x1::option::borrow<0x1::string::String>(&v1) != v0.pack_key) {
                    return false
                };
                let v2 = 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::pack_record_v5(arg2, v0.pack_key);
                if (0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::pack_access_kind_v5(v2) != 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::pack_access_free() || !0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::pack_active_v5(v2)) {
                    return false
                };
            };
        } else if (v0.product_kind == 1) {
            if (0x1::option::is_none<0x1::string::String>(&v1) || *0x1::option::borrow<0x1::string::String>(&v1) != v0.pack_key) {
                return false
            };
        } else {
            return false
        };
        if (0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::style_product_asset_blob_id_v5(arg2, v0.part_key, v0.item_key, v0.style_key) != v0.ciphertext_blob_id) {
            return false
        };
        if (v0.product_kind == 0) {
            0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::has_base_entitlement_v5(arg2, arg3)
        } else {
            let v4 = 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::pack_record_v5(arg2, v0.pack_key);
            if (0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::pack_access_kind_v5(v4) == 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::pack_access_paid_once()) {
                if (0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::pack_active_v5(v4)) {
                    if (0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::has_base_entitlement_v5(arg2, arg3)) {
                        0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::has_pack_entitlement_v5(arg2, v0.pack_key, arg3)
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        }
    }

    entry fun create_and_share_maker_seal_policy_v5(arg0: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerRootV5, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        share_maker_seal_policy_v5(new_maker_seal_policy_v5(arg0, arg1, arg2));
    }

    public fun derive_seal_id_v5(arg0: vector<u8>, arg1: u8, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: vector<u8>) : vector<u8> {
        assert!(0x1::vector::length<u8>(&arg0) == 32, 6);
        assert!(0x1::vector::length<u8>(&arg6) == 32, 7);
        assert!(arg1 == 0 || arg1 == 1, 14);
        let v0 = SealIdentityV5{
            release_commitment : arg0,
            product_kind       : arg1,
            part_key           : arg2,
            item_key           : arg3,
            style_key          : arg4,
            pack_key           : arg5,
            asset_digest       : arg6,
        };
        0x1::hash::sha2_256(0x1::bcs::to_bytes<SealIdentityV5>(&v0))
    }

    public fun new_maker_seal_policy_v5(arg0: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerRootV5, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) : MakerSealPolicyV5 {
        assert_root_owner(arg0, arg2);
        assert!(0x1::vector::length<u8>(&arg1) == 32, 6);
        let v0 = MakerSealPolicyV5{
            id                        : 0x2::object::new(arg2),
            version                   : 1,
            root_id                   : 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::root_id_v5(arg0),
            release_commitment        : arg1,
            registered_assets         : 0x2::table::new<vector<u8>, PaidStyleAssetV5>(arg2),
            registered_style_products : 0x2::table::new<vector<u8>, bool>(arg2),
            asset_count               : 0,
            sealed                    : false,
        };
        let v1 = MakerSealPolicyCreatedV5{
            policy_id          : 0x2::object::id<MakerSealPolicyV5>(&v0),
            root_id            : 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::root_id_v5(arg0),
            release_commitment : arg1,
        };
        0x2::event::emit<MakerSealPolicyCreatedV5>(v1);
        v0
    }

    public fun policy_asset_count_v5(arg0: &MakerSealPolicyV5) : u64 {
        arg0.asset_count
    }

    public fun policy_id_v5(arg0: &MakerSealPolicyV5) : 0x2::object::ID {
        0x2::object::id<MakerSealPolicyV5>(arg0)
    }

    public fun policy_release_commitment_v5(arg0: &MakerSealPolicyV5) : &vector<u8> {
        &arg0.release_commitment
    }

    public fun policy_root_id_v5(arg0: &MakerSealPolicyV5) : 0x2::object::ID {
        arg0.root_id
    }

    public fun policy_sealed_v5(arg0: &MakerSealPolicyV5) : bool {
        arg0.sealed
    }

    public fun register_paid_style_asset_v5(arg0: &mut MakerSealPolicyV5, arg1: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerRootV5, arg2: u8, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: vector<u8>, arg8: &0x2::tx_context::TxContext) {
        assert_policy_root(arg0, arg1);
        assert_root_owner(arg1, arg8);
        assert!(!arg0.sealed, 3);
        assert!(0x1::vector::length<u8>(&arg7) == 32, 7);
        assert!(arg2 == 0 || arg2 == 1, 14);
        assert!(0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::style_product_seal_protected_v5(arg1, arg3, arg4, arg5), 17);
        let v0 = 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::style_product_pack_key_v5(arg1, arg3, arg4, arg5);
        if (arg2 == 0) {
            assert!(0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::base_access_kind_v5(arg1) == 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::pack_access_paid_once(), 15);
            if (0x1::option::is_none<0x1::string::String>(&v0)) {
                assert!(0x1::string::is_empty(&arg6), 9);
            } else {
                assert!(*0x1::option::borrow<0x1::string::String>(&v0) == arg6, 9);
                let v1 = 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::pack_record_v5(arg1, arg6);
                assert!(0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::pack_access_kind_v5(v1) == 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::pack_access_free(), 8);
                assert!(0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::pack_active_v5(v1), 10);
            };
        } else {
            assert!(0x1::option::is_some<0x1::string::String>(&v0), 8);
            assert!(*0x1::option::borrow<0x1::string::String>(&v0) == arg6, 9);
            let v2 = 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::pack_record_v5(arg1, arg6);
            assert!(0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::pack_access_kind_v5(v2) == 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::pack_access_paid_once(), 8);
            assert!(0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::pack_active_v5(v2), 10);
        };
        let v3 = 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::style_product_asset_blob_id_v5(arg1, arg3, arg4, arg5);
        let v4 = derive_seal_id_v5(arg0.release_commitment, arg2, arg3, arg4, arg5, arg6, arg7);
        let v5 = StyleProductIdentityV5{
            product_kind : arg2,
            part_key     : arg3,
            item_key     : arg4,
            style_key    : arg5,
            pack_key     : arg6,
        };
        let v6 = 0x1::hash::sha2_256(0x1::bcs::to_bytes<StyleProductIdentityV5>(&v5));
        assert!(!0x2::table::contains<vector<u8>, PaidStyleAssetV5>(&arg0.registered_assets, v4), 11);
        assert!(!0x2::table::contains<vector<u8>, bool>(&arg0.registered_style_products, v6), 16);
        0x2::table::add<vector<u8>, bool>(&mut arg0.registered_style_products, v6, true);
        let v7 = PaidStyleAssetV5{
            seal_id            : v4,
            product_kind       : arg2,
            part_key           : arg3,
            item_key           : arg4,
            style_key          : arg5,
            pack_key           : arg6,
            ciphertext_blob_id : v3,
            asset_digest       : arg7,
        };
        0x2::table::add<vector<u8>, PaidStyleAssetV5>(&mut arg0.registered_assets, v4, v7);
        arg0.asset_count = arg0.asset_count + 1;
        let v8 = PaidStyleAssetRegisteredV5{
            policy_id          : 0x2::object::id<MakerSealPolicyV5>(arg0),
            root_id            : 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::root_id_v5(arg1),
            seal_id            : v4,
            product_kind       : arg2,
            part_key           : arg3,
            item_key           : arg4,
            style_key          : arg5,
            pack_key           : arg6,
            ciphertext_blob_id : v3,
            asset_digest       : arg7,
        };
        0x2::event::emit<PaidStyleAssetRegisteredV5>(v8);
    }

    entry fun seal_approve_complete_output_v5(arg0: vector<u8>, arg1: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerRootV5, arg2: &0x2::tx_context::TxContext) {
        assert!(check_complete_output_access_v5(arg0, arg1, 0x2::tx_context::sender(arg2)), 0);
    }

    entry fun seal_approve_paid_style_v5(arg0: vector<u8>, arg1: &MakerSealPolicyV5, arg2: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerRootV5, arg3: &0x2::tx_context::TxContext) {
        assert!(check_paid_style_access_v5(arg0, arg1, arg2, 0x2::tx_context::sender(arg3)), 0);
    }

    public fun seal_maker_seal_policy_v5(arg0: &mut MakerSealPolicyV5, arg1: &mut 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerRootV5, arg2: &0x2::tx_context::TxContext) {
        assert_policy_root(arg0, arg1);
        assert_root_owner(arg1, arg2);
        assert!(!arg0.sealed, 3);
        assert!(0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::style_registry_sealed_v5(arg1), 5);
        assert!(arg0.asset_count > 0, 12);
        arg0.sealed = true;
        0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::bind_seal_policy_v5(arg1, 0x2::object::id<MakerSealPolicyV5>(arg0), arg0.release_commitment, arg0.asset_count);
        let v0 = MakerSealPolicySealedV5{
            policy_id   : 0x2::object::id<MakerSealPolicyV5>(arg0),
            root_id     : 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::root_id_v5(arg1),
            asset_count : arg0.asset_count,
        };
        0x2::event::emit<MakerSealPolicySealedV5>(v0);
    }

    public fun share_maker_seal_policy_v5(arg0: MakerSealPolicyV5) {
        0x2::transfer::share_object<MakerSealPolicyV5>(arg0);
    }

    // decompiled from Move bytecode v7
}

