module 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::accolades {
    fun borrow_reward_values(arg0: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iaccolades::AccoladeReward, arg1: 0x1::string::String) : vector<0x2::vec_map::VecMap<0x1::string::String, u64>> {
        *0x2::dynamic_field::borrow<0x1::string::String, vector<0x2::vec_map::VecMap<0x1::string::String, u64>>>(0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iaccolades::get_accolade_reward(arg0), arg1)
    }

    public(friend) fun claim_accolade_rewards(arg0: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::CapWrapper, arg1: &mut 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::Player, arg2: &0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::map_version::Version, arg3: &mut 0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::TurfInformation, arg4: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iperks::PerksMetadataHolder, arg5: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iaccolades::AccoladeThresholdMapRegistry, arg6: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iaccolades::AccoladeRewardRegistry, arg7: vector<0x1::string::String>, arg8: 0x1::string::String, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::check_key_exist_accolade(arg1, arg8), 2);
        let v0 = 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iaccolades::get_accolade_rewards_list(arg5, arg8);
        assert!(0x1::option::is_some<0x2::vec_map::VecMap<u128, u64>>(&v0), 3);
        let v1 = 0x1::option::borrow<0x2::vec_map::VecMap<u128, u64>>(&v0);
        let v2 = 0x2::vec_map::keys<u128, u64>(v1);
        let v3 = 0;
        while (v3 < 0x1::vector::length<u128>(&v2)) {
            let v4 = *0x1::vector::borrow<u128>(&v2, v3);
            if (0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::get_accolade_value(arg1, arg8) >= v4) {
                if (!0x2::vec_map::contains<0x1::string::String, vector<u128>>(0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::get_claimed_rewards(arg1), &arg8)) {
                    let v5 = 0x1::vector::empty<u128>();
                    0x1::vector::push_back<u128>(&mut v5, v4);
                    0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::insert_claimed_rewards(arg1, arg8, v5);
                    process_claim(arg0, arg1, arg2, arg6, arg3, arg4, arg7, *0x2::vec_map::get<u128, u64>(v1, 0x1::vector::borrow<u128>(&v2, v3)), arg9);
                } else {
                    let v6 = 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::get_claimed_rewards_value(arg1, arg8);
                    if (!0x1::vector::contains<u128>(&v6, &v4)) {
                        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::push_back_claimed_rewards(arg1, arg8, v4);
                        process_claim(arg0, arg1, arg2, arg6, arg3, arg4, arg7, *0x2::vec_map::get<u128, u64>(v1, 0x1::vector::borrow<u128>(&v2, v3)), arg9);
                    };
                };
            };
            v3 = v3 + 1;
        };
    }

    public(friend) fun delete_reward_pack(arg0: &mut 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iaccolades::AccoladeRewardRegistry, arg1: u64) {
        assert!(0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iaccolades::dynamic_object_fields_exists(arg0, arg1) == true, 1);
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iaccolades::delete_accolade_reward(arg0, arg1);
    }

    fun process_claim(arg0: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::CapWrapper, arg1: &mut 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::Player, arg2: &0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::map_version::Version, arg3: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iaccolades::AccoladeRewardRegistry, arg4: &mut 0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::TurfInformation, arg5: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iperks::PerksMetadataHolder, arg6: vector<0x1::string::String>, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iaccolades::dynamic_object_fields_exists(arg3, arg7) == true, 1);
        let v0 = 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iaccolades::get_dof_accolade_reward(arg3, arg7);
        let v1 = 0x2::vec_map::empty<0x1::string::String, u64>();
        let v2 = 0x2::vec_map::empty<0x1::string::String, u64>();
        let v3 = 0x2::vec_map::empty<0x1::string::String, u64>();
        let v4 = 0;
        while (v4 < 0x1::vector::length<0x1::string::String>(&arg6)) {
            let v5 = 0;
            let v6 = borrow_reward_values(v0, *0x1::vector::borrow<0x1::string::String>(&arg6, v4));
            if (0x1::vector::length<0x2::vec_map::VecMap<0x1::string::String, u64>>(&v6) > 0 && *0x1::vector::borrow<0x1::string::String>(&arg6, v4) == 0x1::string::utf8(b"gangsters")) {
                while (v5 < 0x1::vector::length<0x2::vec_map::VecMap<0x1::string::String, u64>>(&v6)) {
                    let v7 = 0x2::vec_map::keys<0x1::string::String, u64>(0x1::vector::borrow<0x2::vec_map::VecMap<0x1::string::String, u64>>(&v6, v5));
                    let v8 = *0x1::vector::borrow<0x1::string::String>(&v7, 0);
                    let v9 = *0x2::vec_map::get<0x1::string::String, u64>(0x1::vector::borrow<0x2::vec_map::VecMap<0x1::string::String, u64>>(&v6, v5), &v8);
                    0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::turf::update_hq_gangster(0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::borrow_map_cap(arg0), arg2, arg4, v8, v9);
                    0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::add_gangster_in_summary(arg1, v8, v9);
                    let v10 = if (0x2::vec_map::contains<0x1::string::String, u64>(&v1, &v8)) {
                        *0x2::vec_map::get<0x1::string::String, u64>(&v1, &v8)
                    } else {
                        0
                    };
                    0x2::vec_map::insert<0x1::string::String, u64>(&mut v1, v8, v10 + v9);
                    v5 = v5 + 1;
                };
            };
            if (0x1::vector::length<0x2::vec_map::VecMap<0x1::string::String, u64>>(&v6) > 0 && *0x1::vector::borrow<0x1::string::String>(&arg6, v4) == 0x1::string::utf8(b"perks")) {
                while (v5 < 0x1::vector::length<0x2::vec_map::VecMap<0x1::string::String, u64>>(&v6)) {
                    let v11 = 0x2::vec_map::keys<0x1::string::String, u64>(0x1::vector::borrow<0x2::vec_map::VecMap<0x1::string::String, u64>>(&v6, v5));
                    let v12 = *0x1::vector::borrow<0x1::string::String>(&v11, 0);
                    let v13 = *0x2::vec_map::get<0x1::string::String, u64>(0x1::vector::borrow<0x2::vec_map::VecMap<0x1::string::String, u64>>(&v6, v5), &v12);
                    let v14 = 0;
                    while (v14 < v13) {
                        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iperks::transfer_perk(0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iperks::new(arg5, v12, 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_player_dvd_id(arg1), arg8), arg8);
                        v14 = v14 + 1;
                    };
                    let v15 = if (0x2::vec_map::contains<0x1::string::String, u64>(&v2, &v12)) {
                        *0x2::vec_map::get<0x1::string::String, u64>(&v2, &v12)
                    } else {
                        0
                    };
                    0x2::vec_map::insert<0x1::string::String, u64>(&mut v2, v12, v15 + v13);
                    v5 = v5 + 1;
                };
            };
            if (0x1::vector::length<0x2::vec_map::VecMap<0x1::string::String, u64>>(&v6) > 0 && *0x1::vector::borrow<0x1::string::String>(&arg6, v4) == 0x1::string::utf8(b"game_resources")) {
                while (v5 < 0x1::vector::length<0x2::vec_map::VecMap<0x1::string::String, u64>>(&v6)) {
                    let v16 = 0x2::vec_map::keys<0x1::string::String, u64>(0x1::vector::borrow<0x2::vec_map::VecMap<0x1::string::String, u64>>(&v6, v5));
                    let v17 = *0x1::vector::borrow<0x1::string::String>(&v16, 0);
                    let v18 = *0x2::vec_map::get<0x1::string::String, u64>(0x1::vector::borrow<0x2::vec_map::VecMap<0x1::string::String, u64>>(&v6, v5), &v17);
                    0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibuildings::add_resource_amount(0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_mut_player_df<0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibuildings::Resources>(arg1, v17), (v18 as u128) * 0x1::u128::pow(2, 64));
                    let v19 = if (0x2::vec_map::contains<0x1::string::String, u64>(&v3, &v17)) {
                        *0x2::vec_map::get<0x1::string::String, u64>(&v3, &v17)
                    } else {
                        0
                    };
                    0x2::vec_map::insert<0x1::string::String, u64>(&mut v3, v17, v19 + v18);
                    v5 = v5 + 1;
                };
            };
            v4 = v4 + 1;
        };
        0xe660c11d5cddf961e2f153e2e9c89517bdbb2dfa64b9d3aae711672aeb7f240d::game_events::emit_reward_claim_event(0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::borrow_event_cap(arg0), v1, v2, v3);
    }

    // decompiled from Move bytecode v6
}

