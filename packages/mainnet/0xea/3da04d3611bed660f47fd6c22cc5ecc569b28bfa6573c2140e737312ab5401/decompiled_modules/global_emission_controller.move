module 0xea3da04d3611bed660f47fd6c22cc5ecc569b28bfa6573c2140e737312ab5401::global_emission_controller {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct GlobalEmissionConfig has key {
        id: 0x2::object::UID,
        emission_start_timestamp: u64,
        paused: bool,
    }

    struct EmissionScheduleStarted has copy, drop {
        start_timestamp: u64,
        total_weeks: u64,
    }

    struct EmissionPaused has copy, drop {
        paused: bool,
        timestamp: u64,
        admin: address,
    }

    struct ContractAllocationRequested has copy, drop {
        contract_type: 0x1::string::String,
        week: u64,
        phase: u8,
        allocation: u256,
        timestamp: u64,
    }

    struct SystemPaused has copy, drop {
        timestamp: u64,
    }

    struct SystemUnpaused has copy, drop {
        timestamp: u64,
    }

    struct WeekReset has copy, drop {
        old_emission_start: u64,
        new_emission_start: u64,
        target_week: u64,
        timestamp: u64,
    }

    struct TimingAdjusted has copy, drop {
        old_emission_start: u64,
        new_emission_start: u64,
        hours_adjusted: u64,
        subtract: bool,
        timestamp: u64,
    }

    public entry fun adjust_emission_timing(arg0: &AdminCap, arg1: &mut GlobalEmissionConfig, arg2: u64, arg3: bool, arg4: &0x2::clock::Clock) {
        assert!(arg1.paused, 1004);
        assert!(arg2 <= 168, 1006);
        if (arg3) {
            arg1.emission_start_timestamp = arg1.emission_start_timestamp + arg2 * 3600;
        } else {
            arg1.emission_start_timestamp = arg1.emission_start_timestamp - arg2 * 3600;
        };
        let v0 = TimingAdjusted{
            old_emission_start : arg1.emission_start_timestamp,
            new_emission_start : arg1.emission_start_timestamp,
            hours_adjusted     : arg2,
            subtract           : arg3,
            timestamp          : 0x2::clock::timestamp_ms(arg4) / 1000,
        };
        0x2::event::emit<TimingAdjusted>(v0);
    }

    fun calculate_current_week(arg0: &GlobalEmissionConfig, arg1: &0x2::clock::Clock) : u64 {
        if (arg0.emission_start_timestamp == 0) {
            return 0
        };
        let v0 = 0x2::clock::timestamp_ms(arg1) / 1000;
        if (v0 < arg0.emission_start_timestamp) {
            return 0
        };
        (v0 - arg0.emission_start_timestamp) / 604800 + 1
    }

    fun calculate_remaining_total_emissions(arg0: u64) : u256 {
        let v0 = 0;
        while (arg0 <= 156) {
            v0 = v0 + calculate_total_emission_for_week(arg0) * (604800 as u256);
            arg0 = arg0 + 1;
        };
        v0
    }

    fun calculate_total_emission_for_week(arg0: u64) : u256 {
        if (arg0 <= 4) {
            6600000
        } else if (arg0 == 5) {
            5470000
        } else if (arg0 <= 156) {
            let v1 = 5470000;
            let v2 = 0;
            while (v2 < arg0 - 5) {
                let v3 = v1 * (9900 as u256);
                v1 = v3 / 10000;
                v2 = v2 + 1;
            };
            v1
        } else {
            0
        }
    }

    fun calculate_total_emitted_up_to_week(arg0: u64) : u256 {
        let v0 = 0;
        let v1 = 1;
        while (v1 < arg0) {
            v0 = v0 + calculate_total_emission_for_week(v1) * (604800 as u256);
            v1 = v1 + 1;
        };
        v0
    }

    public fun get_all_allocations(arg0: &GlobalEmissionConfig, arg1: &0x2::clock::Clock) : (u256, u256, u256, u256, u64) {
        assert!(!arg0.paused, 1001);
        assert!(arg0.emission_start_timestamp > 0, 1002);
        let v0 = calculate_current_week(arg0, arg1);
        let v1 = calculate_total_emission_for_week(v0);
        let (v2, v3, v4, v5) = get_week_allocation_percentages(v0);
        (v1 * (v2 as u256) / (10000 as u256), v1 * (v3 as u256) / (10000 as u256), v1 * (v4 as u256) / (10000 as u256), v1 * (v5 as u256) / (10000 as u256), v0)
    }

    public fun get_allocation_details(arg0: &GlobalEmissionConfig, arg1: &0x2::clock::Clock) : (u256, u256, u256, u256, u64, u64, u64, u64) {
        let v0 = calculate_current_week(arg0, arg1);
        let v1 = calculate_total_emission_for_week(v0);
        let (v2, v3, v4, v5) = get_week_allocation_percentages(v0);
        (v1 * (v2 as u256) / (10000 as u256), v1 * (v3 as u256) / (10000 as u256), v1 * (v4 as u256) / (10000 as u256), v1 * (v5 as u256) / (10000 as u256), v2, v3, v4, v5)
    }

    public fun get_canonical_week_for_timestamp(arg0: &GlobalEmissionConfig, arg1: u64) : u64 {
        let (v0, _) = get_config_info(arg0);
        if (v0 == 0 || arg1 < v0) {
            return 0
        };
        let v2 = (arg1 - v0) / 604800 + 1;
        if (v2 > 156) {
            156
        } else {
            v2
        }
    }

    public fun get_config_info(arg0: &GlobalEmissionConfig) : (u64, bool) {
        (arg0.emission_start_timestamp, arg0.paused)
    }

    public fun get_current_emission_week(arg0: &GlobalEmissionConfig, arg1: &0x2::clock::Clock) : u64 {
        get_canonical_week_for_timestamp(arg0, 0x2::clock::timestamp_ms(arg1) / 1000)
    }

    public fun get_dev_allocation(arg0: &GlobalEmissionConfig, arg1: &0x2::clock::Clock) : u256 {
        assert!(!arg0.paused, 1001);
        assert!(arg0.emission_start_timestamp > 0, 1002);
        let v0 = calculate_current_week(arg0, arg1);
        let (_, _, _, v4) = get_week_allocation_percentages(v0);
        let v5 = calculate_total_emission_for_week(v0) * (v4 as u256) / (10000 as u256);
        let v6 = if (v0 <= 4) {
            1
        } else if (v0 <= 156) {
            2
        } else {
            3
        };
        let v7 = ContractAllocationRequested{
            contract_type : 0x1::string::utf8(b"dev_treasury"),
            week          : v0,
            phase         : v6,
            allocation    : v5,
            timestamp     : 0x2::clock::timestamp_ms(arg1) / 1000,
        };
        0x2::event::emit<ContractAllocationRequested>(v7);
        v5
    }

    public fun get_emission_metrics(arg0: &GlobalEmissionConfig, arg1: &0x2::clock::Clock) : (u64, u256, u256, u256) {
        let v0 = get_current_emission_week(arg0, arg1);
        (v0, calculate_total_emitted_up_to_week(v0), calculate_remaining_total_emissions(v0), calculate_total_emission_for_week(v0))
    }

    public fun get_emission_phase_parameters() : (u256, u256, u64, u64) {
        (6600000, 5470000, 9900, 156)
    }

    public fun get_emission_status(arg0: &GlobalEmissionConfig, arg1: &0x2::clock::Clock) : (u64, u8, u256, bool, u64) {
        let v0 = calculate_current_week(arg0, arg1);
        let v1 = if (v0 == 0) {
            0
        } else if (v0 <= 4) {
            1
        } else if (v0 <= 156) {
            2
        } else {
            3
        };
        let v2 = if (v0 <= 156) {
            156 - v0
        } else {
            0
        };
        (v0, v1, calculate_total_emission_for_week(v0), arg0.paused, v2)
    }

    public fun get_farm_allocations(arg0: &GlobalEmissionConfig, arg1: &0x2::clock::Clock) : (u256, u256) {
        assert!(!arg0.paused, 1001);
        assert!(arg0.emission_start_timestamp > 0, 1002);
        let v0 = calculate_current_week(arg0, arg1);
        let v1 = calculate_total_emission_for_week(v0);
        let (v2, v3, _, _) = get_week_allocation_percentages(v0);
        let v6 = v1 * (v2 as u256) / (10000 as u256);
        let v7 = v1 * (v3 as u256) / (10000 as u256);
        let v8 = if (v0 <= 4) {
            1
        } else if (v0 <= 156) {
            2
        } else {
            3
        };
        let v9 = ContractAllocationRequested{
            contract_type : 0x1::string::utf8(b"farm"),
            week          : v0,
            phase         : v8,
            allocation    : v6 + v7,
            timestamp     : 0x2::clock::timestamp_ms(arg1) / 1000,
        };
        0x2::event::emit<ContractAllocationRequested>(v9);
        (v6, v7)
    }

    public fun get_system_status(arg0: &GlobalEmissionConfig, arg1: &0x2::clock::Clock) : (bool, u64, u64, bool) {
        let v0 = get_current_emission_week(arg0, arg1);
        let v1 = if (v0 >= 156) {
            0
        } else {
            156 - v0
        };
        (arg0.paused, v0, v1, is_emissions_active(arg0, arg1))
    }

    public fun get_victory_allocation(arg0: &GlobalEmissionConfig, arg1: &0x2::clock::Clock) : u256 {
        assert!(!arg0.paused, 1001);
        assert!(arg0.emission_start_timestamp > 0, 1002);
        let v0 = calculate_current_week(arg0, arg1);
        let (_, _, v3, _) = get_week_allocation_percentages(v0);
        let v5 = calculate_total_emission_for_week(v0) * (v3 as u256) / (10000 as u256);
        let v6 = if (v0 <= 4) {
            1
        } else if (v0 <= 156) {
            2
        } else {
            3
        };
        let v7 = ContractAllocationRequested{
            contract_type : 0x1::string::utf8(b"victory_staking"),
            week          : v0,
            phase         : v6,
            allocation    : v5,
            timestamp     : 0x2::clock::timestamp_ms(arg1) / 1000,
        };
        0x2::event::emit<ContractAllocationRequested>(v7);
        v5
    }

    public fun get_victory_allocation_for_week(arg0: &GlobalEmissionConfig, arg1: u64) : u256 {
        assert!(!arg0.paused, 1001);
        assert!(arg0.emission_start_timestamp > 0, 1002);
        if (arg1 == 0 || arg1 > 156) {
            return 0
        };
        let (_, _, v2, _) = get_week_allocation_percentages(arg1);
        calculate_total_emission_for_week(arg1) * (v2 as u256) / (10000 as u256)
    }

    fun get_week_allocation_percentages(arg0: u64) : (u64, u64, u64, u64) {
        if (arg0 <= 4) {
            return (6500, 1500, 1750, 250)
        };
        if (arg0 <= 12) {
            return (6200, 1200, 2350, 250)
        };
        if (arg0 <= 26) {
            return (5800, 700, 3250, 250)
        };
        if (arg0 <= 52) {
            return (5500, 200, 4050, 250)
        };
        if (arg0 <= 104) {
            return (5000, 0, 4750, 250)
        };
        if (arg0 <= 156) {
            return (4500, 0, 5250, 250)
        };
        (0, 0, 0, 0)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = GlobalEmissionConfig{
            id                       : 0x2::object::new(arg0),
            emission_start_timestamp : 0,
            paused                   : false,
        };
        0x2::transfer::share_object<GlobalEmissionConfig>(v1);
    }

    public entry fun initialize_emission_schedule(arg0: &AdminCap, arg1: &mut GlobalEmissionConfig, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.emission_start_timestamp == 0, 1003);
        let v0 = 0x2::clock::timestamp_ms(arg2) / 1000;
        arg1.emission_start_timestamp = v0;
        let v1 = EmissionScheduleStarted{
            start_timestamp : v0,
            total_weeks     : 156,
        };
        0x2::event::emit<EmissionScheduleStarted>(v1);
    }

    public fun is_emissions_active(arg0: &GlobalEmissionConfig, arg1: &0x2::clock::Clock) : bool {
        if (arg0.paused || arg0.emission_start_timestamp == 0) {
            return false
        };
        let v0 = calculate_current_week(arg0, arg1);
        v0 <= 156 && v0 > 0
    }

    public entry fun pause_system(arg0: &AdminCap, arg1: &mut GlobalEmissionConfig, arg2: &0x2::clock::Clock) {
        arg1.paused = true;
        let v0 = SystemPaused{timestamp: 0x2::clock::timestamp_ms(arg2) / 1000};
        0x2::event::emit<SystemPaused>(v0);
    }

    public fun preview_week_allocations(arg0: u64) : (u256, u256, u256, u256, u8) {
        let v0 = calculate_total_emission_for_week(arg0);
        let (v1, v2, v3, v4) = get_week_allocation_percentages(arg0);
        let v5 = if (arg0 == 0) {
            0
        } else if (arg0 <= 4) {
            1
        } else if (arg0 <= 156) {
            2
        } else {
            3
        };
        (v0 * (v1 as u256) / (10000 as u256), v0 * (v2 as u256) / (10000 as u256), v0 * (v3 as u256) / (10000 as u256), v0 * (v4 as u256) / (10000 as u256), v5)
    }

    public entry fun reset_to_week(arg0: &AdminCap, arg1: &mut GlobalEmissionConfig, arg2: u64, arg3: &0x2::clock::Clock) {
        assert!(arg1.paused, 1004);
        assert!(arg2 > 0 && arg2 <= 156, 1005);
        let v0 = 0x2::clock::timestamp_ms(arg3) / 1000;
        arg1.emission_start_timestamp = v0 - (arg2 - 1) * 604800;
        let v1 = WeekReset{
            old_emission_start : arg1.emission_start_timestamp,
            new_emission_start : arg1.emission_start_timestamp,
            target_week        : arg2,
            timestamp          : v0,
        };
        0x2::event::emit<WeekReset>(v1);
    }

    public entry fun set_pause_state(arg0: &AdminCap, arg1: &mut GlobalEmissionConfig, arg2: bool, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        arg1.paused = arg2;
        let v0 = EmissionPaused{
            paused    : arg2,
            timestamp : 0x2::clock::timestamp_ms(arg3) / 1000,
            admin     : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<EmissionPaused>(v0);
    }

    public entry fun unpause_system(arg0: &AdminCap, arg1: &mut GlobalEmissionConfig, arg2: &0x2::clock::Clock) {
        arg1.paused = false;
        let v0 = SystemUnpaused{timestamp: 0x2::clock::timestamp_ms(arg2) / 1000};
        0x2::event::emit<SystemUnpaused>(v0);
    }

    // decompiled from Move bytecode v6
}

