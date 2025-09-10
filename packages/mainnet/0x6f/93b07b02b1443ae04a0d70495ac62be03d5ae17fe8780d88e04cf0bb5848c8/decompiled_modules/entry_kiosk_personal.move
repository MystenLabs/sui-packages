module 0x6f93b07b02b1443ae04a0d70495ac62be03d5ae17fe8780d88e04cf0bb5848c8::entry_kiosk_personal {
    entry fun allocate_stats_from_kiosk(arg0: &mut 0x2::kiosk::Kiosk, arg1: &mut 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg2: 0x2::object::ID, arg3: &0x6f93b07b02b1443ae04a0d70495ac62be03d5ae17fe8780d88e04cf0bb5848c8::game_data::GameData, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock) {
        let (v0, v1) = 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow_val(arg1);
        let v2 = v0;
        let v3 = 0x2::kiosk::borrow_mut<0x6f93b07b02b1443ae04a0d70495ac62be03d5ae17fe8780d88e04cf0bb5848c8::character_data::Character>(arg0, &v2, arg2);
        0x6f93b07b02b1443ae04a0d70495ac62be03d5ae17fe8780d88e04cf0bb5848c8::progression_logic::auto_release_if_time_passed(0x6f93b07b02b1443ae04a0d70495ac62be03d5ae17fe8780d88e04cf0bb5848c8::character_data::wanted_mut(v3), arg8);
        0x6f93b07b02b1443ae04a0d70495ac62be03d5ae17fe8780d88e04cf0bb5848c8::progression_logic::allocate_stat_points_character(v3, arg4, arg5, arg6, arg7);
        0x6f93b07b02b1443ae04a0d70495ac62be03d5ae17fe8780d88e04cf0bb5848c8::character_data::update_attributes(v3, arg3);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::return_val(arg1, v2, v1);
    }

    entry fun bribe_police_paid_from_kiosk(arg0: &mut 0x2::kiosk::Kiosk, arg1: &mut 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x6f93b07b02b1443ae04a0d70495ac62be03d5ae17fe8780d88e04cf0bb5848c8::billing::BillingConfig, arg5: &mut 0x6f93b07b02b1443ae04a0d70495ac62be03d5ae17fe8780d88e04cf0bb5848c8::billing::Treasury, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow_val(arg1);
        let v2 = v0;
        let v3 = 0x6f93b07b02b1443ae04a0d70495ac62be03d5ae17fe8780d88e04cf0bb5848c8::paid_services::bribe_police_paid(0x2::kiosk::borrow_mut<0x6f93b07b02b1443ae04a0d70495ac62be03d5ae17fe8780d88e04cf0bb5848c8::character_data::Character>(arg0, &v2, arg2), arg3, arg4, arg5, arg6, arg7);
        if (0x1::option::is_some<0x2::coin::Coin<0x2::sui::SUI>>(&v3)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x1::option::extract<0x2::coin::Coin<0x2::sui::SUI>>(&mut v3), 0x2::tx_context::sender(arg7));
        };
        0x1::option::destroy_none<0x2::coin::Coin<0x2::sui::SUI>>(v3);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::return_val(arg1, v2, v1);
    }

    entry fun customise_from_kiosk(arg0: &mut 0x2::kiosk::Kiosk, arg1: &mut 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg2: 0x2::object::ID, arg3: &0x6f93b07b02b1443ae04a0d70495ac62be03d5ae17fe8780d88e04cf0bb5848c8::game_data::GameData, arg4: &0x6f93b07b02b1443ae04a0d70495ac62be03d5ae17fe8780d88e04cf0bb5848c8::render_config::RenderConfig, arg5: vector<u64>, arg6: 0x1::option::Option<0x1::string::String>, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: &0x6f93b07b02b1443ae04a0d70495ac62be03d5ae17fe8780d88e04cf0bb5848c8::billing::BillingConfig, arg9: &mut 0x6f93b07b02b1443ae04a0d70495ac62be03d5ae17fe8780d88e04cf0bb5848c8::billing::Treasury, arg10: u64, arg11: vector<u8>, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x6f93b07b02b1443ae04a0d70495ac62be03d5ae17fe8780d88e04cf0bb5848c8::billing::charge(arg7, 0x6f93b07b02b1443ae04a0d70495ac62be03d5ae17fe8780d88e04cf0bb5848c8::constants::customization_price(), arg8, arg9, arg13);
        if (0x2::coin::value<0x2::sui::SUI>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v0, 0x2::tx_context::sender(arg13));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(v0);
        };
        let (v1, v2) = 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow_val(arg1);
        let v3 = v1;
        0x6f93b07b02b1443ae04a0d70495ac62be03d5ae17fe8780d88e04cf0bb5848c8::customization::customise(0x2::kiosk::borrow_mut<0x6f93b07b02b1443ae04a0d70495ac62be03d5ae17fe8780d88e04cf0bb5848c8::character_data::Character>(arg0, &v3, arg2), arg3, arg4, arg5, arg6, arg10, arg11, arg12);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::return_val(arg1, v3, v2);
    }

    entry fun customise_local_from_kiosk(arg0: &mut 0x2::kiosk::Kiosk, arg1: &mut 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg2: 0x2::object::ID, arg3: &0x6f93b07b02b1443ae04a0d70495ac62be03d5ae17fe8780d88e04cf0bb5848c8::game_data::GameData, arg4: &0x6f93b07b02b1443ae04a0d70495ac62be03d5ae17fe8780d88e04cf0bb5848c8::render_config::RenderConfig, arg5: vector<u64>, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &0x6f93b07b02b1443ae04a0d70495ac62be03d5ae17fe8780d88e04cf0bb5848c8::billing::BillingConfig, arg8: &mut 0x6f93b07b02b1443ae04a0d70495ac62be03d5ae17fe8780d88e04cf0bb5848c8::billing::Treasury, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x6f93b07b02b1443ae04a0d70495ac62be03d5ae17fe8780d88e04cf0bb5848c8::billing::charge(arg6, 0x6f93b07b02b1443ae04a0d70495ac62be03d5ae17fe8780d88e04cf0bb5848c8::constants::customization_price(), arg7, arg8, arg10);
        if (0x2::coin::value<0x2::sui::SUI>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v0, 0x2::tx_context::sender(arg10));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(v0);
        };
        let (v1, v2) = 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow_val(arg1);
        let v3 = v1;
        0x6f93b07b02b1443ae04a0d70495ac62be03d5ae17fe8780d88e04cf0bb5848c8::customization::customise_local(0x2::kiosk::borrow_mut<0x6f93b07b02b1443ae04a0d70495ac62be03d5ae17fe8780d88e04cf0bb5848c8::character_data::Character>(arg0, &v3, arg2), arg3, arg4, arg5, arg9);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::return_val(arg1, v3, v2);
    }

    entry fun enchant_item_from_kiosk(arg0: &mut 0x2::kiosk::Kiosk, arg1: &mut 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg2: 0x2::object::ID, arg3: &0x6f93b07b02b1443ae04a0d70495ac62be03d5ae17fe8780d88e04cf0bb5848c8::game_data::GameData, arg4: u64, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &0x6f93b07b02b1443ae04a0d70495ac62be03d5ae17fe8780d88e04cf0bb5848c8::billing::BillingConfig, arg7: &mut 0x6f93b07b02b1443ae04a0d70495ac62be03d5ae17fe8780d88e04cf0bb5848c8::billing::Treasury, arg8: &0x2::random::Random, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow_val(arg1);
        let v2 = v0;
        let v3 = 0x2::kiosk::borrow_mut<0x6f93b07b02b1443ae04a0d70495ac62be03d5ae17fe8780d88e04cf0bb5848c8::character_data::Character>(arg0, &v2, arg2);
        let (v4, v5) = 0x6f93b07b02b1443ae04a0d70495ac62be03d5ae17fe8780d88e04cf0bb5848c8::paid_services::enchant_item_paid(v3, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
        let v6 = v5;
        let v7 = v4;
        if (0x1::option::is_some<0x2::coin::Coin<0x2::sui::SUI>>(&v6)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x1::option::extract<0x2::coin::Coin<0x2::sui::SUI>>(&mut v6), 0x2::tx_context::sender(arg9));
        };
        0x1::option::destroy_none<0x2::coin::Coin<0x2::sui::SUI>>(v6);
        0x6f93b07b02b1443ae04a0d70495ac62be03d5ae17fe8780d88e04cf0bb5848c8::entry::emit_item_enchanted_event(0x2::tx_context::sender(arg9), 0x2::object::id<0x6f93b07b02b1443ae04a0d70495ac62be03d5ae17fe8780d88e04cf0bb5848c8::character_data::Character>(v3), 0x6f93b07b02b1443ae04a0d70495ac62be03d5ae17fe8780d88e04cf0bb5848c8::enchantment_logic::result_item_id(&v7), 0x6f93b07b02b1443ae04a0d70495ac62be03d5ae17fe8780d88e04cf0bb5848c8::enchantment_logic::result_rarity(&v7), 0x6f93b07b02b1443ae04a0d70495ac62be03d5ae17fe8780d88e04cf0bb5848c8::enchantment_logic::result_budget(&v7), 0x6f93b07b02b1443ae04a0d70495ac62be03d5ae17fe8780d88e04cf0bb5848c8::enchantment_logic::result_agility_bonus(&v7), 0x6f93b07b02b1443ae04a0d70495ac62be03d5ae17fe8780d88e04cf0bb5848c8::enchantment_logic::result_endurance_bonus(&v7), 0x6f93b07b02b1443ae04a0d70495ac62be03d5ae17fe8780d88e04cf0bb5848c8::enchantment_logic::result_stealth_bonus(&v7), 0x6f93b07b02b1443ae04a0d70495ac62be03d5ae17fe8780d88e04cf0bb5848c8::enchantment_logic::result_luck_bonus(&v7), 0x6f93b07b02b1443ae04a0d70495ac62be03d5ae17fe8780d88e04cf0bb5848c8::enchantment_logic::result_was_reroll(&v7), arg9);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::return_val(arg1, v2, v1);
    }

    entry fun join_faction_from_kiosk(arg0: &mut 0x2::kiosk::Kiosk, arg1: &mut 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg2: 0x2::object::ID, arg3: &0x6f93b07b02b1443ae04a0d70495ac62be03d5ae17fe8780d88e04cf0bb5848c8::game_data::GameData, arg4: u64) {
        let (v0, v1) = 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow_val(arg1);
        let v2 = v0;
        0x6f93b07b02b1443ae04a0d70495ac62be03d5ae17fe8780d88e04cf0bb5848c8::faction_selection::set_faction(0x2::kiosk::borrow_mut<0x6f93b07b02b1443ae04a0d70495ac62be03d5ae17fe8780d88e04cf0bb5848c8::character_data::Character>(arg0, &v2, arg2), arg3, arg4);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::return_val(arg1, v2, v1);
    }

    entry fun raid_and_emit_details_from_kiosk(arg0: &mut 0x2::kiosk::Kiosk, arg1: &mut 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg2: 0x2::object::ID, arg3: &mut 0x6f93b07b02b1443ae04a0d70495ac62be03d5ae17fe8780d88e04cf0bb5848c8::game_data::GameData, arg4: &0x6f93b07b02b1443ae04a0d70495ac62be03d5ae17fe8780d88e04cf0bb5848c8::global_buffs::GlobalBuffs, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &0x6f93b07b02b1443ae04a0d70495ac62be03d5ae17fe8780d88e04cf0bb5848c8::billing::BillingConfig, arg7: &mut 0x6f93b07b02b1443ae04a0d70495ac62be03d5ae17fe8780d88e04cf0bb5848c8::billing::Treasury, arg8: &0x2::random::Random, arg9: &0x2::clock::Clock, arg10: 0x1::option::Option<u64>, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x6f93b07b02b1443ae04a0d70495ac62be03d5ae17fe8780d88e04cf0bb5848c8::billing::charge(arg5, 0x6f93b07b02b1443ae04a0d70495ac62be03d5ae17fe8780d88e04cf0bb5848c8::constants::raid_price(), arg6, arg7, arg11);
        if (0x2::coin::value<0x2::sui::SUI>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v0, 0x2::tx_context::sender(arg11));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(v0);
        };
        let (v1, v2) = 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow_val(arg1);
        let v3 = v1;
        let v4 = 0x6f93b07b02b1443ae04a0d70495ac62be03d5ae17fe8780d88e04cf0bb5848c8::character::go_raid_with_result(0x2::kiosk::borrow_mut<0x6f93b07b02b1443ae04a0d70495ac62be03d5ae17fe8780d88e04cf0bb5848c8::character_data::Character>(arg0, &v3, arg2), arg3, arg4, arg8, arg9, arg10, arg11);
        0x6f93b07b02b1443ae04a0d70495ac62be03d5ae17fe8780d88e04cf0bb5848c8::entry::emit_raid_resolved_event(0x2::tx_context::sender(arg11), *0x6f93b07b02b1443ae04a0d70495ac62be03d5ae17fe8780d88e04cf0bb5848c8::raid_result::attempted_item_id(&v4), 0x6f93b07b02b1443ae04a0d70495ac62be03d5ae17fe8780d88e04cf0bb5848c8::raid_result::item_obtained(&v4), 0x6f93b07b02b1443ae04a0d70495ac62be03d5ae17fe8780d88e04cf0bb5848c8::raid_result::item_confiscated(&v4), 0x6f93b07b02b1443ae04a0d70495ac62be03d5ae17fe8780d88e04cf0bb5848c8::raid_result::arrest_attempted(&v4), 0x6f93b07b02b1443ae04a0d70495ac62be03d5ae17fe8780d88e04cf0bb5848c8::raid_result::avoided_arrest(&v4), *0x6f93b07b02b1443ae04a0d70495ac62be03d5ae17fe8780d88e04cf0bb5848c8::raid_result::save_reason(&v4), 0x6f93b07b02b1443ae04a0d70495ac62be03d5ae17fe8780d88e04cf0bb5848c8::raid_result::luck_triggered(&v4), *0x6f93b07b02b1443ae04a0d70495ac62be03d5ae17fe8780d88e04cf0bb5848c8::raid_result::original_item_id(&v4), *0x6f93b07b02b1443ae04a0d70495ac62be03d5ae17fe8780d88e04cf0bb5848c8::raid_result::luck_item_id(&v4), 0x6f93b07b02b1443ae04a0d70495ac62be03d5ae17fe8780d88e04cf0bb5848c8::raid_result::stamina_consumed(&v4), 0x6f93b07b02b1443ae04a0d70495ac62be03d5ae17fe8780d88e04cf0bb5848c8::raid_result::wanted_gained(&v4), arg11);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::return_val(arg1, v3, v2);
    }

    entry fun remove_item_from_kiosk(arg0: &mut 0x2::kiosk::Kiosk, arg1: &mut 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg2: 0x2::object::ID, arg3: &mut 0x6f93b07b02b1443ae04a0d70495ac62be03d5ae17fe8780d88e04cf0bb5848c8::game_data::GameData, arg4: u64) {
        let (v0, v1) = 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow_val(arg1);
        let v2 = v0;
        0x6f93b07b02b1443ae04a0d70495ac62be03d5ae17fe8780d88e04cf0bb5848c8::inventory_management::remove_item_by_instance_id(0x2::kiosk::borrow_mut<0x6f93b07b02b1443ae04a0d70495ac62be03d5ae17fe8780d88e04cf0bb5848c8::character_data::Character>(arg0, &v2, arg2), arg3, arg4);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::return_val(arg1, v2, v1);
    }

    entry fun reset_stats_paid_from_kiosk(arg0: &mut 0x2::kiosk::Kiosk, arg1: &mut 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg2: 0x2::object::ID, arg3: &0x6f93b07b02b1443ae04a0d70495ac62be03d5ae17fe8780d88e04cf0bb5848c8::game_data::GameData, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &0x6f93b07b02b1443ae04a0d70495ac62be03d5ae17fe8780d88e04cf0bb5848c8::billing::BillingConfig, arg6: &mut 0x6f93b07b02b1443ae04a0d70495ac62be03d5ae17fe8780d88e04cf0bb5848c8::billing::Treasury, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow_val(arg1);
        let v2 = v0;
        let v3 = 0x6f93b07b02b1443ae04a0d70495ac62be03d5ae17fe8780d88e04cf0bb5848c8::paid_services::reset_stats_paid(0x2::kiosk::borrow_mut<0x6f93b07b02b1443ae04a0d70495ac62be03d5ae17fe8780d88e04cf0bb5848c8::character_data::Character>(arg0, &v2, arg2), arg3, arg4, arg5, arg6, arg7);
        if (0x1::option::is_some<0x2::coin::Coin<0x2::sui::SUI>>(&v3)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x1::option::extract<0x2::coin::Coin<0x2::sui::SUI>>(&mut v3), 0x2::tx_context::sender(arg7));
        };
        0x1::option::destroy_none<0x2::coin::Coin<0x2::sui::SUI>>(v3);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::return_val(arg1, v2, v1);
    }

    entry fun restore_stamina_paid_from_kiosk(arg0: &mut 0x2::kiosk::Kiosk, arg1: &mut 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x6f93b07b02b1443ae04a0d70495ac62be03d5ae17fe8780d88e04cf0bb5848c8::billing::BillingConfig, arg5: &mut 0x6f93b07b02b1443ae04a0d70495ac62be03d5ae17fe8780d88e04cf0bb5848c8::billing::Treasury, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow_val(arg1);
        let v2 = v0;
        let v3 = 0x6f93b07b02b1443ae04a0d70495ac62be03d5ae17fe8780d88e04cf0bb5848c8::paid_services::restore_stamina_paid(0x2::kiosk::borrow_mut<0x6f93b07b02b1443ae04a0d70495ac62be03d5ae17fe8780d88e04cf0bb5848c8::character_data::Character>(arg0, &v2, arg2), arg3, arg4, arg5, arg6, arg7);
        if (0x1::option::is_some<0x2::coin::Coin<0x2::sui::SUI>>(&v3)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x1::option::extract<0x2::coin::Coin<0x2::sui::SUI>>(&mut v3), 0x2::tx_context::sender(arg7));
        };
        0x1::option::destroy_none<0x2::coin::Coin<0x2::sui::SUI>>(v3);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::return_val(arg1, v2, v1);
    }

    // decompiled from Move bytecode v6
}

