module 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::daily_checkin {
    public(friend) fun check_in(arg0: &mut 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::idaily_checkin::DailyCheckInStreak, arg1: u64, arg2: u64, arg3: u64) {
        let v0 = if (arg2 < arg3) {
            0
        } else {
            (arg2 - arg3) / 86400000
        };
        if ((arg1 - arg3) / 86400000 - v0 >= 2) {
            0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::idaily_checkin::set_dailystreak_last_checkedin_ts(arg0, arg1);
            0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::idaily_checkin::set_dailystreak_count(arg0, 1);
        } else {
            0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::idaily_checkin::set_dailystreak_last_checkedin_ts(arg0, arg1);
            0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::idaily_checkin::set_dailystreak_count(arg0, 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::idaily_checkin::borrow_dailystreak_count(arg0) + 1);
        };
    }

    public(friend) fun distribute_7days_rewards(arg0: &mut 0x95c6aad5cf721dfa4a8d7735522163f1536073851fb23d2ac4e177141fcae364::airdrop::VendettaAirdropNFT, arg1: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::authority::CapWrapper, arg2: &mut 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::Player, arg3: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ilevel::LevelPointRegistry, arg4: 0x2::vec_map::VecMap<0x1::string::String, u64>, arg5: vector<0x1::string::String>, arg6: 0x1::string::String, arg7: u64, arg8: u64, arg9: 0x2::object::ID) {
        let v0 = 0;
        let v1 = 0x2::vec_map::keys<0x1::string::String, u64>(&arg4);
        while (v0 < 0x1::vector::length<0x1::string::String>(&v1)) {
            let v2 = *0x1::vector::borrow<0x1::string::String>(&v1, v0);
            if (v2 == 0x1::string::utf8(b"cash")) {
                0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibuildings::add_resource_amount(0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_mut_player_df<0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibuildings::Resources>(arg2, 0x1::string::utf8(b"cash")), (((*0x2::vec_map::get<0x1::string::String, u64>(&arg4, &v2) as u128) * 0x1::u128::pow(2, 64)) as u128));
            } else if (v2 == 0x1::string::utf8(b"weapon")) {
                0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibuildings::add_resource_amount(0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_mut_player_df<0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibuildings::Resources>(arg2, 0x1::string::utf8(b"weapon")), (((*0x2::vec_map::get<0x1::string::String, u64>(&arg4, &v2) as u128) * 0x1::u128::pow(2, 64)) as u128));
            } else if (v2 == 0x1::string::utf8(b"scouts")) {
                0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibuildings::add_resource_amount(0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_mut_player_df<0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibuildings::Resources>(arg2, 0x1::string::utf8(b"scouts")), (((*0x2::vec_map::get<0x1::string::String, u64>(&arg4, &v2) as u128) * 0x1::u128::pow(2, 64)) as u128));
            } else if (v2 == 0x1::string::utf8(b"level_point")) {
                0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::level::add_level_points_to_player(arg0, arg1, arg2, arg3, (((*0x2::vec_map::get<0x1::string::String, u64>(&arg4, &v2) as u128) * 0x1::u128::pow(2, 64)) as u128));
            };
            v0 = v0 + 1;
        };
        if (0x1::vector::length<0x1::string::String>(&arg5) <= 0) {
            0x57c4f34e9f2dfd372fb40326ef82d0a768344e2f2b4e33c062592ff3ad52c6c6::game_events::emit_late_checkin(0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::authority::borrow_event_cap(arg1), arg5, arg4, 0x2::object::id<0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::Player>(arg2), arg7, arg8, arg9);
        } else {
            0x57c4f34e9f2dfd372fb40326ef82d0a768344e2f2b4e33c062592ff3ad52c6c6::game_events::emit_7days_reward_event(0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::authority::borrow_event_cap(arg1), arg6, arg4, 0x2::object::id<0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::Player>(arg2), arg7, arg8, arg9);
        };
    }

    public(friend) fun get_7days_checkin_reward(arg0: &mut 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::idaily_checkin::SevenDaysCheckInRewardsRegistry, arg1: &mut 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::idaily_checkin::DailyCheckInStreak, arg2: u64, arg3: u64) : (0x2::vec_map::VecMap<0x1::string::String, u64>, 0x1::string::String, u64) {
        let (v0, v1) = get_current_day(arg0, arg2);
        reset_player_claimed_days(arg0, arg1);
        assert!(v0 <= 7, 1);
        if (arg3 > v1) {
            assert!(v0 > (arg3 - v1) / 86400000 + 1, 0);
        };
        let v2 = 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::idaily_checkin::get_7days_checkin_rewards(arg0);
        let v3 = 0x1::u64::to_string(v0);
        assert!(0x2::vec_map::contains<0x1::string::String, 0x2::vec_map::VecMap<0x1::string::String, u64>>(&v2, &v3), 2);
        let v4 = 0x1::u64::to_string(v0);
        let v5 = 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::idaily_checkin::borrow_dailystreak_seven_day_claim(arg1);
        let v6 = 0x1::u64::to_string(v0);
        assert!(!0x1::vector::contains<0x1::string::String>(&v5, &v6), 0);
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::idaily_checkin::insert_in_seven_days_reward_claim_status(arg1, 0x1::u64::to_string(v0));
        (*0x2::vec_map::get<0x1::string::String, 0x2::vec_map::VecMap<0x1::string::String, u64>>(&v2, &v4), 0x1::u64::to_string(v0), v1)
    }

    public(friend) fun get_current_day(arg0: &mut 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::idaily_checkin::SevenDaysCheckInRewardsRegistry, arg1: u64) : (u64, u64) {
        let (v0, v1) = 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::idaily_checkin::get_7days_checkin_start_end_time(arg0);
        let v2 = v1;
        while (arg1 > v2) {
            v2 = v2 + 7 * 86400000;
        };
        if (v0 != v0) {
            0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::idaily_checkin::set_7days_start_time(arg0, v0);
        };
        ((arg1 - v0) / 86400000 + 1, v0)
    }

    public(friend) fun get_late_sign_in_rewards(arg0: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::idaily_checkin::SevenDaysCheckInRewardsRegistry, arg1: &mut 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::idaily_checkin::DailyCheckInStreak, arg2: vector<0x1::string::String>) : 0x2::vec_map::VecMap<0x1::string::String, u64> {
        let v0 = 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::idaily_checkin::get_7days_checkin_rewards(arg0);
        let v1 = 0x2::vec_map::empty<0x1::string::String, u64>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::string::String>(&arg2)) {
            let v3 = *0x2::vec_map::get<0x1::string::String, 0x2::vec_map::VecMap<0x1::string::String, u64>>(&v0, 0x1::vector::borrow<0x1::string::String>(&arg2, v2));
            let v4 = 0x2::vec_map::keys<0x1::string::String, u64>(&v3);
            let v5 = 0;
            while (v5 < 0x1::vector::length<0x1::string::String>(&v4)) {
                if (0x2::vec_map::contains<0x1::string::String, u64>(&v1, 0x1::vector::borrow<0x1::string::String>(&v4, v5))) {
                    let v6 = 0x2::vec_map::get_mut<0x1::string::String, u64>(&mut v1, 0x1::vector::borrow<0x1::string::String>(&v4, v5));
                    *v6 = *v6 + *0x2::vec_map::get<0x1::string::String, u64>(&v3, 0x1::vector::borrow<0x1::string::String>(&v4, v5));
                } else {
                    0x2::vec_map::insert<0x1::string::String, u64>(&mut v1, *0x1::vector::borrow<0x1::string::String>(&v4, v5), *0x2::vec_map::get<0x1::string::String, u64>(&v3, 0x1::vector::borrow<0x1::string::String>(&v4, v5)));
                };
                v5 = v5 + 1;
            };
            v2 = v2 + 1;
        };
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::idaily_checkin::concat_in_seven_days_reward_claim_status(arg1, arg2);
        v1
    }

    public(friend) fun get_missed_days(arg0: &mut 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::idaily_checkin::DailyCheckInStreak, arg1: &mut 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::idaily_checkin::SevenDaysCheckInRewardsRegistry, arg2: u64) : vector<0x1::string::String> {
        let (v0, _) = get_current_day(arg1, arg2);
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = 1;
        reset_player_claimed_days(arg1, arg0);
        let v4 = 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::idaily_checkin::borrow_dailystreak_seven_day_claim(arg0);
        while (v3 <= v0) {
            let v5 = 0x1::u64::to_string(v3);
            if (!0x1::vector::contains<0x1::string::String>(&v4, &v5)) {
                0x1::vector::push_back<0x1::string::String>(&mut v2, 0x1::u64::to_string(v3));
            };
            v3 = v3 + 1;
        };
        assert!(0x1::vector::length<0x1::string::String>(&v2) >= 1, 9);
        v2
    }

    public(friend) fun late_checkin(arg0: &mut 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::idaily_checkin::DailyCheckInStreak, arg1: u64, arg2: u64) {
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::idaily_checkin::set_dailystreak_last_checkedin_ts(arg0, arg2);
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::idaily_checkin::set_dailystreak_count(arg0, 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::idaily_checkin::borrow_dailystreak_count(arg0) + arg1);
    }

    public(friend) fun process_7days_rewards_config(arg0: &mut 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::idaily_checkin::SevenDaysCheckInRewardsRegistry, arg1: vector<0x1::string::String>, arg2: vector<0x1::string::String>, arg3: vector<u64>) {
        let v0 = 0;
        assert!(0x1::vector::length<0x1::string::String>(&arg1) == 0x1::vector::length<0x1::string::String>(&arg2), 3);
        assert!(0x1::vector::length<0x1::string::String>(&arg2) == 0x1::vector::length<u64>(&arg3), 3);
        let v1 = 0x2::vec_map::empty<0x1::string::String, 0x2::vec_map::VecMap<0x1::string::String, u64>>();
        while (v0 < 0x1::vector::length<0x1::string::String>(&arg1)) {
            let v2 = 0x2::vec_map::empty<0x1::string::String, u64>();
            0x2::vec_map::insert<0x1::string::String, u64>(&mut v2, *0x1::vector::borrow<0x1::string::String>(&arg2, v0), *0x1::vector::borrow<u64>(&arg3, v0));
            0x2::vec_map::insert<0x1::string::String, 0x2::vec_map::VecMap<0x1::string::String, u64>>(&mut v1, *0x1::vector::borrow<0x1::string::String>(&arg1, v0), v2);
            v0 = v0 + 1;
        };
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::idaily_checkin::set_7days_rewards_config(arg0, v1);
    }

    public(friend) fun reset_player_claimed_days(arg0: &mut 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::idaily_checkin::SevenDaysCheckInRewardsRegistry, arg1: &mut 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::idaily_checkin::DailyCheckInStreak) {
        let (_, v1) = 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::idaily_checkin::get_7days_checkin_start_end_time(arg0);
        if (v1 > 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::idaily_checkin::borrow_dailystreak_week_exp_ts(arg1)) {
            0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::idaily_checkin::reset_seven_days_reward_claim_status(arg1);
            0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::idaily_checkin::set_dailystreak_week_exp_ts(arg1, v1);
        };
    }

    public(friend) fun validate_v_cost_last_signed_in(arg0: &0x2::vec_map::VecMap<0x1::string::String, u64>, arg1: u64, arg2: u64) {
        let v0 = 0x1::string::utf8(b"v_token");
        assert!(0x2::vec_map::contains<0x1::string::String, u64>(arg0, &v0), 6);
        let v1 = 0x1::string::utf8(b"v_token");
        assert!(*0x2::vec_map::get<0x1::string::String, u64>(arg0, &v1) * arg2 == arg1, 5);
    }

    // decompiled from Move bytecode v6
}

