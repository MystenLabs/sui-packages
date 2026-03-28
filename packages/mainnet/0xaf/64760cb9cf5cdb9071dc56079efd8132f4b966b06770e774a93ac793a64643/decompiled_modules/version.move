module 0xaf64760cb9cf5cdb9071dc56079efd8132f4b966b06770e774a93ac793a64643::version {
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

