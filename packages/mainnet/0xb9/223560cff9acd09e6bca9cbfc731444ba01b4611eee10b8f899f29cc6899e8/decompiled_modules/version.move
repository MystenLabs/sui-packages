module 0xb9223560cff9acd09e6bca9cbfc731444ba01b4611eee10b8f899f29cc6899e8::version {
    public fun major() : u64 {
        2
    }

    public fun minor() : u64 {
        1
    }

    public fun patch() : u64 {
        0
    }

    public fun trust_committee_quorum() : u8 {
        2
    }

    public fun trust_player_quorum() : u8 {
        3
    }

    public fun trust_prototype() : u8 {
        1
    }

    public fun trust_prototype_label() : vector<u8> {
        b"phase2-prototype: settlement signed only by coordinator. Not for mainnet."
    }

    // decompiled from Move bytecode v7
}

