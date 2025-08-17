module 0x9e903d9cfa2a3f432c7729421ae0b3aba339541c976861978a202ced93e956f8::view {
    public fun epoch_config(arg0: &0x9e903d9cfa2a3f432c7729421ae0b3aba339541c976861978a202ced93e956f8::ve_mmt::VeMMT) : &0x9e903d9cfa2a3f432c7729421ae0b3aba339541c976861978a202ced93e956f8::epoch::EpochConfig {
        0x9e903d9cfa2a3f432c7729421ae0b3aba339541c976861978a202ced93e956f8::ve_mmt::ep_config(arg0)
    }

    public fun vote_power_config(arg0: &0x9e903d9cfa2a3f432c7729421ae0b3aba339541c976861978a202ced93e956f8::ve_mmt::VeMMT) : &0x9e903d9cfa2a3f432c7729421ae0b3aba339541c976861978a202ced93e956f8::vote_power::VotePowerConfig {
        0x9e903d9cfa2a3f432c7729421ae0b3aba339541c976861978a202ced93e956f8::ve_mmt::vp_config(arg0)
    }

    // decompiled from Move bytecode v6
}

