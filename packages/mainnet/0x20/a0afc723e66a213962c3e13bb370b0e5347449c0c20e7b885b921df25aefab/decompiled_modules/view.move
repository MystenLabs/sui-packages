module 0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::view {
    public fun epoch_config(arg0: &0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::ve_mmt::VeMMT) : &0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::epoch::EpochConfig {
        0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::ve_mmt::ep_config(arg0)
    }

    public fun vote_power_config(arg0: &0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::ve_mmt::VeMMT) : &0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::vote_power::VotePowerConfig {
        0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::ve_mmt::vp_config(arg0)
    }

    // decompiled from Move bytecode v6
}

