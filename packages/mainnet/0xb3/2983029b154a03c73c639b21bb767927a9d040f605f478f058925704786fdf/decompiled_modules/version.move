module 0xb32983029b154a03c73c639b21bb767927a9d040f605f478f058925704786fdf::version {
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

