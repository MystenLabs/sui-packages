module 0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::turf {
    public(friend) fun does_coordinate_exists(arg0: u64, arg1: bool, arg2: u64, arg3: bool, arg4: &0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::iturf::TurfSystem) : bool {
        0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::iturf::does_coordinate_exists(0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::iturf::new_coordinates(arg0, arg1, arg2, arg3), arg4)
    }

    public fun borrow_turf_id_if_exists(arg0: u64, arg1: bool, arg2: u64, arg3: bool, arg4: &0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::iturf::TurfSystem) : 0x1::option::Option<0x2::object::ID> {
        let v0 = 0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::iturf::new_coordinates(arg0, arg1, arg2, arg3);
        if (0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::iturf::does_coordinate_exists(v0, arg4)) {
            0x1::option::some<0x2::object::ID>(0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::iturf::borrow_turf_id_from_coordinate(arg4, v0))
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

    public fun create_headquarter(arg0: &0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::iturf::MapCap, arg1: 0x2::object::ID, arg2: &mut 0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::iturf::MapConfig, arg3: &mut 0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::iturf::TurfSystem, arg4: u64, arg5: u64, arg6: &0x2::random::Random, arg7: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let (v0, v1, v2, v3) = generate_spawn_location(arg6, arg2, arg7);
        assert!(!does_coordinate_exists(v0, v1, v2, v3, arg3), 9);
        0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::iturf::add_turf_count(arg2, 1);
        update_density(arg2);
        let v4 = 0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::iturf::new(arg1, arg4, arg5, v0, v1, v2, v3, arg7);
        let v5 = 0x2::object::id<0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::iturf::TurfInformation>(&v4);
        let (_, _, v8, v9, v10, v11, _, _) = 0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::iturf::borrow_turf_information(&v4);
        0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::iturf::add_coordinate_in_system(arg0, arg3, 0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::iturf::new_coordinates(v8, v9, v10, v11), v5);
        0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::iturf::share_turf(arg0, v4);
        v5
    }

    public(friend) fun create_turf(arg0: &mut 0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::iturf::MapConfig, arg1: &0x2::random::Random, arg2: &0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::iturf::TurfSystem, arg3: &mut 0x2::tx_context::TxContext) : (u64, bool, u64, bool) {
        let (v0, v1, v2, v3) = generate_spawn_location(arg1, arg0, arg3);
        assert!(!does_coordinate_exists(v0, v1, v2, v3, arg2), 9);
        0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::iturf::add_turf_count(arg0, 1);
        update_density(arg0);
        (v0, v1, v2, v3)
    }

    public(friend) fun find_optimal_radius(arg0: &mut 0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::iturf::MapConfig) : u64 {
        let v0 = 0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::iturf::borrow_map_config_info(arg0);
        let v1 = 0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::iturf::borrow_map_config_info(arg0);
        let v2 = *0x1::vector::borrow<u64>(&v0, 2) + *0x1::vector::borrow<u64>(&v1, 4);
        0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::iturf::set_current_max_radius(arg0, v2);
        let v3 = 0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::iturf::borrow_map_config_info(arg0);
        let v4 = *0x1::vector::borrow<u64>(&v3, 3);
        let v5 = 0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::iturf::borrow_map_config_info(arg0);
        let v6 = *0x1::vector::borrow<u64>(&v5, 0);
        if (v2 < v4) {
            v4
        } else {
            v6
        }
    }

    public(friend) fun generate_spawn_location(arg0: &0x2::random::Random, arg1: &mut 0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::iturf::MapConfig, arg2: &mut 0x2::tx_context::TxContext) : (u64, bool, u64, bool) {
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

    public fun pre_move_gangster_validation(arg0: &0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::iturf::TurfInformation, arg1: &0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::iturf::TurfInformation, arg2: 0x1::string::String, arg3: u64) {
        let (v0, v1, _, _, _, _, _, _) = 0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::iturf::borrow_turf_information(arg0);
        assert!(0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::iturf::gangster_type_exists(arg0, arg2), 4);
        assert!((v0 as u64) >= arg3 + (v1 as u64), 5);
    }

    public(friend) fun random_range_radius(arg0: &mut 0x2::random::RandomGenerator, arg1: u64, arg2: u64, arg3: u64) : u64 {
        0x1::uq64_64::to_int(0x1::uq64_64::from_quotient(((0x2::random::generate_u64_in_range(arg0, arg2, arg3) * arg1) as u128), 100))
    }

    public fun remove_penalty_gangsters(arg0: &0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::iturf::MapCap, arg1: &mut 0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::iturf::TurfInformation, arg2: u64, arg3: u64, arg4: u64) {
        0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::iturf::remove_gangster_from_turf(arg0, arg1, 0x1::string::utf8(b"henchman"), arg2);
        0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::iturf::remove_gangster_from_turf(arg0, arg1, 0x1::string::utf8(b"bouncer"), arg3);
        0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::iturf::remove_gangster_from_turf(arg0, arg1, 0x1::string::utf8(b"enforcer"), arg4);
    }

    public fun remove_warrior_gangster(arg0: &0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::iturf::MapCap, arg1: &mut 0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::iturf::TurfInformation, arg2: vector<0x1::string::String>) {
        let v0 = 0;
        while (0x1::vector::length<0x1::string::String>(&arg2) > v0) {
            let v1 = *0x1::vector::borrow<0x1::string::String>(&arg2, v0);
            assert!(0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::iturf::has_gangster_in_tuf(arg1, v1), 6);
            0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::iturf::remove_gangster_from_turf(arg0, arg1, v1, 1);
            v0 = v0 + 1;
        };
    }

    public(friend) fun should_expand_map(arg0: &0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::iturf::MapConfig) : bool {
        0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::iturf::borrow_density(arg0) > 0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::iturf::borrow_max_density(arg0)
    }

    public(friend) fun update_density(arg0: &mut 0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::iturf::MapConfig) {
        let v0 = 0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::iturf::borrow_map_config_info(arg0);
        let v1 = 0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::iturf::borrow_map_config_info(arg0);
        let v2 = 0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::iturf::borrow_map_config_info(arg0);
        0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::iturf::set_density(arg0, 0x1::uq64_64::to_raw(0x1::uq64_64::from_quotient(0x1::uq64_64::to_raw(0x1::uq64_64::from_quotient((*0x1::vector::borrow<u64>(&v2, 1) as u128), 1)), 0x1::uq64_64::to_raw(0x1::uq64_64::from_quotient(((314159265 * *0x1::vector::borrow<u64>(&v0, 0) * *0x1::vector::borrow<u64>(&v1, 0)) as u128), 100000000)))));
        if (should_expand_map(arg0)) {
            0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::iturf::increase_max_radius_with_expansion_rate(arg0);
        };
    }

    public fun update_hq_gangster(arg0: &0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::iturf::MapCap, arg1: &mut 0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::iturf::TurfInformation, arg2: 0x1::string::String, arg3: u64) {
        if (0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::iturf::gangster_type_exists(arg1, arg2)) {
            0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::iturf::add_gangster_in_turf(arg0, arg1, arg2, arg3);
        } else {
            0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::iturf::add_new_gangster_in_turf(arg1, arg2, arg3);
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

    public fun validate_garrison_limit(arg0: &0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::iturf::TurfInformation) {
        let (v0, v1, _, _, _, _, _, _) = 0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::iturf::borrow_turf_information(arg0);
        assert!(v0 > v1, 5);
    }

    public fun validate_new_turf(arg0: u64, arg1: bool, arg2: u64, arg3: bool, arg4: &0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::iturf::TurfSystem) {
        assert!(!0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::iturf::does_coordinate_exists(0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::iturf::new_coordinates(arg0, arg1, arg2, arg3), arg4), 11);
    }

    public fun validate_turf_cooldown(arg0: &0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::iturf::TurfInformation, arg1: &0x2::clock::Clock) {
        assert!(0x2::clock::timestamp_ms(arg1) >= 0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::iturf::borrow_turf_cooldown_ms(arg0), 12);
    }

    public fun validate_turf_exists(arg0: u64, arg1: bool, arg2: u64, arg3: bool, arg4: &0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::iturf::TurfSystem) {
        assert!(0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::iturf::does_coordinate_exists(0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::iturf::new_coordinates(arg0, arg1, arg2, arg3), arg4), 10);
    }

    public fun validate_turf_owner(arg0: &0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::iturf::TurfInformation, arg1: 0x2::object::ID) {
        let (_, _, _, _, _, _, v6, _) = 0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::iturf::borrow_turf_information(arg0);
        assert!(v6 == arg1, 1);
    }

    // decompiled from Move bytecode v6
}

