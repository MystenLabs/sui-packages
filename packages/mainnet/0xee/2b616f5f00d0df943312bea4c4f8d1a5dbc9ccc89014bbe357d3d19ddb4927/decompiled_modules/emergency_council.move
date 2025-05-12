module 0xee2b616f5f00d0df943312bea4c4f8d1a5dbc9ccc89014bbe357d3d19ddb4927::emergency_council {
    struct EmergencyCouncilCap has store, key {
        id: 0x2::object::UID,
        voter: 0x2::object::ID,
    }

    public fun validate_emergency_council_voter_id(arg0: &EmergencyCouncilCap, arg1: 0x2::object::ID) {
        assert!(arg0.voter == arg1, 9223372084099416065);
    }

    // decompiled from Move bytecode v6
}

