module 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::mob_scaling {
    public fun effect(arg0: &0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::spell_effect::Effect, arg1: u64, arg2: u64, arg3: u64) : 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::spell_effect::Effect {
        let v0 = 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::spell_effect::kind(arg0);
        let v1 = scalable(v0);
        let v2 = if (v1) {
            value(0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::spell_effect::value(arg0), arg1, arg2, arg3)
        } else {
            0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::spell_effect::value(arg0)
        };
        let v3 = if (v1) {
            value(0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::spell_effect::value_max(arg0), arg1, arg2, arg3)
        } else {
            0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::spell_effect::value_max(arg0)
        };
        0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::spell_effect::new_effect(v0, 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::spell_effect::element(arg0), v2, v3, 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::spell_effect::area_shape(arg0), 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::spell_effect::area_size(arg0), 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::spell_effect::target_filter(arg0), 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::spell_effect::chance_bp(arg0), 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::spell_effect::turns(arg0), 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::spell_effect::stat(arg0))
    }

    fun effects(arg0: vector<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::spell_effect::Effect>, arg1: u64, arg2: u64, arg3: u64) : vector<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::spell_effect::Effect> {
        let v0 = 0x1::vector::empty<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::spell_effect::Effect>();
        0x1::vector::reverse<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::spell_effect::Effect>(&mut arg0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::spell_effect::Effect>(&arg0)) {
            let v2 = 0x1::vector::pop_back<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::spell_effect::Effect>(&mut arg0);
            0x1::vector::push_back<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::spell_effect::Effect>(&mut v0, effect(&v2, arg1, arg2, arg3));
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::spell_effect::Effect>(arg0);
        v0
    }

    public fun loot(arg0: vector<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::mob_data::LootEntry>, arg1: u64, arg2: u64, arg3: u64) : vector<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::mob_data::LootEntry> {
        let v0 = 0x1::vector::empty<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::mob_data::LootEntry>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::mob_data::LootEntry>(&arg0)) {
            let v2 = 0x1::vector::borrow<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::mob_data::LootEntry>(&arg0, v1);
            0x1::vector::push_back<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::mob_data::LootEntry>(&mut v0, 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::mob_data::new_loot_entry(0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::mob_data::loot_item_type(v2), (0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::fight_math::mob_loot_chance_scaled((0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::mob_data::loot_chance_bp(v2) as u64), arg1, arg2, arg3) as u16), 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::mob_data::loot_min_qty(v2), 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::mob_data::loot_max_qty(v2)));
            v1 = v1 + 1;
        };
        v0
    }

    fun scalable(arg0: u8) : bool {
        if (arg0 <= 7) {
            true
        } else if (arg0 == 14) {
            true
        } else {
            arg0 == 15
        }
    }

    public fun spell_level(arg0: &0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::spell_effect::SpellLevel, arg1: u64, arg2: u64, arg3: u64) : 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::spell_effect::SpellLevel {
        0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::spell_effect::new_spell_level(0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::spell_effect::ap_cost(arg0), 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::spell_effect::range_min(arg0), 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::spell_effect::range_max(arg0), 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::spell_effect::modifiable_range(arg0), 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::spell_effect::line_of_sight(arg0), 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::spell_effect::line_launch(arg0), 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::spell_effect::free_cell(arg0), 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::spell_effect::casts_per_turn(arg0), 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::spell_effect::casts_per_target(arg0), 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::spell_effect::cooldown_turns(arg0), 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::spell_effect::crit_1_in(arg0), effects(0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::spell_effect::effects(arg0), arg1, arg2, arg3), effects(0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::spell_effect::crit_effects(arg0), arg1, arg2, arg3))
    }

    fun value(arg0: u32, arg1: u64, arg2: u64, arg3: u64) : u32 {
        let v0 = 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::fight_math::band_scaled((arg0 as u64), arg1, arg2, arg3);
        if (arg0 > 0 && v0 == 0) {
            1
        } else if (v0 > 4294967295) {
            4294967295
        } else {
            (v0 as u32)
        }
    }

    // decompiled from Move bytecode v7
}

