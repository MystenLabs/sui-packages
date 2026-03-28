module 0xef51213fc603deb91130db02a967eacdc2d73956ef972fe5ab1b186e8b213e46::futarchy_governance_actions_version {
    struct V1 has drop {
        dummy_field: bool,
    }

    public(friend) fun current() : 0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::version_witness::VersionWitness {
        let v0 = V1{dummy_field: false};
        0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::version_witness::new<V1>(v0)
    }

    public fun get() : u64 {
        1
    }

    // decompiled from Move bytecode v6
}

