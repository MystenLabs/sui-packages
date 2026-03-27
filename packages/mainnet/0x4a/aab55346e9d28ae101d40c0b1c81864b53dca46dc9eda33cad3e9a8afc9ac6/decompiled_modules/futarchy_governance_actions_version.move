module 0x4aaab55346e9d28ae101d40c0b1c81864b53dca46dc9eda33cad3e9a8afc9ac6::futarchy_governance_actions_version {
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

