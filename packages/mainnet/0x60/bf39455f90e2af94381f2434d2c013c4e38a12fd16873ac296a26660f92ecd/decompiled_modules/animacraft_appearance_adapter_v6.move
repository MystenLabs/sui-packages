module 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::animacraft_appearance_adapter_v6 {
    public fun claim_free_soul_item_v6(arg0: &mut 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::CompositionRegistryV6, arg1: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::CompositionProtocolConfigV6, arg2: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::MakerProfileV6, arg3: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::ItemProductV6, arg4: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerRootV5, arg5: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::CommerceProtocolConfigV5, arg6: &0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::SoulState, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) {
        assert_profile_root(arg2, arg4);
        0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::claim_free_soul_item_v6<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::animacraft_soul_owner_proof_v6::AnimacraftSoulOwnerProofV6>(arg0, arg1, arg2, arg3, arg4, arg5, 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::soul_id(arg6), 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::animacraft_soul_owner_proof_v6::new(arg6, arg8), arg7, arg8);
    }

    public fun lock_owned_item_to_soul_v6(arg0: &mut 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::CompositionRegistryV6, arg1: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::CompositionProtocolConfigV6, arg2: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::MakerProfileV6, arg3: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerRootV5, arg4: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::CommerceProtocolConfigV5, arg5: &mut 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::OwnedItemV6, arg6: &0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::SoulState, arg7: &0x2::tx_context::TxContext) {
        assert_profile_root(arg2, arg3);
        0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::lock_owned_item_to_soul_v6<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::animacraft_soul_owner_proof_v6::AnimacraftSoulOwnerProofV6>(arg0, arg1, arg2, arg3, arg4, arg5, 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::soul_id(arg6), 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::animacraft_soul_owner_proof_v6::new(arg6, arg7), arg7);
    }

    public fun purchase_soul_item_v6<T0>(arg0: &mut 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::CompositionRegistryV6, arg1: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::CompositionProtocolConfigV6, arg2: &mut 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::CompositionProtocolTreasuryV6<T0>, arg3: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::MakerProfileV6, arg4: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::ItemProductV6, arg5: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerRootV5, arg6: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::CommerceProtocolConfigV5, arg7: &0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::SoulState, arg8: 0x2::coin::Coin<T0>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert_profile_root(arg3, arg5);
        0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::purchase_soul_item_v6<T0, 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::animacraft_soul_owner_proof_v6::AnimacraftSoulOwnerProofV6>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::soul_id(arg7), 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::animacraft_soul_owner_proof_v6::new(arg7, arg10), arg8, arg9, arg10);
    }

    public fun unlock_owned_item_from_soul_v6(arg0: &mut 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::CompositionRegistryV6, arg1: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::CompositionProtocolConfigV6, arg2: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::MakerProfileV6, arg3: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerRootV5, arg4: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::CommerceProtocolConfigV5, arg5: &mut 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::OwnedItemV6, arg6: &0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::SoulState, arg7: &0x2::tx_context::TxContext) {
        assert_profile_root(arg2, arg3);
        0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::unlock_owned_item_from_soul_v6<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::animacraft_soul_owner_proof_v6::AnimacraftSoulOwnerProofV6>(arg0, arg1, arg2, arg3, arg4, arg5, 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::soul_id(arg6), 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::animacraft_soul_owner_proof_v6::new(arg6, arg7), arg7);
    }

    public fun apply_authorized_appearance_update_v6(arg0: &0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::SoulState, arg1: &mut 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::appearance_v6::SoulAppearanceStateV6, arg2: u64, arg3: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::MakerProfileV6, arg4: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerRootV5, arg5: 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::LoadoutAuthorizationV6) {
        assert_profile_root(arg3, arg4);
        assert_profile_matches_appearance(arg3, arg4, arg1);
        let (v0, v1, v2, v3, v4, v5, v6, v7, v8, v9) = 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::consume_loadout_authorization_v6(arg5);
        0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::appearance_v6::apply_authorized_loadout(arg0, arg1, arg2, validate_authorization(arg0, arg3, arg4, v0, v1, v2, v3, v4, v5, v6, v7, v8, v9));
    }

    fun assert_profile_matches_appearance(arg0: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::MakerProfileV6, arg1: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerRootV5, arg2: &0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::appearance_v6::SoulAppearanceStateV6) {
        assert!(0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::appearance_v6::profile_id(arg2) == 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::profile_id_v6(arg0), 4);
        assert!(0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::appearance_v6::maker_root_id(arg2) == 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::root_id_v5(arg1), 1);
        assert!(0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::appearance_v6::extensions_hash(arg2) == 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::profile_extensions_hash_v6(arg0), 6);
    }

    fun assert_profile_root(arg0: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::MakerProfileV6, arg1: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerRootV5) {
        assert!(0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::profile_root_id_v6(arg0) == 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::root_id_v5(arg1), 1);
    }

    public fun assert_secondary_market_appearance_v6(arg0: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::CompositionRegistryV6, arg1: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::CompositionProtocolConfigV6, arg2: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::MakerProfileV6, arg3: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerRootV5, arg4: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::CommerceProtocolConfigV5, arg5: &0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::SoulState, arg6: &0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::appearance_v6::SoulAppearanceStateV6, arg7: &vector<0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::LoadoutSelectionV6>) {
        0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::appearance_v6::assert_matches_soul(arg6, arg5);
        assert_profile_root(arg2, arg3);
        assert_profile_matches_appearance(arg2, arg3, arg6);
        0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::assert_secondary_market_loadout_v6(arg0, arg1, arg2, arg3, arg4, 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::soul_id(arg5), 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::appearance_v6::current_loadout_hash(arg6), arg7);
    }

    public fun authorize_appearance_update_v6(arg0: &mut 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::CompositionRegistryV6, arg1: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::CompositionProtocolConfigV6, arg2: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::MakerProfileV6, arg3: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerRootV5, arg4: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::CommerceProtocolConfigV5, arg5: &0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::SoulState, arg6: &0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::appearance_v6::SoulAppearanceStateV6, arg7: u64, arg8: vector<u8>, arg9: vector<u8>, arg10: vector<0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::LoadoutSelectionV6>, arg11: &0x2::tx_context::TxContext) : 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::LoadoutAuthorizationV6 {
        0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::appearance_v6::assert_can_authorize_update(arg5, arg6, arg7);
        assert_profile_root(arg2, arg3);
        assert_profile_matches_appearance(arg2, arg3, arg6);
        0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::authorize_loadout_v6<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::animacraft_soul_owner_proof_v6::AnimacraftSoulOwnerProofV6>(arg0, arg1, arg2, arg3, arg4, 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::soul_id(arg5), arg8, arg9, arg10, 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::animacraft_soul_owner_proof_v6::new(arg5, arg11), arg11)
    }

    public fun authorize_initial_appearance_v6(arg0: &mut 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::CompositionRegistryV6, arg1: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::CompositionProtocolConfigV6, arg2: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::MakerProfileV6, arg3: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerRootV5, arg4: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::CommerceProtocolConfigV5, arg5: &0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::SoulState, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::LoadoutSelectionV6>, arg9: &0x2::tx_context::TxContext) : 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::InitialLoadoutAuthorizationV6 {
        assert!(!0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::has_animacraft_appearance_v6(arg5), 0);
        assert_profile_root(arg2, arg3);
        0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::authorize_initial_loadout_v6<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::animacraft_soul_owner_proof_v6::AnimacraftSoulOwnerProofV6>(arg0, arg1, arg2, arg3, arg4, 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::soul_id(arg5), arg6, arg7, arg8, 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::animacraft_soul_owner_proof_v6::new(arg5, arg9), arg9)
    }

    public fun bind_initial_appearance_v6(arg0: &mut 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::SoulState, arg1: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::MakerProfileV6, arg2: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerRootV5, arg3: 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::InitialLoadoutAuthorizationV6, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::has_animacraft_appearance_v6(arg0), 0);
        assert_profile_root(arg1, arg2);
        let (v0, v1, v2, v3, v4, v5, v6, v7, v8, v9) = 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::consume_initial_loadout_authorization_v6(arg3);
        0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::appearance_v6::new_bind_and_publish(arg0, 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::profile_mode_v6(arg1), 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::profile_loadout_mutable_v6(arg1), validate_authorization(arg0, arg1, arg2, v0, v1, v2, v3, v4, v5, v6, v7, v8, v9), arg4);
    }

    fun transfer_safe_from_selections(arg0: &vector<0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::LoadoutSelectionV6>, arg1: u64) : bool {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::LoadoutSelectionV6>(arg0)) {
            let v2 = 0x1::vector::borrow<0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::LoadoutSelectionV6>(arg0, v1);
            let v3 = 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::loadout_selection_subject_kind_v6(v2);
            if (v3 == 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::subject_wallet_v6()) {
                v0 = v0 + 1;
            } else {
                assert!(v3 == 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::subject_soul_v6() || v3 == 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::subject_embedded_v6(), 9);
            };
            let v4 = 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::loadout_selection_owned_instance_id_v6(v2);
            if (0x1::option::is_some<0x2::object::ID>(&v4)) {
                assert!(v3 == 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::subject_wallet_v6(), 10);
            };
            v1 = v1 + 1;
        };
        assert!(v0 == arg1, 8);
        v0 == 0
    }

    fun validate_authorization(arg0: &0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::SoulState, arg1: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::MakerProfileV6, arg2: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerRootV5, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: 0x2::object::ID, arg6: address, arg7: vector<u8>, arg8: vector<u8>, arg9: vector<u8>, arg10: vector<0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::LoadoutSelectionV6>, arg11: u64, arg12: u64) : 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::appearance_v6::AppearanceCommitmentV6 {
        assert!(arg5 == 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::soul_id(arg0), 2);
        assert!(arg6 == 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::current_owner(arg0), 3);
        assert!(arg3 == 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::profile_id_v6(arg1), 4);
        assert!(arg4 == 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::root_id_v5(arg2), 1);
        assert!(arg9 == *0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::profile_slot_schema_commitment_v6(arg1), 5);
        assert!(arg12 == 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::composition_protocol_version_v6(), 7);
        0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::appearance_v6::new_commitment(arg4, arg3, arg6, arg7, arg8, arg9, *0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::profile_extensions_hash_v6(arg1), transfer_safe_from_selections(&arg10, arg11))
    }

    // decompiled from Move bytecode v7
}

