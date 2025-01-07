module 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config {
    struct GlobalConfig has store, key {
        id: 0x2::object::UID,
        min_tick: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        max_tick: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        version: u64,
        reward_managers: vector<address>,
    }

    public fun get_tick_range(arg0: &GlobalConfig) : (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) {
        (arg0.min_tick, arg0.max_tick)
    }

    public(friend) fun increase_version(arg0: &mut GlobalConfig) : (u64, u64) {
        assert!(arg0.version < 3, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::errors::verion_cant_be_increased());
        arg0.version = arg0.version + 1;
        (arg0.version, arg0.version)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GlobalConfig{
            id              : 0x2::object::new(arg0),
            min_tick        : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_tick(),
            max_tick        : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_tick(),
            version         : 3,
            reward_managers : 0x1::vector::empty<address>(),
        };
        0x2::transfer::share_object<GlobalConfig>(v0);
    }

    public(friend) fun remove_reward_manager(arg0: &mut GlobalConfig, arg1: address) {
        assert!(verify_reward_manager(arg0, arg1), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::errors::reward_manager_not_found());
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg0.reward_managers)) {
            if (*0x1::vector::borrow<address>(&arg0.reward_managers, v0) == arg1) {
                0x1::vector::remove<address>(&mut arg0.reward_managers, v0);
                break
            };
            v0 = v0 + 1;
        };
    }

    public(friend) fun set_reward_manager(arg0: &mut GlobalConfig, arg1: address) {
        assert!(!verify_reward_manager(arg0, arg1), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::errors::already_a_reward_manger());
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
        assert!(arg0.version == 3, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::errors::version_mismatch());
    }

    // decompiled from Move bytecode v6
}

