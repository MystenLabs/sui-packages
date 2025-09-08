module 0xa8ff12fc9da0117c8e85e8970b87e9470bcbc1e774d469a47b826ca268b5e97::entry_kiosk {
    entry fun allocate_stats_from_kiosk(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: &0xa8ff12fc9da0117c8e85e8970b87e9470bcbc1e774d469a47b826ca268b5e97::game_data::GameData, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock) {
        let v0 = ch_mut(arg0, arg1, arg2);
        0xa8ff12fc9da0117c8e85e8970b87e9470bcbc1e774d469a47b826ca268b5e97::progression_logic::auto_release_if_time_passed(0xa8ff12fc9da0117c8e85e8970b87e9470bcbc1e774d469a47b826ca268b5e97::character_data::wanted_mut(v0), arg8);
        0xa8ff12fc9da0117c8e85e8970b87e9470bcbc1e774d469a47b826ca268b5e97::progression_logic::allocate_stat_points_character(v0, arg4, arg5, arg6, arg7);
        0xa8ff12fc9da0117c8e85e8970b87e9470bcbc1e774d469a47b826ca268b5e97::character_data::update_attributes(v0, arg3);
    }

    entry fun bribe_police_paid_from_kiosk(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0xa8ff12fc9da0117c8e85e8970b87e9470bcbc1e774d469a47b826ca268b5e97::billing::BillingConfig, arg5: &mut 0xa8ff12fc9da0117c8e85e8970b87e9470bcbc1e774d469a47b826ca268b5e97::billing::Treasury, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xa8ff12fc9da0117c8e85e8970b87e9470bcbc1e774d469a47b826ca268b5e97::paid_services::bribe_police_paid(ch_mut(arg0, arg1, arg2), arg3, arg4, arg5, arg6, arg7);
        if (0x1::option::is_some<0x2::coin::Coin<0x2::sui::SUI>>(&v0)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x1::option::extract<0x2::coin::Coin<0x2::sui::SUI>>(&mut v0), 0x2::tx_context::sender(arg7));
        };
        0x1::option::destroy_none<0x2::coin::Coin<0x2::sui::SUI>>(v0);
    }

    fun ch_mut(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID) : &mut 0xa8ff12fc9da0117c8e85e8970b87e9470bcbc1e774d469a47b826ca268b5e97::character_data::Character {
        0x2::kiosk::borrow_mut<0xa8ff12fc9da0117c8e85e8970b87e9470bcbc1e774d469a47b826ca268b5e97::character_data::Character>(arg0, arg1, arg2)
    }

    entry fun customise_from_kiosk(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: &0xa8ff12fc9da0117c8e85e8970b87e9470bcbc1e774d469a47b826ca268b5e97::game_data::GameData, arg4: &0xa8ff12fc9da0117c8e85e8970b87e9470bcbc1e774d469a47b826ca268b5e97::render_config::RenderConfig, arg5: vector<u64>, arg6: 0x1::option::Option<0x1::string::String>, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: &0xa8ff12fc9da0117c8e85e8970b87e9470bcbc1e774d469a47b826ca268b5e97::billing::BillingConfig, arg9: &mut 0xa8ff12fc9da0117c8e85e8970b87e9470bcbc1e774d469a47b826ca268b5e97::billing::Treasury, arg10: u64, arg11: vector<u8>, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xa8ff12fc9da0117c8e85e8970b87e9470bcbc1e774d469a47b826ca268b5e97::billing::charge(arg7, 0xa8ff12fc9da0117c8e85e8970b87e9470bcbc1e774d469a47b826ca268b5e97::constants::customization_price(), arg8, arg9, arg13);
        if (0x2::coin::value<0x2::sui::SUI>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v0, 0x2::tx_context::sender(arg13));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(v0);
        };
        0xa8ff12fc9da0117c8e85e8970b87e9470bcbc1e774d469a47b826ca268b5e97::customization::customise(ch_mut(arg0, arg1, arg2), arg3, arg4, arg5, arg6, arg10, arg11, arg12);
    }

    entry fun customise_local_from_kiosk(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: &0xa8ff12fc9da0117c8e85e8970b87e9470bcbc1e774d469a47b826ca268b5e97::game_data::GameData, arg4: &0xa8ff12fc9da0117c8e85e8970b87e9470bcbc1e774d469a47b826ca268b5e97::render_config::RenderConfig, arg5: vector<u64>, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &0xa8ff12fc9da0117c8e85e8970b87e9470bcbc1e774d469a47b826ca268b5e97::billing::BillingConfig, arg8: &mut 0xa8ff12fc9da0117c8e85e8970b87e9470bcbc1e774d469a47b826ca268b5e97::billing::Treasury, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xa8ff12fc9da0117c8e85e8970b87e9470bcbc1e774d469a47b826ca268b5e97::billing::charge(arg6, 0xa8ff12fc9da0117c8e85e8970b87e9470bcbc1e774d469a47b826ca268b5e97::constants::customization_price(), arg7, arg8, arg10);
        if (0x2::coin::value<0x2::sui::SUI>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v0, 0x2::tx_context::sender(arg10));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(v0);
        };
        0xa8ff12fc9da0117c8e85e8970b87e9470bcbc1e774d469a47b826ca268b5e97::customization::customise_local(ch_mut(arg0, arg1, arg2), arg3, arg4, arg5, arg9);
    }

    entry fun enchant_item_from_kiosk(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: &0xa8ff12fc9da0117c8e85e8970b87e9470bcbc1e774d469a47b826ca268b5e97::game_data::GameData, arg4: u64, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &0xa8ff12fc9da0117c8e85e8970b87e9470bcbc1e774d469a47b826ca268b5e97::billing::BillingConfig, arg7: &mut 0xa8ff12fc9da0117c8e85e8970b87e9470bcbc1e774d469a47b826ca268b5e97::billing::Treasury, arg8: &0x2::random::Random, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = ch_mut(arg0, arg1, arg2);
        let (v1, v2) = 0xa8ff12fc9da0117c8e85e8970b87e9470bcbc1e774d469a47b826ca268b5e97::paid_services::enchant_item_paid(v0, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
        let v3 = v2;
        let v4 = v1;
        if (0x1::option::is_some<0x2::coin::Coin<0x2::sui::SUI>>(&v3)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x1::option::extract<0x2::coin::Coin<0x2::sui::SUI>>(&mut v3), 0x2::tx_context::sender(arg9));
        };
        0x1::option::destroy_none<0x2::coin::Coin<0x2::sui::SUI>>(v3);
        0xa8ff12fc9da0117c8e85e8970b87e9470bcbc1e774d469a47b826ca268b5e97::entry::emit_item_enchanted_event(0x2::tx_context::sender(arg9), 0x2::object::id<0xa8ff12fc9da0117c8e85e8970b87e9470bcbc1e774d469a47b826ca268b5e97::character_data::Character>(v0), 0xa8ff12fc9da0117c8e85e8970b87e9470bcbc1e774d469a47b826ca268b5e97::enchantment_logic::result_item_id(&v4), 0xa8ff12fc9da0117c8e85e8970b87e9470bcbc1e774d469a47b826ca268b5e97::enchantment_logic::result_rarity(&v4), 0xa8ff12fc9da0117c8e85e8970b87e9470bcbc1e774d469a47b826ca268b5e97::enchantment_logic::result_budget(&v4), 0xa8ff12fc9da0117c8e85e8970b87e9470bcbc1e774d469a47b826ca268b5e97::enchantment_logic::result_agility_bonus(&v4), 0xa8ff12fc9da0117c8e85e8970b87e9470bcbc1e774d469a47b826ca268b5e97::enchantment_logic::result_endurance_bonus(&v4), 0xa8ff12fc9da0117c8e85e8970b87e9470bcbc1e774d469a47b826ca268b5e97::enchantment_logic::result_stealth_bonus(&v4), 0xa8ff12fc9da0117c8e85e8970b87e9470bcbc1e774d469a47b826ca268b5e97::enchantment_logic::result_luck_bonus(&v4), 0xa8ff12fc9da0117c8e85e8970b87e9470bcbc1e774d469a47b826ca268b5e97::enchantment_logic::result_was_reroll(&v4), arg9);
    }

    entry fun join_faction_from_kiosk(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: &0xa8ff12fc9da0117c8e85e8970b87e9470bcbc1e774d469a47b826ca268b5e97::game_data::GameData, arg4: u64) {
        0xa8ff12fc9da0117c8e85e8970b87e9470bcbc1e774d469a47b826ca268b5e97::faction_selection::set_faction(ch_mut(arg0, arg1, arg2), arg3, arg4);
    }

    entry fun raid_and_emit_details_from_kiosk(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: &mut 0xa8ff12fc9da0117c8e85e8970b87e9470bcbc1e774d469a47b826ca268b5e97::game_data::GameData, arg4: &0xa8ff12fc9da0117c8e85e8970b87e9470bcbc1e774d469a47b826ca268b5e97::global_buffs::GlobalBuffs, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &0xa8ff12fc9da0117c8e85e8970b87e9470bcbc1e774d469a47b826ca268b5e97::billing::BillingConfig, arg7: &mut 0xa8ff12fc9da0117c8e85e8970b87e9470bcbc1e774d469a47b826ca268b5e97::billing::Treasury, arg8: &0x2::random::Random, arg9: &0x2::clock::Clock, arg10: 0x1::option::Option<u64>, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xa8ff12fc9da0117c8e85e8970b87e9470bcbc1e774d469a47b826ca268b5e97::billing::charge(arg5, 0xa8ff12fc9da0117c8e85e8970b87e9470bcbc1e774d469a47b826ca268b5e97::constants::raid_price(), arg6, arg7, arg11);
        if (0x2::coin::value<0x2::sui::SUI>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v0, 0x2::tx_context::sender(arg11));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(v0);
        };
        let v1 = 0xa8ff12fc9da0117c8e85e8970b87e9470bcbc1e774d469a47b826ca268b5e97::character::go_raid_with_result(ch_mut(arg0, arg1, arg2), arg3, arg4, arg8, arg9, arg10, arg11);
        0xa8ff12fc9da0117c8e85e8970b87e9470bcbc1e774d469a47b826ca268b5e97::entry::emit_raid_resolved_event(0x2::tx_context::sender(arg11), *0xa8ff12fc9da0117c8e85e8970b87e9470bcbc1e774d469a47b826ca268b5e97::raid_result::attempted_item_id(&v1), 0xa8ff12fc9da0117c8e85e8970b87e9470bcbc1e774d469a47b826ca268b5e97::raid_result::item_obtained(&v1), 0xa8ff12fc9da0117c8e85e8970b87e9470bcbc1e774d469a47b826ca268b5e97::raid_result::item_confiscated(&v1), 0xa8ff12fc9da0117c8e85e8970b87e9470bcbc1e774d469a47b826ca268b5e97::raid_result::arrest_attempted(&v1), 0xa8ff12fc9da0117c8e85e8970b87e9470bcbc1e774d469a47b826ca268b5e97::raid_result::avoided_arrest(&v1), *0xa8ff12fc9da0117c8e85e8970b87e9470bcbc1e774d469a47b826ca268b5e97::raid_result::save_reason(&v1), 0xa8ff12fc9da0117c8e85e8970b87e9470bcbc1e774d469a47b826ca268b5e97::raid_result::luck_triggered(&v1), *0xa8ff12fc9da0117c8e85e8970b87e9470bcbc1e774d469a47b826ca268b5e97::raid_result::original_item_id(&v1), *0xa8ff12fc9da0117c8e85e8970b87e9470bcbc1e774d469a47b826ca268b5e97::raid_result::luck_item_id(&v1), 0xa8ff12fc9da0117c8e85e8970b87e9470bcbc1e774d469a47b826ca268b5e97::raid_result::stamina_consumed(&v1), 0xa8ff12fc9da0117c8e85e8970b87e9470bcbc1e774d469a47b826ca268b5e97::raid_result::wanted_gained(&v1), arg11);
    }

    entry fun remove_item_from_kiosk(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: &mut 0xa8ff12fc9da0117c8e85e8970b87e9470bcbc1e774d469a47b826ca268b5e97::game_data::GameData, arg4: u64) {
        0xa8ff12fc9da0117c8e85e8970b87e9470bcbc1e774d469a47b826ca268b5e97::inventory_management::remove_item_by_instance_id(ch_mut(arg0, arg1, arg2), arg3, arg4);
    }

    entry fun reset_stats_paid_from_kiosk(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: &0xa8ff12fc9da0117c8e85e8970b87e9470bcbc1e774d469a47b826ca268b5e97::game_data::GameData, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &0xa8ff12fc9da0117c8e85e8970b87e9470bcbc1e774d469a47b826ca268b5e97::billing::BillingConfig, arg6: &mut 0xa8ff12fc9da0117c8e85e8970b87e9470bcbc1e774d469a47b826ca268b5e97::billing::Treasury, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xa8ff12fc9da0117c8e85e8970b87e9470bcbc1e774d469a47b826ca268b5e97::paid_services::reset_stats_paid(ch_mut(arg0, arg1, arg2), arg3, arg4, arg5, arg6, arg7);
        if (0x1::option::is_some<0x2::coin::Coin<0x2::sui::SUI>>(&v0)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x1::option::extract<0x2::coin::Coin<0x2::sui::SUI>>(&mut v0), 0x2::tx_context::sender(arg7));
        };
        0x1::option::destroy_none<0x2::coin::Coin<0x2::sui::SUI>>(v0);
    }

    entry fun restore_stamina_paid_from_kiosk(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0xa8ff12fc9da0117c8e85e8970b87e9470bcbc1e774d469a47b826ca268b5e97::billing::BillingConfig, arg5: &mut 0xa8ff12fc9da0117c8e85e8970b87e9470bcbc1e774d469a47b826ca268b5e97::billing::Treasury, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xa8ff12fc9da0117c8e85e8970b87e9470bcbc1e774d469a47b826ca268b5e97::paid_services::restore_stamina_paid(ch_mut(arg0, arg1, arg2), arg3, arg4, arg5, arg6, arg7);
        if (0x1::option::is_some<0x2::coin::Coin<0x2::sui::SUI>>(&v0)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x1::option::extract<0x2::coin::Coin<0x2::sui::SUI>>(&mut v0), 0x2::tx_context::sender(arg7));
        };
        0x1::option::destroy_none<0x2::coin::Coin<0x2::sui::SUI>>(v0);
    }

    // decompiled from Move bytecode v6
}

