module 0x90f9e30039c06e088a01b5613a1ef0a721eb5049d202e1901b57756de0f836be::timate_params {
    struct TimateParams has store, key {
        id: 0x2::object::UID,
        reward_per_mate_tvyn: u64,
    }

    public entry fun create_and_share(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = TimateParams{
            id                   : 0x2::object::new(arg1),
            reward_per_mate_tvyn : arg0,
        };
        0x2::transfer::share_object<TimateParams>(v0);
    }

    public fun reward_per_mate_tvyn(arg0: &TimateParams) : u64 {
        arg0.reward_per_mate_tvyn
    }

    public entry fun set_params(arg0: &0x90f9e30039c06e088a01b5613a1ef0a721eb5049d202e1901b57756de0f836be::admin::AdminCap, arg1: &mut TimateParams, arg2: u64) {
        arg1.reward_per_mate_tvyn = arg2;
    }

    // decompiled from Move bytecode v6
}

