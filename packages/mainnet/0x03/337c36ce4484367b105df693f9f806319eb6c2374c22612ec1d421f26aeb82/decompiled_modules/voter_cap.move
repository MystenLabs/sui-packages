module 0x3337c36ce4484367b105df693f9f806319eb6c2374c22612ec1d421f26aeb82::voter_cap {
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

    // decompiled from Move bytecode v6
}

