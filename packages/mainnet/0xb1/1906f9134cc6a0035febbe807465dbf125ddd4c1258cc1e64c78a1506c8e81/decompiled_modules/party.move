module 0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party {
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
        assert!(arg1.party_id == 0x2::object::id<Party>(arg0), 0);
        &mut arg0.id
    }

    // decompiled from Move bytecode v7
}

