module 0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_action {
    fun compute_multiplier(arg0: &0xb908f3c6fea6865d32e2048c520cdfe3b5c5bbcebb658117c41bad70f52b7ccc::popkins_nft::Popkins) : u64 {
        let v0 = 0xb908f3c6fea6865d32e2048c520cdfe3b5c5bbcebb658117c41bad70f52b7ccc::popkins_nft::attributes(arg0);
        let v1 = 0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::attributes::get_ANCIENT_ATTRIBUTES();
        if (evaluate_attributes(&v1, &v0)) {
            return 0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::constant::get_ANCIENT_MULTIPLIER()
        };
        let v2 = 0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::attributes::get_RAT_ATTRIBUTES();
        if (evaluate_attributes(&v2, &v0)) {
            return 0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::constant::get_RAT_MULTIPLIER()
        };
        0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::constant::get_DEFAULT_MULTIPLIER()
    }

    fun evaluate_attributes(arg0: &vector<0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::attributes::Attribute>, arg1: &0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::attributes::Attribute>(arg0)) {
            let v1 = 0x1::vector::borrow<0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::attributes::Attribute>(arg0, v0);
            let v2 = 0x2::vec_map::try_get<0x1::string::String, 0x1::string::String>(arg1, 0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::attributes::get_key(v1));
            if (0x1::option::is_some<0x1::string::String>(&v2)) {
                if (*0x1::option::borrow<0x1::string::String>(&v2) == *0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::attributes::get_value(v1)) {
                    return true
                };
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun stake(arg0: &mut 0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_contract::StakingContract, arg1: &mut 0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_data::StakingData, arg2: &mut 0x2::transfer_policy::TransferPolicy<0xb908f3c6fea6865d32e2048c520cdfe3b5c5bbcebb658117c41bad70f52b7ccc::popkins_nft::Popkins>, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: 0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::lock::Lock, arg6: 0x2::object::ID, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_contract::is_correct_version(arg0);
        assert!(0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_data::valid_staking_data(arg1, 0x2::tx_context::sender(arg8)), 0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::constant::get_EIncorrectStakingData());
        let v0 = 0x2::clock::timestamp_ms(arg7);
        0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_data::update_points(arg1, v0);
        let v1 = 0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_contract::class_exists(arg0, arg6);
        let v2 = 0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::lock::get_locktime(v0, arg5);
        let (v3, v4) = 0x2::kiosk::purchase_with_cap<0xb908f3c6fea6865d32e2048c520cdfe3b5c5bbcebb658117c41bad70f52b7ccc::popkins_nft::Popkins>(arg3, 0x2::kiosk::list_with_purchase_cap<0xb908f3c6fea6865d32e2048c520cdfe3b5c5bbcebb658117c41bad70f52b7ccc::popkins_nft::Popkins>(arg3, arg4, arg6, 0, arg8), 0x2::coin::zero<0x2::sui::SUI>(arg8));
        let v5 = v4;
        let v6 = v3;
        if (!v1) {
            let v7 = compute_multiplier(&v6);
            0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_contract::insert_class(arg0, arg6, v7, v2);
            0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_data::increase_current_multiplier(arg1, v7);
        } else {
            0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_data::increase_current_multiplier(arg1, 0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_contract::get_class_multiplier(arg0, arg6));
            0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_contract::set_class_lock_time(arg0, arg6, v2);
        };
        if (!0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::lock::is_lock_none(arg5)) {
            0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_data::add_ephemeral_multiplier_to_staking_data(arg1, 0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::lock::get_lock_multiplier(arg5), 0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::lock::get_locktime(v0, arg5), true);
        };
        let (v8, v9) = 0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_contract::get_contract_kiosk_refs(arg0);
        0x2::kiosk::lock<0xb908f3c6fea6865d32e2048c520cdfe3b5c5bbcebb658117c41bad70f52b7ccc::popkins_nft::Popkins>(v8, v9, arg2, v6);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<0xb908f3c6fea6865d32e2048c520cdfe3b5c5bbcebb658117c41bad70f52b7ccc::popkins_nft::Popkins>(arg2, &mut v5, 0x2::coin::zero<0x2::sui::SUI>(arg8));
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<0xb908f3c6fea6865d32e2048c520cdfe3b5c5bbcebb658117c41bad70f52b7ccc::popkins_nft::Popkins>(&mut v5, v8);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<0xb908f3c6fea6865d32e2048c520cdfe3b5c5bbcebb658117c41bad70f52b7ccc::popkins_nft::Popkins>(arg2, v5);
        0x2::table::add<0x2::object::ID, bool>(0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_data::get_staked_nfts_ids_mut(arg1), arg6, true);
        0x2::table::add<0x2::object::ID, bool>(0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_contract::get_staking_contract_staked_nfts_ids_mut(arg0), arg6, true);
        let v13 = 0x2::object::id<0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_data::StakingData>(arg1);
        0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::events::emit_popkins_staked(arg6, v13, v2);
        0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::events::emit_staking_data_updated(v13, 0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_data::get_points(arg1), 0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_data::get_current_multiplier(arg1), 0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_data::get_ephemeral_multiplier(arg1));
        if (!v1) {
            0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::events::emit_staking_class_created(arg6, 0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_contract::get_class_multiplier(arg0, arg6), true, 0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_contract::get_class_lock_time(arg0, arg6));
        } else {
            0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::events::emit_staking_class_updated(arg6, 0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_contract::get_class_multiplier(arg0, arg6), true, 0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_contract::get_class_lock_time(arg0, arg6));
        };
    }

    public fun unstake(arg0: &mut 0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_contract::StakingContract, arg1: &mut 0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_data::StakingData, arg2: &mut 0x2::transfer_policy::TransferPolicy<0xb908f3c6fea6865d32e2048c520cdfe3b5c5bbcebb658117c41bad70f52b7ccc::popkins_nft::Popkins>, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: 0x2::object::ID, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_contract::is_correct_version(arg0);
        let v0 = 0x2::clock::timestamp_ms(arg6);
        assert!(v0 > 0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_contract::get_class_lock_time(arg0, arg5), 0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::constant::get_EAssetLocked());
        assert!(0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_data::valid_staking_data(arg1, 0x2::tx_context::sender(arg7)), 0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::constant::get_EIncorrectStakingData());
        assert!(0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_contract::class_exists(arg0, arg5), 0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::constant::get_EClassNotFound());
        assert!(0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_contract::is_in_staking_contract(arg0, arg5), 0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::constant::get_EAssetNotInStakingContract());
        assert!(0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_data::is_in_staking_data(arg1, arg5), 0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::constant::get_EAssetNotInStakingData());
        0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_data::update_points(arg1, v0);
        0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_data::decrease_current_multiplier(arg1, 0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_contract::get_class_multiplier(arg0, arg5));
        let (v1, v2) = 0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_contract::get_contract_kiosk_refs(arg0);
        let (v3, v4) = 0x2::kiosk::purchase_with_cap<0xb908f3c6fea6865d32e2048c520cdfe3b5c5bbcebb658117c41bad70f52b7ccc::popkins_nft::Popkins>(v1, 0x2::kiosk::list_with_purchase_cap<0xb908f3c6fea6865d32e2048c520cdfe3b5c5bbcebb658117c41bad70f52b7ccc::popkins_nft::Popkins>(v1, v2, arg5, 0, arg7), 0x2::coin::zero<0x2::sui::SUI>(arg7));
        let v5 = v4;
        0x2::kiosk::lock<0xb908f3c6fea6865d32e2048c520cdfe3b5c5bbcebb658117c41bad70f52b7ccc::popkins_nft::Popkins>(arg3, arg4, arg2, v3);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<0xb908f3c6fea6865d32e2048c520cdfe3b5c5bbcebb658117c41bad70f52b7ccc::popkins_nft::Popkins>(arg2, &mut v5, 0x2::coin::zero<0x2::sui::SUI>(arg7));
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<0xb908f3c6fea6865d32e2048c520cdfe3b5c5bbcebb658117c41bad70f52b7ccc::popkins_nft::Popkins>(&mut v5, arg3);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<0xb908f3c6fea6865d32e2048c520cdfe3b5c5bbcebb658117c41bad70f52b7ccc::popkins_nft::Popkins>(arg2, v5);
        0x2::table::remove<0x2::object::ID, bool>(0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_data::get_staked_nfts_ids_mut(arg1), arg5);
        0x2::table::remove<0x2::object::ID, bool>(0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_contract::get_staking_contract_staked_nfts_ids_mut(arg0), arg5);
        0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::events::emit_popkins_unstaked(arg5);
        0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::events::emit_staking_data_updated(0x2::object::id<0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_data::StakingData>(arg1), 0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_data::get_points(arg1), 0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_data::get_current_multiplier(arg1), 0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_data::get_ephemeral_multiplier(arg1));
        0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::events::emit_staking_class_updated(arg5, 0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_contract::get_class_multiplier(arg0, arg5), false, 0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_contract::get_class_lock_time(arg0, arg5));
    }

    // decompiled from Move bytecode v6
}

