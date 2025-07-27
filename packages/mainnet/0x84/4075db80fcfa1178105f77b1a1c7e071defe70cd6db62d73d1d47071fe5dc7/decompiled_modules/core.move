module 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::core {
    public(friend) fun upgrade_building(arg0: &mut 0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::airdrop::VendettaAirdropNFT, arg1: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::CapWrapper, arg2: &mut 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::Player, arg3: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibuildings::BuildingRegistry, arg4: 0x1::string::String, arg5: &0x2::clock::Clock) {
        let v0 = 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_total_owned_turf_count(arg2);
        claim_resources(arg1, arg2, arg4, arg5);
        let v1 = 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::remove_player_df<0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibuildings::BuildingInfo>(arg2, arg4);
        let v2 = 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibuildings::borrow_building_upgrade_cost(&v1);
        let v3 = 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibuildings::borrow_upgrade_info(v2);
        let v4 = 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibuildings::borrow_upgrade_info(v2);
        let v5 = 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibuildings::borrow_building_level(&v1);
        let v6 = 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibuildings::borrow_building_upgrade_value(arg3, arg4);
        let v7 = 0x1::string::utf8(b"upgrade_wait_ms");
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibuildings::reset_claim_timestamp(0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_mut_player_df<0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibuildings::Resources>(arg2, 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibuildings::borrow_building_production_type(&v1)), 0x2::clock::timestamp_ms(arg5) + (*0x2::vec_map::get<0x1::string::String, u128>(0x2::vec_map::get<u64, 0x2::vec_map::VecMap<0x1::string::String, u128>>(&v6, &v5), &v7) as u64));
        let v8 = 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_mut_player_df<0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibuildings::Resources>(arg2, 0x1::string::utf8(b"cash"));
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::buildings::pre_upgrade_cash_validation(v2, 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibuildings::borrow_resource_amount(v8), v0);
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibuildings::subtract_resource_amount(v8, *0x1::vector::borrow<u128>(&v3, 0));
        let v9 = 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_mut_player_df<0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibuildings::Resources>(arg2, 0x1::string::utf8(b"weapon"));
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::buildings::pre_upgrade_weapon_validation(v2, 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibuildings::borrow_resource_amount(v9));
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibuildings::subtract_resource_amount(v9, *0x1::vector::borrow<u128>(&v4, 2));
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::buildings::upgrade_building(&mut v1, arg3, arg4);
        0xe660c11d5cddf961e2f153e2e9c89517bdbb2dfa64b9d3aae711672aeb7f240d::game_events::upgrade_building_event(0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::borrow_event_cap(arg1), 0x2::object::id<0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::Player>(arg2), 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_player_dvd_id(arg2), 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_player_name(arg2), arg4, 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibuildings::borrow_building_level(&v1));
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::add_player_df<0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibuildings::BuildingInfo>(arg2, arg4, v1);
        0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::airdrop::update_user_game_stats(arg0, 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::borrow_game_cap(arg1), 0x1::string::utf8(b"building"));
    }

    public(friend) fun assign_headquarter(arg0: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::CapWrapper, arg1: &mut 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::Player, arg2: &0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::map_version::Version, arg3: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::Status, arg4: &mut 0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::MapConfig, arg5: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibuildings::BuildingRegistry, arg6: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::PlayersRegistry, arg7: &mut 0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::TurfSystem, arg8: &0x2::random::Random, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::Player>(arg1);
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::validate_onboarding_status(arg3);
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::players::validate_headquarter_assign(arg1);
        let v1 = 0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::turf::create_headquarter(0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::borrow_map_cap(arg0), arg2, v0, arg4, arg7, 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_initial_hq_garrison_limit(arg6), 0, arg8, arg9);
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::set_headquarter(arg1, v1);
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::set_owned_turf(arg1, v1);
        let (v2, v3) = 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::players::initialize_buildings(arg5);
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::add_player_df<0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibuildings::BuildingInfo>(arg1, 0x1::string::utf8(b"cash_operation"), v2);
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::add_player_df<0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibuildings::BuildingInfo>(arg1, 0x1::string::utf8(b"arms_dealership"), v3);
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::update_player_stats(arg1, 0x1::string::utf8(b"territory_boss"), 1);
        0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::emit_headquarter_assigned_event(v0, 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_player_dvd_id(arg1), 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_player_name(arg1), v1);
    }

    public(friend) fun attack_free_turf(arg0: &mut 0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::airdrop::VendettaAirdropNFT, arg1: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::CapWrapper, arg2: &mut 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::Player, arg3: &0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::map_version::Version, arg4: u64, arg5: bool, arg6: u64, arg7: bool, arg8: u64, arg9: bool, arg10: u64, arg11: bool, arg12: &mut 0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::TurfInformation, arg13: vector<0x1::string::String>, arg14: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::igangsters::GangsterBaseStats, arg15: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibattle::DamageMultiplier, arg16: &mut 0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::TurfSystem, arg17: &mut 0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::MapConfig, arg18: &mut 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibattle::PlayerBattleStats, arg19: &mut 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iexperience::WeeklyReport, arg20: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ilevel::LevelPointRegistry, arg21: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::isystem::SystemConfig, arg22: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::Status, arg23: &0x2::clock::Clock, arg24: &0x2::random::Random, arg25: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::option::none<0x2::object::ID>();
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::validate_battle_status(arg22);
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::perks::validate_protection_perk(arg2, arg23);
        0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::turf::validate_new_turf(arg4, arg5, arg6, arg7, arg16);
        0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::turf::validate_turf_exists(arg8, arg9, arg10, arg11, arg16);
        let v1 = 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_total_owned_turf_count(arg2);
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::players::validate_feed_people(arg2, arg23);
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::players::validate_defender_neighbor(arg2, 0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::borrow_turf_id(arg16, arg8, arg9, arg10, arg11));
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::battle::reverse_attack_count(arg2, arg18, arg21, arg23);
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::battle::validate_scouts_count(0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_player_df<0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibuildings::Resources>(arg2, 0x1::string::utf8(b"scouts")), v1);
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::battle::validate_attacker_count(0x1::vector::length<0x1::string::String>(&arg13));
        0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::turf::validate_chebyshev_distance(arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
        let v2 = 0x2::random::new_generator(arg24, arg25);
        0x2::random::shuffle<0x1::string::String>(&mut v2, &mut arg13);
        let v3 = 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::battle::generate_bot_defenses(arg24, (v1 as u128), arg18, arg25);
        0x1::vector::reverse<0x1::string::String>(&mut arg13);
        let (v4, _) = 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::battle::generate_gangster_units(arg13, arg14, 11111, arg23);
        let (v6, _) = 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::battle::generate_gangster_units(v3, arg14, 44444, arg23);
        let (v8, v9, v10, v11, v12, _) = 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::battle::start_simulation(&mut arg13, &mut v3, v4, v6, arg15, arg24, arg25);
        let v14 = v11;
        let v15 = v10;
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iexperience::add_to_gangster_elimination_weekly_report(arg19, 0x1::vector::length<0x1::string::String>(&v14), arg23);
        if (v9 == 1) {
            0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibattle::set_recent_lost(arg18, 0);
            let v16 = 0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::new_turf_from_coordinate(0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::borrow_map_cap(arg1), arg3, 0x2::object::id<0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::Player>(arg2), arg4, arg5, arg6, arg7, 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::igangsters::borrow_unit_types(arg14), v12, arg25);
            let v17 = 0x2::object::id<0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::TurfInformation>(&v16);
            0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::set_owned_turf(arg2, v17);
            0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iexperience::update_to_current_turf_count_weekly_report(arg19, 1, arg23);
            0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::add_coordinate_in_system(0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::borrow_map_cap(arg1), arg3, arg16, 0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::new_coordinates(arg4, arg5, arg6, arg7), v17);
            0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::add_turf_count(0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::borrow_map_cap(arg1), arg3, arg17, 1);
            0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibattle::increase_won_battle_count(arg18);
            0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibattle::increase_recent_occupied_turf_count(arg18);
            0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::players::set_gangsters_count(arg2, arg21);
            0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::airdrop::update_user_game_stats(arg0, 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::borrow_game_cap(arg1), 0x1::string::utf8(b"turf"));
            0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::update_player_stats(arg2, 0x1::string::utf8(b"territory_boss"), 1);
            0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::share_turf(0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::borrow_map_cap(arg1), arg3, v16);
            v0 = 0x1::option::some<0x2::object::ID>(v17);
        } else {
            let v18 = 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibattle::borrow_player_battle_stats(arg18);
            0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibattle::set_recent_lost(arg18, *0x1::vector::borrow<u64>(&v18, 4) + 1);
        };
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibattle::increase_total_battles_count(arg18);
        0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::turf::remove_warrior_gangster(0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::borrow_map_cap(arg1), arg3, arg12, arg13);
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::players::remove_warrior_gangsters(arg2, v15);
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibattle::emit_simulation_result_event(0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibattle::new_result_simulation(v9, 2, 0x2::object::id<0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::Player>(arg2), 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_player_dvd_id(arg2), v0, 0x1::option::none<0x2::object::ID>(), 0x1::option::none<0x2::object::ID>(), 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_player_name(arg2), 0x1::option::none<0x1::string::String>(), 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibattle::new_raided_resources(0, 0, 0), 0, 0, v8, v4, v6, 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::level::add_battle_level_points(arg0, arg1, arg2, arg20, 0x1::string::utf8(b"attack"), 0x1::vector::length<0x1::string::String>(&v15), 2, (v9 as u64), 1, arg24, arg25)));
    }

    public(friend) fun attack_owned_turf(arg0: &mut 0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::airdrop::VendettaAirdropNFT, arg1: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::CapWrapper, arg2: &mut 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::Player, arg3: &mut 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::Player, arg4: &0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::map_version::Version, arg5: u64, arg6: bool, arg7: u64, arg8: bool, arg9: &mut 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibattle::PlayerBattleStats, arg10: &mut 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibattle::PlayerBattleStats, arg11: &mut 0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::TurfInformation, arg12: &mut 0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::TurfInformation, arg13: vector<0x1::string::String>, arg14: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::igangsters::GangsterBaseStats, arg15: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibattle::DamageMultiplier, arg16: &0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::TurfSystem, arg17: &mut 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iexperience::WeeklyReport, arg18: &mut 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iexperience::WeeklyReport, arg19: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::isystem::SystemConfig, arg20: u8, arg21: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ilevel::LevelPointRegistry, arg22: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::Status, arg23: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibuildings::BuildingRegistry, arg24: bool, arg25: &0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::MapRegistry, arg26: &0x2::clock::Clock, arg27: &0x2::random::Random, arg28: &mut 0x2::tx_context::TxContext) {
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::validate_battle_status(arg22);
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::perks::validate_protection_perk(arg2, arg26);
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::players::validate_battle_perks_and_cooldown(arg3, arg26);
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::players::validate_players_stats(arg2, arg9);
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::players::validate_players_stats(arg3, arg10);
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::players::validate_feed_people(arg2, arg26);
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::battle::validate_attacker_count(0x1::vector::length<0x1::string::String>(&arg13));
        0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::turf::validate_turf_cooldown(arg12, arg26);
        let v0 = 0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::turf::borrow_turf_id_if_exists(arg5, arg6, arg7, arg8, arg16);
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::battle::validate_attack_type(arg20);
        let (_, _, v3, v4, v5, v6, _, _) = 0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::borrow_turf_information(arg12);
        if (arg24 && arg20 == 1) {
            let v9 = 0x1::string::utf8(b"raid_info");
            0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::level::validate_search_level(0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_mut_player_df<0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ilevel::PlayerLevelPoint>(arg2, 0x1::string::utf8(b"level_point")), 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_mut_player_df<0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ilevel::PlayerLevelPoint>(arg3, 0x1::string::utf8(b"level_point")), 0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::borrow_key_value(arg25, 0x1::string::utf8(b"level_difference")));
            if (0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::has_player_df(arg2, v9)) {
                0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::turf::update_raid_info(0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::borrow_map_cap(arg1), 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_mut_player_df<0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::RaidInfo>(arg2, v9), arg25, arg26);
            } else {
                0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::add_player_df<0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::RaidInfo>(arg2, v9, 0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::initialize_raid_info(0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::borrow_map_cap(arg1), arg25, arg26));
            };
        } else {
            0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::battle::reverse_attack_count(arg2, arg9, arg19, arg26);
            0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::players::validate_defender_neighbor(arg2, *0x1::option::borrow<0x2::object::ID>(&v0));
            0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::turf::validate_chebyshev_distance(arg5, arg6, arg7, arg8, v3, v4, v5, v6);
        };
        if (arg20 == 2 || arg20 == 3) {
            0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::players::validate_player_capture_cooldown(arg3, arg26);
        };
        let v10 = 0x2::random::new_generator(arg27, arg28);
        0x2::random::shuffle<0x1::string::String>(&mut v10, &mut arg13);
        0x1::vector::reverse<0x1::string::String>(&mut arg13);
        let (v11, v12) = 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::battle::generate_gangster_units(arg13, arg14, 11111, arg26);
        let (v13, v14, v15) = 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::battle::generate_defender_gangsters(arg12, arg14, 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::igangsters::borrow_unit_types(arg14), arg26);
        let v16 = v15;
        let (v17, v18, v19, v20, v21, v22) = 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::battle::start_simulation(&mut arg13, &mut v16, v11, v13, arg15, arg27, arg28);
        let v23 = v20;
        let v24 = v19;
        let (v25, v26, v27) = 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::battle::process_battle_result(arg0, arg1, arg2, arg3, arg4, arg11, arg12, arg16, arg19, arg9, arg10, arg13, arg14, v18, arg20, v24, v23, v21, v22, v12, v14, arg23, arg24, arg25, arg27, arg26, arg28);
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iexperience::add_to_gangster_elimination_weekly_report(arg17, 0x1::vector::length<0x1::string::String>(&v23), arg26);
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iexperience::add_to_gangster_elimination_weekly_report(arg18, 0x1::vector::length<0x1::string::String>(&v24), arg26);
        if (v18 == 1 && (arg20 == 2 || arg20 == 3)) {
            0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iexperience::update_to_current_turf_count_weekly_report(arg17, 1, arg26);
        };
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibattle::emit_simulation_result_event(0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibattle::new_result_simulation(v18, arg20, 0x2::object::id<0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::Player>(arg2), 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_player_dvd_id(arg2), 0x1::option::some<0x2::object::ID>(0x2::object::id<0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::TurfInformation>(arg12)), 0x1::option::some<0x2::object::ID>(0x2::object::id<0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::Player>(arg3)), 0x1::option::some<0x2::object::ID>(0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_player_dvd_id(arg3)), 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_player_name(arg2), 0x1::option::some<0x1::string::String>(0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_player_name(arg3)), 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibattle::new_raided_resources(v25, v26, v27), 0, 0, v17, v11, v13, 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::level::add_battle_level_points(arg0, arg1, arg2, arg21, 0x1::string::utf8(b"attack"), 0x1::vector::length<0x1::string::String>(&v23), (arg20 as u64), (v18 as u64), 0, arg27, arg28)));
    }

    public(friend) fun buy_perk(arg0: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::CapWrapper, arg1: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::Player, arg2: &0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::vendetta_version::Version, arg3: &mut 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iperks::PerksMetadataHolder, arg4: &mut 0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::vendetta::CoinRegistry, arg5: 0x2::coin::Coin<0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::vendetta::VENDETTA>, arg6: 0x1::string::String, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::vendetta::VENDETTA>(&arg5);
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::perks::validate_perk_name(arg3, arg6);
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::perks::validate_perk_price(arg3, arg6, v0, arg7);
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::perks::reset_supply(arg3, arg6, arg8);
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::perks::update_supply(arg3, arg6, arg7);
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::perks::validate_supply(arg3, arg6);
        0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::vendetta::burn(arg4, 0x2::coin::split<0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::vendetta::VENDETTA>(&mut arg5, (0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::utils::percentage_calculation((v0 as u128), 7000) as u64), arg9), arg2);
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::perks::transfer_coin<0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::vendetta::VENDETTA>(arg3, arg5);
        while (arg7 > 0) {
            0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iperks::transfer_perk(0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iperks::new(arg3, arg6, 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_player_dvd_id(arg1), arg9), arg9);
            arg7 = arg7 - 1;
        };
        0xe660c11d5cddf961e2f153e2e9c89517bdbb2dfa64b9d3aae711672aeb7f240d::game_events::emit_perk_enable_event(0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::borrow_event_cap(arg0), 0x2::object::id<0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::Player>(arg1), 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_player_dvd_id(arg1), 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_player_name(arg1), arg6);
    }

    public(friend) fun change_player_name(arg0: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::CapWrapper, arg1: &mut 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::Player, arg2: 0x1::string::String) {
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::set_profile_name(arg1, arg2);
        0xe660c11d5cddf961e2f153e2e9c89517bdbb2dfa64b9d3aae711672aeb7f240d::game_events::emit_change_player_name_event(0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::borrow_event_cap(arg0), 0x2::object::id<0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::Player>(arg1), 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_player_dvd_id(arg1), 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_player_name(arg1), arg2);
    }

    public(friend) fun change_profile_picture(arg0: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::CapWrapper, arg1: &mut 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::Player, arg2: 0x1::string::String) {
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::set_profile_picture(arg1, arg2);
        0xe660c11d5cddf961e2f153e2e9c89517bdbb2dfa64b9d3aae711672aeb7f240d::game_events::emit_change_profile_pic_event(0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::borrow_event_cap(arg0), 0x2::object::id<0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::Player>(arg1), 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_player_dvd_id(arg1), 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_player_name(arg1), arg2);
    }

    public(friend) fun claim_resources(arg0: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::CapWrapper, arg1: &mut 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::Player, arg2: 0x1::string::String, arg3: &0x2::clock::Clock) {
        let v0 = 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::remove_player_df<0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibuildings::BuildingInfo>(arg1, arg2);
        let v1 = 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibuildings::borrow_building_production_type(&v0);
        let v2 = 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_mut_player_df<0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibuildings::Resources>(arg1, v1);
        let v3 = 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibuildings::borrow_building_info(&v0);
        let v4 = 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibuildings::borrow_building_info(&v0);
        let v5 = 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::buildings::calculate_production(0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::players::borrow_perk_ts(arg1, 0x1::string::utf8(b"boost_production")), 0x2::clock::timestamp_ms(arg3), 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibuildings::borrow_last_claimed_ts(v2), *0x1::vector::borrow<u128>(&v3, 0), *0x1::vector::borrow<u128>(&v4, 1));
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibuildings::add_resource_amount(v2, v5);
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibuildings::reset_claim_timestamp(v2, 0x2::clock::timestamp_ms(arg3));
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::add_player_df<0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibuildings::BuildingInfo>(arg1, arg2, v0);
        if (arg2 == 0x1::string::utf8(b"cash_operation")) {
            0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::update_player_stats(arg1, 0x1::string::utf8(b"cash_king"), v5);
        };
        if (arg2 == 0x1::string::utf8(b"arms_dealership")) {
            0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::update_player_stats(arg1, 0x1::string::utf8(b"arms_dealer"), (v5 as u128) / 0x1::u128::pow(2, 64));
        };
        0xe660c11d5cddf961e2f153e2e9c89517bdbb2dfa64b9d3aae711672aeb7f240d::game_events::emit_claim_resource_event(0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::borrow_event_cap(arg0), 0x2::object::id<0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::Player>(arg1), 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_player_dvd_id(arg1), 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_player_name(arg1), arg2, v1, v5);
    }

    public(friend) fun claim_weekly_report(arg0: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::CapWrapper, arg1: &mut 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::Player, arg2: &mut 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iexperience::WeeklyReport, arg3: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iexperience::XPBonusConfig, arg4: &mut 0x7395b1aa27382bc96829269c7f557cd490dd31e953f6533cf10356da2942820b::swap::GameRewardPool, arg5: &0x2::clock::Clock) {
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::players::validate_weekly_report(arg1, 0x2::object::id<0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iexperience::WeeklyReport>(arg2));
        let v0 = 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iexperience::get_xp(arg3, arg2, arg5);
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iexperience::reset_player_weekly_report(arg2, 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::borrow_event_cap(arg0), 0x2::object::id<0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::Player>(arg1), 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_player_dvd_id(arg1), 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_player_name(arg1));
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iexperience::increase_xp(0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_mut_player_df<0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iexperience::Experience>(arg1, 0x1::string::utf8(b"experience")), v0);
        0x7395b1aa27382bc96829269c7f557cd490dd31e953f6533cf10356da2942820b::swap::add_reserve_xp(0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::borrow_swap_cap(arg0), arg4, (((v0 as u128) / 0x1::u128::pow(2, 64)) as u64));
        0xe660c11d5cddf961e2f153e2e9c89517bdbb2dfa64b9d3aae711672aeb7f240d::game_events::emit_weekly_report_claim_event(0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::borrow_event_cap(arg0), 0x2::object::id<0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::Player>(arg1), 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_player_dvd_id(arg1), 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_player_name(arg1), v0);
    }

    public(friend) fun crack_safe(arg0: &mut 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::Player, arg1: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::CapWrapper, arg2: &0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes_version::Version, arg3: 0x2::object::ID, arg4: &mut 0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::airdrop::VendettaAirdropNFT, arg5: &mut 0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::icrack_safe::Safe, arg6: &0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::icrack_safe::SafeRegistry, arg7: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ilevel::LevelPointRegistry, arg8: &mut 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iexperience::WeeklyReport, arg9: u64, arg10: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::Status, arg11: &0x2::clock::Clock, arg12: &0x2::random::Random, arg13: &mut 0x2::tx_context::TxContext) {
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::validate_crime_status(arg10);
        let v0 = 0x1::string::utf8(b"safe_cooldown");
        let v1 = 0x2::vec_map::get_mut<0x1::string::String, u64>(0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_mut_player_timers(arg0), &v0);
        0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crack_safe::validate_safe_cooldown(*v1, arg11);
        0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crack_safe::validate_safe_closed(arg5);
        *v1 = 0x2::clock::timestamp_ms(arg11) + 0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::icrack_safe::borrow_cooldown_ts(arg6);
        let v2 = 0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crack_safe::borrow_safe_bounds(arg5);
        let v3 = 0x2::random::new_generator(arg12, arg13);
        let v4 = 0x2::random::generate_u64_in_range(&mut v3, *0x1::vector::borrow<u64>(&v2, 0), *0x1::vector::borrow<u64>(&v2, 1));
        let v5 = 0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crack_safe::validate_guess(0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::borrow_crimes_cap(arg1), arg2, arg6, arg5, arg11, arg9, v4, arg12, arg13);
        let v6 = 0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::icrack_safe::borrow_crack_the_safe_registry(arg6);
        let v7 = if (arg9 == v4) {
            *0x1::vector::borrow<u64>(&v6, 4)
        } else {
            *0x1::vector::borrow<u64>(&v6, 5)
        };
        let v8 = if (v5 == 0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::icrack_safe::guess_won()) {
            0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iexperience::add_to_crack_safe_weekly_report(arg8, 1, v5 == 0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::icrack_safe::guess_won(), arg11);
            0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::update_player_stats(arg0, 0x1::string::utf8(b"safe_cracker"), 1);
            let v9 = 0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::icrack_safe::borrow_safe_information(arg5);
            0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibuildings::add_resource_amount(0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_mut_player_df<0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibuildings::Resources>(arg0, 0x1::string::utf8(b"cash")), (*0x1::vector::borrow<u64>(&v9, 2) as u128) * 0x1::u128::pow(2, 64));
            0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::update_player_stats(arg0, 0x1::string::utf8(b"cash_king"), (*0x1::vector::borrow<u64>(&v6, 3) as u128) * 0x1::u128::pow(2, 64));
            0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::airdrop::update_user_game_stats(arg4, 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::borrow_game_cap(arg1), 0x1::string::utf8(b"safe"));
            (*0x1::vector::borrow<u64>(&v6, 3) as u128) * 0x1::u128::pow(2, 64)
        } else {
            0
        };
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::level::add_level_points_to_player(arg4, arg1, arg0, arg7, ((v7 as u128) as u128) * 0x1::u128::pow(2, 64));
        0xe660c11d5cddf961e2f153e2e9c89517bdbb2dfa64b9d3aae711672aeb7f240d::game_events::emit_crack_safe_event(0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::borrow_event_cap(arg1), 0x2::object::id<0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::Player>(arg0), arg3, 0x2::object::id<0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::icrack_safe::Safe>(arg5), 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_player_name(arg0), (*0x1::vector::borrow<u64>(&v6, 3) as u128) * 0x1::u128::pow(2, 64), arg9, 0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::icrack_safe::set_status(0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::borrow_crimes_cap(arg1), v5), v8, 0, v7);
    }

    public(friend) fun create_player(arg0: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::CapWrapper, arg1: 0x2::object::ID, arg2: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::version::Version, arg3: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::Status, arg4: 0x1::string::String, arg5: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ilevel::LevelPointRegistry, arg6: &mut 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::PlayersRegistry, arg7: &mut 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::isystem::SystemConfig, arg8: &0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::imission::MissionRegistry, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::version::validate_version(arg2);
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::validate_onboarding_status(arg3);
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::players::validate_player_name(arg4);
        let v0 = 0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::iblackmail::new_blackmail_info(0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::borrow_crimes_cap(arg0), arg10);
        let v1 = 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::new(arg1, 0x1::string::utf8(b""), arg4, 0x2::object::id_from_address(@0x0), 0x1::vector::empty<0x2::object::ID>(), 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_initial_hq_garrison_limit(arg6), 0x2::object::id_from_address(@0x0), 0x2::object::id<0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::iblackmail::PlayerBlackmailInfo>(&v0), 0x7395b1aa27382bc96829269c7f557cd490dd31e953f6533cf10356da2942820b::swap::create_swap_points(0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::borrow_swap_cap(arg0), arg10), 0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::imission::new_mission_info(0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::borrow_crimes_cap(arg0), arg8, arg9, arg10), 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iexperience::init_player_report(arg9, arg10), 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::idaily_checkin::new_check_in_streak(arg10), arg9, arg10);
        0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::iblackmail::share_blackmail(0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::borrow_crimes_cap(arg0), v0);
        let v2 = 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibattle::new_player_battle_stats(arg9, arg10);
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::isystem::increase_active_scout_supply(arg7, 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_initial_scouts(arg6));
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::add_player_df<0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibuildings::Resources>(&mut v1, 0x1::string::utf8(b"weapon"), 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibuildings::new((0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_initial_weapon(arg6) as u128) * 0x1::u128::pow(2, 64), 0x1::string::utf8(b"arms_dealership"), arg9));
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::add_player_df<0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibuildings::Resources>(&mut v1, 0x1::string::utf8(b"cash"), 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibuildings::new((0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_initial_cash(arg6) as u128) * 0x1::u128::pow(2, 64), 0x1::string::utf8(b"cash_operation"), arg9));
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::add_player_df<0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibuildings::Resources>(&mut v1, 0x1::string::utf8(b"scouts"), 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibuildings::new((0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_initial_scouts(arg6) as u128) * 0x1::u128::pow(2, 64), 0x1::string::utf8(b"scouts"), arg9));
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::add_player_df<0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ilevel::PlayerLevelPoint>(&mut v1, 0x1::string::utf8(b"level_point"), 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ilevel::new_level_point(0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ilevel::level_point_required(arg5, 1)));
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::add_player_df<0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iexperience::Experience>(&mut v1, 0x1::string::utf8(b"experience"), 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iexperience::new_experience());
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::add_player_df<0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iaccolades::Accolade>(&mut v1, 0x1::string::utf8(b"accolade"), 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iaccolades::new_accolade());
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::initialize_player_timers(&mut v1, arg6, 0x2::object::id<0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibattle::PlayerBattleStats>(&v2), arg9);
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::players::initialize_perks(&mut v1, 0x2::clock::timestamp_ms(arg9) + 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_newbie_protection_duration(arg6), 0x1::string::utf8(b"newbie_protection"));
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::players::initialize_perks(&mut v1, 0, 0x1::string::utf8(b"boost_production"));
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::players::initialize_perks(&mut v1, 0, 0x1::string::utf8(b"attack_protection"));
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::players::initialize_perks(&mut v1, 0, 0x1::string::utf8(b"blackmail_protection"));
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::players::initialize_perks(&mut v1, 0, 0x1::string::utf8(b"attack_reset"));
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::share_player(v1);
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibattle::share_player_battle_stats(v2);
        0x2::object::id<0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::Player>(&v1)
    }

    public(friend) fun daily_check_in(arg0: &mut 0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::airdrop::VendettaAirdropNFT, arg1: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::CapWrapper, arg2: &mut 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::Player, arg3: &mut 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::idaily_checkin::DailyCheckInStreak, arg4: &mut 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::idaily_checkin::SevenDaysCheckInRewardsRegistry, arg5: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ilevel::LevelPointRegistry, arg6: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg6);
        let v1 = 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::idaily_checkin::borrow_dailystreak_last_checkedin_ts(arg3);
        let (v2, v3, v4) = 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::daily_checkin::get_7days_checkin_reward(arg4, arg3, v0, v1);
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::daily_checkin::distribute_7days_rewards(arg0, arg1, arg2, arg5, v2, 0x1::vector::empty<0x1::string::String>(), v3, 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::idaily_checkin::borrow_dailystreak_count(arg3), v0, 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_player_dvd_id(arg2));
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::daily_checkin::check_in(arg3, v0, v1, v4);
    }

    public(friend) fun enable_perk(arg0: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::CapWrapper, arg1: &mut 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::Player, arg2: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iperks::PerksMetadataHolder, arg3: &mut 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iperks::Perk, arg4: 0x1::string::String, arg5: &0x2::clock::Clock) {
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::perks::validate_perk_name(arg2, arg4);
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::perks::validate_perk_expired(arg3);
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::perks::validate_active_perk(arg1, arg4, arg5);
        let v0 = 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iperks::borrow_perk_life(arg3);
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iperks::set_perk_expire_ts(arg3, arg5, v0);
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::players::update_player_perk_ts(arg1, arg4, v0, arg5);
        0xe660c11d5cddf961e2f153e2e9c89517bdbb2dfa64b9d3aae711672aeb7f240d::game_events::emit_perk_enable_event(0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::borrow_event_cap(arg0), 0x2::object::id<0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::Player>(arg1), 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_player_dvd_id(arg1), 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_player_name(arg1), arg4);
    }

    public(friend) fun feed(arg0: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::CapWrapper, arg1: &mut 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::Player, arg2: &0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::vendetta_version::Version, arg3: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::FeedRegistry, arg4: &mut 0x7395b1aa27382bc96829269c7f557cd490dd31e953f6533cf10356da2942820b::swap::GameRewardPool, arg5: &mut 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iexperience::WeeklyReport, arg6: &mut 0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::vendetta::CoinRegistry, arg7: 0x1::option::Option<0x2::coin::Coin<0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::vendetta::VENDETTA>>, arg8: &0x2::clock::Clock, arg9: &0x2::random::Random, arg10: &mut 0x2::tx_context::TxContext) {
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::players::validate_feed_people(arg1, arg8);
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::players::validate_weekly_report(arg1, 0x2::object::id<0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iexperience::WeeklyReport>(arg5));
        let v0 = 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_feed_registry_values(arg3);
        let v1 = 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::players::calculate_base_cost(arg1, arg3);
        let v2 = 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_mut_player_df<0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibuildings::Resources>(arg1, 0x1::string::utf8(b"cash"));
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::buildings::validate_resource_amount(v2, v1);
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibuildings::subtract_resource_amount(v2, v1);
        let v3 = 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::players::calculate_new_recruits(arg1, arg3);
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::increase_recruit_count(arg1, v3);
        let (v4, v5) = if (0x1::option::is_some<0x2::coin::Coin<0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::vendetta::VENDETTA>>(&arg7)) {
            let v6 = 0x1::option::destroy_some<0x2::coin::Coin<0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::vendetta::VENDETTA>>(arg7);
            let v7 = 0x2::coin::value<0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::vendetta::VENDETTA>(&v6);
            0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::players::validate_feed_coin(v7, *0x1::vector::borrow<u64>(&v0, 3), false);
            0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::vendetta::burn(arg6, v6, arg2);
            0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iexperience::add_to_feed_people_weekly_report(arg5, 1, arg8);
            let v8 = 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::players::calculate_xp_feed_xp_gain(arg9, v3, arg10);
            0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iexperience::increase_xp(0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_mut_player_df<0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iexperience::Experience>(arg1, 0x1::string::utf8(b"experience")), v8);
            0x7395b1aa27382bc96829269c7f557cd490dd31e953f6533cf10356da2942820b::swap::add_reserve_xp(0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::borrow_swap_cap(arg0), arg4, (((v8 as u128) / 0x1::u128::pow(2, 64)) as u64));
            (v8, v7)
        } else {
            0x1::option::destroy_none<0x2::coin::Coin<0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::vendetta::VENDETTA>>(arg7);
            (0, 0)
        };
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::players::update_timer(arg1, 0x1::string::utf8(b"feed_people"), *0x1::vector::borrow<u64>(&v0, 2) + 0x2::clock::timestamp_ms(arg8));
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::update_player_stats(arg1, 0x1::string::utf8(b"badge_flipper"), 1);
        0xe660c11d5cddf961e2f153e2e9c89517bdbb2dfa64b9d3aae711672aeb7f240d::game_events::emit_feed_people_event(0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::borrow_event_cap(arg0), 0x2::object::id<0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::Player>(arg1), 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_player_dvd_id(arg1), 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_player_name(arg1), v3, v1, v4, v5);
    }

    public(friend) fun hire_scouts(arg0: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::CapWrapper, arg1: &mut 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::Player, arg2: &mut 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::isystem::SystemConfig, arg3: u64, arg4: &0x2::clock::Clock) {
        let (_, v1) = 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::isystem::borrow_scout_config(arg2);
        let v2 = ((v1 * arg3) as u128) * 0x1::u128::pow(2, 64);
        let v3 = 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_mut_player_df<0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibuildings::Resources>(arg1, 0x1::string::utf8(b"cash"));
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::buildings::validate_resource_amount(v3, v2);
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibuildings::subtract_resource_amount(v3, v2);
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibuildings::add_resource_amount(0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_mut_player_df<0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibuildings::Resources>(arg1, 0x1::string::utf8(b"scouts")), (arg3 as u128) * 0x1::u128::pow(2, 64));
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::players::validate_hire_scouts_cooldown(arg1, arg4);
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::isystem::calculate_scout_supply(arg2, arg3, arg4);
        0xe660c11d5cddf961e2f153e2e9c89517bdbb2dfa64b9d3aae711672aeb7f240d::game_events::emit_hire_scout_event(0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::borrow_event_cap(arg0), 0x2::object::id<0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::Player>(arg1), 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_player_dvd_id(arg1), 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_player_name(arg1), v2, arg3);
    }

    public(friend) fun late_daily_check_in(arg0: &mut 0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::airdrop::VendettaAirdropNFT, arg1: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::CapWrapper, arg2: &mut 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::Player, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::idaily_checkin::DailyCheckInStreak, arg5: &mut 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::idaily_checkin::SevenDaysCheckInRewardsRegistry, arg6: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::isystem::SystemConfig, arg7: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ilevel::LevelPointRegistry, arg8: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg8);
        let v1 = 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::daily_checkin::get_missed_days(arg4, arg5, v0);
        let (_, v3) = 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::idaily_checkin::get_7days_max_missed_and_cost(arg5);
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::daily_checkin::validate_v_cost_last_signed_in(v3, 0x2::coin::value<0x2::sui::SUI>(&arg3), 0x1::vector::length<0x1::string::String>(&v1) - 1);
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::daily_checkin::distribute_7days_rewards(arg0, arg1, arg2, arg7, 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::daily_checkin::get_late_sign_in_rewards(arg5, arg4, v1), v1, 0x1::string::utf8(b""), 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::idaily_checkin::borrow_dailystreak_count(arg4), v0, 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_player_dvd_id(arg2));
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::daily_checkin::late_checkin(arg4, 0x1::vector::length<0x1::string::String>(&v1), v0);
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::isystem::add_v_to_game_treasury(arg6, arg3);
    }

    public(friend) fun move_gangster(arg0: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::CapWrapper, arg1: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::Player, arg2: &0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::map_version::Version, arg3: &mut 0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::TurfInformation, arg4: &mut 0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::TurfInformation, arg5: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::igangsters::GangsterBaseStats, arg6: 0x1::string::String, arg7: u64, arg8: &0x2::clock::Clock) {
        let v0 = 0x2::object::id<0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::Player>(arg1);
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::players::validate_feed_people(arg1, arg8);
        0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::turf::pre_move_gangster_validation(arg3, arg4, arg6, arg7);
        0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::turf::validate_turf_owner(arg3, v0);
        0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::turf::validate_turf_owner(arg4, v0);
        0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::turf::validate_gangster_type(arg6, 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::igangsters::borrow_unit_types(arg5));
        0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::turf::validate_destination_turf(0x2::object::id<0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::TurfInformation>(arg3), 0x2::object::id<0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::TurfInformation>(arg4));
        0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::remove_gangster_from_turf(0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::borrow_map_cap(arg0), arg2, arg3, arg6, arg7);
        0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::add_gangster_in_turf(0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::borrow_map_cap(arg0), arg2, arg4, arg6, arg7);
        0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::emit_move_gangster_event(v0, 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_player_dvd_id(arg1), 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_player_name(arg1), arg6, 1, 0x2::object::id<0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::TurfInformation>(arg3), 0x2::object::id<0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::TurfInformation>(arg4));
    }

    public(friend) fun re_assign_hq(arg0: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::CapWrapper, arg1: &mut 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::Player, arg2: &0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::map_version::Version, arg3: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::Status, arg4: &mut 0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::MapConfig, arg5: &mut 0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::TurfSystem, arg6: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::PlayersRegistry, arg7: &0x2::random::Random, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::Player>(arg1);
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::validate_onboarding_status(arg3);
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::players::validate_headquarter_assign(arg1);
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::reset_gangsters(arg1, arg6);
        let v1 = 0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::turf::create_headquarter(0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::borrow_map_cap(arg0), arg2, v0, arg4, arg5, 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_initial_hq_garrison_limit(arg6), 0, arg7, arg8);
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::set_headquarter(arg1, v1);
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::set_owned_turf(arg1, v1);
        0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::emit_re_assign_headquarter_event(v0, 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_player_dvd_id(arg1), 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_player_name(arg1), v1);
    }

    public(friend) fun record_blackmail(arg0: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::CapWrapper, arg1: &mut 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iexperience::WeeklyReport, arg2: &0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes_version::Version, arg3: &mut 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::Player, arg4: &mut 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::Player, arg5: &mut 0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::airdrop::VendettaAirdropNFT, arg6: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ilevel::LevelPointRegistry, arg7: &mut 0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::iblackmail::PlayerBlackmailInfo, arg8: &0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::iblackmail::PlayerBlackmailInfo, arg9: &0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::iblackmail::BlackmailType, arg10: &0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::iblackmail::BlackmailRegistry, arg11: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::Status, arg12: &0x2::clock::Clock, arg13: &0x2::random::Random, arg14: &mut 0x2::tx_context::TxContext) {
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::validate_crime_status(arg11);
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::players::validate_blackmail(arg3, 0x2::object::id<0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::iblackmail::PlayerBlackmailInfo>(arg7));
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::players::validate_blackmail(arg4, 0x2::object::id<0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::iblackmail::PlayerBlackmailInfo>(arg8));
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::players::validate_self_blackmail(0x2::object::id<0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::Player>(arg3), 0x2::object::id<0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::Player>(arg4));
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::players::validate_perk_enabled(arg4, 0x1::string::utf8(b"blackmail_protection"), arg12);
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::players::validate_blackmail_cooldown(arg3, arg4, arg12);
        let (v0, v1, v2, v3, v4, v5) = 0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::blackmail::record_blackmail(0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::borrow_crimes_cap(arg0), arg2, 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ilevel::borrow_level(0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_mut_player_df<0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ilevel::PlayerLevelPoint>(arg3, 0x1::string::utf8(b"level_point"))), 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ilevel::borrow_level(0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_mut_player_df<0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ilevel::PlayerLevelPoint>(arg4, 0x1::string::utf8(b"level_point"))), arg7, arg8, arg9, arg10, 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibuildings::borrow_resource_amount(0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_player_df<0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibuildings::Resources>(arg4, 0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::iblackmail::borrow_blackmail_resource_type(arg9))), arg13, arg14);
        let v6 = 0x1::string::utf8(b"blackmail_attack_cooldown");
        *0x2::vec_map::get_mut<0x1::string::String, u64>(0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_mut_player_timers(arg3), &v6) = 0x2::clock::timestamp_ms(arg12) + v0;
        let v7 = 0x1::string::utf8(b"blackmail_looted_cooldown");
        *0x2::vec_map::get_mut<0x1::string::String, u64>(0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_mut_player_timers(arg4), &v7) = 0x2::clock::timestamp_ms(arg12) + v1;
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::level::add_blackmail_level_point(arg5, arg0, arg3, arg6, v2);
        if (v3 == 0x1::string::utf8(b"cash")) {
            0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::update_player_stats(arg3, 0x1::string::utf8(b"cash_king"), v4);
        } else if (v3 == 0x1::string::utf8(b"weapon")) {
            0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::update_player_stats(arg3, 0x1::string::utf8(b"arms_dealer"), (v4 as u128) / 0x1::u128::pow(2, 64));
        };
        if (v5 && v4 >= 1 * 0x1::u128::pow(2, 64)) {
            0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iexperience::add_to_blackmail_weekly_report(arg1, 1, (((v4 as u128) / 0x1::u128::pow(2, 64)) as u64), arg12);
            0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::airdrop::update_user_game_stats(arg5, 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::borrow_game_cap(arg0), 0x1::string::utf8(b"blackmail"));
            0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::update_player_stats(arg3, 0x1::string::utf8(b"shakedown_artist"), 1);
            let v8 = 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_mut_player_df<0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibuildings::Resources>(arg4, v3);
            0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::buildings::validate_resource_amount(v8, v4);
            0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibuildings::subtract_resource_amount(v8, v4);
            0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibuildings::add_resource_amount(0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_mut_player_df<0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibuildings::Resources>(arg3, v3), v4);
        };
        let v9 = v4 >= 1 && v5;
        0xe660c11d5cddf961e2f153e2e9c89517bdbb2dfa64b9d3aae711672aeb7f240d::game_events::emit_blackmail_event(0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::borrow_event_cap(arg0), 0x2::object::id<0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::Player>(arg4), 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_player_dvd_id(arg4), 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_player_name(arg4), 0x2::object::id<0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::Player>(arg3), 0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::iblackmail::borrow_blackmail_resource_type(arg9), 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_player_name(arg3), 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_player_dvd_id(arg3), 0x2::clock::timestamp_ms(arg12), v9, v4, 0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::blackmail::calculate_heat_points(v4, v5), (v2 as u128) * 0x1::u128::pow(2, 64));
    }

    public(friend) fun revive_recruits(arg0: &mut 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::Player, arg1: &0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::vendetta_version::Version, arg2: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::FeedRegistry, arg3: &mut 0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::vendetta::CoinRegistry, arg4: 0x1::option::Option<0x2::coin::Coin<0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::vendetta::VENDETTA>>, arg5: 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::PenaltyReceipt, arg6: &0x2::clock::Clock) {
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::players::validate_revive_people(arg0, &arg5, arg6);
        let v0 = 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_feed_registry_values(arg2);
        if (0x1::option::is_some<0x2::coin::Coin<0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::vendetta::VENDETTA>>(&arg4)) {
            let v1 = 0x1::option::destroy_some<0x2::coin::Coin<0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::vendetta::VENDETTA>>(arg4);
            0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::players::validate_feed_coin(0x2::coin::value<0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::vendetta::VENDETTA>(&v1), *0x1::vector::borrow<u64>(&v0, 3), true);
            0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::vendetta::burn(arg3, v1, arg1);
        } else {
            0x1::option::destroy_none<0x2::coin::Coin<0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::vendetta::VENDETTA>>(arg4);
            0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibuildings::subtract_resource_amount(0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_mut_player_df<0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibuildings::Resources>(arg0, 0x1::string::utf8(b"cash")), 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::players::calculate_base_cost(arg0, arg2) * 2);
        };
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::players::update_timer(arg0, 0x1::string::utf8(b"feed_people"), *0x1::vector::borrow<u64>(&v0, 2) + 0x2::clock::timestamp_ms(arg6));
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::consume_receipt(arg5);
    }

    public(friend) fun start_mission(arg0: &mut 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::Player, arg1: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::CapWrapper, arg2: &0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes_version::Version, arg3: 0x2::object::ID, arg4: &mut 0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::airdrop::VendettaAirdropNFT, arg5: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ilevel::LevelPointRegistry, arg6: &mut 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iexperience::WeeklyReport, arg7: &0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::imission::MissionRegistry, arg8: &mut 0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::imission::MissionInfo, arg9: u64, arg10: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::Status, arg11: &0x2::clock::Clock, arg12: &0x2::random::Random, arg13: &mut 0x2::tx_context::TxContext) {
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::validate_crime_status(arg10);
        0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::mission::validate_player_mission_info(0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_mission_info(arg0), 0x2::object::id<0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::imission::MissionInfo>(arg8));
        let (v0, v1, v2) = 0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::mission::start_mission(0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::borrow_crimes_cap(arg1), arg2, arg7, arg8, arg9, arg11, arg12, 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ilevel::borrow_level(0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_mut_player_df<0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ilevel::PlayerLevelPoint>(arg0, 0x1::string::utf8(b"level_point"))), arg13);
        let v3 = v2;
        let v4 = v1;
        let v5 = 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_mut_player_timers(arg0);
        let v6 = 0x1::string::utf8(b"mission_cooldown");
        assert!(0x2::vec_map::contains<0x1::string::String, u64>(v5, &v6), 1234);
        let v7 = 0x2::vec_map::get_mut<0x1::string::String, u64>(v5, &v6);
        assert!(0x2::clock::timestamp_ms(arg11) > *v7, 2234);
        let v8 = 0x2::clock::timestamp_ms(arg11) + *0x1::vector::borrow<u64>(&v4, 2);
        *v7 = v8;
        let v9 = if (v0) {
            0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iexperience::add_to_mission_weekly_report(arg6, 1, ((((*0x1::vector::borrow<u128>(&v3, 0) + *0x1::vector::borrow<u128>(&v3, 1)) as u128) / 0x1::u128::pow(2, 64)) as u64), arg11);
            0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibuildings::add_resource_amount(0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_mut_player_df<0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibuildings::Resources>(arg0, 0x1::string::utf8(b"cash")), *0x1::vector::borrow<u128>(&v3, 0));
            0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibuildings::add_resource_amount(0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_mut_player_df<0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibuildings::Resources>(arg0, 0x1::string::utf8(b"weapon")), *0x1::vector::borrow<u128>(&v3, 1));
            0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::level::add_mission_level_point(arg4, arg1, arg0, arg5, *0x1::vector::borrow<u64>(&v4, 7));
            *0x1::vector::borrow<u64>(&v4, 7)
        } else {
            0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::level::add_mission_level_point(arg4, arg1, arg0, arg5, *0x1::vector::borrow<u64>(&v4, 8));
            *0x1::vector::borrow<u64>(&v4, 8)
        };
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::update_player_stats(arg0, 0x1::string::utf8(b"cash_king"), *0x1::vector::borrow<u128>(&v3, 0));
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::update_player_stats(arg0, 0x1::string::utf8(b"arms_dealer"), (*0x1::vector::borrow<u128>(&v3, 1) as u128) / 0x1::u128::pow(2, 64));
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::update_player_stats(arg0, 0x1::string::utf8(b"scavenger"), 1);
        0xe660c11d5cddf961e2f153e2e9c89517bdbb2dfa64b9d3aae711672aeb7f240d::game_events::emit_mission_event(0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::borrow_event_cap(arg1), 0x2::object::id<0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::Player>(arg0), arg3, 0x2::object::id<0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::imission::MissionInfo>(arg8), 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_player_name(arg0), v0, *0x1::vector::borrow<u128>(&v3, 1), *0x1::vector::borrow<u128>(&v3, 0), v8, (v9 as u128) * 0x1::u128::pow(2, 64));
    }

    public(friend) fun start_weekly_report(arg0: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::CapWrapper, arg1: &mut 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::Player, arg2: &mut 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iexperience::WeeklyReport, arg3: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iexperience::XPBonusConfig, arg4: &0x2::clock::Clock) {
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::players::validate_weekly_report(arg1, 0x2::object::id<0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iexperience::WeeklyReport>(arg2));
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iexperience::reset_report_and_update_timer(arg2, 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::borrow_event_cap(arg0), 0x2::object::id<0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::Player>(arg1), 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_player_dvd_id(arg1), 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_player_name(arg1), arg4);
    }

    public(friend) fun train_recruits(arg0: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::CapWrapper, arg1: &mut 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::Player, arg2: &0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::map_version::Version, arg3: &mut 0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::TurfInformation, arg4: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::igangsters::GangsterBaseStats, arg5: 0x1::string::String, arg6: &0x2::clock::Clock) {
        let v0 = 1;
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::players::validate_feed_people(arg1, arg6);
        let v1 = 0x2::object::id<0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::Player>(arg1);
        0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::turf::validate_turf_owner(arg3, v1);
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::gangsters::validate_available_gangster(arg4, arg5);
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::players::validate_recruit_count(arg1, v0);
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::decrease_recruit_count(arg1, v0);
        let v2 = 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::igangsters::borrow_gangster_recruit_cost(0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::igangsters::borrow_gangster_df<0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::igangsters::GangsterStats>(arg4, arg5));
        let v3 = 0;
        let v4 = 0;
        let v5 = 0;
        while (v3 < 0x1::vector::length<0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::igangsters::GangsterRecruitCost>(v2)) {
            let v6 = 0x1::vector::borrow<0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::igangsters::GangsterRecruitCost>(v2, v3);
            let v7 = 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::igangsters::borrow_gangster_recruit_cost_amount(v6);
            let v8 = 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::igangsters::borrow_gangster_recruit_cost_type(v6);
            if (v8 != 0x1::string::utf8(b"turf")) {
                let v9 = 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_mut_player_df<0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibuildings::Resources>(arg1, v8);
                0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::buildings::validate_resource_amount(v9, v7);
                0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibuildings::subtract_resource_amount(v9, v7);
                if (v8 == 0x1::string::utf8(b"cash")) {
                    v4 = v7;
                } else {
                    v5 = v7;
                };
            } else {
                0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::gangsters::validate_turf_recruit_cost(((0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_total_owned_turf_count(arg1) as u128) as u128) * 0x1::u128::pow(2, 64), v7);
            };
            v3 = v3 + 1;
        };
        0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::turf::update_hq_gangster(0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::borrow_map_cap(arg0), arg2, arg3, arg5, v0);
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::add_gangster_in_summary(arg1, arg5, v0);
        0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::turf::validate_garrison_limit(arg3);
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::update_player_stats(arg1, 0x1::string::utf8(b"family_consigliere"), 1);
        0xe660c11d5cddf961e2f153e2e9c89517bdbb2dfa64b9d3aae711672aeb7f240d::game_events::emit_train_recruit_event(0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::borrow_event_cap(arg0), v1, 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_player_dvd_id(arg1), 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_player_name(arg1), arg5, v0, v4, v5);
    }

    public(friend) fun use_attack_reset_perk(arg0: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::CapWrapper, arg1: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::Player, arg2: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iperks::PerksMetadataHolder, arg3: &mut 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iperks::Perk, arg4: 0x1::string::String, arg5: &mut 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibattle::PlayerBattleStats, arg6: &0x2::clock::Clock) {
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::battle::validate_if_owned_battle_stats(arg1, arg5);
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::perks::validate_perk_name(arg2, arg4);
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::perks::validate_perk_expired(arg3);
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iperks::set_perk_expire_ts(arg3, arg6, 0);
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibattle::set_player_battle_ts(arg5, 0x2::clock::timestamp_ms(arg6));
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibattle::set_player_battle_counts(arg5, 0);
        0xe660c11d5cddf961e2f153e2e9c89517bdbb2dfa64b9d3aae711672aeb7f240d::game_events::emit_perk_enable_event(0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::borrow_event_cap(arg0), 0x2::object::id<0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::Player>(arg1), 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_player_dvd_id(arg1), 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_player_name(arg1), arg4);
    }

    public(friend) fun use_raid_reset_perk(arg0: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::CapWrapper, arg1: &mut 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::Player, arg2: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iperks::PerksMetadataHolder, arg3: &mut 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iperks::Perk, arg4: &0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::MapRegistry, arg5: 0x1::string::String, arg6: &0x2::clock::Clock) {
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::perks::validate_perk_name(arg2, arg5);
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::perks::validate_perk_expired(arg3);
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iperks::set_perk_expire_ts(arg3, arg6, 0);
        0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::turf::raid_reset_perk(0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::borrow_map_cap(arg0), 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_mut_player_df<0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::RaidInfo>(arg1, 0x1::string::utf8(b"raid_info")), arg4, arg6);
        0xe660c11d5cddf961e2f153e2e9c89517bdbb2dfa64b9d3aae711672aeb7f240d::game_events::emit_perk_enable_event(0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::borrow_event_cap(arg0), 0x2::object::id<0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::Player>(arg1), 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_player_dvd_id(arg1), 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_player_name(arg1), arg5);
    }

    // decompiled from Move bytecode v6
}

