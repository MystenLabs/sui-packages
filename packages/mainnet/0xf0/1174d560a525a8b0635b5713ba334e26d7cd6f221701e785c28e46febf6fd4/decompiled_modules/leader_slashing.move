module 0xf01174d560a525a8b0635b5713ba334e26d7cd6f221701e785c28e46febf6fd4::leader_slashing {
    struct OverLeaderSlashing has drop {
        dummy_field: bool,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::owner_cap::CloneableOwnerCap<OverLeaderSlashing> {
        let v0 = 0x2::object::new(arg0);
        let v1 = OverLeaderSlashing{dummy_field: false};
        0x2::object::delete(v0);
        0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::owner_cap::new_cloneable_drop<OverLeaderSlashing>(v1, &v0, arg0)
    }

    public(friend) fun send_cap_to_sender(arg0: 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::owner_cap::CloneableOwnerCap<OverLeaderSlashing>, arg1: &0x2::tx_context::TxContext) {
        0x2::transfer::public_party_transfer<0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::owner_cap::CloneableOwnerCap<OverLeaderSlashing>>(arg0, 0x2::party::single_owner(0x2::tx_context::sender(arg1)));
    }

    // decompiled from Move bytecode v7
}

