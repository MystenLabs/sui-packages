module 0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::raid {
    fun apply_type_penalty(arg0: &mut 0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::character_data::Character, arg1: u64) {
        let v0 = get_type_weight(arg0, arg1);
        let v1 = if (v0 < 0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::constants::min_weight() + 0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::constants::weight_penalty()) {
            0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::constants::min_weight()
        } else {
            v0 - 0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::constants::weight_penalty()
        };
        update_type_weight(arg0, arg1, v1);
    }

    fun check_item_drop(arg0: &0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::game_data::GameData, arg1: u64, arg2: u64) : bool {
        arg2 % 10000 < 0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::item_types::item_info_drop_rate(0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::game_data::get_item_by_id(arg0, arg1))
    }

    fun find_type_weight_by_id(arg0: &0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::character_data::Character, arg1: u64) : 0x1::option::Option<u64> {
        let v0 = 0;
        let v1 = 0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::character_data::type_history(arg0);
        while (v0 < 0x1::vector::length<0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::traits::TypeWeight>(v1)) {
            if (0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::traits::type_weight_type_id(0x1::vector::borrow<0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::traits::TypeWeight>(v1, v0)) == arg1) {
                return 0x1::option::some<u64>(v0)
            };
            v0 = v0 + 1;
        };
        0x1::option::none<u64>()
    }

    fun get_available_items_of_type(arg0: &0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::character_data::Character, arg1: &0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::game_data::GameData, arg2: u64) : vector<u64> {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = 0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::character_data::equipped_items(arg0);
        let v2 = 0;
        let v3 = 0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::game_data::game_data_items_registry(arg1);
        while (v2 < 0x1::vector::length<0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::item_types::ItemInfo>(v3)) {
            let v4 = 0x1::vector::borrow<0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::item_types::ItemInfo>(v3, v2);
            if (0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::item_types::item_info_type_id(v4) == arg2) {
                let v5 = 0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::item_types::item_info_id(v4);
                if (!0x1::vector::contains<u64>(v1, &v5)) {
                    let v6 = 0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::item_types::item_info_max_supply(v4);
                    if (v6 == 0 || 0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::item_types::item_info_current_count(v4) < v6) {
                        0x1::vector::push_back<u64>(&mut v0, v5);
                    };
                };
            };
            v2 = v2 + 1;
        };
        v0
    }

    fun get_type_weight(arg0: &0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::character_data::Character, arg1: u64) : u64 {
        let v0 = find_type_weight_by_id(arg0, arg1);
        if (0x1::option::is_some<u64>(&v0)) {
            0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::traits::type_weight_weight(0x1::vector::borrow<0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::traits::TypeWeight>(0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::character_data::type_history(arg0), 0x1::option::extract<u64>(&mut v0)))
        } else {
            0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::constants::default_type_weight()
        }
    }

    public entry fun go_raid(arg0: &mut 0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::character_data::Character, arg1: &mut 0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::game_data::GameData, arg2: &0x2::random::Random, arg3: &0x2::clock::Clock, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) {
        sync_type_history(arg0, arg1);
        if (arg4) {
            0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::customization::auto_decline_pending(arg0, arg1);
        };
        0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::errors::assert_pending_exists(0x1::option::is_none<u64>(0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::character_data::get_pending(arg0)));
        let v0 = 0x2::clock::timestamp_ms(arg3);
        0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::errors::assert_raid_cooldown(v0 >= 0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::character_data::last_raid_time(arg0) + 0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::constants::raid_cooldown_ms());
        let v1 = 0x2::random::new_generator(arg2, arg5);
        let v2 = &mut v1;
        let v3 = roll_for_item(arg0, arg1, v2);
        if (0x1::option::is_some<0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::item_types::ItemSelectionResult>(&v3)) {
            let v4 = 0x1::option::extract<0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::item_types::ItemSelectionResult>(&mut v3);
            let v5 = 0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::item_types::selection_result_item_id(&v4);
            let v6 = 0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::game_data::get_item_by_id_mut(arg1, v5);
            let v7 = 0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::item_types::item_info_max_supply(v6);
            if (v7 != 0) {
                0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::errors::assert_invalid_item(0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::item_types::item_info_current_count(v6) < v7);
            };
            0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::item_types::increment_current_count(v6);
            *0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::character_data::pending_item_mut(arg0) = 0x1::option::some<u64>(v5);
        };
        0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::character_data::set_last_raid_time(arg0, v0);
        0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::character_data::set_total_raids(arg0, 0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::character_data::total_raids(arg0) + 1);
    }

    fun recover_type_weights(arg0: &mut 0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::character_data::Character) {
        let v0 = 0;
        let v1 = 0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::character_data::type_history_mut(arg0);
        while (v0 < 0x1::vector::length<0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::traits::TypeWeight>(v1)) {
            let v2 = 0x1::vector::borrow_mut<0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::traits::TypeWeight>(v1, v0);
            let v3 = 0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::traits::type_weight_weight(v2);
            let v4 = if (v3 + 0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::constants::weight_recovery() > 0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::constants::max_weight()) {
                0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::constants::max_weight()
            } else {
                v3 + 0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::constants::weight_recovery()
            };
            0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::traits::set_type_weight_weight(v2, v4);
            v0 = v0 + 1;
        };
    }

    fun roll_for_item(arg0: &mut 0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::character_data::Character, arg1: &0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::game_data::GameData, arg2: &mut 0x2::random::RandomGenerator) : 0x1::option::Option<0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::item_types::ItemSelectionResult> {
        recover_type_weights(arg0);
        let v0 = select_item_type(arg0, 0x2::random::generate_u64(arg2));
        if (0x1::option::is_none<u64>(&v0)) {
            return 0x1::option::none<0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::item_types::ItemSelectionResult>()
        };
        let v1 = 0x1::option::extract<u64>(&mut v0);
        let v2 = get_available_items_of_type(arg0, arg1, v1);
        if (0x1::vector::is_empty<u64>(&v2)) {
            return 0x1::option::none<0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::item_types::ItemSelectionResult>()
        };
        let v3 = select_random_item(&v2, 0x2::random::generate_u64(arg2));
        if (0x1::option::is_none<u64>(&v3)) {
            return 0x1::option::none<0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::item_types::ItemSelectionResult>()
        };
        let v4 = 0x1::option::extract<u64>(&mut v3);
        if (!check_item_drop(arg1, v4, 0x2::random::generate_u64(arg2))) {
            return 0x1::option::none<0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::item_types::ItemSelectionResult>()
        };
        apply_type_penalty(arg0, v1);
        0x1::option::some<0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::item_types::ItemSelectionResult>(0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::item_types::new_item_selection_result(v4, v1))
    }

    fun select_item_type(arg0: &0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::character_data::Character, arg1: u64) : 0x1::option::Option<u64> {
        let v0 = 0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::character_data::type_history(arg0);
        if (0x1::vector::is_empty<0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::traits::TypeWeight>(v0)) {
            return 0x1::option::none<u64>()
        };
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::traits::TypeWeight>(v0)) {
            v1 = v1 + 0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::traits::type_weight_weight(0x1::vector::borrow<0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::traits::TypeWeight>(v0, v2));
            v2 = v2 + 1;
        };
        if (v1 == 0) {
            return 0x1::option::none<u64>()
        };
        let v3 = arg1 % v1;
        let v4 = 0;
        v2 = 0;
        while (v2 < 0x1::vector::length<0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::traits::TypeWeight>(v0)) {
            let v5 = 0x1::vector::borrow<0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::traits::TypeWeight>(v0, v2);
            let v6 = 0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::traits::type_weight_weight(v5);
            if (v3 >= v4 && v3 < v4 + v6) {
                return 0x1::option::some<u64>(0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::traits::type_weight_type_id(v5))
            };
            v4 = v4 + v6;
            v2 = v2 + 1;
        };
        0x1::option::none<u64>()
    }

    fun select_random_item(arg0: &vector<u64>, arg1: u64) : 0x1::option::Option<u64> {
        if (0x1::vector::is_empty<u64>(arg0)) {
            return 0x1::option::none<u64>()
        };
        0x1::option::some<u64>(*0x1::vector::borrow<u64>(arg0, arg1 % 0x1::vector::length<u64>(arg0)))
    }

    fun sync_type_history(arg0: &mut 0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::character_data::Character, arg1: &0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::game_data::GameData) {
        let v0 = 0;
        let v1 = 0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::game_data::game_data_item_types(arg1);
        while (v0 < 0x1::vector::length<0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::item_types::ItemType>(v1)) {
            let v2 = 0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::item_types::item_type_id(0x1::vector::borrow<0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::item_types::ItemType>(v1, v0));
            let v3 = find_type_weight_by_id(arg0, v2);
            if (0x1::option::is_none<u64>(&v3)) {
                0x1::vector::push_back<0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::traits::TypeWeight>(0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::character_data::type_history_mut(arg0), 0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::traits::new_type_weight(v2, 0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::constants::default_type_weight()));
            };
            v0 = v0 + 1;
        };
    }

    fun update_type_weight(arg0: &mut 0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::character_data::Character, arg1: u64, arg2: u64) {
        let v0 = find_type_weight_by_id(arg0, arg1);
        if (0x1::option::is_some<u64>(&v0)) {
            0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::traits::set_type_weight_weight(0x1::vector::borrow_mut<0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::traits::TypeWeight>(0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::character_data::type_history_mut(arg0), 0x1::option::extract<u64>(&mut v0)), arg2);
        } else {
            0x1::vector::push_back<0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::traits::TypeWeight>(0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::character_data::type_history_mut(arg0), 0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::traits::new_type_weight(arg1, arg2));
        };
    }

    // decompiled from Move bytecode v6
}

