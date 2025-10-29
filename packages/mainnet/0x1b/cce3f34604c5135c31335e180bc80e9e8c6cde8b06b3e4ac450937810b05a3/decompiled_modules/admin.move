module 0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::admin {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct ExtendConfig has key {
        id: 0x2::object::UID,
        reward_amount: u64,
    }

    public fun get_extend_reward(arg0: &ExtendConfig) : u64 {
        arg0.reward_amount
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = ExtendConfig{
            id            : 0x2::object::new(arg0),
            reward_amount : 0,
        };
        0x2::transfer::share_object<ExtendConfig>(v1);
    }

    public entry fun update_extend_reward(arg0: &AdminCap, arg1: &mut ExtendConfig, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.reward_amount = arg2;
    }

    // decompiled from Move bytecode v6
}

