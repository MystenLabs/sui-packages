module 0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::config {
    struct GlobalConfig has store, key {
        id: 0x2::object::UID,
        min_tick: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        max_tick: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        version: u64,
        reward_managers: vector<address>,
    }

    struct RewardEmissionCaps has drop, store {
        max_emission_delta_per_window: u64,
        max_duration_extension_per_window: u64,
        emission_window_seconds: u64,
        window_start_ts: u64,
        window_delta_sum: u64,
        window_duration_sum: u64,
    }

    public(friend) fun enforce_duration_extension_cap(arg0: &mut GlobalConfig, arg1: &0x2::clock::Clock, arg2: u64) {
        let v0 = 0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::constants::emission_caps_dynamic_key();
        if (!0x2::dynamic_field::exists_<0x1::string::String>(&arg0.id, v0)) {
            return
        };
        let v1 = 0x2::dynamic_field::borrow_mut<0x1::string::String, RewardEmissionCaps>(&mut arg0.id, v0);
        roll_window_if_expired(v1, arg1);
        assert!(v1.max_duration_extension_per_window - v1.window_duration_sum >= arg2, 0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::errors::cap_exceeded());
        v1.window_duration_sum = v1.window_duration_sum + arg2;
    }

    public(friend) fun enforce_emission_delta_cap(arg0: &mut GlobalConfig, arg1: &0x2::clock::Clock, arg2: u64) {
        let v0 = 0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::constants::emission_caps_dynamic_key();
        if (!0x2::dynamic_field::exists_<0x1::string::String>(&arg0.id, v0)) {
            return
        };
        let v1 = 0x2::dynamic_field::borrow_mut<0x1::string::String, RewardEmissionCaps>(&mut arg0.id, v0);
        roll_window_if_expired(v1, arg1);
        assert!(v1.max_emission_delta_per_window - v1.window_delta_sum >= arg2, 0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::errors::cap_exceeded());
        v1.window_delta_sum = v1.window_delta_sum + arg2;
    }

    public(friend) fun get_config_id(arg0: &mut GlobalConfig) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public fun get_pool_creation_fee_amount<T0>(arg0: &GlobalConfig) : (bool, u64) {
        let v0 = &arg0.id;
        let v1 = 0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::constants::pool_creation_fee_dynamic_key();
        let v2 = 0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::utils::get_type_string<T0>();
        if (!0x2::dynamic_field::exists_<0x1::string::String>(v0, v1)) {
            return (false, 0)
        };
        let v3 = 0x2::dynamic_field::borrow<0x1::string::String, 0x2::table::Table<0x1::string::String, u64>>(v0, v1);
        if (!0x2::table::contains<0x1::string::String, u64>(v3, v2)) {
            return (false, 0)
        };
        (true, *0x2::table::borrow<0x1::string::String, u64>(v3, v2))
    }

    public fun get_tick_range(arg0: &GlobalConfig) : (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) {
        (arg0.min_tick, arg0.max_tick)
    }

    public(friend) fun id(arg0: &GlobalConfig) : &0x2::object::UID {
        &arg0.id
    }

    public(friend) fun increase_version(arg0: &mut GlobalConfig) : (u64, u64) {
        assert!(arg0.version < 9, 0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::errors::verion_cant_be_increased());
        arg0.version = arg0.version + 1;
        (arg0.version, arg0.version)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GlobalConfig{
            id              : 0x2::object::new(arg0),
            min_tick        : 0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::tick_math::min_tick(),
            max_tick        : 0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::tick_math::max_tick(),
            version         : 9,
            reward_managers : 0x1::vector::empty<address>(),
        };
        0x2::transfer::share_object<GlobalConfig>(v0);
    }

    public(friend) fun remove_reward_manager(arg0: &mut GlobalConfig, arg1: address) {
        assert!(verify_reward_manager(arg0, arg1), 0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::errors::reward_manager_not_found());
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg0.reward_managers)) {
            if (*0x1::vector::borrow<address>(&arg0.reward_managers, v0) == arg1) {
                0x1::vector::remove<address>(&mut arg0.reward_managers, v0);
                break
            };
            v0 = v0 + 1;
        };
    }

    fun roll_window_if_expired(arg0: &mut RewardEmissionCaps, arg1: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg1) / 1000;
        if (v0 - arg0.window_start_ts > arg0.emission_window_seconds) {
            arg0.window_start_ts = v0;
            arg0.window_delta_sum = 0;
            arg0.window_duration_sum = 0;
        };
    }

    public(friend) fun set_emission_caps(arg0: &mut GlobalConfig, arg1: u64, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock) {
        assert!(arg3 > 0, 0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::errors::invalid_emission_window());
        let v0 = RewardEmissionCaps{
            max_emission_delta_per_window     : arg1,
            max_duration_extension_per_window : arg2,
            emission_window_seconds           : arg3,
            window_start_ts                   : 0x2::clock::timestamp_ms(arg4) / 1000,
            window_delta_sum                  : 0,
            window_duration_sum               : 0,
        };
        let v1 = 0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::constants::emission_caps_dynamic_key();
        if (0x2::dynamic_field::exists_<0x1::string::String>(&arg0.id, v1)) {
            0x2::dynamic_field::remove<0x1::string::String, RewardEmissionCaps>(&mut arg0.id, v1);
        };
        0x2::dynamic_field::add<0x1::string::String, RewardEmissionCaps>(&mut arg0.id, v1, v0);
        0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::events::emit_emission_caps_updated_event(arg1, arg2, arg3);
    }

    public(friend) fun set_reward_manager(arg0: &mut GlobalConfig, arg1: address) {
        assert!(!verify_reward_manager(arg0, arg1), 0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::errors::already_a_reward_manger());
        0x1::vector::push_back<address>(&mut arg0.reward_managers, arg1);
    }

    public fun verify_reward_manager(arg0: &GlobalConfig, arg1: address) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg0.reward_managers)) {
            if (*0x1::vector::borrow<address>(&arg0.reward_managers, v0) == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun verify_version(arg0: &GlobalConfig) {
        assert!(arg0.version == 9, 0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::errors::version_mismatch());
    }

    // decompiled from Move bytecode v7
}

