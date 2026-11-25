module 0x456eebcde700350c8b185b3031c4b726d9338d172fee8d92cabc0841cacc8175::party_featured_pressing {
    struct PartyFeaturedPressingKey has copy, drop, store {
        dummy_field: bool,
    }

    struct PartyFeaturedPressingSetEvent has copy, drop {
        party_id: 0x2::object::ID,
        pressing_id: 0x2::object::ID,
    }

    struct PartyFeaturedPressingClearedEvent has copy, drop {
        party_id: 0x2::object::ID,
    }

    public fun clear_featured_pressing(arg0: &mut 0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::Party, arg1: &0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::PartyAdminCap) {
        let v0 = 0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::uid_mut(arg0, arg1);
        let v1 = PartyFeaturedPressingKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<PartyFeaturedPressingKey>(v0, v1)) {
            return
        };
        let v2 = PartyFeaturedPressingKey{dummy_field: false};
        0x2::dynamic_field::remove<PartyFeaturedPressingKey, 0x2::object::ID>(v0, v2);
        let v3 = PartyFeaturedPressingClearedEvent{party_id: 0x2::object::id<0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::Party>(arg0)};
        0x2::event::emit<PartyFeaturedPressingClearedEvent>(v3);
    }

    public fun featured_pressing(arg0: &0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::Party) : 0x1::option::Option<0x2::object::ID> {
        let v0 = PartyFeaturedPressingKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<PartyFeaturedPressingKey>(0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::uid(arg0), v0)) {
            return 0x1::option::none<0x2::object::ID>()
        };
        let v1 = PartyFeaturedPressingKey{dummy_field: false};
        0x1::option::some<0x2::object::ID>(*0x2::dynamic_field::borrow<PartyFeaturedPressingKey, 0x2::object::ID>(0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::uid(arg0), v1))
    }

    public fun set_featured_pressing(arg0: &mut 0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::Party, arg1: &0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::PartyAdminCap, arg2: &0x428736685cb8dc84f9564f8293fc2868a4ab98c5d7222fde16b41e24587b0eb7::pressing::Pressing) {
        let v0 = 0x2::object::id<0x428736685cb8dc84f9564f8293fc2868a4ab98c5d7222fde16b41e24587b0eb7::pressing::Pressing>(arg2);
        let v1 = 0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::uid_mut(arg0, arg1);
        let v2 = PartyFeaturedPressingKey{dummy_field: false};
        if (0x2::dynamic_field::exists<PartyFeaturedPressingKey>(v1, v2)) {
            let v3 = PartyFeaturedPressingKey{dummy_field: false};
            let v4 = 0x2::dynamic_field::borrow_mut<PartyFeaturedPressingKey, 0x2::object::ID>(v1, v3);
            if (*v4 == v0) {
                return
            };
            *v4 = v0;
        } else {
            let v5 = PartyFeaturedPressingKey{dummy_field: false};
            0x2::dynamic_field::add<PartyFeaturedPressingKey, 0x2::object::ID>(v1, v5, v0);
        };
        let v6 = PartyFeaturedPressingSetEvent{
            party_id    : 0x2::object::id<0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::Party>(arg0),
            pressing_id : v0,
        };
        0x2::event::emit<PartyFeaturedPressingSetEvent>(v6);
    }

    // decompiled from Move bytecode v7
}

