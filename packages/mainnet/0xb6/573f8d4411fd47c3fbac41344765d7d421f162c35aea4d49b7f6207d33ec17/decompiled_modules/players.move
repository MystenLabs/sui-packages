module 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::players {
    public fun generate_penalty_receipt(arg0: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::Player, arg1: &0x2::clock::Clock) : 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::PenaltyReceipt {
        let v0 = 0x1::string::utf8(b"feed_people");
        let v1 = 0x2::vec_map::get<0x1::string::String, u64>(0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_player_timers(arg0), &v0);
        assert!(0x2::clock::timestamp_ms(arg1) > *v1, 25);
        let v2 = (1 + (0x2::clock::timestamp_ms(arg1) - *v1) / 86400000) * 2;
        let v3 = 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_recruit_count(arg0) + 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_gangster_current_count(arg0) < v2;
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::generate_penalty_receipt(v2, v3)
    }

    public(friend) fun apply_penalty_validation(arg0: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::authority::CapWrapper, arg1: &mut 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::Player, arg2: &mut 0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::iturf::TurfInformation, arg3: &mut 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::PenaltyReceipt, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock) {
        let v0 = 0x1::string::utf8(b"feed_people");
        assert!(0x2::clock::timestamp_ms(arg9) > *0x2::vec_map::get<0x1::string::String, u64>(0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_player_timers(arg1), &v0), 25);
        0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::turf::validate_turf_owner(arg2, 0x2::object::id<0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::Player>(arg1));
        0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::turf::remove_penalty_gangsters(0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::authority::borrow_map_cap(arg0), arg2, arg6, arg7, arg8);
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::decrease_recruit_count(arg1, arg4);
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::remove_gangster_from_summary(arg1, 0x1::string::utf8(b"henchman"), arg6);
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::remove_gangster_from_summary(arg1, 0x1::string::utf8(b"bouncer"), arg7);
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::remove_gangster_from_summary(arg1, 0x1::string::utf8(b"enforcer"), arg8);
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::set_total_paid(arg3, arg5 + arg4);
    }

    public(friend) fun borrow_perk_ts(arg0: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::Player, arg1: 0x1::string::String) : u64 {
        *0x2::vec_map::get<0x1::string::String, u64>(0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_player_perks(arg0), &arg1)
    }

    public fun borrow_player_ids(arg0: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::PlayersRegistry, arg1: &0x2::random::Random, arg2: &mut 0x2::tx_context::TxContext) : vector<0x2::object::ID> {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::total_player_len(arg0);
        let v2 = 0;
        if (v1 <= 10) {
            while (v2 < v1) {
                0x1::vector::push_back<0x2::object::ID>(&mut v0, 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_player_id(arg0, v2));
                v2 = v2 + 1;
            };
        } else {
            let v3 = 0x2::random::new_generator(arg1, arg2);
            while (v2 < 10) {
                0x1::vector::push_back<0x2::object::ID>(&mut v0, 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_player_id(arg0, 0x2::random::generate_u64_in_range(&mut v3, 0, v1 - 1)));
                v2 = v2 + 1;
            };
        };
        v0
    }

    public fun calculate_base_cost(arg0: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::Player, arg1: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::FeedRegistry) : u128 {
        let v0 = 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_feed_registry_values(arg1);
        let v1 = 1000;
        (((*0x1::vector::borrow<u64>(&v0, 0) as u128) * (v1 + ((0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_recruit_count(arg0) + 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_gangster_current_count(arg0)) as u128) * v1 / (*0x1::vector::borrow<u64>(&v0, 1) as u128)) / v1) as u128) * 0x1::u128::pow(2, 64)
    }

    public(friend) fun calculate_loot_xp(arg0: u8, arg1: &mut 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::Player, arg2: u128, arg3: &mut 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::Player, arg4: u128) : u128 {
        let v0 = 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_mut_player_df<0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iexperience::Experience>(arg3, 0x1::string::utf8(b"experience"));
        let v1 = 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_mut_player_df<0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iexperience::Experience>(arg1, 0x1::string::utf8(b"experience"));
        let v2 = 0x1::uq64_64::to_raw(0x1::uq64_64::from_quotient(50, 100));
        let v3 = 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::utils::percentage_value(0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iexperience::get_exp_point(v0), 50);
        let v4 = 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::utils::percentage_value(0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iexperience::get_exp_point(v1), 50);
        let v5 = 0x1::uq64_64::to_raw(0x1::uq64_64::from_quotient(arg2, arg2 + arg4));
        if (v5 >= v2) {
            if (arg0 == 1) {
                let v7 = v5 + 1 * 0x1::u128::pow(2, 64) + v4;
                let v6 = v7;
                if (v7 > v3) {
                    v6 = v3;
                };
                0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iexperience::increase_xp(v1, v6);
                0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iexperience::decrease_xp(v0, v6);
                v6
            } else {
                let v8 = v5 + 1 * 0x1::u128::pow(2, 64) + v3;
                let v6 = v8;
                if (v8 > v4) {
                    v6 = v4;
                };
                0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iexperience::increase_xp(v0, v6);
                0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iexperience::decrease_xp(v1, v6);
                v6
            }
        } else if (arg0 == 1) {
            let v9 = v2 - v5 + 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::utils::percentage_increment(v4, 60);
            let v6 = v9;
            if (v9 > v3) {
                v6 = v3;
            };
            0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iexperience::increase_xp(v1, v6);
            v6
        } else {
            let v10 = v2 - v5 + 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::utils::percentage_increment(v3, 60);
            let v6 = v10;
            if (v10 > v4) {
                v6 = v4;
            };
            0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iexperience::increase_xp(v0, v6);
            0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iexperience::decrease_xp(v1, v6);
            v6
        }
    }

    public fun calculate_new_recruits(arg0: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::Player, arg1: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::FeedRegistry) : u64 {
        let _ = 1000;
        let _ = 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_feed_registry_values(arg1);
        let v2 = 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_recruit_count(arg0);
        let v3 = 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_gangster_capacity(arg0) - 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_gangster_current_count(arg0);
        if (v3 >= v2) {
            v3 - v2
        } else {
            0
        }
    }

    public fun calculate_xp_feed_xp_gain(arg0: &0x2::random::Random, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : u128 {
        let v0 = 0x2::random::new_generator(arg0, arg2);
        ((arg1 + 0x2::random::generate_u64_in_range(&mut v0, 1, 5)) as u128) * 0x1::u128::pow(2, 64)
    }

    public(friend) fun initialize_buildings(arg0: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibuildings::BuildingRegistry) : (0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibuildings::BuildingInfo, 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibuildings::BuildingInfo) {
        (0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::buildings::initialize_building(arg0, 0x1::string::utf8(b"cash_operation"), 0x1::string::utf8(b"cash")), 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::buildings::initialize_building(arg0, 0x1::string::utf8(b"arms_dealership"), 0x1::string::utf8(b"weapon")))
    }

    public(friend) fun initialize_perks(arg0: &mut 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::Player, arg1: u64, arg2: 0x1::string::String) {
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::add_new_perk_type(arg0, arg2, arg1);
    }

    public(friend) fun remove_warrior_gangsters(arg0: &mut 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::Player, arg1: vector<0x1::string::String>) {
        let v0 = 0;
        while (0x1::vector::length<0x1::string::String>(&arg1) > v0) {
            0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::remove_gangster_from_summary(arg0, *0x1::vector::borrow<0x1::string::String>(&arg1, v0), 1);
            v0 = v0 + 1;
        };
    }

    public(friend) fun reset_player(arg0: &mut 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::Player, arg1: bool) {
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::set_headquarter(arg0, 0x2::object::id_from_address(@0x2));
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::reset_player_perks_and_locations(arg0);
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::reset_player_status(arg0, arg1);
    }

    public(friend) fun set_gangsters_count(arg0: &mut 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::Player, arg1: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::isystem::SystemConfig) {
        let (_, _, _, _, v4, _) = 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::isystem::borrow_system_config(arg1);
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::increase_gangster_capacity(arg0, v4);
    }

    public(friend) fun update_player_perk_ts(arg0: &mut 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::Player, arg1: 0x1::string::String, arg2: u64, arg3: &0x2::clock::Clock) {
        *0x2::vec_map::get_mut<0x1::string::String, u64>(0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_mut_player_perks(arg0), &arg1) = 0x2::clock::timestamp_ms(arg3) + arg2 * 60 * 60 * 1000;
    }

    public(friend) fun update_timer(arg0: &mut 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::Player, arg1: 0x1::string::String, arg2: u64) {
        *0x2::vec_map::get_mut<0x1::string::String, u64>(0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_mut_player_timers(arg0), &arg1) = arg2;
    }

    public(friend) fun validate_and_update_raid_cooldown(arg0: &mut 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::Player, arg1: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::isystem::SystemConfig, arg2: &0x2::clock::Clock) {
        let (_, _, _, _, _, v5) = 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::isystem::borrow_system_config(arg1);
        validate_player_raid_cooldown(arg0, arg2);
        let v6 = 0x1::string::utf8(b"raid_cooldown");
        *0x2::vec_map::get_mut<0x1::string::String, u64>(0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_mut_player_timers(arg0), &v6) = 0x2::clock::timestamp_ms(arg2) + v5;
    }

    public(friend) fun validate_battle_perks_and_cooldown(arg0: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::Player, arg1: &0x2::clock::Clock) {
        let v0 = 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_player_perks(arg0);
        let v1 = 0x1::string::utf8(b"attack_protection");
        assert!(0x2::clock::timestamp_ms(arg1) > *0x2::vec_map::get<0x1::string::String, u64>(v0, &v1), 13);
        let v2 = 0x1::string::utf8(b"newbie_protection");
        assert!(0x2::clock::timestamp_ms(arg1) > *0x2::vec_map::get<0x1::string::String, u64>(v0, &v2), 14);
    }

    public(friend) fun validate_blackmail(arg0: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::Player, arg1: 0x2::object::ID) {
        assert!(0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_player_blackmail(arg0) == arg1, 8);
    }

    public(friend) fun validate_blackmail_cooldown(arg0: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::Player, arg1: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::Player, arg2: &0x2::clock::Clock) {
        let v0 = 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_player_timers(arg1);
        let v1 = 0x1::string::utf8(b"blackmail_attack_cooldown");
        assert!(0x2::clock::timestamp_ms(arg2) > *0x2::vec_map::get<0x1::string::String, u64>(0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_player_timers(arg0), &v1), 9);
        let v2 = 0x1::string::utf8(b"blackmail_looted_cooldown");
        assert!(0x2::clock::timestamp_ms(arg2) > *0x2::vec_map::get<0x1::string::String, u64>(v0, &v2), 10);
    }

    public(friend) fun validate_defender_neighbor(arg0: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::Player, arg1: 0x2::object::ID) {
        let v0 = 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_player_owned_location(arg0);
        assert!(0x1::vector::contains<0x2::object::ID>(&v0, &arg1), 7);
    }

    public(friend) fun validate_feed_coin(arg0: u64, arg1: u64, arg2: bool) {
        if (arg2) {
            assert!(arg0 == arg1 * 2, 20);
        } else {
            assert!(arg0 == arg1, 20);
        };
    }

    public(friend) fun validate_feed_people(arg0: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::Player, arg1: &0x2::clock::Clock) {
        let v0 = 0x1::string::utf8(b"feed_people");
        assert!(0x2::clock::timestamp_ms(arg1) < *0x2::vec_map::get<0x1::string::String, u64>(0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_player_timers(arg0), &v0), 21);
    }

    public(friend) fun validate_free_player(arg0: &0xb2898452c2c4fd7cb52372f168deeb8447ef7841f756705f42369ecd4c84318e::vendetta_free_dvd::FreeVendettaDVD, arg1: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::Player, arg2: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::version::Version, arg3: &0xb2898452c2c4fd7cb52372f168deeb8447ef7841f756705f42369ecd4c84318e::dvd_version::Version) {
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::version::validate_version(arg2);
        0xb2898452c2c4fd7cb52372f168deeb8447ef7841f756705f42369ecd4c84318e::vendetta_free_dvd::is_valid_player(arg0, arg3, 0x2::object::id<0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::Player>(arg1));
        assert!(!0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_player_status(arg1), 2);
    }

    public(friend) fun validate_headquarter_assign(arg0: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::Player) {
        assert!(0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::can_assign_headquarter(arg0), 4);
    }

    public(friend) fun validate_hire_scouts_cooldown(arg0: &mut 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::Player, arg1: &0x2::clock::Clock) {
        let v0 = 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_mut_player_timers(arg0);
        let v1 = 0x1::string::utf8(b"hire_scouts_cooldown");
        assert!(0x2::vec_map::contains<0x1::string::String, u64>(v0, &v1), 1119);
        let v2 = 0x1::string::utf8(b"hire_scouts_cooldown");
        let v3 = 0x2::vec_map::get_mut<0x1::string::String, u64>(v0, &v2);
        assert!(0x2::clock::timestamp_ms(arg1) > *v3, 16);
        *v3 = 0x2::clock::timestamp_ms(arg1) + 3600000;
    }

    public(friend) fun validate_perk_enabled(arg0: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::Player, arg1: 0x1::string::String, arg2: &0x2::clock::Clock) {
        assert!(*0x2::vec_map::get<0x1::string::String, u64>(0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_player_perks(arg0), &arg1) >= 0x2::clock::timestamp_ms(arg2), 6);
    }

    public(friend) fun validate_player(arg0: &0xb2898452c2c4fd7cb52372f168deeb8447ef7841f756705f42369ecd4c84318e::vendetta_dvd::VendettaDVD, arg1: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::Player, arg2: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::version::Version, arg3: &0xb2898452c2c4fd7cb52372f168deeb8447ef7841f756705f42369ecd4c84318e::dvd_version::Version) {
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::version::validate_version(arg2);
        0xb2898452c2c4fd7cb52372f168deeb8447ef7841f756705f42369ecd4c84318e::vendetta_dvd::is_valid_player(arg0, arg3, 0x2::object::id<0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::Player>(arg1));
        assert!(!0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_player_status(arg1), 2);
    }

    public(friend) fun validate_player_name(arg0: 0x1::string::String) {
        assert!(!0x1::string::is_empty(&arg0), 0);
        assert!(0x1::string::length(&arg0) <= 30, 1);
    }

    public(friend) fun validate_player_raid_cooldown(arg0: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::Player, arg1: &0x2::clock::Clock) {
        let v0 = 0x1::string::utf8(b"raid_cooldown");
        assert!(0x2::clock::timestamp_ms(arg1) > *0x2::vec_map::get<0x1::string::String, u64>(0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_player_timers(arg0), &v0), 26);
    }

    public(friend) fun validate_players_stats(arg0: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::Player, arg1: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibattle::PlayerBattleStats) {
        assert!(0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_player_attack_stats(arg0) == 0x2::object::id<0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibattle::PlayerBattleStats>(arg1), 15);
    }

    public(friend) fun validate_recruit_count(arg0: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::Player, arg1: u64) {
        assert!(0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::has_enough_recruit_count(arg0, arg1), 12);
    }

    public(friend) fun validate_revive_people(arg0: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::Player, arg1: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::PenaltyReceipt, arg2: &0x2::clock::Clock) {
        let v0 = 0x1::string::utf8(b"feed_people");
        assert!(0x2::clock::timestamp_ms(arg2) > *0x2::vec_map::get<0x1::string::String, u64>(0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_player_timers(arg0), &v0), 23);
        if (0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::can_skip(arg1)) {
            assert!(0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_recruit_count(arg0) + 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_gangster_current_count(arg0) == 0, 27);
        } else {
            assert!(0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_total_to_pay(arg1) == 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_total_paid(arg1), 27);
        };
    }

    public(friend) fun validate_weekly_report(arg0: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::Player, arg1: 0x2::object::ID) {
        assert!(0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iplayer::borrow_player_weekly_report(arg0) == arg1, 28);
    }

    // decompiled from Move bytecode v6
}

