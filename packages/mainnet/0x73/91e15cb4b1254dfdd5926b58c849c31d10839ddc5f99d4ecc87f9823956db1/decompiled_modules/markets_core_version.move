module 0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::markets_core_version {
    struct V1 has drop {
        dummy_field: bool,
    }

    public(friend) fun current() : 0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::version_witness::VersionWitness {
        let v0 = V1{dummy_field: false};
        0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::version_witness::new<V1>(v0)
    }

    public fun get() : u64 {
        1
    }

    // decompiled from Move bytecode v6
}

