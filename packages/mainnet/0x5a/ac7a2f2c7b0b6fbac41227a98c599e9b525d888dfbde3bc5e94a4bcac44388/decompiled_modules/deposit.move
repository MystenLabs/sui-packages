module 0x5aac7a2f2c7b0b6fbac41227a98c599e9b525d888dfbde3bc5e94a4bcac44388::deposit {
    struct DepositEvent has copy, drop {
        pool_id: address,
        quantity: u64,
        owner: address,
    }

    public fun spoof_authenticated(arg0: address, arg1: u64, arg2: address) {
        let v0 = DepositEvent{
            pool_id  : arg2,
            quantity : arg1,
            owner    : arg0,
        };
        0x2::event::emit_authenticated<DepositEvent>(v0);
    }

    public fun spoof_plain(arg0: address, arg1: u64, arg2: address) {
        let v0 = DepositEvent{
            pool_id  : arg2,
            quantity : arg1,
            owner    : arg0,
        };
        0x2::event::emit<DepositEvent>(v0);
    }

    // decompiled from Move bytecode v7
}

