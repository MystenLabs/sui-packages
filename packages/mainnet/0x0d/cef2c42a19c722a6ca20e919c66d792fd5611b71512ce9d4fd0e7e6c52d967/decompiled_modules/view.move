module 0xdcef2c42a19c722a6ca20e919c66d792fd5611b71512ce9d4fd0e7e6c52d967::view {
    public fun epoch_config(arg0: &0xdcef2c42a19c722a6ca20e919c66d792fd5611b71512ce9d4fd0e7e6c52d967::ve_mmt::VeMMT) : &0xdcef2c42a19c722a6ca20e919c66d792fd5611b71512ce9d4fd0e7e6c52d967::epoch::EpochConfig {
        0xdcef2c42a19c722a6ca20e919c66d792fd5611b71512ce9d4fd0e7e6c52d967::ve_mmt::ep_config(arg0)
    }

    public fun vote_power_config(arg0: &0xdcef2c42a19c722a6ca20e919c66d792fd5611b71512ce9d4fd0e7e6c52d967::ve_mmt::VeMMT) : &0xdcef2c42a19c722a6ca20e919c66d792fd5611b71512ce9d4fd0e7e6c52d967::vote_power::VotePowerConfig {
        0xdcef2c42a19c722a6ca20e919c66d792fd5611b71512ce9d4fd0e7e6c52d967::ve_mmt::vp_config(arg0)
    }

    // decompiled from Move bytecode v6
}

