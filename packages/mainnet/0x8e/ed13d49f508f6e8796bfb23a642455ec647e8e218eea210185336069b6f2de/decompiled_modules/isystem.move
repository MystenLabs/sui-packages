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

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AttackMechanics{
            max_attacks_count            : 6,
            attack_increment_duration_ms : 3600000,
            attack_increment_value       : 1,
        };
        let v1 = CapacityConfig{
            headquarter_garrison_limit : 10,
            increment_unit_capacity    : 5,
        };
        let v2 = ScoutConfig{
            total_supply        : 100,
            timestamp           : 0,
            total_active_scouts : 0,
            max_hire            : 5,
            reset_cooldown_ms   : 86400000,
            max_scout_cap       : 100,
            scout_cash_cost     : 64,
        };
        let v3 = SystemConfig{
            id                   : 0x2::object::new(arg0),
            attack               : v0,
            capacity             : v1,
            raid_cooldown_hq     : 7200000,
            raid_cooldown_normal : 21600000,
            raid_loot_normal_min : 5,
            raid_loot_hq_min     : 20,
            raid_loot_hq_max     : 20,
            raid_loot_normal_max : 10,
            revenue_treasury     : 0x2::tx_context::sender(arg0),
            scout_config         : v2,
        };
        0x2::transfer::share_object<SystemConfig>(v3);
    }

    public(friend) fun set_system_config(arg0: &mut SystemConfig, arg1: u64, arg2: u64, arg3: u8, arg4: u64, arg5: u8, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: address, arg17: &0x2::clock::Clock) {
        arg0.revenue_treasury = arg16;
        arg0.capacity.headquarter_garrison_limit = arg1;
        arg0.capacity.increment_unit_capacity = arg2;
        arg0.attack.max_attacks_count = arg3;
        arg0.attack.attack_increment_duration_ms = arg4;
        arg0.attack.attack_increment_value = arg5;
        arg0.scout_config.timestamp = 0x2::clock::timestamp_ms(arg17) + arg14 * 60 * 60 * 1000;
        arg0.scout_config.reset_cooldown_ms = arg12;
        arg0.scout_config.max_scout_cap = arg13;
        arg0.scout_config.scout_cash_cost = arg15;
        arg0.raid_cooldown_hq = arg6;
        arg0.raid_cooldown_normal = arg7;
        arg0.raid_loot_normal_min = arg8;
        arg0.raid_loot_hq_min = arg9;
        arg0.raid_loot_hq_max = arg10;
        arg0.raid_loot_normal_max = arg11;
    }

    // decompiled from Move bytecode v6
}

