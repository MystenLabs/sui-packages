module 0x7c90babe3f59e43970791e363018bccbe16ff698a1c7ff050acfe4ac2bc182ee::party_hero {
    struct PartyHeroKey has copy, drop, store {
        dummy_field: bool,
    }

    struct PartyHeroSetEvent has copy, drop {
        party_id: 0x2::object::ID,
        blob_id: u256,
    }

    struct PartyHeroClearedEvent has copy, drop {
        party_id: 0x2::object::ID,
    }

    public fun clear_hero(arg0: &mut 0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::Party, arg1: &0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::PartyAdminCap) {
        let v0 = 0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::uid_mut(arg0, arg1);
        let v1 = PartyHeroKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<PartyHeroKey>(v0, v1)) {
            return
        };
        let v2 = PartyHeroKey{dummy_field: false};
        0x2::dynamic_field::remove<PartyHeroKey, u256>(v0, v2);
        let v3 = PartyHeroClearedEvent{party_id: 0x2::object::id<0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::Party>(arg0)};
        0x2::event::emit<PartyHeroClearedEvent>(v3);
    }

    public fun has_hero(arg0: &0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::Party) : bool {
        let v0 = PartyHeroKey{dummy_field: false};
        0x2::dynamic_field::exists<PartyHeroKey>(0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::uid(arg0), v0)
    }

    public fun hero(arg0: &0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::Party) : u256 {
        assert!(has_hero(arg0), 0);
        let v0 = PartyHeroKey{dummy_field: false};
        *0x2::dynamic_field::borrow<PartyHeroKey, u256>(0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::uid(arg0), v0)
    }

    public fun set_hero(arg0: &mut 0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::Party, arg1: &0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::PartyAdminCap, arg2: u256) {
        let v0 = 0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::uid_mut(arg0, arg1);
        let v1 = PartyHeroKey{dummy_field: false};
        if (0x2::dynamic_field::exists<PartyHeroKey>(v0, v1)) {
            let v2 = PartyHeroKey{dummy_field: false};
            let v3 = 0x2::dynamic_field::borrow_mut<PartyHeroKey, u256>(v0, v2);
            if (*v3 == arg2) {
                return
            };
            *v3 = arg2;
        } else {
            let v4 = PartyHeroKey{dummy_field: false};
            0x2::dynamic_field::add<PartyHeroKey, u256>(v0, v4, arg2);
        };
        let v5 = PartyHeroSetEvent{
            party_id : 0x2::object::id<0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::Party>(arg0),
            blob_id  : arg2,
        };
        0x2::event::emit<PartyHeroSetEvent>(v5);
    }

    // decompiled from Move bytecode v7
}

