module 0x138de32047c175c735290e663ec7861a2c1ef9fef1fc90f8d70387a64e43e6e0::version {
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

