module 0xb37c47b69844e80738e95dbbdb26b6eda77c3eab0396618e96be581389c0cbcd::voter_cap {
    struct VoterCap has store, key {
        id: 0x2::object::UID,
        gauger_id: 0x2::object::ID,
    }

    public fun create_voter_cap(arg0: 0x2::object::ID, arg1: &mut 0x2::tx_context::TxContext) : VoterCap {
        VoterCap{
            id        : 0x2::object::new(arg1),
            gauger_id : arg0,
        }
    }

    public fun get_gauger_id(arg0: &VoterCap) : 0x2::object::ID {
        arg0.gauger_id
    }

    // decompiled from Move bytecode v6
}

