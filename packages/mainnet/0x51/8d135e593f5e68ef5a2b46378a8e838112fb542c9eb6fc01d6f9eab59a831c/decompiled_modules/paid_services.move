module 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::paid_services {
    public(friend) fun bribe_police_paid(arg0: &mut 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character_data::Character, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::billing::BillingConfig, arg3: &mut 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::billing::Treasury, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x2::coin::Coin<0x2::sui::SUI>> {
        0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::progression_logic::auto_release_if_time_passed(0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character_data::wanted_mut(arg0), arg4);
        0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::errors::assert_is_arrested(0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::progression::is_arrested(0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character_data::wanted(arg0)));
        let v0 = 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::billing::charge(arg1, 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::constants::police_bribe_price(), arg2, arg3, arg5);
        let v1 = if (0x2::coin::value<0x2::sui::SUI>(&v0) > 0) {
            0x1::option::some<0x2::coin::Coin<0x2::sui::SUI>>(v0)
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(v0);
            0x1::option::none<0x2::coin::Coin<0x2::sui::SUI>>()
        };
        0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::progression::escape_arrest(0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character_data::wanted_mut(arg0), 0x2::clock::timestamp_ms(arg4));
        v1
    }

    public(friend) fun enchant_item_paid(arg0: &mut 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character_data::Character, arg1: &0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::game_data::GameData, arg2: u64, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::billing::BillingConfig, arg5: &mut 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::billing::Treasury, arg6: &0x2::random::Random, arg7: &mut 0x2::tx_context::TxContext) : (0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::enchantment_logic::EnchantmentResult, 0x1::option::Option<0x2::coin::Coin<0x2::sui::SUI>>) {
        let v0 = 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::billing::charge(arg3, 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::constants::enchant_item_price(), arg4, arg5, arg7);
        0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::errors::assert_item_equipped(0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::inventory_management::is_type_equipped(arg0, 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::inventory_item::type_id(0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character_data::get_item_by_instance_id(arg0, arg2))));
        let v1 = if (0x2::coin::value<0x2::sui::SUI>(&v0) > 0) {
            0x1::option::some<0x2::coin::Coin<0x2::sui::SUI>>(v0)
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(v0);
            0x1::option::none<0x2::coin::Coin<0x2::sui::SUI>>()
        };
        (0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::enchantment_logic::enchant_inventory_slot(arg0, arg1, arg2, arg6, arg7), v1)
    }

    public(friend) fun reset_stats_paid(arg0: &mut 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character_data::Character, arg1: &0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::game_data::GameData, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::billing::BillingConfig, arg4: &mut 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::billing::Treasury, arg5: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x2::coin::Coin<0x2::sui::SUI>> {
        let v0 = 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::billing::charge(arg2, 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::constants::stat_reset_price(), arg3, arg4, arg5);
        let v1 = if (0x2::coin::value<0x2::sui::SUI>(&v0) > 0) {
            0x1::option::some<0x2::coin::Coin<0x2::sui::SUI>>(v0)
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(v0);
            0x1::option::none<0x2::coin::Coin<0x2::sui::SUI>>()
        };
        0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::stat_allocation_logic::reset_all_stats(arg0);
        0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character_data::update_attributes(arg0, arg1);
        v1
    }

    public(friend) fun restore_stamina_paid(arg0: &mut 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character_data::Character, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::billing::BillingConfig, arg3: &mut 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::billing::Treasury, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x2::coin::Coin<0x2::sui::SUI>> {
        let v0 = 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::billing::charge(arg1, 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::constants::stamina_restore_price(), arg2, arg3, arg5);
        let v1 = if (0x2::coin::value<0x2::sui::SUI>(&v0) > 0) {
            0x1::option::some<0x2::coin::Coin<0x2::sui::SUI>>(v0)
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(v0);
            0x1::option::none<0x2::coin::Coin<0x2::sui::SUI>>()
        };
        let v2 = 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::total_stats::calculate_total_stats(arg0);
        0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::progression_logic::restore_stamina_full_paid(0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character_data::stamina_mut(arg0), 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::total_stats::total_endurance(&v2), arg4);
        v1
    }

    // decompiled from Move bytecode v6
}

