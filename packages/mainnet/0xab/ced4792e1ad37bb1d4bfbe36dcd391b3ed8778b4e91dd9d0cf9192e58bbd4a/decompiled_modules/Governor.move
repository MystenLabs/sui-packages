module 0xabced4792e1ad37bb1d4bfbe36dcd391b3ed8778b4e91dd9d0cf9192e58bbd4a::Governor {
    struct Config has store, key {
        id: 0x2::object::UID,
        quorum_bps: u64,
        threshold_bps: u64,
        vote_period_secs: u64,
        timelock_secs: u64,
        admin: address,
    }

    public entry fun deploy(arg0: address, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = Config{
            id               : 0x2::object::new(arg5),
            quorum_bps       : arg1,
            threshold_bps    : arg2,
            vote_period_secs : arg3,
            timelock_secs    : arg4,
            admin            : arg0,
        };
        0x2::transfer::share_object<Config>(v0);
    }

    public entry fun exec_distribute(arg0: &mut 0xabced4792e1ad37bb1d4bfbe36dcd391b3ed8778b4e91dd9d0cf9192e58bbd4a::Treasury::Treasury, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0xabced4792e1ad37bb1d4bfbe36dcd391b3ed8778b4e91dd9d0cf9192e58bbd4a::Treasury::distribute(arg0, arg1, arg2, arg3);
    }

    public entry fun set_params(arg0: &mut Config, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == arg0.admin, 7001);
        arg0.quorum_bps = arg1;
        arg0.threshold_bps = arg2;
        arg0.vote_period_secs = arg3;
        arg0.timelock_secs = arg4;
    }

    // decompiled from Move bytecode v6
}

