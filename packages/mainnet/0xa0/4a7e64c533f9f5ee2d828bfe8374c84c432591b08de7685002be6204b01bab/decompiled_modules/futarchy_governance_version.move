module 0xa04a7e64c533f9f5ee2d828bfe8374c84c432591b08de7685002be6204b01bab::futarchy_governance_version {
    struct V1 has drop {
        dummy_field: bool,
    }

    public(friend) fun current() : 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::version_witness::VersionWitness {
        let v0 = V1{dummy_field: false};
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::version_witness::new<V1>(v0)
    }

    public fun get() : u64 {
        1
    }

    // decompiled from Move bytecode v6
}

