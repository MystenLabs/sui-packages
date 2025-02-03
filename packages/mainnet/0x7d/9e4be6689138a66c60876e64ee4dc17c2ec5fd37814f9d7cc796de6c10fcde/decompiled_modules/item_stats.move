module 0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::item_stats {
    struct ItemStatistics has copy, drop, store {
        vitality: u16,
        wisdom: u16,
        strength: u16,
        intelligence: u16,
        chance: u16,
        agility: u16,
        range: u8,
        movement: u8,
        action: u8,
        critical: u8,
        raw_damage: u16,
        critical_chance: u8,
        critical_outcomes: u8,
        earth_resistance: u8,
        fire_resistance: u8,
        water_resistance: u8,
        air_resistance: u8,
    }

    struct StatsKey has copy, drop, store {
        dummy_field: bool,
    }

    public fun action(arg0: &ItemStatistics) : u8 {
        arg0.action
    }

    public fun admin_augment_with_stats(arg0: &0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::admin::AdminCap, arg1: &mut 0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::item::Item, arg2: ItemStatistics, arg3: &0x2::tx_context::TxContext) {
        0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::admin::verify(arg0, arg3);
        augment_with_stats(arg1, arg2);
    }

    public fun admin_new(arg0: &0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::admin::AdminCap, arg1: u16, arg2: u16, arg3: u16, arg4: u16, arg5: u16, arg6: u16, arg7: u8, arg8: u8, arg9: u8, arg10: u8, arg11: u16, arg12: u8, arg13: u8, arg14: u8, arg15: u8, arg16: u8, arg17: u8, arg18: &0x2::tx_context::TxContext) : ItemStatistics {
        0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::admin::verify(arg0, arg18);
        new(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17)
    }

    public fun agility(arg0: &ItemStatistics) : u16 {
        arg0.agility
    }

    public fun air_resistance(arg0: &ItemStatistics) : u8 {
        arg0.air_resistance
    }

    public(friend) fun augment_with_stats(arg0: &mut 0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::item::Item, arg1: ItemStatistics) {
        assert!(!0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::item::stackable(arg0), 1);
        let v0 = StatsKey{dummy_field: false};
        0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::item::add_field<StatsKey, ItemStatistics>(arg0, v0, arg1);
    }

    public fun chance(arg0: &ItemStatistics) : u16 {
        arg0.chance
    }

    public fun critical(arg0: &ItemStatistics) : u8 {
        arg0.critical
    }

    public fun critical_chance(arg0: &ItemStatistics) : u8 {
        arg0.critical_chance
    }

    public fun critical_outcomes(arg0: &ItemStatistics) : u8 {
        arg0.critical_outcomes
    }

    public fun earth_resistance(arg0: &ItemStatistics) : u8 {
        arg0.earth_resistance
    }

    public fun fire_resistance(arg0: &ItemStatistics) : u8 {
        arg0.fire_resistance
    }

    public fun intelligence(arg0: &ItemStatistics) : u16 {
        arg0.intelligence
    }

    public fun movement(arg0: &ItemStatistics) : u8 {
        arg0.movement
    }

    public(friend) fun new(arg0: u16, arg1: u16, arg2: u16, arg3: u16, arg4: u16, arg5: u16, arg6: u8, arg7: u8, arg8: u8, arg9: u8, arg10: u16, arg11: u8, arg12: u8, arg13: u8, arg14: u8, arg15: u8, arg16: u8) : ItemStatistics {
        ItemStatistics{
            vitality          : arg0,
            wisdom            : arg1,
            strength          : arg2,
            intelligence      : arg3,
            chance            : arg4,
            agility           : arg5,
            range             : arg6,
            movement          : arg7,
            action            : arg8,
            critical          : arg9,
            raw_damage        : arg10,
            critical_chance   : arg11,
            critical_outcomes : arg12,
            earth_resistance  : arg13,
            fire_resistance   : arg14,
            water_resistance  : arg15,
            air_resistance    : arg16,
        }
    }

    public fun range(arg0: &ItemStatistics) : u8 {
        arg0.range
    }

    public fun raw_damage(arg0: &ItemStatistics) : u16 {
        arg0.raw_damage
    }

    public fun strength(arg0: &ItemStatistics) : u16 {
        arg0.strength
    }

    public fun vitality(arg0: &ItemStatistics) : u16 {
        arg0.vitality
    }

    public fun water_resistance(arg0: &ItemStatistics) : u8 {
        arg0.water_resistance
    }

    public fun wisdom(arg0: &ItemStatistics) : u16 {
        arg0.wisdom
    }

    // decompiled from Move bytecode v6
}

