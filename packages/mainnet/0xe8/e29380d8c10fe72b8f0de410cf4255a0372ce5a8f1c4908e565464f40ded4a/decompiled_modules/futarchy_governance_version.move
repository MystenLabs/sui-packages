module 0xe8e29380d8c10fe72b8f0de410cf4255a0372ce5a8f1c4908e565464f40ded4a::futarchy_governance_version {
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

