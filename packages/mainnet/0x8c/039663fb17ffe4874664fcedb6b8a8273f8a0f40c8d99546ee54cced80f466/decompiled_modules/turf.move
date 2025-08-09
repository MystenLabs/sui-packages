module 0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::turf {
    public(friend) fun does_coordinate_exists(arg0: u64, arg1: bool, arg2: u64, arg3: bool, arg4: &0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::TurfSystem) : bool {
        0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::does_coordinate_exists(0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::new_coordinates(arg0, arg1, arg2, arg3), arg4)
    }

    public fun raid_reset_perk(arg0: &0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::MapCap, arg1: &mut 0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::RaidInfo, arg2: &0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::MapRegistry, arg3: &0x2::clock::Clock) {
        0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::raid_reset_perk(arg1, arg2, arg3);
    }

    public fun update_raid_info(arg0: &0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::MapCap, arg1: &mut 0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::RaidInfo, arg2: &0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::MapRegistry, arg3: &0x2::clock::Clock) {
        0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::validate_raid_counts(arg1, arg2, arg3);
        0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::update_raid_info(arg1, arg2, arg3);
    }

    public fun borrow_turf_id_if_exists(arg0: u64, arg1: bool, arg2: u64, arg3: bool, arg4: &0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::TurfSystem) : 0x1::option::Option<0x2::object::ID> {
        let v0 = 0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::new_coordinates(arg0, arg1, arg2, arg3);
        if (0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::does_coordinate_exists(v0, arg4)) {
            0x1::option::some<0x2::object::ID>(0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::borrow_turf_id_from_coordinate(arg4, v0))
        } else {
            0x1::option::none<0x2::object::ID>()
        }
    }

    fun calculate_chebyshev_distance(arg0: u64, arg1: bool, arg2: u64, arg3: bool, arg4: u64, arg5: bool, arg6: u64, arg7: bool) : u64 {
        let v0 = if (arg1 == arg5) {
            if (arg0 >= arg4) {
                arg0 - arg4
            } else {
                arg4 - arg0
            }
        } else {
            arg0 + arg4
        };
        let v1 = if (arg3 == arg7) {
            if (arg2 >= arg6) {
                arg2 - arg6
            } else {
                arg6 - arg2
            }
        } else {
            arg2 + arg6
        };
        if (v0 >= v1) {
            v0
        } else {
            v1
        }
    }

    public fun create_headquarter(arg0: &0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::MapCap, arg1: &0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::map_version::Version, arg2: 0x2::object::ID, arg3: &mut 0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::MapConfig, arg4: &mut 0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::TurfSystem, arg5: u64, arg6: u64, arg7: &0x2::random::Random, arg8: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::map_version::validate_version(arg1);
        let (v0, v1, v2, v3) = generate_spawn_location(arg7, arg3, arg8);
        assert!(!does_coordinate_exists(v0, v1, v2, v3, arg4), 9);
        0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::add_turf_count(arg0, arg1, arg3, 1);
        update_density(arg3);
        let v4 = 0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::new(arg2, arg5, arg6, v0, v1, v2, v3, arg8);
        let v5 = 0x2::object::id<0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::TurfInformation>(&v4);
        let (_, _, v8, v9, v10, v11, _, _) = 0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::borrow_turf_information(&v4);
        0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::add_coordinate_in_system(arg0, arg1, arg4, 0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::new_coordinates(v8, v9, v10, v11), v5);
        0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::share_turf(arg0, arg1, v4);
        v5
    }

    public(friend) fun find_optimal_radius(arg0: &mut 0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::MapConfig) : u64 {
        let v0 = 0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::borrow_map_config_info(arg0);
        let v1 = 0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::borrow_map_config_info(arg0);
        let v2 = 0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::borrow_map_config_info(arg0);
        let v3 = 0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::borrow_map_config_info(arg0);
        let v4 = 0x1::u64::max(*0x1::vector::borrow<u64>(&v0, 3), 0x1::u64::min(*0x1::vector::borrow<u64>(&v2, 1) + *0x1::vector::borrow<u64>(&v3, 4), *0x1::vector::borrow<u64>(&v1, 0)));
        0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::set_current_max_radius(arg0, v4);
        v4
    }

    public(friend) fun generate_bot_defenses(arg0: &0x2::random::Random, arg1: u128, arg2: &mut 0x2::tx_context::TxContext) : vector<0x1::string::String> {
        let v0 = 0x2::random::new_generator(arg0, arg2);
        let v1 = 100;
        let v2 = if (arg1 < 3) {
            let v3 = 0x1::vector::empty<0x1::string::String>();
            0x1::vector::push_back<0x1::string::String>(&mut v3, 0x1::string::utf8(b"henchman"));
            get_gangster_vector(v3, vector[1])
        } else if (arg1 < 8) {
            let v4 = percentage(((3 + 0x2::random::generate_u8_in_range(&mut v0, 0, 1)) as u128), v1);
            let v5 = if (v4 == 0) {
                1
            } else {
                v4
            };
            let v6 = 0x1::vector::empty<0x1::string::String>();
            0x1::vector::push_back<0x1::string::String>(&mut v6, 0x1::string::utf8(b"henchman"));
            let v7 = 0x1::vector::empty<u128>();
            0x1::vector::push_back<u128>(&mut v7, v5);
            get_gangster_vector(v6, v7)
        } else if (arg1 < 17) {
            let v8 = percentage((0x2::random::generate_u8_in_range(&mut v0, 2, 3) as u128), v1);
            let v9 = percentage(2, v1);
            let v10 = percentage((0x2::random::generate_u8_in_range(&mut v0, 0, 1) as u128), v1);
            let v11 = 0x1::vector::empty<0x1::string::String>();
            let v12 = 0x1::vector::empty<u128>();
            if (v8 > 0) {
                0x1::vector::push_back<0x1::string::String>(&mut v11, 0x1::string::utf8(b"henchman"));
                0x1::vector::push_back<u128>(&mut v12, v8);
            };
            if (v9 > 0) {
                0x1::vector::push_back<0x1::string::String>(&mut v11, 0x1::string::utf8(b"bouncer"));
                0x1::vector::push_back<u128>(&mut v12, v9);
            };
            if (v10 > 0) {
                0x1::vector::push_back<0x1::string::String>(&mut v11, 0x1::string::utf8(b"enforcer"));
                0x1::vector::push_back<u128>(&mut v12, v10);
            };
            if (v8 + v9 + v10 == 0) {
                let v13 = 0x1::vector::empty<0x1::string::String>();
                0x1::vector::push_back<0x1::string::String>(&mut v13, 0x1::string::utf8(b"henchman"));
                get_gangster_vector(v13, vector[1])
            } else {
                get_gangster_vector(v11, v12)
            }
        } else if (arg1 < 32) {
            let v14 = percentage((0x2::random::generate_u8_in_range(&mut v0, 2, 3) as u128), v1);
            let v15 = percentage((0x2::random::generate_u8_in_range(&mut v0, 4, 5) as u128), v1);
            let v16 = percentage((0x2::random::generate_u8_in_range(&mut v0, 4, 5) as u128), v1);
            let v17 = 0x1::vector::empty<0x1::string::String>();
            let v18 = 0x1::vector::empty<u128>();
            if (v14 > 0) {
                0x1::vector::push_back<0x1::string::String>(&mut v17, 0x1::string::utf8(b"henchman"));
                0x1::vector::push_back<u128>(&mut v18, v14);
            };
            if (v15 > 0) {
                0x1::vector::push_back<0x1::string::String>(&mut v17, 0x1::string::utf8(b"bouncer"));
                0x1::vector::push_back<u128>(&mut v18, v15);
            };
            if (v16 > 0) {
                0x1::vector::push_back<0x1::string::String>(&mut v17, 0x1::string::utf8(b"enforcer"));
                0x1::vector::push_back<u128>(&mut v18, v16);
            };
            if (v14 + v15 + v16 == 0) {
                let v19 = 0x1::vector::empty<0x1::string::String>();
                0x1::vector::push_back<0x1::string::String>(&mut v19, 0x1::string::utf8(b"enforcer"));
                get_gangster_vector(v19, vector[1])
            } else {
                get_gangster_vector(v17, v18)
            }
        } else {
            let v20 = 0x1::vector::empty<0x1::string::String>();
            let v21 = &mut v20;
            0x1::vector::push_back<0x1::string::String>(v21, 0x1::string::utf8(b"bouncer"));
            0x1::vector::push_back<0x1::string::String>(v21, 0x1::string::utf8(b"enforcer"));
            let v22 = 0x1::vector::empty<u128>();
            let v23 = &mut v22;
            0x1::vector::push_back<u128>(v23, percentage(4 + (arg1 - 30) / 10, v1));
            0x1::vector::push_back<u128>(v23, percentage(3 + (arg1 - 30) / 5, v1));
            get_gangster_vector(v20, v22)
        };
        let v24 = v2;
        0x2::random::shuffle<0x1::string::String>(&mut v0, &mut v24);
        let v25 = 0;
        let v26 = 0x1::vector::empty<0x1::string::String>();
        while (v25 < 0x1::vector::length<0x1::string::String>(&v24)) {
            if (v25 >= 10) {
                break
            };
            0x1::vector::push_back<0x1::string::String>(&mut v26, *0x1::vector::borrow<0x1::string::String>(&v24, v25));
            v25 = v25 + 1;
        };
        v26
    }

    public(friend) fun generate_spawn_location(arg0: &0x2::random::Random, arg1: &mut 0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::MapConfig, arg2: &mut 0x2::tx_context::TxContext) : (u64, bool, u64, bool) {
        let v0 = 0x2::random::new_generator(arg0, arg2);
        let v1 = &mut v0;
        let v2 = random_range_radius(v1, find_optimal_radius(arg1), 90, 120);
        let v3 = 0x2::random::generate_u8_in_range(&mut v0, 1, 4);
        let v4 = 0x2::random::generate_u64_in_range(&mut v0, 0, v2);
        let v5 = 0x2::random::generate_u64_in_range(&mut v0, 0, v2);
        let v6 = false;
        let v7 = false;
        if (v3 == 1) {
        } else if (v3 == 2) {
            v6 = true;
        } else if (v3 == 3) {
            v6 = true;
            v7 = true;
        } else {
            v7 = true;
        };
        if (v4 == 0) {
            v6 = false;
        };
        if (v5 == 0) {
            v7 = false;
        };
        (v4, v6, v5, v7)
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

    public fun get_or_create_defenders(arg0: &0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::MapCap, arg1: &mut 0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::FreeTurfDefenderRegistry, arg2: u64, arg3: bool, arg4: u64, arg5: bool, arg6: &0x2::random::Random, arg7: u128, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : vector<0x1::string::String> {
        let v0 = 0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::new_coordinates(arg2, arg3, arg4, arg5);
        if (0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::has_coordinate(arg1, v0)) {
            let v2 = 0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::borrow_mut_defender_states(arg1, v0);
            if (0x2::clock::timestamp_ms(arg8) <= 0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::borrow_created_timestamp(v2) + 0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::borrow_recovery_duration_ms(arg1)) {
                *0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::borrow_defender_gangsters(v2)
            } else {
                0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::set_turf_state_defender_gangsters(v2, generate_bot_defenses(arg6, arg7, arg9));
                0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::set_turf_state_created_ts(v2, arg8);
                *0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::borrow_defender_gangsters(v2)
            }
        } else {
            let v3 = generate_bot_defenses(arg6, arg7, arg9);
            0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::add_new_free_turf_defender_state(arg1, v0, v3, arg8);
            v3
        }
    }

    public(friend) fun percentage(arg0: u128, arg1: u128) : u128 {
        assert!(arg0 <= 340282366920938463463374607431768211455, 1);
        arg0 * arg1 / 100
    }

    public fun pre_move_gangster_validation(arg0: &0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::TurfInformation, arg1: &0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::TurfInformation, arg2: 0x1::string::String, arg3: u64) {
        let (v0, v1, _, _, _, _, _, _) = 0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::borrow_turf_information(arg0);
        assert!(0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::gangster_type_exists(arg0, arg2), 4);
        assert!((v0 as u64) >= arg3 + (v1 as u64), 5);
    }

    public(friend) fun random_range_radius(arg0: &mut 0x2::random::RandomGenerator, arg1: u64, arg2: u64, arg3: u64) : u64 {
        0x1::uq64_64::to_int(0x1::uq64_64::from_quotient(((0x2::random::generate_u64_in_range(arg0, arg2, arg3) * arg1) as u128), 100))
    }

    public fun remove_penalty_gangsters(arg0: &0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::MapCap, arg1: &0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::map_version::Version, arg2: &mut 0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::TurfInformation, arg3: u64, arg4: u64, arg5: u64) {
        0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::map_version::validate_version(arg1);
        0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::remove_gangster_from_turf(arg0, arg1, arg2, 0x1::string::utf8(b"henchman"), arg3);
        0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::remove_gangster_from_turf(arg0, arg1, arg2, 0x1::string::utf8(b"bouncer"), arg4);
        0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::remove_gangster_from_turf(arg0, arg1, arg2, 0x1::string::utf8(b"enforcer"), arg5);
    }

    public fun remove_warrior_gangster(arg0: &0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::MapCap, arg1: &0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::map_version::Version, arg2: &mut 0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::TurfInformation, arg3: vector<0x1::string::String>) {
        0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::map_version::validate_version(arg1);
        let v0 = 0;
        while (0x1::vector::length<0x1::string::String>(&arg3) > v0) {
            let v1 = *0x1::vector::borrow<0x1::string::String>(&arg3, v0);
            assert!(0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::has_gangster_in_tuf(arg2, v1), 6);
            0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::remove_gangster_from_turf(arg0, arg1, arg2, v1, 1);
            v0 = v0 + 1;
        };
    }

    public(friend) fun should_expand_map(arg0: &0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::MapConfig) : bool {
        0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::borrow_density(arg0) > 0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::borrow_max_density(arg0)
    }

    public(friend) fun update_density(arg0: &mut 0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::MapConfig) {
        let v0 = 0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::borrow_map_config_info(arg0);
        let v1 = 0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::borrow_map_config_info(arg0);
        let v2 = 0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::borrow_map_config_info(arg0);
        0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::set_density(arg0, 0x1::uq64_64::to_raw(0x1::uq64_64::from_quotient(0x1::uq64_64::to_raw(0x1::uq64_64::from_quotient((*0x1::vector::borrow<u64>(&v2, 1) as u128), 1)), 0x1::uq64_64::to_raw(0x1::uq64_64::from_quotient(((314159265 * *0x1::vector::borrow<u64>(&v0, 0) * *0x1::vector::borrow<u64>(&v1, 0)) as u128), 100000000)))));
        if (should_expand_map(arg0)) {
            0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::increase_max_radius_with_expansion_rate(arg0);
        };
    }

    public fun update_hq_gangster(arg0: &0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::MapCap, arg1: &0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::map_version::Version, arg2: &mut 0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::TurfInformation, arg3: 0x1::string::String, arg4: u64) {
        0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::map_version::validate_version(arg1);
        if (0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::gangster_type_exists(arg2, arg3)) {
            0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::add_gangster_in_turf(arg0, arg1, arg2, arg3, arg4);
        } else {
            0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::add_new_gangster_in_turf(arg2, arg3, arg4);
        };
    }

    public fun validate_chebyshev_distance(arg0: u64, arg1: bool, arg2: u64, arg3: bool, arg4: u64, arg5: bool, arg6: u64, arg7: bool) {
        assert!(calculate_chebyshev_distance(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7) == 1, 8);
    }

    public fun validate_destination_turf(arg0: 0x2::object::ID, arg1: 0x2::object::ID) {
        assert!(arg0 != arg1, 3);
    }

    public fun validate_gangster_type(arg0: 0x1::string::String, arg1: vector<0x1::string::String>) {
        assert!(!0x1::string::is_empty(&arg0), 2);
        assert!(0x1::vector::contains<0x1::string::String>(&arg1, &arg0), 4);
    }

    public fun validate_garrison_limit(arg0: &0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::TurfInformation) {
        let (v0, v1, _, _, _, _, _, _) = 0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::borrow_turf_information(arg0);
        assert!(v0 > v1, 5);
    }

    public fun validate_new_turf(arg0: u64, arg1: bool, arg2: u64, arg3: bool, arg4: &0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::TurfSystem) {
        assert!(!0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::does_coordinate_exists(0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::new_coordinates(arg0, arg1, arg2, arg3), arg4), 11);
    }

    public fun validate_turf_cooldown(arg0: &0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::TurfInformation, arg1: &0x2::clock::Clock) {
        assert!(0x2::clock::timestamp_ms(arg1) >= 0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::borrow_turf_cooldown_ms(arg0), 12);
    }

    public fun validate_turf_exists(arg0: u64, arg1: bool, arg2: u64, arg3: bool, arg4: &0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::TurfSystem) {
        assert!(0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::does_coordinate_exists(0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::new_coordinates(arg0, arg1, arg2, arg3), arg4), 10);
    }

    public fun validate_turf_owner(arg0: &0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::TurfInformation, arg1: 0x2::object::ID) {
        let (_, _, _, _, _, _, v6, _) = 0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf::borrow_turf_information(arg0);
        assert!(v6 == arg1, 1);
    }

    // decompiled from Move bytecode v6
}

