module 0xbf2d92e824a654c4b73adad73d9df6181a6b1904f182305ab76f93d8c74108d5::emergency_council {
    struct EmergencyCouncilCap has store, key {
        id: 0x2::object::UID,
        voter: 0x2::object::ID,
        minter: 0x2::object::ID,
    }

    struct EMERGENCY_COUNCIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: EMERGENCY_COUNCIL, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<EMERGENCY_COUNCIL>(arg0, arg1);
    }

    public fun validate_emergency_council_minter_id(arg0: &EmergencyCouncilCap, arg1: 0x2::object::ID) {
        assert!(arg0.minter == arg1, 715059658219014000);
    }

    public fun validate_emergency_council_voter_id(arg0: &EmergencyCouncilCap, arg1: 0x2::object::ID) {
        assert!(arg0.voter == arg1, 370065501622769400);
    }

    // decompiled from Move bytecode v6
}

