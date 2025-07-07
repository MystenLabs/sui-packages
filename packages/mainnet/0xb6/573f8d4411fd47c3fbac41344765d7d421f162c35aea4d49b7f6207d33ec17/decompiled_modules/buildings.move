module 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::buildings {
    public(friend) fun calculate_boosted_production(arg0: u64, arg1: u128) : u128 {
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::utils::safe_multiply((arg0 as u128) / 1000, 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::utils::percentage_increment(arg1, 60))
    }

    fun calculate_normal_production(arg0: u64, arg1: u128) : u128 {
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::utils::safe_multiply((arg0 as u128) / 1000, arg1)
    }

    public(friend) fun calculate_production(arg0: u64, arg1: u64, arg2: u64, arg3: u128, arg4: u128) : u128 {
        let v0 = if (arg0 > 0) {
            if (arg0 > arg1) {
                calculate_boosted_production(0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::utils::safe_subtract_u64(arg1, arg2), arg3)
            } else if (arg0 > arg2) {
                calculate_boosted_production(0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::utils::safe_subtract_u64(arg0, arg2), arg3) + calculate_normal_production(0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::utils::safe_subtract_u64(arg1, arg0), arg3)
            } else {
                calculate_normal_production(0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::utils::safe_subtract_u64(arg1, arg2), arg3)
            }
        } else {
            calculate_normal_production(0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::utils::safe_subtract_u64(arg1, arg2), arg3)
        };
        if (v0 > arg4) {
            arg4
        } else {
            v0
        }
    }

    public(friend) fun has_enough_dirty_cop(arg0: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibuildings::Resources, arg1: u64) {
        assert!((arg1 as u128) * 0x1::u128::pow(2, 64) < 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibuildings::borrow_resource_amount(arg0) / 2, 5);
    }

    public(friend) fun initialize_building(arg0: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibuildings::BuildingRegistry, arg1: 0x1::string::String, arg2: 0x1::string::String) : 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibuildings::BuildingInfo {
        let v0 = 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibuildings::borrow_building_upgrade_value(arg0, arg1);
        let v1 = 2;
        let v2 = 0x2::vec_map::get<u64, 0x2::vec_map::VecMap<0x1::string::String, u128>>(&v0, &v1);
        let v3 = 0x1::string::utf8(b"upgrade_cash_cost");
        let v4 = 0x1::string::utf8(b"upgrade_turf_cost");
        let v5 = 0x1::string::utf8(b"upgrade_weapon_cost");
        let v6 = 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibuildings::borrow_building_upgrade_value(arg0, arg1);
        let v7 = 1;
        let v8 = 0x2::vec_map::get<u64, 0x2::vec_map::VecMap<0x1::string::String, u128>>(&v6, &v7);
        let v9 = 0x1::string::utf8(b"production_rate");
        let v10 = 0x1::string::utf8(b"building_capacity");
        let v11 = 0x1::string::utf8(b"upgrade_wait_ms");
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibuildings::new_building(arg2, *0x2::vec_map::get<0x1::string::String, u128>(v8, &v9), *0x2::vec_map::get<0x1::string::String, u128>(v8, &v10), *0x2::vec_map::get<0x1::string::String, u128>(v8, &v11), arg1, *0x2::vec_map::get<0x1::string::String, u128>(v2, &v3), *0x2::vec_map::get<0x1::string::String, u128>(v2, &v4), *0x2::vec_map::get<0x1::string::String, u128>(v2, &v5))
    }

    public(friend) fun pre_upgrade_cash_validation(arg0: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibuildings::UpgradeCost, arg1: u128, arg2: u64) {
        let v0 = 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibuildings::borrow_upgrade_info(arg0);
        assert!(arg1 >= *0x1::vector::borrow<u128>(&v0, 0), 0);
        let v1 = 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibuildings::borrow_upgrade_info(arg0);
        assert!((arg2 as u128) >= *0x1::vector::borrow<u128>(&v1, 1), 1);
    }

    public(friend) fun pre_upgrade_weapon_validation(arg0: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibuildings::UpgradeCost, arg1: u128) {
        let v0 = 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibuildings::borrow_upgrade_info(arg0);
        assert!(arg1 >= *0x1::vector::borrow<u128>(&v0, 2), 6);
    }

    public(friend) fun set_buildings_value(arg0: &mut 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibuildings::BuildingRegistry, arg1: 0x1::string::String, arg2: u64, arg3: 0x1::string::String, arg4: u128) {
        assert!(arg2 != 0, 2);
        assert!(0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibuildings::check_building_level(arg0, arg2), 3);
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibuildings::set_building_configs(arg0, arg1, arg2, arg3, 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibuildings::get_scaled_config_value(arg3, arg4));
    }

    public(friend) fun upgrade_building(arg0: &mut 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibuildings::BuildingInfo, arg1: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibuildings::BuildingRegistry, arg2: 0x1::string::String, arg3: &0x2::clock::Clock) {
        let v0 = 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibuildings::borrow_building_info(arg0);
        assert!((0x2::clock::timestamp_ms(arg3) as u128) > *0x1::vector::borrow<u128>(&v0, 2), 4);
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibuildings::increase_building_level(arg0);
        let v1 = 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibuildings::borrow_building_level(arg0);
        assert!(v1 < 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibuildings::borrow_building_max_level(arg1), 3);
        let v2 = 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibuildings::borrow_building_upgrade_value(arg1, arg2);
        let v3 = 0x2::vec_map::get<u64, 0x2::vec_map::VecMap<0x1::string::String, u128>>(&v2, &v1);
        let v4 = 0x1::string::utf8(b"building_capacity");
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibuildings::set_building_storage_capacity(arg0, *0x2::vec_map::get<0x1::string::String, u128>(v3, &v4));
        let v5 = 0x1::string::utf8(b"production_rate");
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibuildings::set_building_production_rate(arg0, *0x2::vec_map::get<0x1::string::String, u128>(v3, &v5));
        let v6 = v1 + 1;
        let v7 = 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibuildings::borrow_building_upgrade_value(arg1, arg2);
        let v8 = 0x2::vec_map::get<u64, 0x2::vec_map::VecMap<0x1::string::String, u128>>(&v7, &v6);
        let v9 = 0x1::string::utf8(b"upgrade_cash_cost");
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibuildings::set_building_upgrade_cash_cost(arg0, *0x2::vec_map::get<0x1::string::String, u128>(v8, &v9));
        let v10 = 0x1::string::utf8(b"upgrade_turf_cost");
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibuildings::set_building_upgrade_turf_cost(arg0, *0x2::vec_map::get<0x1::string::String, u128>(v8, &v10));
        let v11 = 0x1::string::utf8(b"upgrade_wait_ms");
        0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibuildings::set_building_upgrade_wait_ts(arg0, (0x2::clock::timestamp_ms(arg3) as u128) + *0x2::vec_map::get<0x1::string::String, u128>(v8, &v11));
    }

    public(friend) fun validate_resource_amount(arg0: &0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibuildings::Resources, arg1: u128) {
        assert!(0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::ibuildings::borrow_resource_amount(arg0) >= arg1, 5);
    }

    // decompiled from Move bytecode v6
}

