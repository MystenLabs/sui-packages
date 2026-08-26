module 0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_authority {
    struct OverTool has drop {
        dummy_field: bool,
    }

    public(friend) fun new(arg0: &0x2::object::UID, arg1: &mut 0x2::tx_context::TxContext) : 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::owner_cap::CloneableOwnerCap<OverTool> {
        let v0 = OverTool{dummy_field: false};
        0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::owner_cap::new_cloneable_drop<OverTool>(v0, arg0, arg1)
    }

    // decompiled from Move bytecode v7
}

