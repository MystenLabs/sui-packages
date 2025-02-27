module 0xbcf711836bc18d4284d9a515462279bb473bbddb5c27f85900ca797e76d82a9d::emergency_council {
    struct EmergencyCouncilCap has store, key {
        id: 0x2::object::UID,
        voter: 0x2::object::ID,
    }

    public fun validate_emergency_council_voter_id(arg0: &EmergencyCouncilCap, arg1: 0x2::object::ID) {
        assert!(arg0.voter == arg1, 9223372084099416065);
    }

    // decompiled from Move bytecode v6
}

