module 0x97b3643b2225f09904b8658aa580c01c922b226f861a87cc0e93a752182b852e::markets_core_version {
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

