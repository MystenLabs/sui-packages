module 0x2de81c0f5cc2aa176da9f093834efbf846d581afa46516bf4952b6efd3a44992::voter_cap {
    struct VoterCap has store, key {
        id: 0x2::object::UID,
        voter_id: 0x2::object::ID,
    }

    public fun create_voter_cap(arg0: &0x2::package::Publisher, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) : VoterCap {
        assert!(0x2::package::from_package<VoterCap>(arg0), 13906834243062857727);
        VoterCap{
            id       : 0x2::object::new(arg2),
            voter_id : arg1,
        }
    }

    public fun get_voter_id(arg0: &VoterCap) : 0x2::object::ID {
        arg0.voter_id
    }

    // decompiled from Move bytecode v7
}

