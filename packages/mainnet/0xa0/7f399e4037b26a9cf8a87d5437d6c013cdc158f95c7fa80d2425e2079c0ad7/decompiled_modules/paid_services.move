module 0xa07f399e4037b26a9cf8a87d5437d6c013cdc158f95c7fa80d2425e2079c0ad7::paid_services {
    public(friend) fun bribe_police_paid(arg0: &mut 0xa07f399e4037b26a9cf8a87d5437d6c013cdc158f95c7fa80d2425e2079c0ad7::character_data::Character, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0xa07f399e4037b26a9cf8a87d5437d6c013cdc158f95c7fa80d2425e2079c0ad7::billing::BillingConfig, arg3: &mut 0xa07f399e4037b26a9cf8a87d5437d6c013cdc158f95c7fa80d2425e2079c0ad7::billing::Treasury, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x2::coin::Coin<0x2::sui::SUI>> {
        0xa07f399e4037b26a9cf8a87d5437d6c013cdc158f95c7fa80d2425e2079c0ad7::progression_logic::auto_release_if_time_passed(0xa07f399e4037b26a9cf8a87d5437d6c013cdc158f95c7fa80d2425e2079c0ad7::character_data::wanted_mut(arg0), arg4);
        0xa07f399e4037b26a9cf8a87d5437d6c013cdc158f95c7fa80d2425e2079c0ad7::errors::assert_is_arrested(0xa07f399e4037b26a9cf8a87d5437d6c013cdc158f95c7fa80d2425e2079c0ad7::progression::is_arrested(0xa07f399e4037b26a9cf8a87d5437d6c013cdc158f95c7fa80d2425e2079c0ad7::character_data::wanted(arg0)));
        let v0 = 0xa07f399e4037b26a9cf8a87d5437d6c013cdc158f95c7fa80d2425e2079c0ad7::billing::charge(arg1, 0xa07f399e4037b26a9cf8a87d5437d6c013cdc158f95c7fa80d2425e2079c0ad7::constants::police_bribe_price(), arg2, arg3, arg5);
        let v1 = if (0x2::coin::value<0x2::sui::SUI>(&v0) > 0) {
            0x1::option::some<0x2::coin::Coin<0x2::sui::SUI>>(v0)
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(v0);
            0x1::option::none<0x2::coin::Coin<0x2::sui::SUI>>()
        };
        0xa07f399e4037b26a9cf8a87d5437d6c013cdc158f95c7fa80d2425e2079c0ad7::progression::escape_arrest(0xa07f399e4037b26a9cf8a87d5437d6c013cdc158f95c7fa80d2425e2079c0ad7::character_data::wanted_mut(arg0), 0x2::clock::timestamp_ms(arg4));
        v1
    }

    public(friend) fun enchant_item_paid(arg0: &mut 0xa07f399e4037b26a9cf8a87d5437d6c013cdc158f95c7fa80d2425e2079c0ad7::character_data::Character, arg1: &0xa07f399e4037b26a9cf8a87d5437d6c013cdc158f95c7fa80d2425e2079c0ad7::game_data::GameData, arg2: u64, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0xa07f399e4037b26a9cf8a87d5437d6c013cdc158f95c7fa80d2425e2079c0ad7::billing::BillingConfig, arg5: &mut 0xa07f399e4037b26a9cf8a87d5437d6c013cdc158f95c7fa80d2425e2079c0ad7::billing::Treasury, arg6: &0x2::random::Random, arg7: &mut 0x2::tx_context::TxContext) : (0xa07f399e4037b26a9cf8a87d5437d6c013cdc158f95c7fa80d2425e2079c0ad7::enchantment_logic::EnchantmentResult, 0x1::option::Option<0x2::coin::Coin<0x2::sui::SUI>>) {
        let v0 = 0xa07f399e4037b26a9cf8a87d5437d6c013cdc158f95c7fa80d2425e2079c0ad7::billing::charge(arg3, 0xa07f399e4037b26a9cf8a87d5437d6c013cdc158f95c7fa80d2425e2079c0ad7::constants::enchant_item_price(), arg4, arg5, arg7);
        let v1 = if (0x2::coin::value<0x2::sui::SUI>(&v0) > 0) {
            0x1::option::some<0x2::coin::Coin<0x2::sui::SUI>>(v0)
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(v0);
            0x1::option::none<0x2::coin::Coin<0x2::sui::SUI>>()
        };
        (0xa07f399e4037b26a9cf8a87d5437d6c013cdc158f95c7fa80d2425e2079c0ad7::enchantment_logic::enchant_inventory_slot(arg0, arg1, arg2, arg6, arg7), v1)
    }

    public(friend) fun reset_stats_paid(arg0: &mut 0xa07f399e4037b26a9cf8a87d5437d6c013cdc158f95c7fa80d2425e2079c0ad7::character_data::Character, arg1: &0xa07f399e4037b26a9cf8a87d5437d6c013cdc158f95c7fa80d2425e2079c0ad7::game_data::GameData, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0xa07f399e4037b26a9cf8a87d5437d6c013cdc158f95c7fa80d2425e2079c0ad7::billing::BillingConfig, arg4: &mut 0xa07f399e4037b26a9cf8a87d5437d6c013cdc158f95c7fa80d2425e2079c0ad7::billing::Treasury, arg5: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x2::coin::Coin<0x2::sui::SUI>> {
        let v0 = 0xa07f399e4037b26a9cf8a87d5437d6c013cdc158f95c7fa80d2425e2079c0ad7::billing::charge(arg2, 0xa07f399e4037b26a9cf8a87d5437d6c013cdc158f95c7fa80d2425e2079c0ad7::constants::stat_reset_price(), arg3, arg4, arg5);
        let v1 = if (0x2::coin::value<0x2::sui::SUI>(&v0) > 0) {
            0x1::option::some<0x2::coin::Coin<0x2::sui::SUI>>(v0)
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(v0);
            0x1::option::none<0x2::coin::Coin<0x2::sui::SUI>>()
        };
        0xa07f399e4037b26a9cf8a87d5437d6c013cdc158f95c7fa80d2425e2079c0ad7::stat_allocation_logic::reset_all_stats(arg0);
        0xa07f399e4037b26a9cf8a87d5437d6c013cdc158f95c7fa80d2425e2079c0ad7::character_data::update_attributes(arg0, arg1);
        v1
    }

    public(friend) fun restore_stamina_paid(arg0: &mut 0xa07f399e4037b26a9cf8a87d5437d6c013cdc158f95c7fa80d2425e2079c0ad7::character_data::Character, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0xa07f399e4037b26a9cf8a87d5437d6c013cdc158f95c7fa80d2425e2079c0ad7::billing::BillingConfig, arg3: &mut 0xa07f399e4037b26a9cf8a87d5437d6c013cdc158f95c7fa80d2425e2079c0ad7::billing::Treasury, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x2::coin::Coin<0x2::sui::SUI>> {
        let v0 = 0xa07f399e4037b26a9cf8a87d5437d6c013cdc158f95c7fa80d2425e2079c0ad7::billing::charge(arg1, 0xa07f399e4037b26a9cf8a87d5437d6c013cdc158f95c7fa80d2425e2079c0ad7::constants::stamina_restore_price(), arg2, arg3, arg5);
        let v1 = if (0x2::coin::value<0x2::sui::SUI>(&v0) > 0) {
            0x1::option::some<0x2::coin::Coin<0x2::sui::SUI>>(v0)
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(v0);
            0x1::option::none<0x2::coin::Coin<0x2::sui::SUI>>()
        };
        let v2 = 0xa07f399e4037b26a9cf8a87d5437d6c013cdc158f95c7fa80d2425e2079c0ad7::total_stats::calculate_total_stats(arg0);
        0xa07f399e4037b26a9cf8a87d5437d6c013cdc158f95c7fa80d2425e2079c0ad7::progression_logic::restore_stamina_full_paid(0xa07f399e4037b26a9cf8a87d5437d6c013cdc158f95c7fa80d2425e2079c0ad7::character_data::stamina_mut(arg0), 0xa07f399e4037b26a9cf8a87d5437d6c013cdc158f95c7fa80d2425e2079c0ad7::total_stats::total_endurance(&v2), arg4);
        v1
    }

    // decompiled from Move bytecode v6
}

