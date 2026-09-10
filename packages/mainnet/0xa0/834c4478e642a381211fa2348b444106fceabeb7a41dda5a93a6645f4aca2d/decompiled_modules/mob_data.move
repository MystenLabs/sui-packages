module 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::mob_data {
    struct MobSpell has copy, drop, store {
        name: 0x1::string::String,
        level: 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::spell_effect::SpellLevel,
    }

    struct LootEntry has copy, drop, store {
        item_type: 0x1::string::String,
        chance_bp: u16,
        min_qty: u8,
        max_qty: u8,
    }

    struct MobData has copy, drop, store {
        name: 0x1::string::String,
        mob_type: 0x1::string::String,
        element: 0x1::string::String,
        level_min: u8,
        level_max: u8,
        hp: u64,
        ap: u8,
        mp: u8,
        agility: u16,
        wisdom: u16,
        earth_resistance: u16,
        fire_resistance: u16,
        water_resistance: u16,
        air_resistance: u16,
        spells: vector<MobSpell>,
        loot: vector<LootEntry>,
        xp: u64,
        is_boss: bool,
    }

    public fun agility(arg0: &MobData) : u16 {
        arg0.agility
    }

    public fun air_resistance(arg0: &MobData) : u16 {
        arg0.air_resistance
    }

    public fun ap(arg0: &MobData) : u8 {
        arg0.ap
    }

    fun assert_turn_work(arg0: u8, arg1: &vector<MobSpell>) {
        if (0x1::vector::is_empty<MobSpell>(arg1)) {
            return
        };
        let v0 = 256;
        let v1 = v0;
        let v2 = 0;
        let v3 = v2;
        let v4 = 0;
        while (v4 < 0x1::vector::length<MobSpell>(arg1)) {
            let v5 = &0x1::vector::borrow<MobSpell>(arg1, v4).level;
            let v6 = (0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::spell_effect::ap_cost(v5) as u64);
            if (v6 < v0) {
                v1 = v6;
            };
            let v7 = 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::spell_effect::effects(v5);
            let v8 = 0x1::vector::length<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::spell_effect::Effect>(&v7);
            let v9 = 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::spell_effect::crit_effects(v5);
            let v10 = 0x1::vector::length<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::spell_effect::Effect>(&v9);
            let v11 = if (v8 > v10) {
                v8
            } else {
                v10
            };
            if (v11 > v2) {
                v3 = v11;
            };
            v4 = v4 + 1;
        };
        assert!((arg0 as u64) / v1 * v3 <= 10, 1207);
    }

    public fun earth_resistance(arg0: &MobData) : u16 {
        arg0.earth_resistance
    }

    public fun element(arg0: &MobData) : 0x1::string::String {
        arg0.element
    }

    public fun fire_resistance(arg0: &MobData) : u16 {
        arg0.fire_resistance
    }

    public fun hp(arg0: &MobData) : u64 {
        arg0.hp
    }

    public fun is_boss(arg0: &MobData) : bool {
        arg0.is_boss
    }

    public fun level_max(arg0: &MobData) : u8 {
        arg0.level_max
    }

    public fun level_min(arg0: &MobData) : u8 {
        arg0.level_min
    }

    public fun loot(arg0: &MobData) : vector<LootEntry> {
        arg0.loot
    }

    public fun loot_chance_bp(arg0: &LootEntry) : u16 {
        arg0.chance_bp
    }

    public fun loot_item_type(arg0: &LootEntry) : 0x1::string::String {
        arg0.item_type
    }

    public fun loot_max_qty(arg0: &LootEntry) : u8 {
        arg0.max_qty
    }

    public fun loot_min_qty(arg0: &LootEntry) : u8 {
        arg0.min_qty
    }

    public fun mob_type(arg0: &MobData) : 0x1::string::String {
        arg0.mob_type
    }

    public fun mp(arg0: &MobData) : u8 {
        arg0.mp
    }

    public fun name(arg0: &MobData) : 0x1::string::String {
        arg0.name
    }

    public fun new_loot_entry(arg0: 0x1::string::String, arg1: u16, arg2: u8, arg3: u8) : LootEntry {
        assert!(arg1 <= 10000, 1205);
        assert!(arg2 > 0 && arg2 <= arg3, 1206);
        LootEntry{
            item_type : arg0,
            chance_bp : arg1,
            min_qty   : arg2,
            max_qty   : arg3,
        }
    }

    public fun new_mob_data(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u8, arg4: u8, arg5: u64, arg6: u8, arg7: u8, arg8: u16, arg9: u16, arg10: u16, arg11: u16, arg12: u16, arg13: u16, arg14: vector<MobSpell>, arg15: vector<LootEntry>, arg16: u64, arg17: bool) : MobData {
        assert!(arg3 <= arg4, 1201);
        assert!(0x1::vector::length<MobSpell>(&arg14) <= 5, 1202);
        assert_turn_work(arg6, &arg14);
        assert!(0x1::vector::length<LootEntry>(&arg15) <= 16, 1203);
        assert!(0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::item_damages::is_element(&arg2), 1204);
        MobData{
            name             : arg0,
            mob_type         : arg1,
            element          : arg2,
            level_min        : arg3,
            level_max        : arg4,
            hp               : arg5,
            ap               : arg6,
            mp               : arg7,
            agility          : arg8,
            wisdom           : arg9,
            earth_resistance : arg10,
            fire_resistance  : arg11,
            water_resistance : arg12,
            air_resistance   : arg13,
            spells           : arg14,
            loot             : arg15,
            xp               : arg16,
            is_boss          : arg17,
        }
    }

    public fun new_mob_spell(arg0: 0x1::string::String, arg1: 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::spell_effect::SpellLevel) : MobSpell {
        MobSpell{
            name  : arg0,
            level : arg1,
        }
    }

    public fun spell_level(arg0: &MobSpell) : 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::spell_effect::SpellLevel {
        arg0.level
    }

    public fun spell_name(arg0: &MobSpell) : 0x1::string::String {
        arg0.name
    }

    public fun spells(arg0: &MobData) : vector<MobSpell> {
        arg0.spells
    }

    public fun water_resistance(arg0: &MobData) : u16 {
        arg0.water_resistance
    }

    public fun wisdom(arg0: &MobData) : u16 {
        arg0.wisdom
    }

    public fun xp(arg0: &MobData) : u64 {
        arg0.xp
    }

    // decompiled from Move bytecode v7
}

