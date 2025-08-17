module 0x83837d4c898d6113f9a302290d7f4bf52bd9ec91918e63809c5984b368d16ef5::view {
    public fun epoch_config(arg0: &0x83837d4c898d6113f9a302290d7f4bf52bd9ec91918e63809c5984b368d16ef5::ve_mmt::VeMMT) : &0x83837d4c898d6113f9a302290d7f4bf52bd9ec91918e63809c5984b368d16ef5::epoch::EpochConfig {
        0x83837d4c898d6113f9a302290d7f4bf52bd9ec91918e63809c5984b368d16ef5::ve_mmt::ep_config(arg0)
    }

    public fun vote_power_config(arg0: &0x83837d4c898d6113f9a302290d7f4bf52bd9ec91918e63809c5984b368d16ef5::ve_mmt::VeMMT) : &0x83837d4c898d6113f9a302290d7f4bf52bd9ec91918e63809c5984b368d16ef5::vote_power::VotePowerConfig {
        0x83837d4c898d6113f9a302290d7f4bf52bd9ec91918e63809c5984b368d16ef5::ve_mmt::vp_config(arg0)
    }

    // decompiled from Move bytecode v6
}

