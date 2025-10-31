module 0xe5bda0278568aa03390e8809fe9fadaf21a2b47756c8baa5eb36c7a72677db9a::admin {
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

    entry fun update_extend_reward(arg0: &AdminCap, arg1: &mut ExtendConfig, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.reward_amount = arg2;
    }

    // decompiled from Move bytecode v6
}

