module 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::battle {
    public fun borrow_current_attack_count(arg0: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibattle::PlayerBattleStats, arg1: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::isystem::SystemConfig, arg2: &0x2::clock::Clock) : (u64, u64, u64) {
        let v0 = 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibattle::borrow_player_battle_stats(arg0);
        let v1 = *0x1::vector::borrow<u64>(&v0, 0);
        let (_, _, v4, _, _, _, _, _, _, _, _) = 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::isystem::borrow_system_config(arg1);
        let v13 = 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibattle::borrow_player_battle_stats(arg0);
        let v14 = *0x1::vector::borrow<u64>(&v13, 1);
        let v15 = (0x2::clock::timestamp_ms(arg2) - v14) / v4;
        let v16 = if (v15 > v1) {
            0
        } else {
            v1 - v15
        };
        (v16, v15 * v4, v14 + v15 * v4 + v4)
    }

    fun calculate_damage(arg0: u128, arg1: u128, arg2: &0x2::random::Random, arg3: &mut 0x2::tx_context::TxContext) : 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibattle::Damage {
        let v0 = 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::utils::roll_dice(6, arg2, arg3);
        let v1 = if (v0 >= 5) {
            arg1 * 2
        } else if (v0 == 1) {
            arg1 / 2
        } else {
            arg1
        };
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibattle::new_damage(v1 * arg0 / 1 * 0x1::u128::pow(2, 64), v0)
    }

    public(friend) fun generate_defender_gangsters(arg0: &0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::TurfInformation, arg1: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::igangsters::GangsterBaseStats, arg2: vector<0x1::string::String>, arg3: &0x2::random::Random, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (vector<0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibattle::GangsterUnitBattleStats>, u128, vector<0x1::string::String>) {
        let v0 = 10;
        let v1 = 0;
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = 0x1::vector::empty<0x1::string::String>();
        while (0x1::vector::length<0x1::string::String>(&arg2) > v1) {
            let v4 = 0x1::vector::borrow<0x1::string::String>(&arg2, v1);
            let v5 = 0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::borrow_unit_value(arg0, v4);
            v1 = v1 + 1;
            while (v5 > 0) {
                0x1::vector::push_back<0x1::string::String>(&mut v3, *v4);
                v5 = v5 - 1;
            };
        };
        let v6 = 0x2::random::new_generator(arg3, arg5);
        0x2::random::shuffle<0x1::string::String>(&mut v6, &mut v3);
        let v7 = 0;
        while (0x1::vector::length<0x1::string::String>(&v3) > 0 && 0x1::vector::length<0x1::string::String>(&v2) < v0) {
            if (0x1::vector::length<0x1::string::String>(&v2) == v0) {
                break
            };
            0x1::vector::push_back<0x1::string::String>(&mut v2, 0x1::vector::remove<0x1::string::String>(&mut v3, 0));
            v7 = v7 + 1;
        };
        0x1::vector::reverse<0x1::string::String>(&mut v2);
        let (v8, v9) = generate_gangster_units(v2, arg1, 44444, arg4);
        (v8, v9, v2)
    }

    public(friend) fun generate_gangster_units(arg0: vector<0x1::string::String>, arg1: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::igangsters::GangsterBaseStats, arg2: u64, arg3: &0x2::clock::Clock) : (vector<0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibattle::GangsterUnitBattleStats>, u128) {
        let v0 = 0x1::vector::empty<0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibattle::GangsterUnitBattleStats>();
        let v1 = 0x1::vector::length<0x1::string::String>(&arg0);
        let v2 = 0;
        while (v1 > 0) {
            let v3 = *0x1::vector::borrow<0x1::string::String>(&arg0, v1 - 1);
            let (v4, v5) = 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::igangsters::borrow_gangster_battle_stats(0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::igangsters::borrow_gangster_df<0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::igangsters::GangsterStats>(arg1, v3));
            v2 = v2 + v5;
            0x1::vector::push_back<0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibattle::GangsterUnitBattleStats>(&mut v0, 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibattle::new_gangster_unit_battle_stats(v3, v5, v5, v4, v1 + arg2, arg3));
            v1 = v1 - 1;
        };
        (v0, v2)
    }

    public(friend) fun process_battle_result(arg0: &mut 0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::airdrop::VendettaAirdropNFT, arg1: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::CapWrapper, arg2: &mut 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::Player, arg3: &mut 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::Player, arg4: &0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::map_version::Version, arg5: &mut 0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::TurfInformation, arg6: &mut 0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::TurfInformation, arg7: &0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::TurfSystem, arg8: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::isystem::SystemConfig, arg9: &mut 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibattle::PlayerBattleStats, arg10: &mut 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibattle::PlayerBattleStats, arg11: vector<0x1::string::String>, arg12: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::igangsters::GangsterBaseStats, arg13: u8, arg14: u8, arg15: vector<0x1::string::String>, arg16: vector<0x1::string::String>, arg17: vector<0x1::string::String>, arg18: vector<0x1::string::String>, arg19: u128, arg20: u128, arg21: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibuildings::BuildingRegistry, arg22: bool, arg23: &0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::MapRegistry, arg24: &0x2::random::Random, arg25: &0x2::clock::Clock, arg26: &mut 0x2::tx_context::TxContext) : (u128, u128, u128) {
        let v0 = 0;
        let v1 = v0;
        let v2 = 0;
        let v3 = v2;
        0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::turf::remove_warrior_gangster(0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::borrow_map_cap(arg1), arg4, arg6, arg16);
        0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::turf::remove_warrior_gangster(0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::borrow_map_cap(arg1), arg4, arg5, arg11);
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::players::remove_warrior_gangsters(arg2, arg15);
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::players::remove_warrior_gangsters(arg3, arg16);
        let v4 = 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_player_headquarter(arg3) == 0x2::object::id<0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::TurfInformation>(arg6);
        let v5 = if (arg13 == 1 && (arg14 == 1 || arg14 == 3)) {
            0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::players::calculate_loot_xp(arg13, arg2, arg19, arg3, arg20)
        } else {
            0
        };
        if (arg13 == 1) {
            if (arg14 == 1) {
                let (v6, v7) = process_raid(arg1, arg2, arg3, arg8, arg24, arg25, v4, arg22, arg23, arg26);
                0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::add_alive_units(0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::borrow_map_cap(arg1), arg4, arg5, arg17, 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::igangsters::borrow_unit_types(arg12));
                v1 = v6;
                v3 = v7;
                if (arg22) {
                    0xe660c11d5cddf961e2f153e2e9c89517bdbb2dfa64b9d3aae711672aeb7f240d::game_events::emit_raid_search_event(0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::borrow_event_cap(arg1), 0x2::object::id<0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::Player>(arg2), 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_player_dvd_id(arg2), 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_player_name(arg2), 0x2::object::id<0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::Player>(arg3), 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_player_dvd_id(arg3), 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_player_name(arg3), 0x2::object::id<0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::TurfInformation>(arg6), v6, v7, v5);
                };
            } else if (arg14 == 2) {
                process_capture(arg1, arg2, arg3, arg4, arg6, arg7, arg8, arg9, arg10, arg12, arg17, arg23, v0, v2, v5, arg25);
                0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::increase_turf_cooldown(0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::borrow_map_cap(arg1), arg4, arg6, arg7, arg25);
                0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::airdrop::update_user_game_stats(arg0, 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::borrow_game_cap(arg1), 0x1::string::utf8(b"turf"));
            } else if (arg14 == 3) {
                let (v8, v9) = process_raid(arg1, arg2, arg3, arg8, arg24, arg25, v4, arg22, arg23, arg26);
                v1 = v8;
                v3 = v9;
                process_capture(arg1, arg2, arg3, arg4, arg6, arg7, arg8, arg9, arg10, arg12, arg17, arg23, v8, v9, v5, arg25);
                0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::increase_turf_cooldown(0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::borrow_map_cap(arg1), arg4, arg6, arg7, arg25);
                0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::airdrop::update_user_game_stats(arg0, 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::borrow_game_cap(arg1), 0x1::string::utf8(b"turf"));
            };
            let v10 = 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_total_owned_turf_count(arg3);
            let v11 = 0x2::object::id<0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::Player>(arg3);
            let v12 = 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_player_dvd_id(arg3);
            let v13 = 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_player_name(arg3);
            0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::buildings::downgrade_building(0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_mut_player_df<0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibuildings::BuildingInfo>(arg3, 0x1::string::utf8(b"cash_operation")), arg1, v11, v12, v13, arg21, 0x1::string::utf8(b"cash_operation"), v10);
            0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::buildings::downgrade_building(0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_mut_player_df<0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibuildings::BuildingInfo>(arg3, 0x1::string::utf8(b"arms_dealership")), arg1, v11, v12, v13, arg21, 0x1::string::utf8(b"arms_dealership"), v10);
        };
        (v1, v3, v5)
    }

    fun process_capture(arg0: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::CapWrapper, arg1: &mut 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::Player, arg2: &mut 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::Player, arg3: &0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::map_version::Version, arg4: &mut 0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::TurfInformation, arg5: &0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::TurfSystem, arg6: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::isystem::SystemConfig, arg7: &mut 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibattle::PlayerBattleStats, arg8: &mut 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibattle::PlayerBattleStats, arg9: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::igangsters::GangsterBaseStats, arg10: vector<0x1::string::String>, arg11: &0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::MapRegistry, arg12: u128, arg13: u128, arg14: u128, arg15: &0x2::clock::Clock) {
        let v0 = 0x1::string::utf8(b"capture_cooldown");
        *0x2::vec_map::get_mut<0x1::string::String, u64>(0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_mut_player_timers(arg2), &v0) = 0x2::clock::timestamp_ms(arg15) + 0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::borrow_key_value(arg11, 0x1::string::utf8(b"capture_cooldown"));
        let v1 = 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_player_owned_location(arg1);
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::buildings::has_enough_dirty_cop(0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_mut_player_df<0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibuildings::Resources>(arg1, 0x1::string::utf8(b"scouts")), 0x1::vector::length<0x2::object::ID>(&v1));
        if (!0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::has_alive_gangsters(arg4, 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::igangsters::borrow_unit_types(arg9))) {
            0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::set_turf_owner(0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::borrow_map_cap(arg0), arg3, arg4, 0x2::object::id<0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::Player>(arg1));
        };
        0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::set_turf_cooldown(0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::borrow_map_cap(arg0), arg3, arg4, 0x2::clock::timestamp_ms(arg15) + 0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::borrow_turf_cooldown(arg5));
        if (0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_player_headquarter(arg2) == 0x2::object::id<0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::TurfInformation>(arg4)) {
            let v2 = 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_player_owned_location(arg2);
            if (0x1::vector::length<0x2::object::ID>(&v2) >= 2) {
                if (!0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::has_alive_gangsters(arg4, 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::igangsters::borrow_unit_types(arg9))) {
                    let v3 = 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_player_owned_location(arg2);
                    0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::set_headquarter(arg2, *0x1::vector::borrow<0x2::object::ID>(&v3, 1));
                };
            } else if (!0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::has_alive_gangsters(arg4, 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::igangsters::borrow_unit_types(arg9))) {
                0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::set_headquarter(arg2, 0x2::object::id_from_address(@0x1));
            };
            0xe660c11d5cddf961e2f153e2e9c89517bdbb2dfa64b9d3aae711672aeb7f240d::game_events::emit_headquarter_destroyed_event(0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::borrow_event_cap(arg0), 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_player_dvd_id(arg1), 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_player_dvd_id(arg2), 0x2::object::id<0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::Player>(arg1), 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_player_name(arg1), 0x2::object::id<0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::Player>(arg2), 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_player_name(arg2), 0x2::clock::timestamp_ms(arg15), arg12, arg13, arg14);
        };
        if (!0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::has_alive_gangsters(arg4, 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::igangsters::borrow_unit_types(arg9))) {
            let v4 = 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_player_owned_location(arg2);
            let v5 = 0x2::object::id<0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::TurfInformation>(arg4);
            let (_, v7) = 0x1::vector::index_of<0x2::object::ID>(&v4, &v5);
            0x1::vector::push_back<0x2::object::ID>(0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_mut_player_owned_location(arg1), 0x1::vector::remove<0x2::object::ID>(0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_mut_player_owned_location(arg2), v7));
            let (_, _, _, _, v12, _, _, _, _, _, _) = 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::isystem::borrow_system_config(arg6);
            0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::add_alive_units(0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::borrow_map_cap(arg0), arg3, arg4, arg10, 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::igangsters::borrow_unit_types(arg9));
            0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::increase_gangster_capacity(arg1, v12);
            0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::decrease_gangster_capacity(arg2, v12);
            0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibattle::increase_recent_occupied_turf_count(arg7);
            0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibattle::decrease_recent_occupied_turf_count(arg8);
            0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::update_player_stats(arg1, 0x1::string::utf8(b"territory_boss"), 1);
            0xe660c11d5cddf961e2f153e2e9c89517bdbb2dfa64b9d3aae711672aeb7f240d::game_events::emit_capture_event(0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::borrow_event_cap(arg0), 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_player_dvd_id(arg1), 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_player_dvd_id(arg2), 0x2::object::id<0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::Player>(arg1), 0x2::object::id<0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::Player>(arg2), 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_player_name(arg1), 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_player_name(arg2), 0x2::object::id<0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::TurfInformation>(arg4), 0x2::clock::timestamp_ms(arg15));
        };
    }

    fun process_raid(arg0: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::CapWrapper, arg1: &mut 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::Player, arg2: &mut 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::Player, arg3: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::isystem::SystemConfig, arg4: &0x2::random::Random, arg5: &0x2::clock::Clock, arg6: bool, arg7: bool, arg8: &0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::MapRegistry, arg9: &mut 0x2::tx_context::TxContext) : (u128, u128) {
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::players::validate_player_raid_cooldown(arg2, arg5);
        let (v0, v1) = if (arg6) {
            let (v2, v3) = if (arg7) {
                let v4 = 0x2::random::new_generator(arg4, arg9);
                (0x2::random::generate_u128_in_range(&mut v4, (0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::borrow_key_value(arg8, 0x1::string::utf8(b"min_hq")) as u128), (0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::borrow_key_value(arg8, 0x1::string::utf8(b"max_hq")) as u128)), 0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::borrow_key_value(arg8, 0x1::string::utf8(b"cooldown_hq")))
            } else {
                let (_, _, _, _, _, _, _, _, _, v14, _) = 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::isystem::borrow_system_config(arg3);
                let (_, _, _, _, _, _, _, _, _, _, v26) = 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::isystem::borrow_system_config(arg3);
                let (_, _, _, _, _, v32, _, _, _, _, _) = 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::isystem::borrow_system_config(arg3);
                let v38 = 0x2::random::new_generator(arg4, arg9);
                (0x2::random::generate_u128_in_range(&mut v38, (v14 as u128), (v26 as u128)), v32)
            };
            (v3, v2)
        } else {
            let (v39, v40) = if (arg7) {
                let v41 = 0x2::random::new_generator(arg4, arg9);
                (0x2::random::generate_u128_in_range(&mut v41, (0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::borrow_key_value(arg8, 0x1::string::utf8(b"min")) as u128), (0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::borrow_key_value(arg8, 0x1::string::utf8(b"max")) as u128)), 0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::borrow_key_value(arg8, 0x1::string::utf8(b"cooldown")))
            } else {
                let (_, _, _, _, _, _, _, v49, _, _, _) = 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::isystem::borrow_system_config(arg3);
                let (_, _, _, _, _, _, _, _, v61, _, _) = 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::isystem::borrow_system_config(arg3);
                let (_, _, _, _, _, _, v70, _, _, _, _) = 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::isystem::borrow_system_config(arg3);
                let v75 = 0x2::random::new_generator(arg4, arg9);
                (0x2::random::generate_u128_in_range(&mut v75, (v49 as u128), (v61 as u128)), v70)
            };
            (v40, v39)
        };
        let v76 = 500 * 0x1::u128::pow(2, 64);
        let v77 = 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_mut_player_df<0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibuildings::Resources>(arg2, 0x1::string::utf8(b"cash"));
        let v78 = 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::utils::percentage(0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibuildings::borrow_resource_amount(v77), v1);
        let v79 = v78;
        if (v78 > v76) {
            v79 = v76;
        };
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibuildings::subtract_resource_amount(v77, v79);
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibuildings::add_resource_amount(0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_mut_player_df<0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibuildings::Resources>(arg1, 0x1::string::utf8(b"cash")), v79);
        let v80 = 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_mut_player_df<0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibuildings::Resources>(arg2, 0x1::string::utf8(b"weapon"));
        let v81 = 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::utils::percentage(0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibuildings::borrow_resource_amount(v80), v1);
        let v82 = v81;
        if (v81 > v76) {
            v82 = v76;
        };
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibuildings::subtract_resource_amount(v80, v82);
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibuildings::add_resource_amount(0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_mut_player_df<0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibuildings::Resources>(arg1, 0x1::string::utf8(b"weapon")), v82);
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::players::validate_and_update_raid_cooldown(arg2, v0, arg5);
        0xe660c11d5cddf961e2f153e2e9c89517bdbb2dfa64b9d3aae711672aeb7f240d::game_events::emit_raid_event(0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::borrow_event_cap(arg0), 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_player_dvd_id(arg1), 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_player_dvd_id(arg2), 0x2::object::id<0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::Player>(arg1), 0x2::object::id<0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::Player>(arg2), 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_player_name(arg1), 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_player_name(arg2), v79, v82, 0x2::clock::timestamp_ms(arg5));
        (v79, v82)
    }

    public(friend) fun reverse_attack_count(arg0: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::Player, arg1: &mut 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibattle::PlayerBattleStats, arg2: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::isystem::SystemConfig, arg3: &0x2::clock::Clock) {
        validate_if_owned_battle_stats(arg0, arg1);
        let (v0, v1, _) = borrow_current_attack_count(arg1, arg2, arg3);
        let (v3, _, _, _, _, _, _, _, _, _, _) = 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::isystem::borrow_system_config(arg2);
        assert!(v0 != (v3 as u64), 0);
        let v14 = 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibattle::borrow_player_battle_stats(arg1);
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibattle::set_player_battle_ts(arg1, *0x1::vector::borrow<u64>(&v14, 1) + v1);
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibattle::set_player_battle_counts(arg1, v0 + 1);
    }

    public(friend) fun start_simulation(arg0: &mut vector<0x1::string::String>, arg1: &mut vector<0x1::string::String>, arg2: vector<0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibattle::GangsterUnitBattleStats>, arg3: vector<0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibattle::GangsterUnitBattleStats>, arg4: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibattle::DamageMultiplier, arg5: &0x2::random::Random, arg6: &mut 0x2::tx_context::TxContext) : (vector<0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibattle::GameStateLogger>, u8, vector<0x1::string::String>, vector<0x1::string::String>, vector<0x1::string::String>, vector<0x1::string::String>) {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0;
        let v3 = 0x1::vector::empty<0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibattle::GameStateLogger>();
        let v4 = 0x1::vector::empty<0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibattle::GangsterUnitBattleStats>();
        let v5 = 0x1::vector::empty<0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibattle::GangsterUnitBattleStats>();
        let v6 = 0x1::vector::empty<0x1::string::String>();
        let v7 = 0x1::vector::empty<0x1::string::String>();
        let v8;
        loop {
            v2 = v2 + 1;
            if (0x1::vector::length<0x1::string::String>(arg1) == 0) {
                v8 = 1;
            } else {
                let v9 = 0x1::vector::borrow_mut<0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibattle::GangsterUnitBattleStats>(&mut arg2, v0);
                let v10 = 0x1::vector::borrow_mut<0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibattle::GangsterUnitBattleStats>(&mut arg3, v1);
                let v11 = 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibattle::borrow_gangster_name(v9);
                let v12 = 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibattle::borrow_gangster_name(v10);
                0x1::string::append(&mut v11, 0x1::string::utf8(b"_"));
                0x1::string::append(&mut v11, 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibattle::borrow_gangster_name(v10));
                assert!(0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibattle::has_gangsters_damage_multiplier(arg4, v11), 3);
                0x1::string::append(&mut v12, 0x1::string::utf8(b"_"));
                0x1::string::append(&mut v12, 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibattle::borrow_gangster_name(v9));
                assert!(0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibattle::has_gangsters_damage_multiplier(arg4, v12), 3);
                let v13 = calculate_damage(0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibattle::borrow_gangsters_damage_multiplier(arg4, v11), 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibattle::borrow_gangster_attack_power(v9), arg5, arg6);
                let v14 = calculate_damage(0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibattle::borrow_gangsters_damage_multiplier(arg4, v12), 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibattle::borrow_gangster_attack_power(v10), arg5, arg6);
                let v15 = if (0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibattle::borrow_gangster_current_health(v9) > 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibattle::borrow_damage_value(&v14)) {
                    0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibattle::borrow_gangster_current_health(v9) - 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibattle::borrow_damage_value(&v14)
                } else {
                    0
                };
                0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibattle::set_gangster_current_health(v9, v15);
                0x1::vector::push_back<0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibattle::GangsterUnitBattleStats>(&mut v4, *v9);
                let v16 = 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibattle::new_gangster_battle_stats_logger(0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibattle::borrow_gangster_id(v9), 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibattle::borrow_gangster_name(v9), 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibattle::borrow_dice_roll_value(&v13), 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibattle::borrow_gangster_current_health(v9), 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibattle::borrow_gangster_read_health(v9), 0x1::vector::empty<0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibattle::StatMultiplier>(), 0x1::vector::empty<0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibattle::StatMultiplier>(), 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibattle::borrow_damage_value(&v13), 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibattle::borrow_damage_value(&v14));
                let v17 = if (0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibattle::borrow_gangster_current_health(v10) > 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibattle::borrow_damage_value(&v13)) {
                    0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibattle::borrow_gangster_current_health(v10) - 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibattle::borrow_damage_value(&v13)
                } else {
                    0
                };
                0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibattle::set_gangster_current_health(v10, v17);
                0x1::vector::push_back<0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibattle::GangsterUnitBattleStats>(&mut v5, *v10);
                let v18 = 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibattle::new_gangster_battle_stats_logger(0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibattle::borrow_gangster_id(v10), 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibattle::borrow_gangster_name(v10), 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibattle::borrow_dice_roll_value(&v14), 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibattle::borrow_gangster_current_health(v10), 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibattle::borrow_gangster_read_health(v10), 0x1::vector::empty<0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibattle::StatMultiplier>(), 0x1::vector::empty<0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibattle::StatMultiplier>(), 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibattle::borrow_damage_value(&v14), 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibattle::borrow_damage_value(&v13));
                0x1::vector::push_back<0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibattle::GameStateLogger>(&mut v3, 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibattle::new_game_state_logger(v2, v16, v18));
                if (0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibattle::borrow_gangster_life_status(&v18)) {
                    if (v1 < 0x1::vector::length<0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibattle::GangsterUnitBattleStats>(&arg3)) {
                        0x1::vector::push_back<0x1::string::String>(&mut v6, 0x1::vector::remove<0x1::string::String>(arg1, 0));
                    };
                    v1 = v1 + 1;
                };
                if (0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibattle::borrow_gangster_life_status(&v16)) {
                    if (v0 < 0x1::vector::length<0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibattle::GangsterUnitBattleStats>(&arg2)) {
                        0x1::vector::push_back<0x1::string::String>(&mut v7, 0x1::vector::remove<0x1::string::String>(arg0, 0));
                    };
                    v0 = v0 + 1;
                };
                if (v0 >= 0x1::vector::length<0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibattle::GangsterUnitBattleStats>(&arg2) && v1 >= 0x1::vector::length<0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibattle::GangsterUnitBattleStats>(&arg3)) {
                    v8 = 3;
                } else if (v0 >= 0x1::vector::length<0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibattle::GangsterUnitBattleStats>(&arg2)) {
                    v8 = 2;
                } else {
                    /* goto 34 */
                };
            };
            /* label 33 */
            return (v3, v8, v7, v6, *arg0, *arg1)
            /* label 34 */
            if (v1 >= 0x1::vector::length<0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibattle::GangsterUnitBattleStats>(&arg3)) {
                break
            };
        };
        v8 = 1;
        /* goto 33 */
    }

    public(friend) fun validate_attack_type(arg0: u8) {
        let v0 = if (arg0 == 1) {
            true
        } else if (arg0 == 2) {
            true
        } else {
            arg0 == 3
        };
        assert!(v0, 6);
    }

    public(friend) fun validate_attacker_count(arg0: u64) {
        assert!(arg0 <= 10 && arg0 > 0, 2);
    }

    public(friend) fun validate_if_owned_battle_stats(arg0: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::Player, arg1: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibattle::PlayerBattleStats) {
        assert!(0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_player_battle_stats_id(arg0) == 0x2::object::id<0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibattle::PlayerBattleStats>(arg1), 5);
    }

    public(friend) fun validate_scouts_count(arg0: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibuildings::Resources, arg1: u64) {
        assert!(0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibuildings::borrow_resource_amount(arg0) / 2 > (arg1 as u128) * 0x1::u128::pow(2, 64), 1);
    }

    // decompiled from Move bytecode v6
}

