module 0xe0995fe9b27a7379aea60376ff7d0a9761a2342058eb353e9e466099ccb0cad2::party {
    struct Party has key {
        id: 0x2::object::UID,
    }

    struct PartyAdminCap has store, key {
        id: 0x2::object::UID,
        party_id: 0x2::object::ID,
    }

    struct PartyAdminCapKey has copy, drop, store {
        dummy_field: bool,
    }

    struct PartyCreatedEvent has copy, drop {
        party_id: 0x2::object::ID,
        party_admin_cap_id: 0x2::object::ID,
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) : (Party, PartyAdminCap) {
        let v0 = Party{id: 0x2::object::new(arg0)};
        let v1 = PartyAdminCapKey{dummy_field: false};
        let v2 = PartyAdminCap{
            id       : 0x2::derived_object::claim<PartyAdminCapKey>(&mut v0.id, v1),
            party_id : 0x2::object::id<Party>(&v0),
        };
        let v3 = PartyCreatedEvent{
            party_id           : 0x2::object::id<Party>(&v0),
            party_admin_cap_id : 0x2::object::id<PartyAdminCap>(&v2),
        };
        0x2::event::emit<PartyCreatedEvent>(v3);
        (v0, v2)
    }

    fun authorize(arg0: &Party, arg1: &PartyAdminCap) {
        assert!(arg1.party_id == 0x2::object::id<Party>(arg0), 0);
    }

    public fun party_admin_cap_party_id(arg0: &PartyAdminCap) : 0x2::object::ID {
        arg0.party_id
    }

    public fun share(arg0: Party) {
        0x2::transfer::share_object<Party>(arg0);
    }

    public fun uid(arg0: &Party) : &0x2::object::UID {
        &arg0.id
    }

    public fun uid_mut(arg0: &mut Party, arg1: &PartyAdminCap) : &mut 0x2::object::UID {
        authorize(arg0, arg1);
        &mut arg0.id
    }

    // decompiled from Move bytecode v7
}

