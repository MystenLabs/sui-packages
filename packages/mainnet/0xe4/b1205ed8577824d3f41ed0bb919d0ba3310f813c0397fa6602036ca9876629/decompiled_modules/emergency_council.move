module 0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::emergency_council {
    struct EmergencyCouncilCap has store, key {
        id: 0x2::object::UID,
        voter: 0x2::object::ID,
    }

    public fun validate_emergency_council_voter_id(arg0: &EmergencyCouncilCap, arg1: 0x2::object::ID) {
        assert!(arg0.voter == arg1, 9223372084099416065);
    }

    // decompiled from Move bytecode v6
}

