module 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::accolades {
    fun borrow_reward_values(arg0: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iaccolades::AccoladeReward, arg1: 0x1::string::String) : vector<0x2::vec_map::VecMap<0x1::string::String, u64>> {
        *0x2::dynamic_field::borrow<0x1::string::String, vector<0x2::vec_map::VecMap<0x1::string::String, u64>>>(0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iaccolades::get_accolade_reward(arg0), arg1)
    }

    public(friend) fun claim_accolade_rewards(arg0: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::authority::CapWrapper, arg1: &mut 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::Player, arg2: &mut 0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::iturf::TurfInformation, arg3: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iperks::PerksMetadataHolder, arg4: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iaccolades::AccoladeThresholdMapRegistry, arg5: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iaccolades::AccoladeRewardRegistry, arg6: vector<0x1::string::String>, arg7: 0x1::string::String, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::check_key_exist_accolade(arg1, arg7), 2);
        let v0 = 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iaccolades::get_accolade_rewards_list(arg4, arg7);
        assert!(0x1::option::is_some<0x2::vec_map::VecMap<u128, u64>>(&v0), 3);
        let v1 = 0x1::option::borrow<0x2::vec_map::VecMap<u128, u64>>(&v0);
        let v2 = 0x2::vec_map::keys<u128, u64>(v1);
        let v3 = 0;
        while (v3 < 0x1::vector::length<u128>(&v2)) {
            let v4 = *0x1::vector::borrow<u128>(&v2, v3);
            if (0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::get_accolade_value(arg1, arg7) >= v4) {
                if (!0x2::vec_map::contains<0x1::string::String, vector<u128>>(0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::get_claimed_rewards(arg1), &arg7)) {
                    let v5 = 0x1::vector::empty<u128>();
                    0x1::vector::push_back<u128>(&mut v5, v4);
                    0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::insert_claimed_rewards(arg1, arg7, v5);
                    process_claim(arg0, arg1, arg5, arg2, arg3, arg6, *0x2::vec_map::get<u128, u64>(v1, 0x1::vector::borrow<u128>(&v2, v3)), arg8);
                } else {
                    let v6 = 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::get_claimed_rewards_value(arg1, arg7);
                    if (!0x1::vector::contains<u128>(&v6, &v4)) {
                        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::push_back_claimed_rewards(arg1, arg7, v4);
                        process_claim(arg0, arg1, arg5, arg2, arg3, arg6, *0x2::vec_map::get<u128, u64>(v1, 0x1::vector::borrow<u128>(&v2, v3)), arg8);
                    };
                };
            };
            v3 = v3 + 1;
        };
    }

    public(friend) fun create_reward_pack(arg0: &mut 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iaccolades::AccoladeRewardRegistry, arg1: u64, arg2: vector<0x1::string::String>, arg3: vector<vector<0x1::string::String>>, arg4: vector<vector<u64>>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<0x1::string::String>(&arg2) == 0x1::vector::length<vector<0x1::string::String>>(&arg3), 4);
        assert!(0x1::vector::length<vector<u64>>(&arg4) == 0x1::vector::length<vector<0x1::string::String>>(&arg3), 4);
        assert!(0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iaccolades::dynamic_object_fields_exists(arg0, arg1) == false, 0);
        let v0 = 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iaccolades::new_accolade_reward(arg5);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::string::String>(&arg2)) {
            let v2 = 0x1::vector::empty<0x2::vec_map::VecMap<0x1::string::String, u64>>();
            let v3 = 0;
            assert!(0x1::vector::length<0x1::string::String>(0x1::vector::borrow<vector<0x1::string::String>>(&arg3, v1)) == 0x1::vector::length<u64>(0x1::vector::borrow<vector<u64>>(&arg4, v1)), 4);
            while (v3 < 0x1::vector::length<0x1::string::String>(0x1::vector::borrow<vector<0x1::string::String>>(&arg3, v1))) {
                let v4 = 0x2::vec_map::empty<0x1::string::String, u64>();
                0x2::vec_map::insert<0x1::string::String, u64>(&mut v4, *0x1::vector::borrow<0x1::string::String>(0x1::vector::borrow<vector<0x1::string::String>>(&arg3, v1), v3), *0x1::vector::borrow<u64>(0x1::vector::borrow<vector<u64>>(&arg4, v1), v3));
                0x1::vector::push_back<0x2::vec_map::VecMap<0x1::string::String, u64>>(&mut v2, v4);
                v3 = v3 + 1;
            };
            0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iaccolades::add_df_to_reward_registry(&mut v0, *0x1::vector::borrow<0x1::string::String>(&arg2, v1), v2);
            v1 = v1 + 1;
        };
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iaccolades::add_dof_to_reward_registry(arg0, arg1, v0);
    }

    public(friend) fun delete_reward_pack(arg0: &mut 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iaccolades::AccoladeRewardRegistry, arg1: u64) {
        assert!(0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iaccolades::dynamic_object_fields_exists(arg0, arg1) == true, 1);
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iaccolades::delete_accolade_reward(arg0, arg1);
    }

    public(friend) fun map_threshold_to_reward(arg0: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iaccolades::AccoladeRewardRegistry, arg1: &mut 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iaccolades::AccoladeThresholdMapRegistry, arg2: 0x1::string::String, arg3: u128, arg4: u64) {
        assert!(0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iaccolades::dynamic_object_fields_exists(arg0, arg4) == true, 1);
        let v0 = if (arg2 == 0x1::string::utf8(b"cash_king")) {
            (arg3 as u128) * 0x1::u128::pow(2, 64)
        } else {
            arg3
        };
        let v1 = v0;
        let (_, v3) = 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iaccolades::get_accolade_threshold_rewards(arg1);
        if (!0x2::vec_map::contains<0x1::string::String, 0x2::vec_map::VecMap<u128, u64>>(v3, &arg2)) {
            let v4 = 0x2::vec_map::empty<u128, u64>();
            0x2::vec_map::insert<u128, u64>(&mut v4, v1, arg4);
            0x2::vec_map::insert<0x1::string::String, 0x2::vec_map::VecMap<u128, u64>>(v3, arg2, v4);
        } else {
            let v5 = 0x2::vec_map::get_mut<0x1::string::String, 0x2::vec_map::VecMap<u128, u64>>(v3, &arg2);
            if (0x2::vec_map::contains<u128, u64>(v5, &v1)) {
                let (_, _) = 0x2::vec_map::remove<u128, u64>(v5, &v1);
            };
            0x2::vec_map::insert<u128, u64>(v5, v1, arg4);
        };
    }

    fun process_claim(arg0: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::authority::CapWrapper, arg1: &mut 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::Player, arg2: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iaccolades::AccoladeRewardRegistry, arg3: &mut 0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::iturf::TurfInformation, arg4: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iperks::PerksMetadataHolder, arg5: vector<0x1::string::String>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iaccolades::dynamic_object_fields_exists(arg2, arg6) == true, 1);
        let v0 = 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iaccolades::get_dof_accolade_reward(arg2, arg6);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::string::String>(&arg5)) {
            let v2 = 0;
            let v3 = borrow_reward_values(v0, *0x1::vector::borrow<0x1::string::String>(&arg5, v1));
            if (0x1::vector::length<0x2::vec_map::VecMap<0x1::string::String, u64>>(&v3) > 0 && *0x1::vector::borrow<0x1::string::String>(&arg5, v1) == 0x1::string::utf8(b"gangsters")) {
                while (v2 < 0x1::vector::length<0x2::vec_map::VecMap<0x1::string::String, u64>>(&v3)) {
                    let v4 = 0x2::vec_map::keys<0x1::string::String, u64>(0x1::vector::borrow<0x2::vec_map::VecMap<0x1::string::String, u64>>(&v3, v2));
                    let v5 = *0x1::vector::borrow<0x1::string::String>(&v4, 0);
                    let v6 = *0x2::vec_map::get<0x1::string::String, u64>(0x1::vector::borrow<0x2::vec_map::VecMap<0x1::string::String, u64>>(&v3, v2), &v5);
                    0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::turf::update_hq_gangster(0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::authority::borrow_map_cap(arg0), arg3, v5, v6);
                    0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::add_gangster_in_summary(arg1, v5, v6);
                    v2 = v2 + 1;
                };
            };
            if (0x1::vector::length<0x2::vec_map::VecMap<0x1::string::String, u64>>(&v3) > 0 && *0x1::vector::borrow<0x1::string::String>(&arg5, v1) == 0x1::string::utf8(b"perks")) {
                let v7 = 0;
                while (v2 < 0x1::vector::length<0x2::vec_map::VecMap<0x1::string::String, u64>>(&v3)) {
                    let v8 = 0x2::vec_map::keys<0x1::string::String, u64>(0x1::vector::borrow<0x2::vec_map::VecMap<0x1::string::String, u64>>(&v3, v2));
                    let v9 = *0x1::vector::borrow<0x1::string::String>(&v8, 0);
                    while (v7 < *0x2::vec_map::get<0x1::string::String, u64>(0x1::vector::borrow<0x2::vec_map::VecMap<0x1::string::String, u64>>(&v3, v2), &v9)) {
                        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iperks::transfer_perk(0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iperks::new(arg4, v9, arg7), arg7);
                        v7 = v7 + 1;
                    };
                    v2 = v2 + 1;
                };
            };
            if (0x1::vector::length<0x2::vec_map::VecMap<0x1::string::String, u64>>(&v3) > 0 && *0x1::vector::borrow<0x1::string::String>(&arg5, v1) == 0x1::string::utf8(b"game_resources")) {
                while (v2 < 0x1::vector::length<0x2::vec_map::VecMap<0x1::string::String, u64>>(&v3)) {
                    let v10 = 0x2::vec_map::keys<0x1::string::String, u64>(0x1::vector::borrow<0x2::vec_map::VecMap<0x1::string::String, u64>>(&v3, v2));
                    let v11 = *0x1::vector::borrow<0x1::string::String>(&v10, 0);
                    0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibuildings::add_resource_amount(0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_mut_player_df<0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibuildings::Resources>(arg1, v11), (*0x2::vec_map::get<0x1::string::String, u64>(0x1::vector::borrow<0x2::vec_map::VecMap<0x1::string::String, u64>>(&v3, v2), &v11) as u128) * 0x1::u128::pow(2, 64));
                    v2 = v2 + 1;
                };
            };
            v1 = v1 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

