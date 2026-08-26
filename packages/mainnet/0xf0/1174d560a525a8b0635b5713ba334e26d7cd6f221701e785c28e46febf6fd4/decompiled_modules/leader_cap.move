module 0xf01174d560a525a8b0635b5713ba334e26d7cd6f221701e785c28e46febf6fd4::leader_cap {
    struct OverNetwork has drop {
        dummy_field: bool,
    }

    struct FoundingLeaderCapCreatedEvent has copy, drop {
        leader_cap: 0x2::object::ID,
        network: 0x2::object::ID,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::owner_cap::CloneableOwnerCap<OverNetwork> {
        let v0 = 0x2::object::new(arg0);
        let v1 = OverNetwork{dummy_field: false};
        let v2 = 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::owner_cap::new_cloneable_drop<OverNetwork>(v1, &v0, arg0);
        0x2::object::delete(v0);
        let v3 = FoundingLeaderCapCreatedEvent{
            leader_cap : 0x2::object::id<0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::owner_cap::CloneableOwnerCap<OverNetwork>>(&v2),
            network    : 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::owner_cap::what_for<OverNetwork>(&v2),
        };
        0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::event::emit<FoundingLeaderCapCreatedEvent>(v3);
        v2
    }

    public fun what_for(arg0: &0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::owner_cap::CloneableOwnerCap<OverNetwork>) : 0x2::object::ID {
        0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::owner_cap::what_for<OverNetwork>(arg0)
    }

    // decompiled from Move bytecode v7
}

