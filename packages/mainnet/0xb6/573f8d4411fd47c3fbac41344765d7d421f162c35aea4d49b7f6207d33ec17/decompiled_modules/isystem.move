module 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::isystem {
    struct ScoutConfig has store {
        total_supply: u64,
        timestamp: u64,
        total_active_scouts: u64,
        max_hire: u64,
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
        revenue_treasury: address,
        raid_cooldown: u64,
        scout_config: ScoutConfig,
    }

    public(friend) fun add_v_to_game_treasury(arg0: &SystemConfig, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, arg0.revenue_treasury);
    }

    public fun borrow_system_config(arg0: &SystemConfig) : (u8, u8, u64, u64, u64, u64) {
        (arg0.attack.max_attacks_count, arg0.attack.attack_increment_value, arg0.attack.attack_increment_duration_ms, arg0.capacity.headquarter_garrison_limit, arg0.capacity.increment_unit_capacity, arg0.raid_cooldown)
    }

    public(friend) fun calculate_scout_supply(arg0: &mut SystemConfig, arg1: u64, arg2: &0x2::clock::Clock) {
        assert!(arg1 <= arg0.scout_config.max_hire, 0);
        if (arg0.scout_config.timestamp >= 0x2::clock::timestamp_ms(arg2)) {
            assert!(arg0.scout_config.total_supply >= arg1, 1);
        } else {
            arg0.scout_config.total_supply = 100;
            arg0.scout_config.timestamp = 0x2::clock::timestamp_ms(arg2) + 86400000;
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
            headquarter_garrison_limit : 15,
            increment_unit_capacity    : 7,
        };
        let v2 = ScoutConfig{
            total_supply        : 100,
            timestamp           : 0,
            total_active_scouts : 0,
            max_hire            : 5,
        };
        let v3 = SystemConfig{
            id               : 0x2::object::new(arg0),
            attack           : v0,
            capacity         : v1,
            revenue_treasury : 0x2::tx_context::sender(arg0),
            raid_cooldown    : 10800000,
            scout_config     : v2,
        };
        0x2::transfer::share_object<SystemConfig>(v3);
    }

    public(friend) fun set_system_config(arg0: &mut SystemConfig, arg1: u64, arg2: u64, arg3: u8, arg4: u64, arg5: u8, arg6: u64, arg7: address, arg8: &0x2::clock::Clock) {
        arg0.raid_cooldown = arg6;
        arg0.revenue_treasury = arg7;
        arg0.capacity.headquarter_garrison_limit = arg1;
        arg0.capacity.increment_unit_capacity = arg2;
        arg0.attack.max_attacks_count = arg3;
        arg0.attack.attack_increment_duration_ms = arg4;
        arg0.attack.attack_increment_value = arg5;
        arg0.scout_config.timestamp = 0x2::clock::timestamp_ms(arg8) + 86400000;
    }

    // decompiled from Move bytecode v6
}

