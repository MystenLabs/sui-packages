module 0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::level {
    public(friend) fun add_battle_level_points(arg0: &mut 0x90e956aa82a5c1b444fcee46f32ba659db2d128aab581e893f9c727fb831f2d8::airdrop::VendettaAirdropNFT, arg1: &0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::authority::CapWrapper, arg2: &mut 0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::iplayer::Player, arg3: &0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::ilevel::LevelPointRegistry, arg4: 0x1::string::String, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: &0x2::random::Random, arg10: &mut 0x2::tx_context::TxContext) : u128 {
        let v0 = 0x2::random::new_generator(arg9, arg10);
        let v1 = 0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::ilevel::borrow_action_point_value(arg3, arg4);
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

    public(friend) fun add_blackmail_level_point(arg0: &mut 0x90e956aa82a5c1b444fcee46f32ba659db2d128aab581e893f9c727fb831f2d8::airdrop::VendettaAirdropNFT, arg1: &0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::authority::CapWrapper, arg2: &mut 0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::iplayer::Player, arg3: &0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::ilevel::LevelPointRegistry, arg4: u64) : u128 {
        let v0 = ((arg4 as u128) as u128) * 0x1::u128::pow(2, 64);
        add_level_points_to_player(arg0, arg1, arg2, arg3, v0);
        v0
    }

    public(friend) fun add_crack_safe_level_point(arg0: &mut 0x90e956aa82a5c1b444fcee46f32ba659db2d128aab581e893f9c727fb831f2d8::airdrop::VendettaAirdropNFT, arg1: &0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::authority::CapWrapper, arg2: &mut 0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::iplayer::Player, arg3: &0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::ilevel::LevelPointRegistry, arg4: u64) : u128 {
        let v0 = ((arg4 as u128) as u128) * 0x1::u128::pow(2, 64);
        add_level_points_to_player(arg0, arg1, arg2, arg3, v0);
        v0
    }

    public(friend) fun add_level_points_to_player(arg0: &mut 0x90e956aa82a5c1b444fcee46f32ba659db2d128aab581e893f9c727fb831f2d8::airdrop::VendettaAirdropNFT, arg1: &0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::authority::CapWrapper, arg2: &mut 0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::iplayer::Player, arg3: &0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::ilevel::LevelPointRegistry, arg4: u128) {
        let v0 = 0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::iplayer::borrow_mut_player_df<0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::ilevel::PlayerLevelPoint>(arg2, 0x1::string::utf8(b"level_point"));
        0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::ilevel::add_level_point(v0, arg4);
        let (v1, v2) = is_able_to_upgrade_level(arg3, 0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::ilevel::borrow_level(v0), 0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::ilevel::borrow_level_point(v0));
        if (v1 > 0) {
            0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::ilevel::increase_level_point(v0, v1);
            0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::ilevel::set_previous_level_point(v0);
            0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::ilevel::update_next_level_up_at_points(v0, v2);
            0x90e956aa82a5c1b444fcee46f32ba659db2d128aab581e893f9c727fb831f2d8::airdrop::update_user_game_stats(arg0, 0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::authority::borrow_game_cap(arg1), 0x1::string::utf8(b"level"));
        };
    }

    public(friend) fun add_mission_level_point(arg0: &mut 0x90e956aa82a5c1b444fcee46f32ba659db2d128aab581e893f9c727fb831f2d8::airdrop::VendettaAirdropNFT, arg1: &0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::authority::CapWrapper, arg2: &mut 0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::iplayer::Player, arg3: &0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::ilevel::LevelPointRegistry, arg4: u64) : u128 {
        let v0 = ((arg4 as u128) as u128) * 0x1::u128::pow(2, 64);
        add_level_points_to_player(arg0, arg1, arg2, arg3, v0);
        v0
    }

    fun is_able_to_upgrade_level(arg0: &0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::ilevel::LevelPointRegistry, arg1: u64, arg2: u128) : (u64, u128) {
        let v0 = 0;
        let v1 = 0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::ilevel::level_point_required(arg0, arg1);
        while (arg2 >= v1) {
            v0 = v0 + 1;
            let v2 = arg1 + 1;
            arg1 = v2;
            v1 = 0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::ilevel::level_point_required(arg0, v2);
        };
        (v0, v1)
    }

    // decompiled from Move bytecode v6
}

