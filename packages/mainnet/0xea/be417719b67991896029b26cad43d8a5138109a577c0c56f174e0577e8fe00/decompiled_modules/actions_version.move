module 0xeabe417719b67991896029b26cad43d8a5138109a577c0c56f174e0577e8fe00::actions_version {
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

