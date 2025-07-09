module 0x4ed3c9413856c3f13df3098543b48b788cac9c8961d6997fd1c69e6230e8d995::imission {
    struct MissionRegistry has key {
        id: 0x2::object::UID,
        mission_configs: 0x2::vec_map::VecMap<u64, MissionConfig>,
    }

    struct MissionConfig has copy, store {
        location_name: 0x1::string::String,
        tag: u64,
        unlocked_level: u64,
        cooldown_timer: u64,
        max_success: u64,
        base_success: u64,
        success_increase: u64,
        failed_increase: u64,
        cash_gain: u128,
        weapon_gain: u128,
        success_lp_gained: u64,
        failed_lp_gained: u64,
        decay_rate: u64,
    }

    struct MissionInfo has key {
        id: 0x2::object::UID,
        last_mission_completed_ts: u64,
        mission_state: 0x2::vec_map::VecMap<u64, u64>,
    }

    public(friend) fun add_config(arg0: &mut MissionRegistry, arg1: MissionConfig, arg2: u64) {
        0x2::vec_map::insert<u64, MissionConfig>(&mut arg0.mission_configs, arg2, arg1);
    }

    public fun borrow_cash_gain(arg0: &MissionConfig) : u128 {
        arg0.cash_gain
    }

    public fun borrow_cooldown_timer(arg0: &MissionConfig) : u64 {
        arg0.cooldown_timer
    }

    public fun borrow_current_mission_config(arg0: &MissionRegistry, arg1: u64) : (vector<u128>, vector<u64>) {
        let v0 = 0x2::vec_map::get<u64, MissionConfig>(&arg0.mission_configs, &arg1);
        let v1 = 0x1::vector::empty<u128>();
        let v2 = &mut v1;
        0x1::vector::push_back<u128>(v2, v0.cash_gain);
        0x1::vector::push_back<u128>(v2, v0.weapon_gain);
        let v3 = 0x1::vector::empty<u64>();
        let v4 = &mut v3;
        0x1::vector::push_back<u64>(v4, v0.tag);
        0x1::vector::push_back<u64>(v4, v0.unlocked_level);
        0x1::vector::push_back<u64>(v4, v0.cooldown_timer);
        0x1::vector::push_back<u64>(v4, v0.max_success);
        0x1::vector::push_back<u64>(v4, v0.base_success);
        0x1::vector::push_back<u64>(v4, v0.success_increase);
        0x1::vector::push_back<u64>(v4, v0.failed_increase);
        0x1::vector::push_back<u64>(v4, v0.success_lp_gained);
        0x1::vector::push_back<u64>(v4, v0.failed_lp_gained);
        0x1::vector::push_back<u64>(v4, v0.decay_rate);
        (v1, v3)
    }

    public fun borrow_location_name(arg0: &MissionConfig) : &0x1::string::String {
        &arg0.location_name
    }

    public fun borrow_mission_config(arg0: &MissionRegistry, arg1: &u64) : &MissionConfig {
        0x2::vec_map::get<u64, MissionConfig>(&arg0.mission_configs, arg1)
    }

    public fun borrow_weapon_gain(arg0: &MissionConfig) : u128 {
        arg0.weapon_gain
    }

    public fun has_level_config(arg0: &MissionRegistry, arg1: &u64) : bool {
        0x2::vec_map::contains<u64, MissionConfig>(&arg0.mission_configs, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MissionRegistry{
            id              : 0x2::object::new(arg0),
            mission_configs : 0x2::vec_map::empty<u64, MissionConfig>(),
        };
        0x2::transfer::share_object<MissionRegistry>(v0);
    }

    public(friend) fun new_mission_config(arg0: 0x1::string::String, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u128, arg8: u128, arg9: u64, arg10: u64, arg11: u64, arg12: u64) : MissionConfig {
        MissionConfig{
            location_name     : arg0,
            tag               : arg12,
            unlocked_level    : arg1,
            cooldown_timer    : arg2,
            max_success       : arg3,
            base_success      : arg4,
            success_increase  : arg5,
            failed_increase   : arg6,
            cash_gain         : arg7,
            weapon_gain       : arg8,
            success_lp_gained : arg9,
            failed_lp_gained  : arg10,
            decay_rate        : arg11,
        }
    }

    public fun new_mission_info(arg0: &0x4ed3c9413856c3f13df3098543b48b788cac9c8961d6997fd1c69e6230e8d995::crimes_authority::CrimesCap, arg1: &MissionRegistry, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::vec_map::keys<u64, MissionConfig>(&arg1.mission_configs);
        let v1 = 0x2::vec_map::empty<u64, u64>();
        let v2 = 0;
        while (0x1::vector::length<u64>(&v0) > v2) {
            0x2::vec_map::insert<u64, u64>(&mut v1, *0x1::vector::borrow<u64>(&v0, v2), 0x2::vec_map::get<u64, MissionConfig>(&arg1.mission_configs, 0x1::vector::borrow<u64>(&v0, v2)).base_success);
            v2 = v2 + 1;
        };
        let v3 = MissionInfo{
            id                        : 0x2::object::new(arg3),
            last_mission_completed_ts : 0x2::clock::timestamp_ms(arg2),
            mission_state             : v1,
        };
        0x2::transfer::share_object<MissionInfo>(v3);
        0x2::object::id<MissionInfo>(&v3)
    }

    public(friend) fun process_current_success_chance(arg0: &mut MissionInfo, arg1: &MissionRegistry, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::random::Random, arg5: &mut 0x2::tx_context::TxContext) : bool {
        assert!(0x2::vec_map::contains<u64, MissionConfig>(&arg1.mission_configs, &arg2), 0);
        let v0 = 0x2::vec_map::get<u64, MissionConfig>(&arg1.mission_configs, &arg2);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        let v2 = (v1 - arg0.last_mission_completed_ts) / 86400000;
        arg0.last_mission_completed_ts = v1;
        let (v3, v4) = 0x2::vec_map::into_keys_values<u64, u64>(arg0.mission_state);
        let v5 = v4;
        let v6 = v3;
        let v7 = 0;
        while (0x1::vector::length<u64>(&v5) > v7 && v2 > 0) {
            let v8 = 0;
            if (v2 > 0) {
                v8 = v0.decay_rate * v2;
            };
            let v9 = if (*0x1::vector::borrow<u64>(&v5, v7) > v8) {
                *0x1::vector::borrow<u64>(&v5, v7) - v8
            } else {
                v8 - *0x1::vector::borrow<u64>(&v5, v7)
            };
            *0x2::vec_map::get_mut<u64, u64>(&mut arg0.mission_state, 0x1::vector::borrow<u64>(&v6, v7)) = 0x1::u64::max(0x1::u64::min(v0.max_success, v9), v0.base_success);
            v7 = v7 + 1;
        };
        let v10 = 0x2::vec_map::get_mut<u64, u64>(&mut arg0.mission_state, &v0.tag);
        let v11 = 0x4ed3c9413856c3f13df3098543b48b788cac9c8961d6997fd1c69e6230e8d995::utils_crime::flip_coin(arg4, *v10, arg5);
        let v12 = if (v11) {
            v0.success_increase
        } else {
            v0.failed_increase
        };
        *v10 = 0x1::u64::max(0x1::u64::min(v0.max_success, *v10 + v12), v0.base_success);
        v11
    }

    public(friend) fun share(arg0: MissionInfo) {
        0x2::transfer::share_object<MissionInfo>(arg0);
    }

    // decompiled from Move bytecode v6
}

