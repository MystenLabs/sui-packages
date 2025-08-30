module 0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::paid_services {
    public(friend) fun bribe_police_paid(arg0: &mut 0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::character_data::Character, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::billing::BillingConfig, arg3: &mut 0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::billing::Treasury, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x2::coin::Coin<0x2::sui::SUI>> {
        0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::progression_logic::auto_release_if_time_passed(0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::character_data::wanted_mut(arg0), arg4);
        0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::errors::assert_is_arrested(0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::progression::is_arrested(0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::character_data::wanted(arg0)));
        let v0 = 0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::billing::charge(arg1, 0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::constants::police_bribe_price(), arg2, arg3, arg5);
        let v1 = if (0x2::coin::value<0x2::sui::SUI>(&v0) > 0) {
            0x1::option::some<0x2::coin::Coin<0x2::sui::SUI>>(v0)
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(v0);
            0x1::option::none<0x2::coin::Coin<0x2::sui::SUI>>()
        };
        0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::progression::escape_arrest(0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::character_data::wanted_mut(arg0), 0x2::clock::timestamp_ms(arg4));
        v1
    }

    public(friend) fun enchant_item_paid(arg0: &mut 0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::character_data::Character, arg1: &0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::game_data::GameData, arg2: u64, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::billing::BillingConfig, arg5: &mut 0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::billing::Treasury, arg6: &0x2::random::Random, arg7: &mut 0x2::tx_context::TxContext) : (0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::enchantment_logic::EnchantmentResult, 0x1::option::Option<0x2::coin::Coin<0x2::sui::SUI>>) {
        let v0 = 0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::billing::charge(arg3, 0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::constants::enchant_item_price(), arg4, arg5, arg7);
        let v1 = if (0x2::coin::value<0x2::sui::SUI>(&v0) > 0) {
            0x1::option::some<0x2::coin::Coin<0x2::sui::SUI>>(v0)
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(v0);
            0x1::option::none<0x2::coin::Coin<0x2::sui::SUI>>()
        };
        (0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::enchantment_logic::enchant_inventory_slot(arg0, arg1, arg2, arg6, arg7), v1)
    }

    public(friend) fun reset_stats_paid(arg0: &mut 0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::character_data::Character, arg1: &0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::game_data::GameData, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::billing::BillingConfig, arg4: &mut 0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::billing::Treasury, arg5: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x2::coin::Coin<0x2::sui::SUI>> {
        let v0 = 0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::billing::charge(arg2, 0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::constants::stat_reset_price(), arg3, arg4, arg5);
        let v1 = if (0x2::coin::value<0x2::sui::SUI>(&v0) > 0) {
            0x1::option::some<0x2::coin::Coin<0x2::sui::SUI>>(v0)
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(v0);
            0x1::option::none<0x2::coin::Coin<0x2::sui::SUI>>()
        };
        0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::stat_allocation_logic::reset_all_stats(arg0);
        0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::character_data::update_attributes(arg0, arg1);
        v1
    }

    public(friend) fun restore_stamina_paid(arg0: &mut 0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::character_data::Character, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::billing::BillingConfig, arg3: &mut 0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::billing::Treasury, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x2::coin::Coin<0x2::sui::SUI>> {
        let v0 = 0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::billing::charge(arg1, 0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::constants::stamina_restore_price(), arg2, arg3, arg5);
        let v1 = if (0x2::coin::value<0x2::sui::SUI>(&v0) > 0) {
            0x1::option::some<0x2::coin::Coin<0x2::sui::SUI>>(v0)
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(v0);
            0x1::option::none<0x2::coin::Coin<0x2::sui::SUI>>()
        };
        let v2 = 0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::total_stats::calculate_total_stats(arg0);
        0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::progression_logic::restore_stamina_full_paid(0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::character_data::stamina_mut(arg0), 0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::total_stats::total_endurance(&v2), arg4);
        v1
    }

    // decompiled from Move bytecode v6
}

