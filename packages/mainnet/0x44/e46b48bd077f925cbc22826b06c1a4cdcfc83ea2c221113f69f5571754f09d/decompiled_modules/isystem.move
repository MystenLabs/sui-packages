module 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::isystem {
    struct ScoutConfig has store {
        total_supply: u64,
        timestamp: u64,
        total_active_scouts: u64,
        max_hire: u64,
        reset_cooldown_ms: u64,
        max_scout_cap: u64,
        scout_cash_cost: u64,
    }

    struct CapacityConfig has store {
        headquarter_garrison_limit: u64,
        increment_unit_capacity: u64,
    }

    struct AttackMechanics has store {
        max_attacks_count: u8,
        attack_increment_duration_ms: u64,
        attack_increment_value: u8,
    }

    struct SystemConfig has key {
        id: 0x2::object::UID,
        attack: AttackMechanics,
        capacity: CapacityConfig,
        raid_cooldown_hq: u64,
        raid_cooldown_normal: u64,
        raid_loot_normal_min: u64,
        raid_loot_hq_min: u64,
        raid_loot_hq_max: u64,
        raid_loot_normal_max: u64,
        revenue_treasury: address,
        scout_config: ScoutConfig,
    }

    public(friend) fun add_v_to_game_treasury(arg0: &SystemConfig, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, arg0.revenue_treasury);
    }

    public fun borrow_scout_config(arg0: &SystemConfig) : (u64, u64) {
        (arg0.scout_config.reset_cooldown_ms, arg0.scout_config.scout_cash_cost)
    }

    public fun borrow_system_config(arg0: &SystemConfig) : (u8, u8, u64, u64, u64, u64, u64, u64, u64, u64, u64) {
        (arg0.attack.max_attacks_count, arg0.attack.attack_increment_value, arg0.attack.attack_increment_duration_ms, arg0.capacity.headquarter_garrison_limit, arg0.capacity.increment_unit_capacity, arg0.raid_cooldown_hq, arg0.raid_cooldown_normal, arg0.raid_loot_normal_min, arg0.raid_loot_normal_max, arg0.raid_loot_hq_min, arg0.raid_loot_hq_max)
    }

    public(friend) fun calculate_scout_supply(arg0: &mut SystemConfig, arg1: u64, arg2: &0x2::clock::Clock) {
        assert!(arg1 <= arg0.scout_config.max_hire, 0);
        if (arg0.scout_config.timestamp >= 0x2::clock::timestamp_ms(arg2)) {
            assert!(arg0.scout_config.total_supply >= arg1, 1);
        } else {
            arg0.scout_config.total_supply = arg0.scout_config.max_scout_cap;
            arg0.scout_config.timestamp = 0x2::clock::timestamp_ms(arg2) + arg0.scout_config.reset_cooldown_ms;
        };
        arg0.scout_config.total_supply = arg0.scout_config.total_supply - arg1;
        arg0.scout_config.total_active_scouts = arg0.scout_config.total_active_scouts + arg1;
    }

    public(friend) fun increase_active_scout_supply(arg0: &mut SystemConfig, arg1: u64) {
        arg0.scout_config.total_active_scouts = arg0.scout_config.total_active_scouts + arg1;
    }

    // decompiled from Move bytecode v6
}

