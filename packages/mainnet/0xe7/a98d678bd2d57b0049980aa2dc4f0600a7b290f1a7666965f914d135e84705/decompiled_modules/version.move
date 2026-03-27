module 0xe7a98d678bd2d57b0049980aa2dc4f0600a7b290f1a7666965f914d135e84705::version {
    struct V1 has drop {
        dummy_field: bool,
    }

    public(friend) fun current() : 0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::version_witness::VersionWitness {
        let v0 = V1{dummy_field: false};
        0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::version_witness::new<V1>(v0)
    }

    public fun get() : u64 {
        1
    }

    // decompiled from Move bytecode v6
}

