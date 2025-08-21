module 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::entry_kiosk {
    entry fun allocate_stats_from_kiosk(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: &0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::game_data::GameData, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock) {
        let v0 = ch_mut(arg0, arg1, arg2);
        0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::progression_logic::auto_release_if_time_passed(0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character_data::wanted_mut(v0), arg8);
        0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::progression_logic::allocate_stat_points_character(v0, arg4, arg5, arg6, arg7);
        0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character_data::update_attributes(v0, arg3);
    }

    entry fun bribe_police_paid_from_kiosk(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::billing::BillingConfig, arg5: &mut 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::billing::Treasury, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::paid_services::bribe_police_paid(ch_mut(arg0, arg1, arg2), arg3, arg4, arg5, arg6, arg7);
        if (0x1::option::is_some<0x2::coin::Coin<0x2::sui::SUI>>(&v0)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x1::option::extract<0x2::coin::Coin<0x2::sui::SUI>>(&mut v0), 0x2::tx_context::sender(arg7));
        };
        0x1::option::destroy_none<0x2::coin::Coin<0x2::sui::SUI>>(v0);
    }

    fun ch_mut(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID) : &mut 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character_data::Character {
        0x2::kiosk::borrow_mut<0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character_data::Character>(arg0, arg1, arg2)
    }

    entry fun customise_from_kiosk(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: &0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::game_data::GameData, arg4: &0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::render_config::RenderConfig, arg5: u64, arg6: 0x1::option::Option<0x1::string::String>, arg7: u64, arg8: vector<u8>, arg9: &0x2::clock::Clock) {
        0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::customization::customise(ch_mut(arg0, arg1, arg2), arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    entry fun enchant_item_from_kiosk(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: &0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::game_data::GameData, arg4: u64, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::billing::BillingConfig, arg7: &mut 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::billing::Treasury, arg8: &0x2::random::Random, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = ch_mut(arg0, arg1, arg2);
        let (v1, v2) = 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::paid_services::enchant_item_paid(v0, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
        let v3 = v2;
        let v4 = v1;
        if (0x1::option::is_some<0x2::coin::Coin<0x2::sui::SUI>>(&v3)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x1::option::extract<0x2::coin::Coin<0x2::sui::SUI>>(&mut v3), 0x2::tx_context::sender(arg9));
        };
        0x1::option::destroy_none<0x2::coin::Coin<0x2::sui::SUI>>(v3);
        0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::entry::emit_item_enchanted_event(0x2::tx_context::sender(arg9), 0x2::object::id<0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character_data::Character>(v0), 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::enchantment_logic::result_item_id(&v4), 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::enchantment_logic::result_rarity(&v4), 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::enchantment_logic::result_budget(&v4), 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::enchantment_logic::result_agility_bonus(&v4), 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::enchantment_logic::result_endurance_bonus(&v4), 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::enchantment_logic::result_stealth_bonus(&v4), 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::enchantment_logic::result_luck_bonus(&v4), 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::enchantment_logic::result_was_reroll(&v4), arg9);
    }

    entry fun join_faction_from_kiosk(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: &0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::game_data::GameData, arg4: u64) {
        0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::faction_selection::set_faction(ch_mut(arg0, arg1, arg2), arg3, arg4);
    }

    entry fun raid_and_emit_details_from_kiosk(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: &mut 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::game_data::GameData, arg4: &0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::global_buffs::GlobalBuffs, arg5: &0x2::random::Random, arg6: &0x2::clock::Clock, arg7: 0x1::option::Option<u64>, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character::go_raid_with_result(ch_mut(arg0, arg1, arg2), arg3, arg4, arg5, arg6, arg7, arg8);
        0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::entry::emit_raid_resolved_event(0x2::tx_context::sender(arg8), *0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::raid_result::attempted_item_id(&v0), 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::raid_result::item_obtained(&v0), 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::raid_result::item_confiscated(&v0), 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::raid_result::arrest_attempted(&v0), 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::raid_result::avoided_arrest(&v0), *0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::raid_result::save_reason(&v0), 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::raid_result::luck_triggered(&v0), *0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::raid_result::original_item_id(&v0), *0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::raid_result::luck_item_id(&v0), 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::raid_result::stamina_consumed(&v0), 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::raid_result::wanted_gained(&v0), arg8);
    }

    entry fun remove_item_from_kiosk(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: &mut 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::game_data::GameData, arg4: u64) {
        0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::inventory_management::remove_item_by_instance_id(ch_mut(arg0, arg1, arg2), arg3, arg4);
    }

    entry fun reset_stats_paid_from_kiosk(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: &0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::game_data::GameData, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::billing::BillingConfig, arg6: &mut 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::billing::Treasury, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::paid_services::reset_stats_paid(ch_mut(arg0, arg1, arg2), arg3, arg4, arg5, arg6, arg7);
        if (0x1::option::is_some<0x2::coin::Coin<0x2::sui::SUI>>(&v0)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x1::option::extract<0x2::coin::Coin<0x2::sui::SUI>>(&mut v0), 0x2::tx_context::sender(arg7));
        };
        0x1::option::destroy_none<0x2::coin::Coin<0x2::sui::SUI>>(v0);
    }

    entry fun restore_stamina_paid_from_kiosk(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::billing::BillingConfig, arg5: &mut 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::billing::Treasury, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::paid_services::restore_stamina_paid(ch_mut(arg0, arg1, arg2), arg3, arg4, arg5, arg6, arg7);
        if (0x1::option::is_some<0x2::coin::Coin<0x2::sui::SUI>>(&v0)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x1::option::extract<0x2::coin::Coin<0x2::sui::SUI>>(&mut v0), 0x2::tx_context::sender(arg7));
        };
        0x1::option::destroy_none<0x2::coin::Coin<0x2::sui::SUI>>(v0);
    }

    // decompiled from Move bytecode v6
}

