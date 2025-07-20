module 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::level {
    public(friend) fun add_battle_level_points(arg0: &mut 0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::airdrop::VendettaAirdropNFT, arg1: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::CapWrapper, arg2: &mut 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::Player, arg3: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ilevel::LevelPointRegistry, arg4: 0x1::string::String, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: &0x2::random::Random, arg10: &mut 0x2::tx_context::TxContext) : u128 {
        let v0 = 0x2::random::new_generator(arg9, arg10);
        let v1 = 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ilevel::borrow_action_point_value(arg3, arg4);
        let v2 = 0x1::string::utf8(b"base_min");
        let v3 = 0x1::string::utf8(b"base_max");
        let v4 = 0x1::string::utf8(b"kill");
        let v5 = 0;
        let v6 = 0;
        if (arg7 == 1) {
            let v7 = 0x1::string::utf8(b"raid");
            let v8 = 0x1::string::utf8(b"capture");
            let v9 = 0x1::string::utf8(b"owned");
            let v10 = 0x1::string::utf8(b"free");
            if (arg6 == 1) {
                v5 = *0x2::vec_map::get<0x1::string::String, u64>(&v1, &v7);
            } else if (arg6 == 2) {
                v5 = *0x2::vec_map::get<0x1::string::String, u64>(&v1, &v8);
            } else if (arg6 == 3) {
                v5 = *0x2::vec_map::get<0x1::string::String, u64>(&v1, &v7) + *0x2::vec_map::get<0x1::string::String, u64>(&v1, &v8);
            };
            if (arg8 == 0) {
                v6 = *0x2::vec_map::get<0x1::string::String, u64>(&v1, &v9);
            } else if (arg8 == 1) {
                v6 = *0x2::vec_map::get<0x1::string::String, u64>(&v1, &v10);
            };
        };
        let v11 = (((0x2::random::generate_u64_in_range(&mut v0, *0x2::vec_map::get<0x1::string::String, u64>(&v1, &v2), *0x2::vec_map::get<0x1::string::String, u64>(&v1, &v3)) + arg5 * *0x2::vec_map::get<0x1::string::String, u64>(&v1, &v4) + v5 + v6) as u128) as u128) * 0x1::u128::pow(2, 64);
        add_level_points_to_player(arg0, arg1, arg2, arg3, v11);
        v11
    }

    public(friend) fun add_blackmail_level_point(arg0: &mut 0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::airdrop::VendettaAirdropNFT, arg1: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::CapWrapper, arg2: &mut 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::Player, arg3: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ilevel::LevelPointRegistry, arg4: u64) : u128 {
        let v0 = ((arg4 as u128) as u128) * 0x1::u128::pow(2, 64);
        add_level_points_to_player(arg0, arg1, arg2, arg3, v0);
        v0
    }

    public(friend) fun add_crack_safe_level_point(arg0: &mut 0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::airdrop::VendettaAirdropNFT, arg1: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::CapWrapper, arg2: &mut 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::Player, arg3: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ilevel::LevelPointRegistry, arg4: u64) : u128 {
        let v0 = ((arg4 as u128) as u128) * 0x1::u128::pow(2, 64);
        add_level_points_to_player(arg0, arg1, arg2, arg3, v0);
        v0
    }

    public(friend) fun add_level_points_to_player(arg0: &mut 0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::airdrop::VendettaAirdropNFT, arg1: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::CapWrapper, arg2: &mut 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::Player, arg3: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ilevel::LevelPointRegistry, arg4: u128) {
        let v0 = 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_mut_player_df<0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ilevel::PlayerLevelPoint>(arg2, 0x1::string::utf8(b"level_point"));
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ilevel::add_level_point(v0, arg4);
        let (v1, v2) = is_able_to_upgrade_level(arg3, v0);
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ilevel::update_next_level_up_at_points(v0, v2);
        if (v1 > 0) {
            0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ilevel::increase_level(v0, v1);
            0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ilevel::set_previous_level_point(v0);
            0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::airdrop::update_user_game_stats(arg0, 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::borrow_game_cap(arg1), 0x1::string::utf8(b"level"));
            0xe660c11d5cddf961e2f153e2e9c89517bdbb2dfa64b9d3aae711672aeb7f240d::game_events::emit_player_leveled_up_event(0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::borrow_event_cap(arg1), 0x2::object::id<0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::Player>(arg2), 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_player_dvd_id(arg2), 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_player_name(arg2), 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ilevel::borrow_level(v0), v1, 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ilevel::borrow_next_level_at(v0), 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ilevel::borrow_level_point(v0), 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ilevel::borrow_previous_level_point(v0));
        };
    }

    public(friend) fun add_mission_level_point(arg0: &mut 0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::airdrop::VendettaAirdropNFT, arg1: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::CapWrapper, arg2: &mut 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::Player, arg3: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ilevel::LevelPointRegistry, arg4: u64) : u128 {
        let v0 = ((arg4 as u128) as u128) * 0x1::u128::pow(2, 64);
        add_level_points_to_player(arg0, arg1, arg2, arg3, v0);
        v0
    }

    fun is_able_to_upgrade_level(arg0: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ilevel::LevelPointRegistry, arg1: &mut 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ilevel::PlayerLevelPoint) : (u64, u128) {
        let v0 = 0;
        let v1 = 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ilevel::borrow_level(arg1);
        let v2 = 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ilevel::level_point_required(arg0, v1);
        while (0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ilevel::borrow_level_point(arg1) >= v2) {
            v0 = v0 + 1;
            let v3 = v1 + 1;
            v1 = v3;
            v2 = 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ilevel::level_point_required(arg0, v3);
        };
        (v0, v2)
    }

    public(friend) fun validate_search_level(arg0: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ilevel::PlayerLevelPoint, arg1: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ilevel::PlayerLevelPoint, arg2: u64) {
        assert!(0x1::u64::diff(0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ilevel::borrow_level(arg0), 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ilevel::borrow_level(arg1)) <= arg2, 0);
    }

    // decompiled from Move bytecode v6
}

