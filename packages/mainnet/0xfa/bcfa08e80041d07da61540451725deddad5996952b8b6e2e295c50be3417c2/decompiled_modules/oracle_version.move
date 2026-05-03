module 0xfabcfa08e80041d07da61540451725deddad5996952b8b6e2e295c50be3417c2::oracle_version {
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

