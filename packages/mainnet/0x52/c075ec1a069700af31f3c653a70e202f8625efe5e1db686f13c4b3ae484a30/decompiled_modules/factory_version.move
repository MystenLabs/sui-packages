module 0x52c075ec1a069700af31f3c653a70e202f8625efe5e1db686f13c4b3ae484a30::factory_version {
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

