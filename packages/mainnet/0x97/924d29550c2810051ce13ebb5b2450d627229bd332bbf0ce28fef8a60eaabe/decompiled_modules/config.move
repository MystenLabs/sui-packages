module 0x97924d29550c2810051ce13ebb5b2450d627229bd332bbf0ce28fef8a60eaabe::config {
    struct GlobalConfig has store, key {
        id: 0x2::object::UID,
        min_tick: 0x97924d29550c2810051ce13ebb5b2450d627229bd332bbf0ce28fef8a60eaabe::i32::I32,
        max_tick: 0x97924d29550c2810051ce13ebb5b2450d627229bd332bbf0ce28fef8a60eaabe::i32::I32,
        version: u64,
        reward_managers: vector<address>,
    }

    public fun get_tick_range(arg0: &GlobalConfig) : (0x97924d29550c2810051ce13ebb5b2450d627229bd332bbf0ce28fef8a60eaabe::i32::I32, 0x97924d29550c2810051ce13ebb5b2450d627229bd332bbf0ce28fef8a60eaabe::i32::I32) {
        (arg0.min_tick, arg0.max_tick)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GlobalConfig{
            id              : 0x2::object::new(arg0),
            min_tick        : 0x97924d29550c2810051ce13ebb5b2450d627229bd332bbf0ce28fef8a60eaabe::i32::neg_from(443636),
            max_tick        : 0x97924d29550c2810051ce13ebb5b2450d627229bd332bbf0ce28fef8a60eaabe::i32::from(443636),
            version         : 1,
            reward_managers : 0x1::vector::empty<address>(),
        };
        0x2::transfer::share_object<GlobalConfig>(v0);
    }

    public(friend) fun set_reward_manager(arg0: &mut GlobalConfig, arg1: address) {
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
        assert!(arg0.version == 1, 0x97924d29550c2810051ce13ebb5b2450d627229bd332bbf0ce28fef8a60eaabe::errors::version_mismatch());
    }

    // decompiled from Move bytecode v6
}

