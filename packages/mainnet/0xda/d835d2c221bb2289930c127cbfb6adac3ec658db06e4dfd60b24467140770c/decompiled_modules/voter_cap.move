module 0xdad835d2c221bb2289930c127cbfb6adac3ec658db06e4dfd60b24467140770c::voter_cap {
    struct VoterCap has store, key {
        id: 0x2::object::UID,
        voter_id: 0x2::object::ID,
    }

    public fun create_voter_cap(arg0: &0x2::package::Publisher, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) : VoterCap {
        assert!(0x2::package::from_package<VoterCap>(arg0), 9223372105574252543);
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

