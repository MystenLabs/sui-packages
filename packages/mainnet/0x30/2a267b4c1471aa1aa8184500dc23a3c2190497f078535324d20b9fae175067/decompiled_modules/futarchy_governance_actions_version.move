module 0x302a267b4c1471aa1aa8184500dc23a3c2190497f078535324d20b9fae175067::futarchy_governance_actions_version {
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

