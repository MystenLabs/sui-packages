module 0x991ff8e6e7ad1eeff47e82e6e2921619b79828658941282d7d4e2008a6841d6::timate_params {
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

    public entry fun set_params(arg0: &0x991ff8e6e7ad1eeff47e82e6e2921619b79828658941282d7d4e2008a6841d6::admin::AdminCap, arg1: &mut TimateParams, arg2: u64) {
        arg1.reward_per_mate_tvyn = arg2;
    }

    // decompiled from Move bytecode v6
}

