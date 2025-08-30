module 0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::enchantment_logic {
    struct EnchantmentResult has drop {
        item_id: u64,
        rarity: u8,
        budget: u64,
        agility_bonus: u64,
        endurance_bonus: u64,
        stealth_bonus: u64,
        luck_bonus: u64,
        was_reroll: bool,
    }

    fun budget_for_rarity(arg0: u8) : u64 {
        let v0 = if (arg0 == 0) {
            10000
        } else if (arg0 == 1) {
            11000
        } else if (arg0 == 2) {
            12500
        } else if (arg0 == 3) {
            15000
        } else {
            20000
        };
        (((50 as u128) * (v0 as u128) / (0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::constants::bp_den() as u128)) as u64)
    }

    fun determine_enchantment_rarity(arg0: &mut 0x2::random::RandomGenerator) : u8 {
        let v0 = 0x2::random::generate_u16_in_range(arg0, 0, 9999);
        let v1 = 0 + 80;
        if (v0 < v1) {
            return 4
        };
        let v2 = v1 + 320;
        if (v0 < v2) {
            return 3
        };
        let v3 = v2 + 900;
        if (v0 < v3) {
            return 2
        };
        if (v0 < v3 + 2000) {
            return 1
        };
        0
    }

    fun distribute_budget_randomly(arg0: u64, arg1: &mut 0x2::random::RandomGenerator) : (u64, u64, u64, u64) {
        if (arg0 == 0) {
            return (0, 0, 0, 0)
        };
        let v0 = 0x1::vector::empty<u64>();
        let v1 = 0;
        while (v1 <= arg0 + 2) {
            0x1::vector::push_back<u64>(&mut v0, v1);
            v1 = v1 + 1;
        };
        0x2::random::shuffle<u64>(arg1, &mut v0);
        let (v2, v3, v4) = sort_three_values(*0x1::vector::borrow<u64>(&v0, 0), *0x1::vector::borrow<u64>(&v0, 1), *0x1::vector::borrow<u64>(&v0, 2));
        let v5 = if (v3 > v2) {
            v3 - v2 - 1
        } else {
            0
        };
        let v6 = if (v4 > v3) {
            v4 - v3 - 1
        } else {
            0
        };
        (v2, v5, v6, arg0 - v2 - v5 - v6)
    }

    public(friend) fun enchant_inventory_slot(arg0: &mut 0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::character_data::Character, arg1: &0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::game_data::GameData, arg2: u64, arg3: &0x2::random::Random, arg4: &mut 0x2::tx_context::TxContext) : EnchantmentResult {
        let v0 = 0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::character_data::get_item_by_instance_id(arg0, arg2);
        let v1 = 0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::inventory_item::item_id(v0);
        let v2 = 0x2::random::new_generator(arg3, arg4);
        let v3 = if (0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::inventory_item::enchantment_rarity(v0) > 0) {
            true
        } else if (0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::inventory_item::agility_bonus(v0) > 0) {
            true
        } else if (0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::inventory_item::endurance_bonus(v0) > 0) {
            true
        } else if (0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::inventory_item::stealth_bonus(v0) > 0) {
            true
        } else {
            0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::inventory_item::luck_bonus(v0) > 0
        };
        let v4 = &mut v2;
        let v5 = determine_enchantment_rarity(v4);
        let v6 = budget_for_rarity(v5);
        let v7 = &mut v2;
        let (v8, v9, v10, v11) = distribute_budget_randomly(v6, v7);
        let v12 = 0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::character_data::get_item_by_instance_id_mut(arg0, arg2);
        0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::inventory_item::set_bonuses(v12, v8, v9, v10, v11, v5);
        if (0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::inventory_management::is_type_equipped(arg0, 0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::inventory_item::type_id(v12))) {
            0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::character_data::update_attributes(arg0, arg1);
        };
        EnchantmentResult{
            item_id         : v1,
            rarity          : v5,
            budget          : v6,
            agility_bonus   : v8,
            endurance_bonus : v9,
            stealth_bonus   : v10,
            luck_bonus      : v11,
            was_reroll      : v3,
        }
    }

    public(friend) fun result_agility_bonus(arg0: &EnchantmentResult) : u64 {
        arg0.agility_bonus
    }

    public(friend) fun result_budget(arg0: &EnchantmentResult) : u64 {
        arg0.budget
    }

    public(friend) fun result_endurance_bonus(arg0: &EnchantmentResult) : u64 {
        arg0.endurance_bonus
    }

    public(friend) fun result_item_id(arg0: &EnchantmentResult) : u64 {
        arg0.item_id
    }

    public(friend) fun result_luck_bonus(arg0: &EnchantmentResult) : u64 {
        arg0.luck_bonus
    }

    public(friend) fun result_rarity(arg0: &EnchantmentResult) : u8 {
        arg0.rarity
    }

    public(friend) fun result_stealth_bonus(arg0: &EnchantmentResult) : u64 {
        arg0.stealth_bonus
    }

    public(friend) fun result_was_reroll(arg0: &EnchantmentResult) : bool {
        arg0.was_reroll
    }

    fun sort_three_values(arg0: u64, arg1: u64, arg2: u64) : (u64, u64, u64) {
        let v0 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v0, arg0);
        0x1::vector::push_back<u64>(&mut v0, arg1);
        0x1::vector::push_back<u64>(&mut v0, arg2);
        let v1 = 0;
        while (v1 < 2) {
            let v2 = 0;
            while (v2 < 2 - v1) {
                if (*0x1::vector::borrow<u64>(&v0, v2) > *0x1::vector::borrow<u64>(&v0, v2 + 1)) {
                    0x1::vector::swap<u64>(&mut v0, v2, v2 + 1);
                };
                v2 = v2 + 1;
            };
            v1 = v1 + 1;
        };
        (*0x1::vector::borrow<u64>(&v0, 0), *0x1::vector::borrow<u64>(&v0, 1), *0x1::vector::borrow<u64>(&v0, 2))
    }

    // decompiled from Move bytecode v6
}

