module 0x6f3c9ce6b1f496974066ab37640eb09017a6b9d392138039021db4e4e4c6032c::fee_config {
    struct FeeConfig has copy, drop, store {
        protocol: 0x14844479546b92d12dc4c8476cbcb112b730d11341e01ee3a9f7146b88cfba77::bps::BPS,
        deposit: 0x14844479546b92d12dc4c8476cbcb112b730d11341e01ee3a9f7146b88cfba77::bps::BPS,
        withdraw: 0x14844479546b92d12dc4c8476cbcb112b730d11341e01ee3a9f7146b88cfba77::bps::BPS,
    }

    public(friend) fun new() : FeeConfig {
        FeeConfig{
            protocol : 0x14844479546b92d12dc4c8476cbcb112b730d11341e01ee3a9f7146b88cfba77::bps::new(0),
            deposit  : 0x14844479546b92d12dc4c8476cbcb112b730d11341e01ee3a9f7146b88cfba77::bps::new(0),
            withdraw : 0x14844479546b92d12dc4c8476cbcb112b730d11341e01ee3a9f7146b88cfba77::bps::new(0),
        }
    }

    public fun deposit(arg0: &FeeConfig) : 0x14844479546b92d12dc4c8476cbcb112b730d11341e01ee3a9f7146b88cfba77::bps::BPS {
        arg0.deposit
    }

    public fun protocol(arg0: &FeeConfig) : 0x14844479546b92d12dc4c8476cbcb112b730d11341e01ee3a9f7146b88cfba77::bps::BPS {
        arg0.protocol
    }

    public(friend) fun set_deposit(arg0: &mut FeeConfig, arg1: u64) {
        assert!(arg1 <= 3000, 18);
        arg0.deposit = 0x14844479546b92d12dc4c8476cbcb112b730d11341e01ee3a9f7146b88cfba77::bps::new(arg1);
    }

    public(friend) fun set_protocol(arg0: &mut FeeConfig, arg1: u64) {
        assert!(arg1 <= 3000, 18);
        arg0.protocol = 0x14844479546b92d12dc4c8476cbcb112b730d11341e01ee3a9f7146b88cfba77::bps::new(arg1);
    }

    public(friend) fun set_withdraw(arg0: &mut FeeConfig, arg1: u64) {
        assert!(arg1 <= 3000, 18);
        arg0.withdraw = 0x14844479546b92d12dc4c8476cbcb112b730d11341e01ee3a9f7146b88cfba77::bps::new(arg1);
    }

    public fun withdraw(arg0: &FeeConfig) : 0x14844479546b92d12dc4c8476cbcb112b730d11341e01ee3a9f7146b88cfba77::bps::BPS {
        arg0.withdraw
    }

    // decompiled from Move bytecode v7
}

