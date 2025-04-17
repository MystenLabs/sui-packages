module 0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::fee_config {
    struct FeeConfig has copy, drop, store {
        protocol: 0x825601a3542567b0c99e2d7f29fb169d68a4b8416cfd6ec9ce3a36a835a96ee7::bps::BPS,
        deposit: 0x825601a3542567b0c99e2d7f29fb169d68a4b8416cfd6ec9ce3a36a835a96ee7::bps::BPS,
        withdraw: 0x825601a3542567b0c99e2d7f29fb169d68a4b8416cfd6ec9ce3a36a835a96ee7::bps::BPS,
    }

    public(friend) fun new() : FeeConfig {
        FeeConfig{
            protocol : 0x825601a3542567b0c99e2d7f29fb169d68a4b8416cfd6ec9ce3a36a835a96ee7::bps::new(0),
            deposit  : 0x825601a3542567b0c99e2d7f29fb169d68a4b8416cfd6ec9ce3a36a835a96ee7::bps::new(0),
            withdraw : 0x825601a3542567b0c99e2d7f29fb169d68a4b8416cfd6ec9ce3a36a835a96ee7::bps::new(0),
        }
    }

    public fun deposit(arg0: &FeeConfig) : 0x825601a3542567b0c99e2d7f29fb169d68a4b8416cfd6ec9ce3a36a835a96ee7::bps::BPS {
        arg0.deposit
    }

    public fun protocol(arg0: &FeeConfig) : 0x825601a3542567b0c99e2d7f29fb169d68a4b8416cfd6ec9ce3a36a835a96ee7::bps::BPS {
        arg0.protocol
    }

    public(friend) fun set_deposit(arg0: &mut FeeConfig, arg1: u64) {
        arg0.deposit = 0x825601a3542567b0c99e2d7f29fb169d68a4b8416cfd6ec9ce3a36a835a96ee7::bps::new(arg1);
    }

    public(friend) fun set_protocol(arg0: &mut FeeConfig, arg1: u64) {
        arg0.protocol = 0x825601a3542567b0c99e2d7f29fb169d68a4b8416cfd6ec9ce3a36a835a96ee7::bps::new(arg1);
    }

    public(friend) fun set_withdraw(arg0: &mut FeeConfig, arg1: u64) {
        arg0.withdraw = 0x825601a3542567b0c99e2d7f29fb169d68a4b8416cfd6ec9ce3a36a835a96ee7::bps::new(arg1);
    }

    public fun withdraw(arg0: &FeeConfig) : 0x825601a3542567b0c99e2d7f29fb169d68a4b8416cfd6ec9ce3a36a835a96ee7::bps::BPS {
        arg0.withdraw
    }

    // decompiled from Move bytecode v6
}

