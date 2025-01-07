module 0x982840be4cfd4d0753deb00d2ebc73d3a3c72e967e3fb43f60e2e85681cabbdb::events {
    struct NewCrew has copy, drop {
        id: 0x2::object::ID,
        index: u32,
    }

    struct NewPirate has copy, drop {
        id: 0x2::object::ID,
        kind: u8,
    }

    struct Recruit has copy, drop {
        crew_id: 0x2::object::ID,
        crew_index: u32,
        crew_strength: u16,
        pirate_kind: u8,
    }

    struct AddTreasure has copy, drop {
        amount: u64,
    }

    struct FoundTreasure has copy, drop {
        crew_id: 0x2::object::ID,
        crew_index: u32,
        strength: u16,
    }

    public(friend) fun emit_add_treasure(arg0: u64) {
        let v0 = AddTreasure{amount: arg0};
        0x2::event::emit<AddTreasure>(v0);
    }

    public(friend) fun emit_found_treasure(arg0: 0x2::object::ID, arg1: u32, arg2: u16) {
        let v0 = FoundTreasure{
            crew_id    : arg0,
            crew_index : arg1,
            strength   : arg2,
        };
        0x2::event::emit<FoundTreasure>(v0);
    }

    public(friend) fun emit_new_crew(arg0: 0x2::object::ID, arg1: u32) {
        let v0 = NewCrew{
            id    : arg0,
            index : arg1,
        };
        0x2::event::emit<NewCrew>(v0);
    }

    public(friend) fun emit_new_pirate(arg0: 0x2::object::ID, arg1: u8) {
        let v0 = NewPirate{
            id   : arg0,
            kind : arg1,
        };
        0x2::event::emit<NewPirate>(v0);
    }

    public(friend) fun emit_recruit(arg0: 0x2::object::ID, arg1: u32, arg2: u16, arg3: u8) {
        let v0 = Recruit{
            crew_id       : arg0,
            crew_index    : arg1,
            crew_strength : arg2,
            pirate_kind   : arg3,
        };
        0x2::event::emit<Recruit>(v0);
    }

    // decompiled from Move bytecode v6
}

