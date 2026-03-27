module 0x56583f1cdfbb6b9ae91f7a01a36b863233fdd50d49a6bb7015a48c8d1640577e::factory_version {
    struct V1 has drop {
        dummy_field: bool,
    }

    public(friend) fun current() : 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::version_witness::VersionWitness {
        let v0 = V1{dummy_field: false};
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::version_witness::new<V1>(v0)
    }

    public fun get() : u64 {
        1
    }

    // decompiled from Move bytecode v6
}

