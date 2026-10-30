module 0x6cb2b8eb21112289dece6de339e69b7846d795fca2a32e5c16ed016a694616f1::party_name {
    struct PartyNameKey has copy, drop, store {
        dummy_field: bool,
    }

    struct PartyNameSetEvent has copy, drop {
        party_id: 0x2::object::ID,
        name: 0x1::string::String,
    }

    struct PartyNameClearedEvent has copy, drop {
        party_id: 0x2::object::ID,
    }

    public fun clear_name(arg0: &mut 0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::Party, arg1: &0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::PartyAdminCap) {
        let v0 = 0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::uid_mut(arg0, arg1);
        let v1 = PartyNameKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<PartyNameKey>(v0, v1)) {
            return
        };
        let v2 = PartyNameKey{dummy_field: false};
        0x2::dynamic_field::remove<PartyNameKey, 0x1::string::String>(v0, v2);
        let v3 = PartyNameClearedEvent{party_id: 0x2::object::id<0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::Party>(arg0)};
        0x2::event::emit<PartyNameClearedEvent>(v3);
    }

    public fun has_name(arg0: &0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::Party) : bool {
        let v0 = PartyNameKey{dummy_field: false};
        0x2::dynamic_field::exists<PartyNameKey>(0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::uid(arg0), v0)
    }

    public fun name(arg0: &0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::Party) : &0x1::string::String {
        assert!(has_name(arg0), 1);
        let v0 = PartyNameKey{dummy_field: false};
        0x2::dynamic_field::borrow<PartyNameKey, 0x1::string::String>(0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::uid(arg0), v0)
    }

    public fun set_name(arg0: &mut 0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::Party, arg1: &0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::PartyAdminCap, arg2: 0x1::string::String) {
        assert!(!0x1::string::is_empty(&arg2), 0);
        let v0 = 0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::uid_mut(arg0, arg1);
        let v1 = PartyNameKey{dummy_field: false};
        if (0x2::dynamic_field::exists<PartyNameKey>(v0, v1)) {
            let v2 = PartyNameKey{dummy_field: false};
            let v3 = 0x2::dynamic_field::borrow_mut<PartyNameKey, 0x1::string::String>(v0, v2);
            if (*v3 == arg2) {
                return
            };
            *v3 = arg2;
        } else {
            let v4 = PartyNameKey{dummy_field: false};
            0x2::dynamic_field::add<PartyNameKey, 0x1::string::String>(v0, v4, arg2);
        };
        let v5 = PartyNameSetEvent{
            party_id : 0x2::object::id<0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::Party>(arg0),
            name     : arg2,
        };
        0x2::event::emit<PartyNameSetEvent>(v5);
    }

    // decompiled from Move bytecode v7
}

