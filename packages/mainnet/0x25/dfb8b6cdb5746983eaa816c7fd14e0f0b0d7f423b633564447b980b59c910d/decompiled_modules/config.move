module 0x25dfb8b6cdb5746983eaa816c7fd14e0f0b0d7f423b633564447b980b59c910d::config {
    struct GlobalConfig has store, key {
        id: 0x2::object::UID,
        min_tick: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        max_tick: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        version: u64,
        reward_managers: vector<address>,
    }

    public(friend) fun get_config_id(arg0: &mut GlobalConfig) : &mut 0x2::object::UID {
        abort 0
    }

    public fun get_pool_creation_fee_amount<T0>(arg0: &GlobalConfig) : (bool, u64) {
        abort 0
    }

    public fun get_tick_range(arg0: &GlobalConfig) : (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) {
        abort 0
    }

    public(friend) fun increase_version(arg0: &mut GlobalConfig) : (u64, u64) {
        abort 0
    }

    public(friend) fun remove_reward_manager(arg0: &mut GlobalConfig, arg1: address) {
        abort 0
    }

    public(friend) fun set_reward_manager(arg0: &mut GlobalConfig, arg1: address) {
        abort 0
    }

    public fun verify_reward_manager(arg0: &GlobalConfig, arg1: address) : bool {
        abort 0
    }

    public fun verify_version(arg0: &GlobalConfig) {
        abort 0
    }

    // decompiled from Move bytecode v6
}

