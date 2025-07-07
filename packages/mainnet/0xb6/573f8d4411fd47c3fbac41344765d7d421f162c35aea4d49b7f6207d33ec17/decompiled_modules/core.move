module 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::core {
    struct TestEvent has copy, drop {
        alive_attacker: vector<0x1::string::String>,
        dead_attacker: vector<0x1::string::String>,
        alive_defender: vector<0x1::string::String>,
        dead_defender: vector<0x1::string::String>,
    }

    public(friend) fun record_blackmail(arg0: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::authority::CapWrapper, arg1: &mut 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iexperience::WeeklyReport, arg2: &0x164bec784f38b486bbee578f9e694de7268db81b08d5a4b85d74feb1d2b01880::crimes_version::Version, arg3: &mut 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::Player, arg4: &mut 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::Player, arg5: &mut 0x95c6aad5cf721dfa4a8d7735522163f1536073851fb23d2ac4e177141fcae364::airdrop::VendettaAirdropNFT, arg6: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ilevel::LevelPointRegistry, arg7: &mut 0x164bec784f38b486bbee578f9e694de7268db81b08d5a4b85d74feb1d2b01880::iblackmail::PlayerBlackmailInfo, arg8: &0x164bec784f38b486bbee578f9e694de7268db81b08d5a4b85d74feb1d2b01880::iblackmail::PlayerBlackmailInfo, arg9: &0x164bec784f38b486bbee578f9e694de7268db81b08d5a4b85d74feb1d2b01880::iblackmail::BlackmailType, arg10: &0x164bec784f38b486bbee578f9e694de7268db81b08d5a4b85d74feb1d2b01880::iblackmail::BlackmailRegistry, arg11: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::authority::Status, arg12: &0x2::clock::Clock, arg13: &0x2::random::Random, arg14: &mut 0x2::tx_context::TxContext) {
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::authority::validate_crime_status(arg11);
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::players::validate_blackmail(arg3, 0x2::object::id<0x164bec784f38b486bbee578f9e694de7268db81b08d5a4b85d74feb1d2b01880::iblackmail::PlayerBlackmailInfo>(arg7));
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::players::validate_blackmail(arg4, 0x2::object::id<0x164bec784f38b486bbee578f9e694de7268db81b08d5a4b85d74feb1d2b01880::iblackmail::PlayerBlackmailInfo>(arg8));
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::players::validate_blackmail_cooldown(arg3, arg4, arg12);
        let (v0, v1, v2, v3, v4, v5) = 0x164bec784f38b486bbee578f9e694de7268db81b08d5a4b85d74feb1d2b01880::blackmail::record_blackmail(0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::authority::borrow_crimes_cap(arg0), arg2, 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ilevel::borrow_level(0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_mut_player_df<0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ilevel::PlayerLevelPoint>(arg3, 0x1::string::utf8(b"level_point"))), 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ilevel::borrow_level(0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_mut_player_df<0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ilevel::PlayerLevelPoint>(arg4, 0x1::string::utf8(b"level_point"))), arg7, arg8, arg9, arg10, 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibuildings::borrow_resource_amount(0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_player_df<0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibuildings::Resources>(arg4, 0x164bec784f38b486bbee578f9e694de7268db81b08d5a4b85d74feb1d2b01880::iblackmail::borrow_blackmail_resource_type(arg9))), arg13, arg14);
        let v6 = 0x1::string::utf8(b"blackmail_attack_cooldown");
        *0x2::vec_map::get_mut<0x1::string::String, u64>(0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_mut_player_timers(arg3), &v6) = 0x2::clock::timestamp_ms(arg12) + v0;
        let v7 = 0x1::string::utf8(b"blackmail_looted_cooldown");
        *0x2::vec_map::get_mut<0x1::string::String, u64>(0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_mut_player_timers(arg4), &v7) = 0x2::clock::timestamp_ms(arg12) + v1;
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::level::add_blackmail_level_point(arg5, arg0, arg3, arg6, v2);
        if (v3 == 0x1::string::utf8(b"cash")) {
            0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::update_player_stats(arg3, 0x1::string::utf8(b"cash_king"), v4);
        } else if (v3 == 0x1::string::utf8(b"weapon")) {
            0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::update_player_stats(arg3, 0x1::string::utf8(b"arms_dealer"), (v4 as u128) / 0x1::u128::pow(2, 64));
        };
        if (v5 && v4 >= 1 * 0x1::u128::pow(2, 64)) {
            0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iexperience::add_to_blackmail_weekly_report(arg1, 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::authority::borrow_event_cap(arg0), 0x2::object::id<0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::Player>(arg3), 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_player_dvd_id(arg3), 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_player_name(arg3), 1, (((v4 as u128) / 0x1::u128::pow(2, 64)) as u64), arg12);
            0x95c6aad5cf721dfa4a8d7735522163f1536073851fb23d2ac4e177141fcae364::airdrop::update_user_game_stats(arg5, 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::authority::borrow_game_cap(arg0), 0x1::string::utf8(b"blackmail"));
            0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::update_player_stats(arg3, 0x1::string::utf8(b"shakedown_artist"), 1);
            let v8 = 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_mut_player_df<0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibuildings::Resources>(arg4, v3);
            0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::buildings::validate_resource_amount(v8, v4);
            0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibuildings::subtract_resource_amount(v8, v4);
            0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibuildings::add_resource_amount(0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_mut_player_df<0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibuildings::Resources>(arg3, v3), v4);
        };
        let v9 = v4 >= 1 && v5;
        0x57c4f34e9f2dfd372fb40326ef82d0a768344e2f2b4e33c062592ff3ad52c6c6::game_events::emit_blackmail_event(0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::authority::borrow_event_cap(arg0), 0x2::object::id<0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::Player>(arg4), 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_player_dvd_id(arg4), 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_player_name(arg4), 0x2::object::id<0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::Player>(arg3), 0x164bec784f38b486bbee578f9e694de7268db81b08d5a4b85d74feb1d2b01880::iblackmail::borrow_blackmail_resource_type(arg9), 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_player_name(arg3), 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_player_dvd_id(arg3), 0x2::clock::timestamp_ms(arg12), v9, v4, 0x164bec784f38b486bbee578f9e694de7268db81b08d5a4b85d74feb1d2b01880::blackmail::calculate_heat_points(v4, v5), (v2 as u128) * 0x1::u128::pow(2, 64));
    }

    public(friend) fun crack_safe(arg0: &mut 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::Player, arg1: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::authority::CapWrapper, arg2: &0x164bec784f38b486bbee578f9e694de7268db81b08d5a4b85d74feb1d2b01880::crimes_version::Version, arg3: 0x2::object::ID, arg4: &mut 0x95c6aad5cf721dfa4a8d7735522163f1536073851fb23d2ac4e177141fcae364::airdrop::VendettaAirdropNFT, arg5: &mut 0x164bec784f38b486bbee578f9e694de7268db81b08d5a4b85d74feb1d2b01880::icrack_safe::Safe, arg6: &0x164bec784f38b486bbee578f9e694de7268db81b08d5a4b85d74feb1d2b01880::icrack_safe::SafeRegistry, arg7: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ilevel::LevelPointRegistry, arg8: &mut 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iexperience::WeeklyReport, arg9: u64, arg10: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::authority::Status, arg11: &0x2::clock::Clock, arg12: &0x2::random::Random, arg13: &mut 0x2::tx_context::TxContext) {
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::authority::validate_crime_status(arg10);
        let v0 = 0x2::object::id<0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::Player>(arg0);
        let v1 = 0x1::string::utf8(b"safe_cooldown");
        let v2 = 0x2::vec_map::get_mut<0x1::string::String, u64>(0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_mut_player_timers(arg0), &v1);
        0x164bec784f38b486bbee578f9e694de7268db81b08d5a4b85d74feb1d2b01880::crack_safe::validate_safe_cooldown(*v2, arg11);
        0x164bec784f38b486bbee578f9e694de7268db81b08d5a4b85d74feb1d2b01880::crack_safe::validate_safe_closed(arg5);
        *v2 = 0x2::clock::timestamp_ms(arg11) + 0x164bec784f38b486bbee578f9e694de7268db81b08d5a4b85d74feb1d2b01880::icrack_safe::borrow_cooldown_ts(arg6);
        let v3 = 0x164bec784f38b486bbee578f9e694de7268db81b08d5a4b85d74feb1d2b01880::crack_safe::borrow_safe_bounds(arg5);
        let v4 = 0x2::random::new_generator(arg12, arg13);
        let v5 = 0x2::random::generate_u64_in_range(&mut v4, *0x1::vector::borrow<u64>(&v3, 0), *0x1::vector::borrow<u64>(&v3, 1));
        let v6 = 0x164bec784f38b486bbee578f9e694de7268db81b08d5a4b85d74feb1d2b01880::crack_safe::validate_guess(0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::authority::borrow_crimes_cap(arg1), arg2, arg6, arg5, arg11, arg9, v5, arg12, arg13);
        let v7 = 0x164bec784f38b486bbee578f9e694de7268db81b08d5a4b85d74feb1d2b01880::icrack_safe::borrow_crack_the_safe_registry(arg6);
        let v8 = if (arg9 == v5) {
            *0x1::vector::borrow<u64>(&v7, 4)
        } else {
            *0x1::vector::borrow<u64>(&v7, 5)
        };
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iexperience::add_to_crack_safe_weekly_report(arg8, 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::authority::borrow_event_cap(arg1), v0, 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_player_dvd_id(arg0), 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_player_name(arg0), 1, v6 == 0x164bec784f38b486bbee578f9e694de7268db81b08d5a4b85d74feb1d2b01880::icrack_safe::guess_won(), arg11);
        let v9 = if (v6 == 0x164bec784f38b486bbee578f9e694de7268db81b08d5a4b85d74feb1d2b01880::icrack_safe::guess_won()) {
            0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::update_player_stats(arg0, 0x1::string::utf8(b"safe_cracker"), 1);
            let v10 = 0x164bec784f38b486bbee578f9e694de7268db81b08d5a4b85d74feb1d2b01880::icrack_safe::borrow_safe_information(arg5);
            0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibuildings::add_resource_amount(0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_mut_player_df<0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibuildings::Resources>(arg0, 0x1::string::utf8(b"cash")), (*0x1::vector::borrow<u64>(&v10, 2) as u128) * 0x1::u128::pow(2, 64));
            0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::update_player_stats(arg0, 0x1::string::utf8(b"cash_king"), (*0x1::vector::borrow<u64>(&v7, 3) as u128) * 0x1::u128::pow(2, 64));
            0x95c6aad5cf721dfa4a8d7735522163f1536073851fb23d2ac4e177141fcae364::airdrop::update_user_game_stats(arg4, 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::authority::borrow_game_cap(arg1), 0x1::string::utf8(b"safe"));
            (*0x1::vector::borrow<u64>(&v7, 3) as u128) * 0x1::u128::pow(2, 64)
        } else {
            0
        };
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::level::add_level_points_to_player(arg4, arg1, arg0, arg7, ((v8 as u128) as u128) * 0x1::u128::pow(2, 64));
        0x57c4f34e9f2dfd372fb40326ef82d0a768344e2f2b4e33c062592ff3ad52c6c6::game_events::emit_crack_safe_event(0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::authority::borrow_event_cap(arg1), v0, arg3, 0x2::object::id<0x164bec784f38b486bbee578f9e694de7268db81b08d5a4b85d74feb1d2b01880::icrack_safe::Safe>(arg5), 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_player_name(arg0), (*0x1::vector::borrow<u64>(&v7, 3) as u128) * 0x1::u128::pow(2, 64), arg9, 0x164bec784f38b486bbee578f9e694de7268db81b08d5a4b85d74feb1d2b01880::icrack_safe::set_status(0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::authority::borrow_crimes_cap(arg1), v6), v9, 0, v8);
    }

    public(friend) fun start_mission(arg0: &mut 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::Player, arg1: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::authority::CapWrapper, arg2: &0x164bec784f38b486bbee578f9e694de7268db81b08d5a4b85d74feb1d2b01880::crimes_version::Version, arg3: 0x2::object::ID, arg4: &mut 0x95c6aad5cf721dfa4a8d7735522163f1536073851fb23d2ac4e177141fcae364::airdrop::VendettaAirdropNFT, arg5: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ilevel::LevelPointRegistry, arg6: &mut 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iexperience::WeeklyReport, arg7: &0x164bec784f38b486bbee578f9e694de7268db81b08d5a4b85d74feb1d2b01880::imission::MissionRegistry, arg8: &mut 0x164bec784f38b486bbee578f9e694de7268db81b08d5a4b85d74feb1d2b01880::imission::MissionInfo, arg9: u64, arg10: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::authority::Status, arg11: &0x2::clock::Clock, arg12: &0x2::random::Random, arg13: &mut 0x2::tx_context::TxContext) {
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::authority::validate_crime_status(arg10);
        0x164bec784f38b486bbee578f9e694de7268db81b08d5a4b85d74feb1d2b01880::mission::validate_player_mission_info(0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_mission_info(arg0), 0x2::object::id<0x164bec784f38b486bbee578f9e694de7268db81b08d5a4b85d74feb1d2b01880::imission::MissionInfo>(arg8));
        let (v0, v1, v2) = 0x164bec784f38b486bbee578f9e694de7268db81b08d5a4b85d74feb1d2b01880::mission::start_mission(0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::authority::borrow_crimes_cap(arg1), arg2, arg7, arg8, arg9, arg11, arg12, 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ilevel::borrow_level(0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_mut_player_df<0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ilevel::PlayerLevelPoint>(arg0, 0x1::string::utf8(b"level_point"))), arg13);
        let v3 = v2;
        let v4 = v1;
        let v5 = 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_mut_player_timers(arg0);
        let v6 = 0x1::string::utf8(b"mission_cooldown");
        assert!(0x2::vec_map::contains<0x1::string::String, u64>(v5, &v6), 1234);
        let v7 = 0x2::vec_map::get_mut<0x1::string::String, u64>(v5, &v6);
        assert!(0x2::clock::timestamp_ms(arg11) > *v7, 2234);
        let v8 = 0x2::clock::timestamp_ms(arg11) + *0x1::vector::borrow<u64>(&v4, 2);
        *v7 = v8;
        let v9 = if (v0) {
            0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iexperience::add_to_mission_weekly_report(arg6, 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::authority::borrow_event_cap(arg1), 0x2::object::id<0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::Player>(arg0), 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_player_dvd_id(arg0), 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_player_name(arg0), 1, ((1 / 0x1::u128::pow(2, 64)) as u64), arg11);
            0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibuildings::add_resource_amount(0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_mut_player_df<0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibuildings::Resources>(arg0, 0x1::string::utf8(b"cash")), *0x1::vector::borrow<u128>(&v3, 0));
            0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibuildings::add_resource_amount(0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_mut_player_df<0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibuildings::Resources>(arg0, 0x1::string::utf8(b"weapon")), *0x1::vector::borrow<u128>(&v3, 1));
            0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::level::add_mission_level_point(arg4, arg1, arg0, arg5, *0x1::vector::borrow<u64>(&v4, 7));
            *0x1::vector::borrow<u64>(&v4, 7)
        } else {
            0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::level::add_mission_level_point(arg4, arg1, arg0, arg5, *0x1::vector::borrow<u64>(&v4, 8));
            *0x1::vector::borrow<u64>(&v4, 8)
        };
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::update_player_stats(arg0, 0x1::string::utf8(b"cash_king"), *0x1::vector::borrow<u128>(&v3, 0));
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::update_player_stats(arg0, 0x1::string::utf8(b"arms_dealer"), (*0x1::vector::borrow<u128>(&v3, 1) as u128) / 0x1::u128::pow(2, 64));
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::update_player_stats(arg0, 0x1::string::utf8(b"scavenger"), 1);
        0x57c4f34e9f2dfd372fb40326ef82d0a768344e2f2b4e33c062592ff3ad52c6c6::game_events::emit_mission_event(0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::authority::borrow_event_cap(arg1), 0x2::object::id<0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::Player>(arg0), arg3, 0x2::object::id<0x164bec784f38b486bbee578f9e694de7268db81b08d5a4b85d74feb1d2b01880::imission::MissionInfo>(arg8), 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_player_name(arg0), v0, *0x1::vector::borrow<u128>(&v3, 1), *0x1::vector::borrow<u128>(&v3, 0), v8, (v9 as u128) * 0x1::u128::pow(2, 64));
    }

    public(friend) fun upgrade_building(arg0: &mut 0x95c6aad5cf721dfa4a8d7735522163f1536073851fb23d2ac4e177141fcae364::airdrop::VendettaAirdropNFT, arg1: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::authority::CapWrapper, arg2: &mut 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::Player, arg3: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibuildings::BuildingRegistry, arg4: 0x1::string::String, arg5: &0x2::clock::Clock) {
        let v0 = 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_total_owned_turf_count(arg2);
        let v1 = 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::remove_player_df<0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibuildings::BuildingInfo>(arg2, arg4);
        claim_resources(arg1, arg2, arg4, arg5);
        let v2 = 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibuildings::borrow_building_upgrade_cost(&v1);
        let v3 = 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibuildings::borrow_upgrade_info(v2);
        let v4 = 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibuildings::borrow_upgrade_info(v2);
        let v5 = 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_mut_player_df<0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibuildings::Resources>(arg2, 0x1::string::utf8(b"cash"));
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::buildings::pre_upgrade_cash_validation(v2, 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibuildings::borrow_resource_amount(v5), v0);
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibuildings::subtract_resource_amount(v5, *0x1::vector::borrow<u128>(&v3, 0));
        let v6 = 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_mut_player_df<0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibuildings::Resources>(arg2, 0x1::string::utf8(b"weapon"));
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::buildings::pre_upgrade_weapon_validation(v2, 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibuildings::borrow_resource_amount(v6));
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibuildings::subtract_resource_amount(v6, *0x1::vector::borrow<u128>(&v4, 2));
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::buildings::upgrade_building(&mut v1, arg3, arg4, arg5);
        0x57c4f34e9f2dfd372fb40326ef82d0a768344e2f2b4e33c062592ff3ad52c6c6::game_events::upgrade_building_event(0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::authority::borrow_event_cap(arg1), 0x2::object::id<0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::Player>(arg2), 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_player_dvd_id(arg2), 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_player_name(arg2), arg4, 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibuildings::borrow_building_level(&v1));
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::add_player_df<0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibuildings::BuildingInfo>(arg2, arg4, v1);
        0x95c6aad5cf721dfa4a8d7735522163f1536073851fb23d2ac4e177141fcae364::airdrop::update_user_game_stats(arg0, 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::authority::borrow_game_cap(arg1), 0x1::string::utf8(b"building"));
    }

    public(friend) fun assign_headquarter(arg0: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::authority::CapWrapper, arg1: &mut 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::Player, arg2: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::authority::Status, arg3: &mut 0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::iturf::MapConfig, arg4: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibuildings::BuildingRegistry, arg5: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::PlayersRegistry, arg6: &mut 0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::iturf::TurfSystem, arg7: &0x2::random::Random, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::Player>(arg1);
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::authority::validate_onboarding_status(arg2);
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::players::validate_headquarter_assign(arg1);
        let v1 = 0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::turf::create_headquarter(0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::authority::borrow_map_cap(arg0), v0, arg3, arg6, 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_initial_hq_garrison_limit(arg5), 0, arg7, arg8);
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::set_headquarter(arg1, v1);
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::set_owned_turf(arg1, v1);
        let (v2, v3) = 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::players::initialize_buildings(arg4);
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::add_player_df<0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibuildings::BuildingInfo>(arg1, 0x1::string::utf8(b"cash_operation"), v2);
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::add_player_df<0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibuildings::BuildingInfo>(arg1, 0x1::string::utf8(b"arms_dealership"), v3);
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::update_player_stats(arg1, 0x1::string::utf8(b"territory_boss"), 1);
        0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::iturf::emit_headquarter_assigned_event(v0, 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_player_dvd_id(arg1), 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_player_name(arg1), v1);
    }

    public(friend) fun attack_free_turf(arg0: &mut 0x95c6aad5cf721dfa4a8d7735522163f1536073851fb23d2ac4e177141fcae364::airdrop::VendettaAirdropNFT, arg1: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::authority::CapWrapper, arg2: &mut 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::Player, arg3: u64, arg4: bool, arg5: u64, arg6: bool, arg7: u64, arg8: bool, arg9: u64, arg10: bool, arg11: &mut 0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::iturf::TurfInformation, arg12: vector<0x1::string::String>, arg13: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::igangsters::GangsterBaseStats, arg14: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibattle::DamageMultiplier, arg15: &mut 0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::iturf::TurfSystem, arg16: &mut 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibattle::PlayerBattleStats, arg17: &mut 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iexperience::WeeklyReport, arg18: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ilevel::LevelPointRegistry, arg19: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::isystem::SystemConfig, arg20: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::authority::Status, arg21: &0x2::clock::Clock, arg22: &0x2::random::Random, arg23: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::Player>(arg2);
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::authority::validate_battle_status(arg20);
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::perks::validate_protection_perk(arg2, arg21);
        0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::turf::validate_new_turf(arg3, arg4, arg5, arg6, arg15);
        0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::turf::validate_turf_exists(arg7, arg8, arg9, arg10, arg15);
        let v1 = 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_total_owned_turf_count(arg2);
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::players::validate_feed_people(arg2, arg21);
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::players::validate_defender_neighbor(arg2, 0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::iturf::borrow_turf_id(arg15, arg7, arg8, arg9, arg10));
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::battle::reverse_attack_count(arg2, arg16, arg19, arg21);
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::battle::validate_scouts_count(0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_player_df<0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibuildings::Resources>(arg2, 0x1::string::utf8(b"scouts")), v1);
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::battle::validate_attacker_count(0x1::vector::length<0x1::string::String>(&arg12));
        0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::turf::validate_chebyshev_distance(arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        let v2 = 0x2::random::new_generator(arg22, arg23);
        0x2::random::shuffle<0x1::string::String>(&mut v2, &mut arg12);
        let v3 = 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::battle::generate_bot_defenses(arg22, (v1 as u128), arg16, arg23);
        0x1::vector::reverse<0x1::string::String>(&mut arg12);
        let (v4, _) = 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::battle::generate_gangster_units(arg12, arg13, 11111, arg21);
        let (v6, _) = 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::battle::generate_gangster_units(v3, arg13, 44444, arg21);
        let (v8, v9, v10, v11, v12, v13) = 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::battle::start_simulation(&mut arg12, &mut v3, v4, v6, arg14, arg22, arg23);
        let v14 = v11;
        let v15 = v10;
        let v16 = TestEvent{
            alive_attacker : v12,
            dead_attacker  : v15,
            alive_defender : v13,
            dead_defender  : v14,
        };
        0x2::event::emit<TestEvent>(v16);
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iexperience::add_to_gangster_elimination_weekly_report(arg17, 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::authority::borrow_event_cap(arg1), v0, 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_player_dvd_id(arg2), 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_player_name(arg2), 0x1::vector::length<0x1::string::String>(&v14), arg21);
        if (v9 == 1) {
            0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibattle::set_recent_lost(arg16, 0);
            let v17 = 0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::iturf::new_turf_from_coordinate(0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::authority::borrow_map_cap(arg1), 0x2::object::id<0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::Player>(arg2), arg3, arg4, arg5, arg6, 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::igangsters::borrow_unit_types(arg13), v12, arg23);
            let v18 = 0x2::object::id<0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::iturf::TurfInformation>(&v17);
            0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::set_owned_turf(arg2, v18);
            0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iexperience::update_to_current_turf_count_weekly_report(arg17, 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::authority::borrow_event_cap(arg1), v0, 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_player_dvd_id(arg2), 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_player_name(arg2), 1, true, arg21);
            0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::iturf::add_coordinate_in_system(0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::authority::borrow_map_cap(arg1), arg15, 0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::iturf::new_coordinates(arg3, arg4, arg5, arg6), v18);
            0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibattle::increase_won_battle_count(arg16);
            0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibattle::increase_recent_occupied_turf_count(arg16);
            0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::players::set_gangsters_count(arg2, arg19);
            0x95c6aad5cf721dfa4a8d7735522163f1536073851fb23d2ac4e177141fcae364::airdrop::update_user_game_stats(arg0, 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::authority::borrow_game_cap(arg1), 0x1::string::utf8(b"turf"));
            0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::update_player_stats(arg2, 0x1::string::utf8(b"territory_boss"), 1);
            0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::iturf::share_turf(0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::authority::borrow_map_cap(arg1), v17);
        } else {
            let v19 = 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibattle::borrow_player_battle_stats(arg16);
            0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibattle::set_recent_lost(arg16, *0x1::vector::borrow<u64>(&v19, 4) + 1);
        };
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibattle::increase_total_battles_count(arg16);
        0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::turf::remove_warrior_gangster(0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::authority::borrow_map_cap(arg1), arg11, arg12);
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::players::remove_warrior_gangsters(arg2, v15);
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibattle::emit_simulation_result_event(0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibattle::new_result_simulation(v9, 2, v0, 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_player_dvd_id(arg2), 0x1::option::none<0x2::object::ID>(), 0x1::option::none<0x2::object::ID>(), 0x1::option::none<0x2::object::ID>(), 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_player_name(arg2), 0x1::option::none<0x1::string::String>(), 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibattle::new_raided_resources(0, 0, 0), 0, 0, v8, v4, v6, 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::level::add_battle_level_points(arg0, arg1, arg2, arg18, 0x1::string::utf8(b"attack"), 0x1::vector::length<0x1::string::String>(&v15), 2, (v9 as u64), 1, arg22, arg23)));
    }

    public(friend) fun attack_owned_turf(arg0: &mut 0x95c6aad5cf721dfa4a8d7735522163f1536073851fb23d2ac4e177141fcae364::airdrop::VendettaAirdropNFT, arg1: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::authority::CapWrapper, arg2: &mut 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::Player, arg3: &mut 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::Player, arg4: u64, arg5: bool, arg6: u64, arg7: bool, arg8: &mut 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibattle::PlayerBattleStats, arg9: &mut 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibattle::PlayerBattleStats, arg10: &mut 0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::iturf::TurfInformation, arg11: &mut 0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::iturf::TurfInformation, arg12: vector<0x1::string::String>, arg13: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::igangsters::GangsterBaseStats, arg14: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibattle::DamageMultiplier, arg15: &0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::iturf::TurfSystem, arg16: &mut 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iexperience::WeeklyReport, arg17: &mut 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iexperience::WeeklyReport, arg18: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::isystem::SystemConfig, arg19: u8, arg20: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ilevel::LevelPointRegistry, arg21: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::authority::Status, arg22: &0x2::clock::Clock, arg23: &0x2::random::Random, arg24: &mut 0x2::tx_context::TxContext) {
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::authority::validate_crime_status(arg21);
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::perks::validate_protection_perk(arg2, arg22);
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::players::validate_battle_perks_and_cooldown(arg3, arg22);
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::players::validate_players_stats(arg2, arg8);
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::players::validate_players_stats(arg3, arg9);
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::players::validate_feed_people(arg2, arg22);
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::battle::validate_attacker_count(0x1::vector::length<0x1::string::String>(&arg12));
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::battle::reverse_attack_count(arg2, arg8, arg18, arg22);
        0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::turf::validate_turf_cooldown(arg11, arg22);
        let v0 = 0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::turf::borrow_turf_id_if_exists(arg4, arg5, arg6, arg7, arg15);
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::players::validate_defender_neighbor(arg2, *0x1::option::borrow<0x2::object::ID>(&v0));
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::battle::validate_attack_type(arg19);
        let (_, _, v3, v4, v5, v6, _, _) = 0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::iturf::borrow_turf_information(arg11);
        0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::turf::validate_chebyshev_distance(arg4, arg5, arg6, arg7, v3, v4, v5, v6);
        let v9 = 0x2::random::new_generator(arg23, arg24);
        0x2::random::shuffle<0x1::string::String>(&mut v9, &mut arg12);
        0x1::vector::reverse<0x1::string::String>(&mut arg12);
        let (v10, v11) = 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::battle::generate_gangster_units(arg12, arg13, 11111, arg22);
        let (v12, v13, v14) = 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::battle::generate_defender_gangsters(arg11, arg13, 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::igangsters::borrow_unit_types(arg13), arg22);
        let v15 = v14;
        let (v16, v17, v18, v19, v20, v21) = 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::battle::start_simulation(&mut arg12, &mut v15, v10, v12, arg14, arg23, arg24);
        let v22 = v19;
        let v23 = v18;
        let (v24, v25, v26) = 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::battle::process_battle_result(arg0, arg1, arg2, arg3, arg10, arg11, arg15, arg18, arg8, arg9, arg12, arg13, v17, arg19, v23, v22, v20, v21, v11, v13, arg23, arg22, arg24);
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iexperience::add_to_gangster_elimination_weekly_report(arg16, 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::authority::borrow_event_cap(arg1), 0x2::object::id<0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::Player>(arg2), 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_player_dvd_id(arg2), 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_player_name(arg2), 0x1::vector::length<0x1::string::String>(&v22), arg22);
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iexperience::add_to_gangster_elimination_weekly_report(arg17, 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::authority::borrow_event_cap(arg1), 0x2::object::id<0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::Player>(arg3), 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_player_dvd_id(arg3), 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_player_name(arg2), 0x1::vector::length<0x1::string::String>(&v23), arg22);
        if (v17 == 1 && (arg19 == 2 || arg19 == 3)) {
            0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iexperience::update_to_current_turf_count_weekly_report(arg16, 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::authority::borrow_event_cap(arg1), 0x2::object::id<0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::Player>(arg2), 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_player_dvd_id(arg2), 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_player_name(arg2), 1, true, arg22);
            0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iexperience::update_to_current_turf_count_weekly_report(arg17, 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::authority::borrow_event_cap(arg1), 0x2::object::id<0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::Player>(arg3), 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_player_dvd_id(arg3), 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_player_name(arg2), 1, false, arg22);
        };
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iexperience::increase_xp(0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_mut_player_df<0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iexperience::Experience>(arg2, 0x1::string::utf8(b"experience")), v26);
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibattle::emit_simulation_result_event(0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibattle::new_result_simulation(v17, arg19, 0x2::object::id<0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::Player>(arg2), 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_player_dvd_id(arg2), 0x1::option::some<0x2::object::ID>(0x2::object::id<0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::Player>(arg3)), 0x1::option::some<0x2::object::ID>(0x2::object::id<0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::iturf::TurfInformation>(arg11)), 0x1::option::some<0x2::object::ID>(0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_player_dvd_id(arg3)), 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_player_name(arg2), 0x1::option::some<0x1::string::String>(0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_player_name(arg3)), 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibattle::new_raided_resources(v24, v25, v26), 0, 0, v16, v10, v12, 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::level::add_battle_level_points(arg0, arg1, arg2, arg20, 0x1::string::utf8(b"attack"), 0x1::vector::length<0x1::string::String>(&v22), (arg19 as u64), (v17 as u64), 0, arg23, arg24)));
    }

    public(friend) fun buy_perk(arg0: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::authority::CapWrapper, arg1: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::Player, arg2: &0x95c6aad5cf721dfa4a8d7735522163f1536073851fb23d2ac4e177141fcae364::vendetta_version::Version, arg3: &mut 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iperks::PerksMetadataHolder, arg4: &mut 0x95c6aad5cf721dfa4a8d7735522163f1536073851fb23d2ac4e177141fcae364::vendetta::CoinRegistry, arg5: 0x2::coin::Coin<0x95c6aad5cf721dfa4a8d7735522163f1536073851fb23d2ac4e177141fcae364::vendetta::VENDETTA>, arg6: 0x1::string::String, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x95c6aad5cf721dfa4a8d7735522163f1536073851fb23d2ac4e177141fcae364::vendetta::VENDETTA>(&arg5);
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::perks::validate_perk_name(arg3, arg6);
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::perks::validate_perk_price(arg3, arg6, v0, arg7);
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::perks::update_supply(arg3, arg6, arg7);
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::perks::validate_supply(arg3, arg6);
        0x95c6aad5cf721dfa4a8d7735522163f1536073851fb23d2ac4e177141fcae364::vendetta::burn(arg4, 0x2::coin::split<0x95c6aad5cf721dfa4a8d7735522163f1536073851fb23d2ac4e177141fcae364::vendetta::VENDETTA>(&mut arg5, (0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::utils::percentage_calculation((v0 as u128), 7000) as u64), arg9), arg2);
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::perks::reset_supply(arg3, arg6, arg8);
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::perks::transfer_coin<0x95c6aad5cf721dfa4a8d7735522163f1536073851fb23d2ac4e177141fcae364::vendetta::VENDETTA>(arg3, arg5);
        while (arg7 > 0) {
            0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iperks::transfer_perk(0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iperks::new(arg3, arg6, arg9), arg9);
            arg7 = arg7 - 1;
        };
        0x57c4f34e9f2dfd372fb40326ef82d0a768344e2f2b4e33c062592ff3ad52c6c6::game_events::emit_perk_enable_event(0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::authority::borrow_event_cap(arg0), 0x2::object::id<0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::Player>(arg1), 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_player_dvd_id(arg1), 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_player_name(arg1), arg6);
    }

    public(friend) fun change_player_name(arg0: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::authority::CapWrapper, arg1: &mut 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::Player, arg2: 0x1::string::String) {
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::set_profile_name(arg1, arg2);
        0x57c4f34e9f2dfd372fb40326ef82d0a768344e2f2b4e33c062592ff3ad52c6c6::game_events::emit_change_player_name_event(0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::authority::borrow_event_cap(arg0), 0x2::object::id<0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::Player>(arg1), 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_player_dvd_id(arg1), 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_player_name(arg1), arg2);
    }

    public(friend) fun change_profile_picture(arg0: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::authority::CapWrapper, arg1: &mut 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::Player, arg2: 0x1::string::String) {
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::set_profile_picture(arg1, arg2);
        0x57c4f34e9f2dfd372fb40326ef82d0a768344e2f2b4e33c062592ff3ad52c6c6::game_events::emit_change_profile_pic_event(0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::authority::borrow_event_cap(arg0), 0x2::object::id<0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::Player>(arg1), 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_player_dvd_id(arg1), 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_player_name(arg1), arg2);
    }

    public(friend) fun claim_resources(arg0: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::authority::CapWrapper, arg1: &mut 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::Player, arg2: 0x1::string::String, arg3: &0x2::clock::Clock) {
        let v0 = 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::remove_player_df<0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibuildings::BuildingInfo>(arg1, arg2);
        let v1 = 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibuildings::borrow_building_production_type(&v0);
        let v2 = 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_mut_player_df<0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibuildings::Resources>(arg1, v1);
        let v3 = 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibuildings::borrow_building_info(&v0);
        let v4 = 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibuildings::borrow_building_info(&v0);
        let v5 = 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::buildings::calculate_production(0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::players::borrow_perk_ts(arg1, 0x1::string::utf8(b"boost_production")), 0x2::clock::timestamp_ms(arg3), 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibuildings::borrow_last_claimed_ts(v2), *0x1::vector::borrow<u128>(&v3, 0), *0x1::vector::borrow<u128>(&v4, 1));
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibuildings::add_resource_amount(v2, v5);
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibuildings::reset_claim_timestamp(v2, arg3);
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::add_player_df<0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibuildings::BuildingInfo>(arg1, arg2, v0);
        if (arg2 == 0x1::string::utf8(b"cash_operation")) {
            0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::update_player_stats(arg1, 0x1::string::utf8(b"cash_king"), v5);
        };
        if (arg2 == 0x1::string::utf8(b"arms_dealership")) {
            0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::update_player_stats(arg1, 0x1::string::utf8(b"arms_dealer"), (v5 as u128) / 0x1::u128::pow(2, 64));
        };
        0x57c4f34e9f2dfd372fb40326ef82d0a768344e2f2b4e33c062592ff3ad52c6c6::game_events::emit_claim_resource_event(0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::authority::borrow_event_cap(arg0), 0x2::object::id<0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::Player>(arg1), 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_player_dvd_id(arg1), 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_player_name(arg1), arg2, v1, v5);
    }

    public(friend) fun claim_weekly_report(arg0: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::authority::CapWrapper, arg1: &mut 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::Player, arg2: &mut 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iexperience::WeeklyReport, arg3: &mut 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iexperience::XPBonusConfig, arg4: &0x2::clock::Clock) {
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::players::validate_weekly_report(arg1, 0x2::object::id<0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iexperience::WeeklyReport>(arg2));
        let v0 = 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iexperience::get_xp(arg3, arg2, 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::authority::borrow_event_cap(arg0), 0x2::object::id<0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::Player>(arg1), 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_player_dvd_id(arg1), 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_player_name(arg1), arg4);
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iexperience::increase_xp(0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_mut_player_df<0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iexperience::Experience>(arg1, 0x1::string::utf8(b"experience")), v0);
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iexperience::update_report_ts(arg2, 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::authority::borrow_event_cap(arg0), 0x2::object::id<0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::Player>(arg1), 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_player_dvd_id(arg1), 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_player_name(arg1), arg4);
        0x57c4f34e9f2dfd372fb40326ef82d0a768344e2f2b4e33c062592ff3ad52c6c6::game_events::emit_weekly_report_claim_event(0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::authority::borrow_event_cap(arg0), 0x2::object::id<0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::Player>(arg1), 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_player_dvd_id(arg1), 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_player_name(arg1), v0);
    }

    public(friend) fun create_player(arg0: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::authority::CapWrapper, arg1: 0x2::object::ID, arg2: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::version::Version, arg3: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::authority::Status, arg4: 0x1::string::String, arg5: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ilevel::LevelPointRegistry, arg6: &mut 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::PlayersRegistry, arg7: &mut 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::isystem::SystemConfig, arg8: &0x164bec784f38b486bbee578f9e694de7268db81b08d5a4b85d74feb1d2b01880::imission::MissionRegistry, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::version::validate_version(arg2);
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::authority::validate_onboarding_status(arg3);
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::players::validate_player_name(arg4);
        let v0 = 0x164bec784f38b486bbee578f9e694de7268db81b08d5a4b85d74feb1d2b01880::iblackmail::new_blackmail_info(0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::authority::borrow_crimes_cap(arg0), arg10);
        let v1 = 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::new(arg1, 0x1::string::utf8(b""), arg4, 0x2::object::id_from_address(@0x0), 0x1::vector::empty<0x2::object::ID>(), 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_initial_hq_garrison_limit(arg6), 0x2::object::id_from_address(@0x0), 0x2::object::id<0x164bec784f38b486bbee578f9e694de7268db81b08d5a4b85d74feb1d2b01880::iblackmail::PlayerBlackmailInfo>(&v0), 0xecf2c9925a01015e98d274ebb68629f09896d87c707b4cbe0061bd452eba5aa1::swap::create_swap_points(0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::authority::borrow_swap_cap(arg0), arg10), 0x164bec784f38b486bbee578f9e694de7268db81b08d5a4b85d74feb1d2b01880::imission::new_mission_info(0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::authority::borrow_crimes_cap(arg0), arg8, arg9, arg10), 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iexperience::init_player_report(arg9, arg10), 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::idaily_checkin::new_check_in_streak(arg10), arg9, arg10);
        0x164bec784f38b486bbee578f9e694de7268db81b08d5a4b85d74feb1d2b01880::iblackmail::share_blackmail(0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::authority::borrow_crimes_cap(arg0), v0);
        let v2 = 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibattle::new_player_battle_stats(arg9, arg10);
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::isystem::increase_active_scout_supply(arg7, 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_initial_scouts(arg6));
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::add_player_df<0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibuildings::Resources>(&mut v1, 0x1::string::utf8(b"weapon"), 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibuildings::new((0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_initial_weapon(arg6) as u128) * 0x1::u128::pow(2, 64), 0x1::string::utf8(b"arms_dealership"), arg9));
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::add_player_df<0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibuildings::Resources>(&mut v1, 0x1::string::utf8(b"cash"), 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibuildings::new((0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_initial_cash(arg6) as u128) * 0x1::u128::pow(2, 64), 0x1::string::utf8(b"cash_operation"), arg9));
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::add_player_df<0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibuildings::Resources>(&mut v1, 0x1::string::utf8(b"scouts"), 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibuildings::new((0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_initial_scouts(arg6) as u128) * 0x1::u128::pow(2, 64), 0x1::string::utf8(b"scouts"), arg9));
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::add_player_df<0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ilevel::PlayerLevelPoint>(&mut v1, 0x1::string::utf8(b"level_point"), 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ilevel::new_level_point(0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ilevel::level_point_required(arg5, 1)));
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::add_player_df<0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iexperience::Experience>(&mut v1, 0x1::string::utf8(b"experience"), 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iexperience::new_experience());
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::add_player_df<0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iaccolades::Accolade>(&mut v1, 0x1::string::utf8(b"accolade"), 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iaccolades::new_accolade());
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::initialize_player_timers(&mut v1, arg6, 0x2::object::id<0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibattle::PlayerBattleStats>(&v2), arg9);
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::players::initialize_perks(&mut v1, 0, 0x1::string::utf8(b"newbie_protection"));
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::players::initialize_perks(&mut v1, 0, 0x1::string::utf8(b"boost_production"));
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::players::initialize_perks(&mut v1, 0, 0x1::string::utf8(b"attack_protection"));
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::players::initialize_perks(&mut v1, 0, 0x1::string::utf8(b"blackmail_protection"));
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::players::initialize_perks(&mut v1, 0, 0x1::string::utf8(b"attack_reset"));
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::share_player(v1);
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibattle::share_player_battle_stats(v2);
        0x2::object::id<0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::Player>(&v1)
    }

    public(friend) fun daily_check_in(arg0: &mut 0x95c6aad5cf721dfa4a8d7735522163f1536073851fb23d2ac4e177141fcae364::airdrop::VendettaAirdropNFT, arg1: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::authority::CapWrapper, arg2: &mut 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::Player, arg3: &mut 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::idaily_checkin::DailyCheckInStreak, arg4: &mut 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::idaily_checkin::SevenDaysCheckInRewardsRegistry, arg5: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ilevel::LevelPointRegistry, arg6: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg6);
        let v1 = 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::idaily_checkin::borrow_dailystreak_last_checkedin_ts(arg3);
        let (v2, v3, v4) = 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::daily_checkin::get_7days_checkin_reward(arg4, arg3, v0, v1);
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::daily_checkin::distribute_7days_rewards(arg0, arg1, arg2, arg5, v2, 0x1::vector::empty<0x1::string::String>(), v3, 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::idaily_checkin::borrow_dailystreak_count(arg3), v0, 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_player_dvd_id(arg2));
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::daily_checkin::check_in(arg3, v0, v1, v4);
    }

    public(friend) fun enable_perk(arg0: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::authority::CapWrapper, arg1: &mut 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::Player, arg2: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iperks::PerksMetadataHolder, arg3: &mut 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iperks::Perk, arg4: 0x1::string::String, arg5: &0x2::clock::Clock) {
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::perks::validate_perk_name(arg2, arg4);
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::perks::validate_perk_expired(arg3);
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::perks::validate_active_perk(arg1, arg4, arg5);
        let v0 = 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iperks::borrow_perk_life(arg3);
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iperks::set_perk_expire_ts(arg3, arg5, v0);
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::players::update_player_perk_ts(arg1, arg4, v0, arg5);
        0x57c4f34e9f2dfd372fb40326ef82d0a768344e2f2b4e33c062592ff3ad52c6c6::game_events::emit_perk_enable_event(0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::authority::borrow_event_cap(arg0), 0x2::object::id<0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::Player>(arg1), 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_player_dvd_id(arg1), 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_player_name(arg1), arg4);
    }

    public(friend) fun feed(arg0: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::authority::CapWrapper, arg1: &mut 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::Player, arg2: &0x95c6aad5cf721dfa4a8d7735522163f1536073851fb23d2ac4e177141fcae364::vendetta_version::Version, arg3: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::FeedRegistry, arg4: &mut 0xecf2c9925a01015e98d274ebb68629f09896d87c707b4cbe0061bd452eba5aa1::swap::GameRewardPool, arg5: &mut 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iexperience::WeeklyReport, arg6: &mut 0x95c6aad5cf721dfa4a8d7735522163f1536073851fb23d2ac4e177141fcae364::vendetta::CoinRegistry, arg7: 0x1::option::Option<0x2::coin::Coin<0x95c6aad5cf721dfa4a8d7735522163f1536073851fb23d2ac4e177141fcae364::vendetta::VENDETTA>>, arg8: &0x2::clock::Clock, arg9: &0x2::random::Random, arg10: &mut 0x2::tx_context::TxContext) {
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::players::validate_feed_people(arg1, arg8);
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::players::validate_weekly_report(arg1, 0x2::object::id<0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iexperience::WeeklyReport>(arg5));
        let v0 = 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_feed_registry_values(arg3);
        let v1 = 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::players::calculate_base_cost(arg1, arg3);
        let v2 = 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_mut_player_df<0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibuildings::Resources>(arg1, 0x1::string::utf8(b"cash"));
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::buildings::validate_resource_amount(v2, v1);
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibuildings::subtract_resource_amount(v2, v1);
        let v3 = 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::players::calculate_new_recruits(arg1, arg3);
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::increase_recruit_count(arg1, v3);
        let (v4, v5) = if (0x1::option::is_some<0x2::coin::Coin<0x95c6aad5cf721dfa4a8d7735522163f1536073851fb23d2ac4e177141fcae364::vendetta::VENDETTA>>(&arg7)) {
            let v6 = 0x1::option::destroy_some<0x2::coin::Coin<0x95c6aad5cf721dfa4a8d7735522163f1536073851fb23d2ac4e177141fcae364::vendetta::VENDETTA>>(arg7);
            let v7 = 0x2::coin::value<0x95c6aad5cf721dfa4a8d7735522163f1536073851fb23d2ac4e177141fcae364::vendetta::VENDETTA>(&v6);
            0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::players::validate_feed_coin(v7, *0x1::vector::borrow<u64>(&v0, 3), false);
            0x95c6aad5cf721dfa4a8d7735522163f1536073851fb23d2ac4e177141fcae364::vendetta::burn(arg6, v6, arg2);
            0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iexperience::add_to_feed_people_weekly_report(arg5, 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::authority::borrow_event_cap(arg0), 0x2::object::id<0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::Player>(arg1), 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_player_dvd_id(arg1), 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_player_name(arg1), 1, arg8);
            let v8 = 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::players::calculate_xp_feed_xp_gain(arg9, v3, arg10);
            0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iexperience::increase_xp(0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_mut_player_df<0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iexperience::Experience>(arg1, 0x1::string::utf8(b"experience")), v8);
            0xecf2c9925a01015e98d274ebb68629f09896d87c707b4cbe0061bd452eba5aa1::swap::add_reserve_xp(0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::authority::borrow_swap_cap(arg0), arg4, (((v8 as u128) / 0x1::u128::pow(2, 64)) as u64));
            (v8, v7)
        } else {
            0x1::option::destroy_none<0x2::coin::Coin<0x95c6aad5cf721dfa4a8d7735522163f1536073851fb23d2ac4e177141fcae364::vendetta::VENDETTA>>(arg7);
            (0, 0)
        };
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::players::update_timer(arg1, 0x1::string::utf8(b"feed_people"), *0x1::vector::borrow<u64>(&v0, 2) + 0x2::clock::timestamp_ms(arg8));
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::update_player_stats(arg1, 0x1::string::utf8(b"badge_flipper"), 1);
        0x57c4f34e9f2dfd372fb40326ef82d0a768344e2f2b4e33c062592ff3ad52c6c6::game_events::emit_feed_people_event(0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::authority::borrow_event_cap(arg0), 0x2::object::id<0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::Player>(arg1), 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_player_dvd_id(arg1), 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_player_name(arg1), v3, v1, v4, v5);
    }

    public(friend) fun hire_scouts(arg0: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::authority::CapWrapper, arg1: &mut 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::Player, arg2: &mut 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::isystem::SystemConfig, arg3: u64, arg4: &0x2::clock::Clock) {
        let v0 = ((60 * arg3) as u128) * 0x1::u128::pow(2, 64);
        let v1 = 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_mut_player_df<0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibuildings::Resources>(arg1, 0x1::string::utf8(b"cash"));
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::buildings::validate_resource_amount(v1, v0);
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibuildings::subtract_resource_amount(v1, v0);
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibuildings::add_resource_amount(0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_mut_player_df<0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibuildings::Resources>(arg1, 0x1::string::utf8(b"scouts")), (arg3 as u128) * 0x1::u128::pow(2, 64));
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::players::validate_hire_scouts_cooldown(arg1, arg4);
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::isystem::calculate_scout_supply(arg2, arg3, arg4);
        0x57c4f34e9f2dfd372fb40326ef82d0a768344e2f2b4e33c062592ff3ad52c6c6::game_events::emit_hire_scout_event(0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::authority::borrow_event_cap(arg0), 0x2::object::id<0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::Player>(arg1), 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_player_dvd_id(arg1), 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_player_name(arg1), v0, arg3);
    }

    public(friend) fun late_daily_check_in(arg0: &mut 0x95c6aad5cf721dfa4a8d7735522163f1536073851fb23d2ac4e177141fcae364::airdrop::VendettaAirdropNFT, arg1: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::authority::CapWrapper, arg2: &mut 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::Player, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::idaily_checkin::DailyCheckInStreak, arg5: &mut 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::idaily_checkin::SevenDaysCheckInRewardsRegistry, arg6: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::isystem::SystemConfig, arg7: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ilevel::LevelPointRegistry, arg8: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg8);
        let v1 = 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::daily_checkin::get_missed_days(arg4, arg5, v0);
        let (_, v3) = 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::idaily_checkin::get_7days_max_missed_and_cost(arg5);
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::daily_checkin::validate_v_cost_last_signed_in(v3, 0x2::coin::value<0x2::sui::SUI>(&arg3), 0x1::vector::length<0x1::string::String>(&v1) - 1);
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::daily_checkin::distribute_7days_rewards(arg0, arg1, arg2, arg7, 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::daily_checkin::get_late_sign_in_rewards(arg5, arg4, v1), v1, 0x1::string::utf8(b""), 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::idaily_checkin::borrow_dailystreak_count(arg4), v0, 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_player_dvd_id(arg2));
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::daily_checkin::late_checkin(arg4, 0x1::vector::length<0x1::string::String>(&v1), v0);
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::isystem::add_v_to_game_treasury(arg6, arg3);
    }

    public(friend) fun move_gangster(arg0: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::authority::CapWrapper, arg1: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::Player, arg2: &mut 0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::iturf::TurfInformation, arg3: &mut 0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::iturf::TurfInformation, arg4: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::igangsters::GangsterBaseStats, arg5: 0x1::string::String, arg6: u64, arg7: &0x2::clock::Clock) {
        let v0 = 0x2::object::id<0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::Player>(arg1);
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::players::validate_feed_people(arg1, arg7);
        0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::turf::pre_move_gangster_validation(arg2, arg3, arg5, arg6);
        0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::turf::validate_turf_owner(arg2, v0);
        0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::turf::validate_turf_owner(arg3, v0);
        0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::turf::validate_gangster_type(arg5, 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::igangsters::borrow_unit_types(arg4));
        0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::turf::validate_destination_turf(0x2::object::id<0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::iturf::TurfInformation>(arg2), 0x2::object::id<0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::iturf::TurfInformation>(arg3));
        0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::iturf::remove_gangster_from_turf(0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::authority::borrow_map_cap(arg0), arg2, arg5, arg6);
        0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::iturf::add_gangster_in_turf(0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::authority::borrow_map_cap(arg0), arg3, arg5, arg6);
        0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::iturf::emit_move_gangster_event(v0, 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_player_dvd_id(arg1), 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_player_name(arg1), arg5, 1, 0x2::object::id<0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::iturf::TurfInformation>(arg2), 0x2::object::id<0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::iturf::TurfInformation>(arg3));
    }

    public(friend) fun re_assign_hq(arg0: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::authority::CapWrapper, arg1: &mut 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::Player, arg2: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::authority::Status, arg3: &mut 0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::iturf::MapConfig, arg4: &mut 0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::iturf::TurfSystem, arg5: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::PlayersRegistry, arg6: &0x2::random::Random, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::Player>(arg1);
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::authority::validate_onboarding_status(arg2);
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::players::validate_headquarter_assign(arg1);
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::reset_gangsters(arg1, arg5);
        let v1 = 0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::turf::create_headquarter(0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::authority::borrow_map_cap(arg0), v0, arg3, arg4, 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_initial_hq_garrison_limit(arg5), 0, arg6, arg7);
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::set_headquarter(arg1, v1);
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::set_owned_turf(arg1, v1);
        0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::iturf::emit_re_assign_headquarter_event(v0, 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_player_dvd_id(arg1), 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_player_name(arg1), v1);
    }

    public(friend) fun revive_recruits(arg0: &mut 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::Player, arg1: &0x95c6aad5cf721dfa4a8d7735522163f1536073851fb23d2ac4e177141fcae364::vendetta_version::Version, arg2: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::FeedRegistry, arg3: &mut 0x95c6aad5cf721dfa4a8d7735522163f1536073851fb23d2ac4e177141fcae364::vendetta::CoinRegistry, arg4: 0x1::option::Option<0x2::coin::Coin<0x95c6aad5cf721dfa4a8d7735522163f1536073851fb23d2ac4e177141fcae364::vendetta::VENDETTA>>, arg5: 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::PenaltyReceipt, arg6: &0x2::clock::Clock) {
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::players::validate_revive_people(arg0, &arg5, arg6);
        let v0 = 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_feed_registry_values(arg2);
        if (0x1::option::is_some<0x2::coin::Coin<0x95c6aad5cf721dfa4a8d7735522163f1536073851fb23d2ac4e177141fcae364::vendetta::VENDETTA>>(&arg4)) {
            let v1 = 0x1::option::destroy_some<0x2::coin::Coin<0x95c6aad5cf721dfa4a8d7735522163f1536073851fb23d2ac4e177141fcae364::vendetta::VENDETTA>>(arg4);
            0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::players::validate_feed_coin(0x2::coin::value<0x95c6aad5cf721dfa4a8d7735522163f1536073851fb23d2ac4e177141fcae364::vendetta::VENDETTA>(&v1), *0x1::vector::borrow<u64>(&v0, 3), true);
            0x95c6aad5cf721dfa4a8d7735522163f1536073851fb23d2ac4e177141fcae364::vendetta::burn(arg3, v1, arg1);
        } else {
            0x1::option::destroy_none<0x2::coin::Coin<0x95c6aad5cf721dfa4a8d7735522163f1536073851fb23d2ac4e177141fcae364::vendetta::VENDETTA>>(arg4);
            0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibuildings::subtract_resource_amount(0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_mut_player_df<0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibuildings::Resources>(arg0, 0x1::string::utf8(b"cash")), 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::players::calculate_base_cost(arg0, arg2) * 2);
        };
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::players::update_timer(arg0, 0x1::string::utf8(b"feed_people"), *0x1::vector::borrow<u64>(&v0, 2) + 0x2::clock::timestamp_ms(arg6));
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::consume_receipt(arg5);
    }

    public(friend) fun train_recruits(arg0: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::authority::CapWrapper, arg1: &mut 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::Player, arg2: &mut 0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::iturf::TurfInformation, arg3: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::igangsters::GangsterBaseStats, arg4: 0x1::string::String, arg5: &0x2::clock::Clock) {
        let v0 = 1;
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::players::validate_feed_people(arg1, arg5);
        let v1 = 0x2::object::id<0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::Player>(arg1);
        0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::turf::validate_turf_owner(arg2, v1);
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::gangsters::validate_available_gangster(arg3, arg4);
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::players::validate_recruit_count(arg1, v0);
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::decrease_recruit_count(arg1, v0);
        let v2 = 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::igangsters::borrow_gangster_recruit_cost(0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::igangsters::borrow_gangster_df<0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::igangsters::GangsterStats>(arg3, arg4));
        let v3 = 0;
        let v4 = 0;
        let v5 = 0;
        while (v3 < 0x1::vector::length<0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::igangsters::GangsterRecruitCost>(v2)) {
            let v6 = 0x1::vector::borrow<0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::igangsters::GangsterRecruitCost>(v2, v3);
            let v7 = 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::igangsters::borrow_gangster_recruit_cost_amount(v6);
            let v8 = 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::igangsters::borrow_gangster_recruit_cost_type(v6);
            if (v8 != 0x1::string::utf8(b"turf")) {
                let v9 = 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_mut_player_df<0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibuildings::Resources>(arg1, v8);
                0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::buildings::validate_resource_amount(v9, v7);
                0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibuildings::subtract_resource_amount(v9, v7);
                if (v8 == 0x1::string::utf8(b"cash")) {
                    v4 = v7;
                } else {
                    v5 = v7;
                };
            } else {
                0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::gangsters::validate_turf_recruit_cost(((0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_total_owned_turf_count(arg1) as u128) as u128) * 0x1::u128::pow(2, 64), v7);
            };
            v3 = v3 + 1;
        };
        0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::turf::update_hq_gangster(0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::authority::borrow_map_cap(arg0), arg2, arg4, v0);
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::add_gangster_in_summary(arg1, arg4, v0);
        0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::turf::validate_garrison_limit(arg2);
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::update_player_stats(arg1, 0x1::string::utf8(b"family_consigliere"), 1);
        0x57c4f34e9f2dfd372fb40326ef82d0a768344e2f2b4e33c062592ff3ad52c6c6::game_events::emit_train_recruit_event(0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::authority::borrow_event_cap(arg0), v1, 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_player_dvd_id(arg1), 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_player_name(arg1), arg4, v0, v4, v5);
    }

    public(friend) fun use_attack_reset_perk(arg0: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::authority::CapWrapper, arg1: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::Player, arg2: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iperks::PerksMetadataHolder, arg3: &mut 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iperks::Perk, arg4: 0x1::string::String, arg5: &mut 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibattle::PlayerBattleStats, arg6: &0x2::clock::Clock) {
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::battle::validate_if_owned_battle_stats(arg1, arg5);
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::perks::validate_perk_name(arg2, arg4);
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::perks::validate_perk_expired(arg3);
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iperks::set_perk_expire_ts(arg3, arg6, 0);
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibattle::set_player_battle_ts(arg5, 0x2::clock::timestamp_ms(arg6));
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibattle::set_player_battle_counts(arg5, 0);
        0x57c4f34e9f2dfd372fb40326ef82d0a768344e2f2b4e33c062592ff3ad52c6c6::game_events::emit_perk_enable_event(0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::authority::borrow_event_cap(arg0), 0x2::object::id<0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::Player>(arg1), 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_player_dvd_id(arg1), 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_player_name(arg1), arg4);
    }

    // decompiled from Move bytecode v6
}

