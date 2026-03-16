module 0x6432af42a13ca4959039643db01b481e48b8f53bc7659138407f296b088189a6::futarchy_governance_actions_version {
    struct V1 has drop {
        dummy_field: bool,
    }

    public(friend) fun current() : 0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::version_witness::VersionWitness {
        let v0 = V1{dummy_field: false};
        0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::version_witness::new<V1>(v0)
    }

    public fun get() : u64 {
        1
    }

    // decompiled from Move bytecode v6
}

