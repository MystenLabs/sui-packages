module 0xc228487ef78ae4bd9899d25fbe018f51573e84c5e11b941b93806008c607ce0d::futarchy_actions_version {
    struct V1 has drop {
        dummy_field: bool,
    }

    public(friend) fun current() : 0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::version_witness::VersionWitness {
        let v0 = V1{dummy_field: false};
        0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::version_witness::new<V1>(v0)
    }

    public fun get() : u64 {
        1
    }

    // decompiled from Move bytecode v6
}

