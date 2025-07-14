module 0x5ee778a0e10b43e6b28367b72cb15731760e4f42d0da4637af5bbecbcd814e8b::emergency_council {
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

