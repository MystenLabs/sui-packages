module 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::animacraft_output_seal {
    public fun seal_approve_animacraft_complete_output_v5(arg0: vector<u8>, arg1: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerRootV5, arg2: &0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::animacraft_provenance::AnimacraftProvenance, arg3: &0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::animacraft_output_provenance_v5::AnimacraftOutputProvenanceV5, arg4: &0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::SoulState, arg5: &0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg0) == 32, 0);
        assert!(0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::animacraft_provenance::is_v5_commerce_compatible(arg2), 1);
        0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::animacraft_provenance::assert_matches_soul(arg2, arg4);
        0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::animacraft_output_provenance_v5::assert_matches_soul(arg3, arg4);
        0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::animacraft_output_provenance_v5::assert_matches_root(arg3, arg1);
        assert!(0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::current_owner(arg4) == 0x2::tx_context::sender(arg5), 0);
        assert!(0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::root_id_v5(arg1) == 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::animacraft_provenance::maker_id(arg2) && 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::root_treasury_id_v5(arg1) == 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::animacraft_provenance::maker_treasury_id(arg2), 2);
        assert!(0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::animacraft_output_provenance_v5::output_seal_id(arg3) == &arg0 && 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::complete_output_exists_v5(arg1, arg0), 3);
        let v0 = 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::complete_output_record_v5(arg1, arg0);
        let v1 = if (0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::complete_output_is_soul_bound_v5(v0)) {
            let v2 = 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::soul_id(arg4);
            0x1::option::contains<0x2::object::ID>(0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::complete_output_bound_soul_id_v5(v0), &v2)
        } else {
            false
        };
        assert!(v1, 4);
        let v3 = if (0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::complete_output_seal_id_v5(v0) == &arg0) {
            if (0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::complete_output_payer_v5(v0) == 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::animacraft_provenance::payer(arg2)) {
                if (0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::complete_output_recipe_hash_v5(v0) == 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::animacraft_provenance::recipe_hash(arg2)) {
                    if (0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::complete_output_ciphertext_blob_id_v5(v0) == 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::animacraft_provenance::image_blob_id(arg2)) {
                        !0x1::string::is_empty(0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::complete_output_ciphertext_blob_id_v5(v0))
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
        assert!(v3, 3);
        assert!(0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::derive_complete_output_seal_id_v5(0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::root_id_v5(arg1), 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::complete_output_payer_v5(v0), *0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::complete_output_recipe_hash_v5(v0), *0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::complete_output_nonce_v5(v0), *0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::complete_output_digest_v5(v0)) == arg0, 3);
    }

    // decompiled from Move bytecode v7
}

