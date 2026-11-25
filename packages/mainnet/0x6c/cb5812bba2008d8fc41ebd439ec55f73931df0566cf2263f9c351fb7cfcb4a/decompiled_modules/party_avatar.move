module 0x6ccb5812bba2008d8fc41ebd439ec55f73931df0566cf2263f9c351fb7cfcb4a::party_avatar {
    struct PartyAvatarKey has copy, drop, store {
        dummy_field: bool,
    }

    struct PartyAvatarSetEvent has copy, drop {
        party_id: 0x2::object::ID,
        blob_id: u256,
    }

    struct PartyAvatarClearedEvent has copy, drop {
        party_id: 0x2::object::ID,
    }

    public fun avatar(arg0: &0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::Party) : u256 {
        assert!(has_avatar(arg0), 0);
        let v0 = PartyAvatarKey{dummy_field: false};
        *0x2::dynamic_field::borrow<PartyAvatarKey, u256>(0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::uid(arg0), v0)
    }

    public fun clear_avatar(arg0: &mut 0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::Party, arg1: &0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::PartyAdminCap) {
        let v0 = 0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::uid_mut(arg0, arg1);
        let v1 = PartyAvatarKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<PartyAvatarKey>(v0, v1)) {
            return
        };
        let v2 = PartyAvatarKey{dummy_field: false};
        0x2::dynamic_field::remove<PartyAvatarKey, u256>(v0, v2);
        let v3 = PartyAvatarClearedEvent{party_id: 0x2::object::id<0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::Party>(arg0)};
        0x2::event::emit<PartyAvatarClearedEvent>(v3);
    }

    public fun has_avatar(arg0: &0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::Party) : bool {
        let v0 = PartyAvatarKey{dummy_field: false};
        0x2::dynamic_field::exists<PartyAvatarKey>(0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::uid(arg0), v0)
    }

    public fun set_avatar(arg0: &mut 0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::Party, arg1: &0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::PartyAdminCap, arg2: u256) {
        let v0 = 0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::uid_mut(arg0, arg1);
        let v1 = PartyAvatarKey{dummy_field: false};
        if (0x2::dynamic_field::exists<PartyAvatarKey>(v0, v1)) {
            let v2 = PartyAvatarKey{dummy_field: false};
            let v3 = 0x2::dynamic_field::borrow_mut<PartyAvatarKey, u256>(v0, v2);
            if (*v3 == arg2) {
                return
            };
            *v3 = arg2;
        } else {
            let v4 = PartyAvatarKey{dummy_field: false};
            0x2::dynamic_field::add<PartyAvatarKey, u256>(v0, v4, arg2);
        };
        let v5 = PartyAvatarSetEvent{
            party_id : 0x2::object::id<0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::Party>(arg0),
            blob_id  : arg2,
        };
        0x2::event::emit<PartyAvatarSetEvent>(v5);
    }

    // decompiled from Move bytecode v7
}

