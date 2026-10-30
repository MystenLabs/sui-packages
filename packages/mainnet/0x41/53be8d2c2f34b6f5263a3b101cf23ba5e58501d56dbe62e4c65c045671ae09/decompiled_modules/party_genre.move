module 0x4153be8d2c2f34b6f5263a3b101cf23ba5e58501d56dbe62e4c65c045671ae09::party_genre {
    struct PartyGenreKey has copy, drop, store {
        pos0: 0x2::object::ID,
    }

    struct PartyGenreAddedEvent has copy, drop {
        party_id: 0x2::object::ID,
        genre_id: 0x2::object::ID,
        genre_name: 0x1::string::String,
    }

    struct PartyGenreRemovedEvent has copy, drop {
        party_id: 0x2::object::ID,
        genre_id: 0x2::object::ID,
    }

    public fun add_genre(arg0: &mut 0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::Party, arg1: &0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::PartyAdminCap, arg2: &0xfa21fae0a05165943e5a4b466e84b34d7a8ea6d1b29c86d1185675e793a34363::genre::Genre) {
        let v0 = 0x2::object::id<0xfa21fae0a05165943e5a4b466e84b34d7a8ea6d1b29c86d1185675e793a34363::genre::Genre>(arg2);
        let v1 = 0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::uid_mut(arg0, arg1);
        let v2 = PartyGenreKey{pos0: v0};
        assert!(!0x2::dynamic_field::exists<PartyGenreKey>(v1, v2), 0);
        let v3 = PartyGenreKey{pos0: v0};
        0x2::dynamic_field::add<PartyGenreKey, bool>(v1, v3, true);
        let v4 = PartyGenreAddedEvent{
            party_id   : 0x2::object::id<0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::Party>(arg0),
            genre_id   : v0,
            genre_name : *0xfa21fae0a05165943e5a4b466e84b34d7a8ea6d1b29c86d1185675e793a34363::genre::name(arg2),
        };
        0x2::event::emit<PartyGenreAddedEvent>(v4);
    }

    public fun has_genre(arg0: &0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::Party, arg1: 0x2::object::ID) : bool {
        let v0 = PartyGenreKey{pos0: arg1};
        0x2::dynamic_field::exists<PartyGenreKey>(0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::uid(arg0), v0)
    }

    public fun remove_genre(arg0: &mut 0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::Party, arg1: &0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::PartyAdminCap, arg2: 0x2::object::ID) {
        let v0 = 0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::uid_mut(arg0, arg1);
        let v1 = PartyGenreKey{pos0: arg2};
        assert!(0x2::dynamic_field::exists<PartyGenreKey>(v0, v1), 1);
        let v2 = PartyGenreKey{pos0: arg2};
        0x2::dynamic_field::remove<PartyGenreKey, bool>(v0, v2);
        let v3 = PartyGenreRemovedEvent{
            party_id : 0x2::object::id<0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::Party>(arg0),
            genre_id : arg2,
        };
        0x2::event::emit<PartyGenreRemovedEvent>(v3);
    }

    // decompiled from Move bytecode v7
}

