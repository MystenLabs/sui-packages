module 0x1c00074e80bcb82298b8cb4f743af3f9423b057bfdfaea40e085f62960021f4e::futarchy_governance_version {
    struct V1 has drop {
        dummy_field: bool,
    }

    public(friend) fun current() : 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::version_witness::VersionWitness {
        let v0 = V1{dummy_field: false};
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::version_witness::new<V1>(v0)
    }

    public fun get() : u64 {
        1
    }

    // decompiled from Move bytecode v6
}

