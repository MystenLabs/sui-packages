module 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::battle {
    public fun borrow_current_attack_count(arg0: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibattle::PlayerBattleStats, arg1: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::isystem::SystemConfig, arg2: &0x2::clock::Clock) : (u64, u64, u64) {
        let v0 = 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibattle::borrow_player_battle_stats(arg0);
        let v1 = *0x1::vector::borrow<u64>(&v0, 0);
        let (_, _, v4, _, _, _) = 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::isystem::borrow_system_config(arg1);
        let v8 = 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibattle::borrow_player_battle_stats(arg0);
        let v9 = *0x1::vector::borrow<u64>(&v8, 1);
        let v10 = (0x2::clock::timestamp_ms(arg2) - v9) / v4;
        let v11 = if (v10 > v1) {
            0
        } else {
            v1 - v10
        };
        (v11, v10 * v4, v9 + v10 * v4 + v4)
    }

    fun calculate_damage(arg0: u128, arg1: u128, arg2: &0x2::random::Random, arg3: &mut 0x2::tx_context::TxContext) : 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibattle::Damage {
        let v0 = 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::utils::roll_dice(6, arg2, arg3);
        let v1 = if (v0 >= 5) {
            arg1 * 2
        } else if (v0 == 2) {
            arg1 / 2
        } else if (v0 == 1) {
            0
        } else {
            arg1
        };
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibattle::new_damage(v1 * arg0 / 1 * 0x1::u128::pow(2, 64), v0)
    }

    public(friend) fun generate_bot_defenses(arg0: &0x2::random::Random, arg1: u128, arg2: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibattle::PlayerBattleStats, arg3: &mut 0x2::tx_context::TxContext) : vector<0x1::string::String> {
        let v0 = 0x2::random::new_generator(arg0, arg3);
        let v1 = 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibattle::borrow_player_battle_stats(arg2);
        let v2 = *0x1::vector::borrow<u64>(&v1, 4);
        let v3 = if (v2 >= 5) {
            50
        } else if (v2 >= 3) {
            60
        } else if (v2 >= 2) {
            70
        } else {
            100
        };
        let v4 = if (arg1 < 3) {
            let v5 = 0x1::vector::empty<0x1::string::String>();
            0x1::vector::push_back<0x1::string::String>(&mut v5, 0x1::string::utf8(b"henchman"));
            get_gangster_vector(v5, vector[1])
        } else if (arg1 < 8) {
            let v6 = 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::utils::percentage(((3 + 0x2::random::generate_u8_in_range(&mut v0, 0, 1)) as u128), v3);
            let v7 = if (v6 == 0) {
                1
            } else {
                v6
            };
            let v8 = 0x1::vector::empty<0x1::string::String>();
            0x1::vector::push_back<0x1::string::String>(&mut v8, 0x1::string::utf8(b"henchman"));
            let v9 = 0x1::vector::empty<u128>();
            0x1::vector::push_back<u128>(&mut v9, v7);
            get_gangster_vector(v8, v9)
        } else if (arg1 < 17) {
            let v10 = 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::utils::percentage((0x2::random::generate_u8_in_range(&mut v0, 2, 3) as u128), v3);
            let v11 = 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::utils::percentage(2, v3);
            let v12 = 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::utils::percentage((0x2::random::generate_u8_in_range(&mut v0, 0, 1) as u128), v3);
            let v13 = 0x1::vector::empty<0x1::string::String>();
            let v14 = 0x1::vector::empty<u128>();
            if (v10 > 0) {
                0x1::vector::push_back<0x1::string::String>(&mut v13, 0x1::string::utf8(b"henchman"));
                0x1::vector::push_back<u128>(&mut v14, v10);
            };
            if (v11 > 0) {
                0x1::vector::push_back<0x1::string::String>(&mut v13, 0x1::string::utf8(b"bouncer"));
                0x1::vector::push_back<u128>(&mut v14, v11);
            };
            if (v12 > 0) {
                0x1::vector::push_back<0x1::string::String>(&mut v13, 0x1::string::utf8(b"enforcer"));
                0x1::vector::push_back<u128>(&mut v14, v12);
            };
            if (v10 + v11 + v12 == 0) {
                let v15 = 0x1::vector::empty<0x1::string::String>();
                0x1::vector::push_back<0x1::string::String>(&mut v15, 0x1::string::utf8(b"henchman"));
                get_gangster_vector(v15, vector[1])
            } else {
                get_gangster_vector(v13, v14)
            }
        } else if (arg1 < 32) {
            let v16 = 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::utils::percentage((0x2::random::generate_u8_in_range(&mut v0, 2, 3) as u128), v3);
            let v17 = 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::utils::percentage((0x2::random::generate_u8_in_range(&mut v0, 4, 5) as u128), v3);
            let v18 = 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::utils::percentage((0x2::random::generate_u8_in_range(&mut v0, 4, 5) as u128), v3);
            let v19 = 0x1::vector::empty<0x1::string::String>();
            let v20 = 0x1::vector::empty<u128>();
            if (v16 > 0) {
                0x1::vector::push_back<0x1::string::String>(&mut v19, 0x1::string::utf8(b"henchman"));
                0x1::vector::push_back<u128>(&mut v20, v16);
            };
            if (v17 > 0) {
                0x1::vector::push_back<0x1::string::String>(&mut v19, 0x1::string::utf8(b"bouncer"));
                0x1::vector::push_back<u128>(&mut v20, v17);
            };
            if (v18 > 0) {
                0x1::vector::push_back<0x1::string::String>(&mut v19, 0x1::string::utf8(b"enforcer"));
                0x1::vector::push_back<u128>(&mut v20, v18);
            };
            if (v16 + v17 + v18 == 0) {
                let v21 = 0x1::vector::empty<0x1::string::String>();
                0x1::vector::push_back<0x1::string::String>(&mut v21, 0x1::string::utf8(b"enforcer"));
                get_gangster_vector(v21, vector[1])
            } else {
                get_gangster_vector(v19, v20)
            }
        } else {
            let v22 = 0x1::vector::empty<0x1::string::String>();
            let v23 = &mut v22;
            0x1::vector::push_back<0x1::string::String>(v23, 0x1::string::utf8(b"bouncer"));
            0x1::vector::push_back<0x1::string::String>(v23, 0x1::string::utf8(b"enforcer"));
            let v24 = 0x1::vector::empty<u128>();
            let v25 = &mut v24;
            0x1::vector::push_back<u128>(v25, 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::utils::percentage(4 + (arg1 - 30) / 10, v3));
            0x1::vector::push_back<u128>(v25, 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::utils::percentage(3 + (arg1 - 30) / 5, v3));
            get_gangster_vector(v22, v24)
        };
        let v26 = v4;
        0x2::random::shuffle<0x1::string::String>(&mut v0, &mut v26);
        let v27 = 0;
        let v28 = 0x1::vector::empty<0x1::string::String>();
        while (v27 < 0x1::vector::length<0x1::string::String>(&v26)) {
            if (v27 >= 10) {
                break
            };
            0x1::vector::push_back<0x1::string::String>(&mut v28, *0x1::vector::borrow<0x1::string::String>(&v26, v27));
            v27 = v27 + 1;
        };
        v28
    }

    public(friend) fun generate_defender_gangsters(arg0: &0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::iturf::TurfInformation, arg1: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::igangsters::GangsterBaseStats, arg2: vector<0x1::string::String>, arg3: &0x2::clock::Clock) : (vector<0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibattle::GangsterUnitBattleStats>, u128, vector<0x1::string::String>) {
        let v0 = 10;
        let v1 = 0;
        let v2 = 0x1::vector::empty<0x1::string::String>();
        while (0x1::vector::length<0x1::string::String>(&arg2) > v1) {
            if (0x1::vector::length<0x1::string::String>(&v2) == v0) {
                break
            };
            let v3 = 0x1::vector::borrow<0x1::string::String>(&arg2, v1);
            let v4 = 0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::iturf::borrow_unit_value(arg0, v3);
            v1 = v1 + 1;
            while (v4 > 0) {
                if (0x1::vector::length<0x1::string::String>(&v2) == v0) {
                    break
                };
                0x1::vector::push_back<0x1::string::String>(&mut v2, *v3);
                v4 = v4 - 1;
            };
        };
        let (v5, v6) = generate_gangster_units(v2, arg1, 44444, arg3);
        (v5, v6, v2)
    }

    public(friend) fun generate_gangster_units(arg0: vector<0x1::string::String>, arg1: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::igangsters::GangsterBaseStats, arg2: u64, arg3: &0x2::clock::Clock) : (vector<0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibattle::GangsterUnitBattleStats>, u128) {
        let v0 = 0x1::vector::empty<0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibattle::GangsterUnitBattleStats>();
        let v1 = 0x1::vector::length<0x1::string::String>(&arg0);
        let v2 = 0;
        while (v1 > 0) {
            let v3 = *0x1::vector::borrow<0x1::string::String>(&arg0, v1 - 1);
            let (v4, v5) = 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::igangsters::borrow_gangster_battle_stats(0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::igangsters::borrow_gangster_df<0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::igangsters::GangsterStats>(arg1, v3));
            v2 = v2 + v5;
            0x1::vector::push_back<0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibattle::GangsterUnitBattleStats>(&mut v0, 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibattle::new_gangster_unit_battle_stats(v3, v5, v5, v4, v1 + arg2, arg3));
            v1 = v1 - 1;
        };
        (v0, v2)
    }

    fun get_gangster_vector(arg0: vector<0x1::string::String>, arg1: vector<u128>) : vector<0x1::string::String> {
        let v0 = 0;
        let v1 = 0x1::vector::empty<0x1::string::String>();
        while (v0 < 0x1::vector::length<0x1::string::String>(&arg0)) {
            let v2 = 0;
            let v3 = 0x1::vector::borrow<0x1::string::String>(&arg0, v0);
            while (v2 < *0x1::vector::borrow<u128>(&arg1, v0)) {
                0x1::vector::push_back<0x1::string::String>(&mut v1, *v3);
                v2 = v2 + 1;
            };
            v0 = v0 + 1;
        };
        v1
    }

    public(friend) fun process_battle_result(arg0: &mut 0x95c6aad5cf721dfa4a8d7735522163f1536073851fb23d2ac4e177141fcae364::airdrop::VendettaAirdropNFT, arg1: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::authority::CapWrapper, arg2: &mut 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::Player, arg3: &mut 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::Player, arg4: &mut 0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::iturf::TurfInformation, arg5: &mut 0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::iturf::TurfInformation, arg6: &0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::iturf::TurfSystem, arg7: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::isystem::SystemConfig, arg8: &mut 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibattle::PlayerBattleStats, arg9: &mut 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibattle::PlayerBattleStats, arg10: vector<0x1::string::String>, arg11: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::igangsters::GangsterBaseStats, arg12: u8, arg13: u8, arg14: vector<0x1::string::String>, arg15: vector<0x1::string::String>, arg16: vector<0x1::string::String>, arg17: vector<0x1::string::String>, arg18: u128, arg19: u128, arg20: &0x2::random::Random, arg21: &0x2::clock::Clock, arg22: &mut 0x2::tx_context::TxContext) : (u128, u128, u128) {
        let v0 = 0;
        let v1 = 0;
        0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::turf::remove_warrior_gangster(0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::authority::borrow_map_cap(arg1), arg5, arg15);
        0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::turf::remove_warrior_gangster(0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::authority::borrow_map_cap(arg1), arg4, arg10);
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::players::remove_warrior_gangsters(arg2, arg14);
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::players::remove_warrior_gangsters(arg3, arg15);
        if (arg12 == 1) {
            if (arg13 == 1) {
                let (v2, v3) = process_raid(arg1, arg2, arg3, arg7, arg20, arg21, arg22);
                0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::iturf::add_alive_units(0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::authority::borrow_map_cap(arg1), arg4, arg16, 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::igangsters::borrow_unit_types(arg11));
                v0 = v2;
                v1 = v3;
            } else if (arg13 == 2) {
                process_capture(arg1, arg2, arg3, arg5, arg6, arg7, arg8, arg9, arg11, arg16, arg21);
                0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::iturf::increase_turf_cooldown(0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::authority::borrow_map_cap(arg1), arg5, arg21);
                0x95c6aad5cf721dfa4a8d7735522163f1536073851fb23d2ac4e177141fcae364::airdrop::update_user_game_stats(arg0, 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::authority::borrow_game_cap(arg1), 0x1::string::utf8(b"turf"));
            } else if (arg13 == 3) {
                let (v4, v5) = process_raid(arg1, arg2, arg3, arg7, arg20, arg21, arg22);
                v0 = v4;
                v1 = v5;
                process_capture(arg1, arg2, arg3, arg5, arg6, arg7, arg8, arg9, arg11, arg16, arg21);
                0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::iturf::increase_turf_cooldown(0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::authority::borrow_map_cap(arg1), arg5, arg21);
                0x95c6aad5cf721dfa4a8d7735522163f1536073851fb23d2ac4e177141fcae364::airdrop::update_user_game_stats(arg0, 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::authority::borrow_game_cap(arg1), 0x1::string::utf8(b"turf"));
            };
        };
        (v0, v1, 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::players::calculate_loot_xp(arg12, arg2, arg18, arg3, arg19))
    }

    fun process_capture(arg0: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::authority::CapWrapper, arg1: &mut 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::Player, arg2: &mut 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::Player, arg3: &mut 0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::iturf::TurfInformation, arg4: &0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::iturf::TurfSystem, arg5: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::isystem::SystemConfig, arg6: &mut 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibattle::PlayerBattleStats, arg7: &mut 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibattle::PlayerBattleStats, arg8: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::igangsters::GangsterBaseStats, arg9: vector<0x1::string::String>, arg10: &0x2::clock::Clock) {
        let v0 = 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_player_owned_location(arg1);
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::buildings::has_enough_dirty_cop(0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_mut_player_df<0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibuildings::Resources>(arg1, 0x1::string::utf8(b"scouts")), 0x1::vector::length<0x2::object::ID>(&v0));
        0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::iturf::set_turf_owner(0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::authority::borrow_map_cap(arg0), arg3, 0x2::object::id<0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::Player>(arg1));
        0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::iturf::set_turf_cooldown(0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::authority::borrow_map_cap(arg0), arg3, 0x2::clock::timestamp_ms(arg10) + 0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::iturf::borrow_turf_cooldown(arg4));
        if (0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_player_headquarter(arg2) == 0x2::object::id<0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::iturf::TurfInformation>(arg3)) {
            let v1 = 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_player_owned_location(arg2);
            if (0x1::vector::length<0x2::object::ID>(&v1) >= 2) {
                let v2 = 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_player_owned_location(arg2);
                0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::set_headquarter(arg2, *0x1::vector::borrow<0x2::object::ID>(&v2, 1));
            } else {
                0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::set_headquarter(arg2, 0x2::object::id_from_address(@0x1));
                0x57c4f34e9f2dfd372fb40326ef82d0a768344e2f2b4e33c062592ff3ad52c6c6::game_events::emit_headquarter_destroyed_event(0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::authority::borrow_event_cap(arg0), 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_player_dvd_id(arg1), 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_player_dvd_id(arg2), 0x2::object::id<0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::Player>(arg1), 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_player_name(arg1), 0x2::object::id<0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::Player>(arg2), 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_player_name(arg2), 0x2::clock::timestamp_ms(arg10), 0, 0, 0);
            };
        };
        let v3 = 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_player_owned_location(arg2);
        let v4 = 0x2::object::id<0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::iturf::TurfInformation>(arg3);
        let (_, v6) = 0x1::vector::index_of<0x2::object::ID>(&v3, &v4);
        0x1::vector::push_back<0x2::object::ID>(0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_mut_player_owned_location(arg1), 0x1::vector::remove<0x2::object::ID>(0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_mut_player_owned_location(arg2), v6));
        let (_, _, _, _, v11, _) = 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::isystem::borrow_system_config(arg5);
        0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::iturf::add_alive_units(0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::authority::borrow_map_cap(arg0), arg3, arg9, 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::igangsters::borrow_unit_types(arg8));
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::increase_gangster_capacity(arg1, v11);
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::decrease_gangster_capacity(arg2, v11);
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibattle::increase_recent_occupied_turf_count(arg6);
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibattle::decrease_recent_occupied_turf_count(arg7);
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::update_player_stats(arg1, 0x1::string::utf8(b"territory_boss"), 1);
        0x57c4f34e9f2dfd372fb40326ef82d0a768344e2f2b4e33c062592ff3ad52c6c6::game_events::emit_capture_event(0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::authority::borrow_event_cap(arg0), 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_player_dvd_id(arg1), 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_player_dvd_id(arg2), 0x2::object::id<0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::Player>(arg1), 0x2::object::id<0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::Player>(arg2), 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_player_name(arg1), 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_player_name(arg2), 0x2::object::id<0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::iturf::TurfInformation>(arg3), 0x2::clock::timestamp_ms(arg10));
    }

    fun process_raid(arg0: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::authority::CapWrapper, arg1: &mut 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::Player, arg2: &mut 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::Player, arg3: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::isystem::SystemConfig, arg4: &0x2::random::Random, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (u128, u128) {
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::players::validate_player_raid_cooldown(arg2, arg5);
        let v0 = 0x2::random::new_generator(arg4, arg6);
        let v1 = 0x2::random::generate_u128_in_range(&mut v0, 5, 10);
        let v2 = 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_mut_player_df<0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibuildings::Resources>(arg2, 0x1::string::utf8(b"cash"));
        let v3 = 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::utils::percentage(0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibuildings::borrow_resource_amount(v2), v1);
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibuildings::subtract_resource_amount(v2, v3);
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibuildings::add_resource_amount(0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_mut_player_df<0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibuildings::Resources>(arg1, 0x1::string::utf8(b"cash")), v3);
        let v4 = 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_mut_player_df<0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibuildings::Resources>(arg2, 0x1::string::utf8(b"weapon"));
        let v5 = 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::utils::percentage(0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibuildings::borrow_resource_amount(v4), v1);
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibuildings::subtract_resource_amount(v4, v5);
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibuildings::add_resource_amount(0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_mut_player_df<0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibuildings::Resources>(arg1, 0x1::string::utf8(b"weapon")), v5);
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::players::validate_and_update_raid_cooldown(arg2, arg3, arg5);
        0x57c4f34e9f2dfd372fb40326ef82d0a768344e2f2b4e33c062592ff3ad52c6c6::game_events::emit_raid_event(0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::authority::borrow_event_cap(arg0), 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_player_dvd_id(arg1), 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_player_dvd_id(arg2), 0x2::object::id<0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::Player>(arg1), 0x2::object::id<0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::Player>(arg2), 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_player_name(arg1), 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_player_name(arg2), v3, v5, 0x2::clock::timestamp_ms(arg5));
        (v3, v5)
    }

    public(friend) fun reverse_attack_count(arg0: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::Player, arg1: &mut 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibattle::PlayerBattleStats, arg2: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::isystem::SystemConfig, arg3: &0x2::clock::Clock) {
        validate_if_owned_battle_stats(arg0, arg1);
        let (v0, v1, _) = borrow_current_attack_count(arg1, arg2, arg3);
        let (v3, _, _, _, _, _) = 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::isystem::borrow_system_config(arg2);
        assert!(v0 != (v3 as u64), 0);
        let v9 = 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibattle::borrow_player_battle_stats(arg1);
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibattle::set_player_battle_ts(arg1, *0x1::vector::borrow<u64>(&v9, 1) + v1);
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibattle::set_player_battle_counts(arg1, v0 + 1);
    }

    public(friend) fun start_simulation(arg0: &mut vector<0x1::string::String>, arg1: &mut vector<0x1::string::String>, arg2: vector<0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibattle::GangsterUnitBattleStats>, arg3: vector<0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibattle::GangsterUnitBattleStats>, arg4: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibattle::DamageMultiplier, arg5: &0x2::random::Random, arg6: &mut 0x2::tx_context::TxContext) : (vector<0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibattle::GameStateLogger>, u8, vector<0x1::string::String>, vector<0x1::string::String>, vector<0x1::string::String>, vector<0x1::string::String>) {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0;
        let v3 = 0x1::vector::empty<0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibattle::GameStateLogger>();
        let v4 = 0x1::vector::empty<0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibattle::GangsterUnitBattleStats>();
        let v5 = 0x1::vector::empty<0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibattle::GangsterUnitBattleStats>();
        let v6 = 0x1::vector::empty<0x1::string::String>();
        let v7 = 0x1::vector::empty<0x1::string::String>();
        let v8;
        loop {
            v2 = v2 + 1;
            if (0x1::vector::length<0x1::string::String>(arg1) == 0) {
                v8 = 1;
            } else {
                let v9 = 0x1::vector::borrow_mut<0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibattle::GangsterUnitBattleStats>(&mut arg2, v0);
                let v10 = 0x1::vector::borrow_mut<0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibattle::GangsterUnitBattleStats>(&mut arg3, v1);
                let v11 = 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibattle::borrow_gangster_name(v9);
                0x1::string::append(&mut v11, 0x1::string::utf8(b"_"));
                0x1::string::append(&mut v11, 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibattle::borrow_gangster_name(v10));
                assert!(0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibattle::has_gangsters_damage_multiplier(arg4, v11), 3);
                let v12 = 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibattle::borrow_gangsters_damage_multiplier(arg4, v11);
                let v13 = calculate_damage(v12, 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibattle::borrow_gangster_attack_power(v9), arg5, arg6);
                let v14 = calculate_damage(v12, 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibattle::borrow_gangster_attack_power(v10), arg5, arg6);
                let v15 = if (0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibattle::borrow_gangster_current_health(v9) > 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibattle::borrow_damage_value(&v14)) {
                    0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibattle::borrow_gangster_current_health(v9) - 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibattle::borrow_damage_value(&v14)
                } else {
                    0
                };
                0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibattle::set_gangster_current_health(v9, v15);
                0x1::vector::push_back<0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibattle::GangsterUnitBattleStats>(&mut v4, *v9);
                let v16 = 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibattle::new_gangster_battle_stats_logger(0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibattle::borrow_gangster_id(v9), 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibattle::borrow_gangster_name(v9), 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibattle::borrow_dice_roll_value(&v13), 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibattle::borrow_gangster_current_health(v9), 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibattle::borrow_gangster_read_health(v9), 0x1::vector::empty<0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibattle::StatMultiplier>(), 0x1::vector::empty<0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibattle::StatMultiplier>(), 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibattle::borrow_damage_value(&v13), 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibattle::borrow_damage_value(&v14));
                let v17 = if (0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibattle::borrow_gangster_current_health(v10) > 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibattle::borrow_damage_value(&v13)) {
                    0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibattle::borrow_gangster_current_health(v10) - 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibattle::borrow_damage_value(&v13)
                } else {
                    0
                };
                0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibattle::set_gangster_current_health(v10, v17);
                0x1::vector::push_back<0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibattle::GangsterUnitBattleStats>(&mut v5, *v10);
                let v18 = 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibattle::new_gangster_battle_stats_logger(0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibattle::borrow_gangster_id(v10), 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibattle::borrow_gangster_name(v10), 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibattle::borrow_dice_roll_value(&v14), 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibattle::borrow_gangster_current_health(v10), 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibattle::borrow_gangster_read_health(v10), 0x1::vector::empty<0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibattle::StatMultiplier>(), 0x1::vector::empty<0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibattle::StatMultiplier>(), 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibattle::borrow_damage_value(&v14), 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibattle::borrow_damage_value(&v13));
                0x1::vector::push_back<0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibattle::GameStateLogger>(&mut v3, 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibattle::new_game_state_logger(v2, v16, v18));
                if (0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibattle::borrow_gangster_life_status(&v18)) {
                    if (v1 < 0x1::vector::length<0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibattle::GangsterUnitBattleStats>(&arg3)) {
                        0x1::vector::push_back<0x1::string::String>(&mut v6, 0x1::vector::remove<0x1::string::String>(arg1, 0));
                    };
                    v1 = v1 + 1;
                };
                if (0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibattle::borrow_gangster_life_status(&v16)) {
                    if (v0 < 0x1::vector::length<0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibattle::GangsterUnitBattleStats>(&arg2)) {
                        0x1::vector::push_back<0x1::string::String>(&mut v7, 0x1::vector::remove<0x1::string::String>(arg0, 0));
                    };
                    v0 = v0 + 1;
                };
                if (v0 >= 0x1::vector::length<0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibattle::GangsterUnitBattleStats>(&arg2) && v1 >= 0x1::vector::length<0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibattle::GangsterUnitBattleStats>(&arg3)) {
                    v8 = 3;
                } else if (v0 >= 0x1::vector::length<0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibattle::GangsterUnitBattleStats>(&arg2)) {
                    v8 = 2;
                } else {
                    /* goto 31 */
                };
            };
            /* label 30 */
            return (v3, v8, v7, v6, *arg0, *arg1)
            /* label 31 */
            if (v1 >= 0x1::vector::length<0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibattle::GangsterUnitBattleStats>(&arg3)) {
                break
            };
        };
        v8 = 1;
        /* goto 30 */
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

    public(friend) fun validate_if_owned_battle_stats(arg0: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::Player, arg1: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibattle::PlayerBattleStats) {
        assert!(0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_player_battle_stats_id(arg0) == 0x2::object::id<0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibattle::PlayerBattleStats>(arg1), 5);
    }

    public(friend) fun validate_multiplier_key(arg0: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibattle::DamageMultiplier, arg1: 0x1::string::String) {
        assert!(!0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibattle::has_multiplier_key(arg0, arg1), 4);
    }

    public(friend) fun validate_scouts_count(arg0: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibuildings::Resources, arg1: u64) {
        assert!(0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibuildings::borrow_resource_amount(arg0) / 2 > (arg1 as u128) * 0x1::u128::pow(2, 64), 1);
    }

    // decompiled from Move bytecode v6
}

