module 0x39eeb775b5abe9f68786c20935c594946149eed6dfc28bcce1d83c0705a767b8::markets_core_version {
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

