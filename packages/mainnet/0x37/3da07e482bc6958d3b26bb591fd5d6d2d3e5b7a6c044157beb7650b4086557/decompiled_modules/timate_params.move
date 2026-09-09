module 0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::timate_params {
    struct TimateParams has store, key {
        id: 0x2::object::UID,
        reward_per_mate_tvyn: u64,
    }

    public entry fun create_and_share(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 <= 500000000, 1);
        let v0 = TimateParams{
            id                   : 0x2::object::new(arg1),
            reward_per_mate_tvyn : arg0,
        };
        0x2::transfer::share_object<TimateParams>(v0);
    }

    public fun reward_per_mate_tvyn(arg0: &TimateParams) : u64 {
        arg0.reward_per_mate_tvyn
    }

    public entry fun set_params(arg0: &0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::admin::AdminCap, arg1: &mut TimateParams, arg2: u64) {
        assert!(arg2 <= 500000000, 1);
        arg1.reward_per_mate_tvyn = arg2;
    }

    // decompiled from Move bytecode v7
}

