module 0x8f590aa6736839006120ccd266402d39e31200e4ee455b27889ca27b2c6dd535::version {
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

