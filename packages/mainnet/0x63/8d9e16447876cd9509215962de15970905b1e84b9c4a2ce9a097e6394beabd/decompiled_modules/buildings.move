module 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::buildings {
    public(friend) fun calculate_boosted_production(arg0: u64, arg1: u128) : u128 {
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::utils::safe_multiply((arg0 as u128) / 1000, 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::utils::percentage_increment(arg1, 60))
    }

    fun calculate_normal_production(arg0: u64, arg1: u128) : u128 {
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::utils::safe_multiply((arg0 as u128) / 1000, arg1)
    }

    public(friend) fun calculate_production(arg0: u64, arg1: u64, arg2: u64, arg3: u128, arg4: u128) : u128 {
        let v0 = if (arg0 > 0) {
            if (arg0 > arg1) {
                calculate_boosted_production(0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::utils::safe_subtract_u64(arg1, arg2), arg3)
            } else if (arg0 > arg2) {
                calculate_boosted_production(0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::utils::safe_subtract_u64(arg0, arg2), arg3) + calculate_normal_production(0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::utils::safe_subtract_u64(arg1, arg0), arg3)
            } else {
                calculate_normal_production(0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::utils::safe_subtract_u64(arg1, arg2), arg3)
            }
        } else {
            calculate_normal_production(0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::utils::safe_subtract_u64(arg1, arg2), arg3)
        };
        if (v0 > arg4) {
            arg4
        } else {
            v0
        }
    }

    public(friend) fun downgrade_building(arg0: &mut 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibuildings::BuildingInfo, arg1: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::CapWrapper, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: 0x1::string::String, arg5: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibuildings::BuildingRegistry, arg6: 0x1::string::String, arg7: u64) {
        let v0 = 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibuildings::borrow_building_level(arg0);
        let v1 = 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibuildings::borrow_building_level(arg0);
        loop {
            let v2 = 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibuildings::borrow_building_upgrade_value(arg5, arg6);
            let v3 = 0x1::string::utf8(b"upgrade_turf_cost");
            if ((arg7 as u128) < *0x2::vec_map::get<0x1::string::String, u128>(0x2::vec_map::get<u64, 0x2::vec_map::VecMap<0x1::string::String, u128>>(&v2, &v1), &v3) && v1 > 1) {
                let v4 = v1;
                v1 = v4 - 1;
                0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibuildings::decrease_building_level(arg0);
            } else {
                break
            };
        };
        let v5 = 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibuildings::borrow_building_upgrade_value(arg5, arg6);
        let v6 = 0x2::vec_map::get<u64, 0x2::vec_map::VecMap<0x1::string::String, u128>>(&v5, &v1);
        let v7 = 0x1::string::utf8(b"building_capacity");
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibuildings::set_building_storage_capacity(arg0, *0x2::vec_map::get<0x1::string::String, u128>(v6, &v7));
        let v8 = 0x1::string::utf8(b"production_rate");
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibuildings::set_building_production_rate(arg0, *0x2::vec_map::get<0x1::string::String, u128>(v6, &v8));
        let v9 = v1 + 1;
        let v10 = 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibuildings::borrow_building_upgrade_value(arg5, arg6);
        let v11 = 0x2::vec_map::get<u64, 0x2::vec_map::VecMap<0x1::string::String, u128>>(&v10, &v9);
        let v12 = 0x1::string::utf8(b"upgrade_cash_cost");
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibuildings::set_building_upgrade_cash_cost(arg0, *0x2::vec_map::get<0x1::string::String, u128>(v11, &v12));
        let v13 = 0x1::string::utf8(b"upgrade_weapon_cost");
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibuildings::set_building_upgrade_weapon_cost(arg0, *0x2::vec_map::get<0x1::string::String, u128>(v11, &v13));
        let v14 = 0x1::string::utf8(b"upgrade_turf_cost");
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibuildings::set_building_upgrade_turf_cost(arg0, *0x2::vec_map::get<0x1::string::String, u128>(v11, &v14));
        let v15 = 0x1::string::utf8(b"upgrade_wait_ms");
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibuildings::set_building_upgrade_wait_ts(arg0, *0x2::vec_map::get<0x1::string::String, u128>(v11, &v15));
        if (v0 > v1) {
            0xe660c11d5cddf961e2f153e2e9c89517bdbb2dfa64b9d3aae711672aeb7f240d::game_events::emit_downgrade_building_event(0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::borrow_event_cap(arg1), arg2, arg3, arg4, arg6, v1, v0);
        };
    }

    public(friend) fun has_enough_dirty_cop(arg0: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibuildings::Resources, arg1: u64) {
        assert!((arg1 as u128) * 0x1::u128::pow(2, 64) < 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibuildings::borrow_resource_amount(arg0) / 2, 4);
    }

    public(friend) fun initialize_building(arg0: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibuildings::BuildingRegistry, arg1: 0x1::string::String, arg2: 0x1::string::String) : 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibuildings::BuildingInfo {
        let v0 = 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibuildings::borrow_building_upgrade_value(arg0, arg1);
        let v1 = 2;
        let v2 = 0x2::vec_map::get<u64, 0x2::vec_map::VecMap<0x1::string::String, u128>>(&v0, &v1);
        let v3 = 0x1::string::utf8(b"upgrade_cash_cost");
        let v4 = 0x1::string::utf8(b"upgrade_turf_cost");
        let v5 = 0x1::string::utf8(b"upgrade_weapon_cost");
        let v6 = 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibuildings::borrow_building_upgrade_value(arg0, arg1);
        let v7 = 1;
        let v8 = 0x2::vec_map::get<u64, 0x2::vec_map::VecMap<0x1::string::String, u128>>(&v6, &v7);
        let v9 = 0x1::string::utf8(b"production_rate");
        let v10 = 0x1::string::utf8(b"building_capacity");
        let v11 = 0x1::string::utf8(b"upgrade_wait_ms");
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibuildings::new_building(arg2, *0x2::vec_map::get<0x1::string::String, u128>(v8, &v9), *0x2::vec_map::get<0x1::string::String, u128>(v8, &v10), *0x2::vec_map::get<0x1::string::String, u128>(v8, &v11), arg1, *0x2::vec_map::get<0x1::string::String, u128>(v2, &v3), *0x2::vec_map::get<0x1::string::String, u128>(v2, &v4), *0x2::vec_map::get<0x1::string::String, u128>(v2, &v5))
    }

    public(friend) fun pre_upgrade_cash_validation(arg0: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibuildings::UpgradeCost, arg1: u128, arg2: u64) {
        let v0 = 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibuildings::borrow_upgrade_info(arg0);
        assert!(arg1 >= *0x1::vector::borrow<u128>(&v0, 0), 0);
        let v1 = 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibuildings::borrow_upgrade_info(arg0);
        assert!((arg2 as u128) >= *0x1::vector::borrow<u128>(&v1, 1), 1);
    }

    public(friend) fun pre_upgrade_weapon_validation(arg0: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibuildings::UpgradeCost, arg1: u128) {
        let v0 = 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibuildings::borrow_upgrade_info(arg0);
        assert!(arg1 >= *0x1::vector::borrow<u128>(&v0, 2), 5);
    }

    public(friend) fun set_buildings_value(arg0: &mut 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibuildings::BuildingRegistry, arg1: 0x1::string::String, arg2: u64, arg3: 0x1::string::String, arg4: u128) {
        assert!(arg2 != 0, 2);
        assert!(0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibuildings::check_building_level(arg0, arg2), 3);
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibuildings::set_building_configs(arg0, arg1, arg2, arg3, 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibuildings::get_scaled_config_value(arg3, arg4));
    }

    public(friend) fun upgrade_building(arg0: &mut 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibuildings::BuildingInfo, arg1: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibuildings::BuildingRegistry, arg2: 0x1::string::String) {
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibuildings::increase_building_level(arg0);
        let v0 = 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibuildings::borrow_building_level(arg0);
        assert!(v0 < 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibuildings::borrow_building_max_level(arg1), 3);
        let v1 = 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibuildings::borrow_building_upgrade_value(arg1, arg2);
        let v2 = 0x2::vec_map::get<u64, 0x2::vec_map::VecMap<0x1::string::String, u128>>(&v1, &v0);
        let v3 = 0x1::string::utf8(b"building_capacity");
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibuildings::set_building_storage_capacity(arg0, *0x2::vec_map::get<0x1::string::String, u128>(v2, &v3));
        let v4 = 0x1::string::utf8(b"production_rate");
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibuildings::set_building_production_rate(arg0, *0x2::vec_map::get<0x1::string::String, u128>(v2, &v4));
        let v5 = v0 + 1;
        let v6 = 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibuildings::borrow_building_upgrade_value(arg1, arg2);
        let v7 = 0x2::vec_map::get<u64, 0x2::vec_map::VecMap<0x1::string::String, u128>>(&v6, &v5);
        let v8 = 0x1::string::utf8(b"upgrade_cash_cost");
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibuildings::set_building_upgrade_cash_cost(arg0, *0x2::vec_map::get<0x1::string::String, u128>(v7, &v8));
        let v9 = 0x1::string::utf8(b"upgrade_weapon_cost");
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibuildings::set_building_upgrade_weapon_cost(arg0, *0x2::vec_map::get<0x1::string::String, u128>(v7, &v9));
        let v10 = 0x1::string::utf8(b"upgrade_turf_cost");
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibuildings::set_building_upgrade_turf_cost(arg0, *0x2::vec_map::get<0x1::string::String, u128>(v7, &v10));
        let v11 = 0x1::string::utf8(b"upgrade_wait_ms");
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibuildings::set_building_upgrade_wait_ts(arg0, *0x2::vec_map::get<0x1::string::String, u128>(v7, &v11));
    }

    public(friend) fun validate_resource_amount(arg0: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibuildings::Resources, arg1: u128) {
        assert!(0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibuildings::borrow_resource_amount(arg0) >= arg1, 4);
    }

    // decompiled from Move bytecode v6
}

