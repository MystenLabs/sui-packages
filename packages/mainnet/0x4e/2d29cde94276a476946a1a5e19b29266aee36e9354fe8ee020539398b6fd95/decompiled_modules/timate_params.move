module 0x4e2d29cde94276a476946a1a5e19b29266aee36e9354fe8ee020539398b6fd95::timate_params {
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

    public entry fun set_params(arg0: &0x4e2d29cde94276a476946a1a5e19b29266aee36e9354fe8ee020539398b6fd95::admin::AdminCap, arg1: &mut TimateParams, arg2: u64) {
        arg1.reward_per_mate_tvyn = arg2;
    }

    // decompiled from Move bytecode v6
}

