module 0xe6f27140ed9512299942c388c83b1eadbaca9298bbd152100a81baac441120aa::composition_credits {
    struct CompositionCredits has store {
        credits: 0x2::vec_map::VecMap<0x2::object::ID, 0xf6c09b6b20a514c9494b6b31443642841441d2965c8c49968315b54f27bc2222::credit::Credit<0xe6f27140ed9512299942c388c83b1eadbaca9298bbd152100a81baac441120aa::composition_party_role::CompositionPartyRole>>,
    }

    struct CompositionCreditsKey has copy, drop, store {
        dummy_field: bool,
    }

    struct CompositionCreditAddedEvent has copy, drop {
        composition_id: 0x2::object::ID,
        party_id: 0x2::object::ID,
        display_name: 0x1::string::String,
        roles: vector<0xe6f27140ed9512299942c388c83b1eadbaca9298bbd152100a81baac441120aa::composition_party_role::CompositionPartyRole>,
    }

    struct CompositionCreditRemovedEvent has copy, drop {
        composition_id: 0x2::object::ID,
        party_id: 0x2::object::ID,
    }

    public fun add_credit<T0>(arg0: &mut 0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::composition::Composition<T0>, arg1: &0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::composition::CompositionAdminCap<T0>, arg2: &0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::Party, arg3: 0xf6c09b6b20a514c9494b6b31443642841441d2965c8c49968315b54f27bc2222::credit::Credit<0xe6f27140ed9512299942c388c83b1eadbaca9298bbd152100a81baac441120aa::composition_party_role::CompositionPartyRole>) {
        let v0 = 0x2::object::id<0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::Party>(arg2);
        let v1 = 0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::composition::uid_mut<T0>(arg0, arg1);
        let v2 = CompositionCreditsKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<CompositionCreditsKey>(v1, v2)) {
            let v3 = CompositionCreditsKey{dummy_field: false};
            let v4 = CompositionCredits{credits: 0x2::vec_map::empty<0x2::object::ID, 0xf6c09b6b20a514c9494b6b31443642841441d2965c8c49968315b54f27bc2222::credit::Credit<0xe6f27140ed9512299942c388c83b1eadbaca9298bbd152100a81baac441120aa::composition_party_role::CompositionPartyRole>>()};
            0x2::dynamic_field::add<CompositionCreditsKey, CompositionCredits>(v1, v3, v4);
        };
        let v5 = CompositionCreditsKey{dummy_field: false};
        let v6 = 0x2::dynamic_field::borrow_mut<CompositionCreditsKey, CompositionCredits>(v1, v5);
        assert!(0x2::vec_map::length<0x2::object::ID, 0xf6c09b6b20a514c9494b6b31443642841441d2965c8c49968315b54f27bc2222::credit::Credit<0xe6f27140ed9512299942c388c83b1eadbaca9298bbd152100a81baac441120aa::composition_party_role::CompositionPartyRole>>(&v6.credits) < 50, 0);
        assert!(!0x2::vec_map::contains<0x2::object::ID, 0xf6c09b6b20a514c9494b6b31443642841441d2965c8c49968315b54f27bc2222::credit::Credit<0xe6f27140ed9512299942c388c83b1eadbaca9298bbd152100a81baac441120aa::composition_party_role::CompositionPartyRole>>(&v6.credits, &v0), 1);
        0x2::vec_map::insert<0x2::object::ID, 0xf6c09b6b20a514c9494b6b31443642841441d2965c8c49968315b54f27bc2222::credit::Credit<0xe6f27140ed9512299942c388c83b1eadbaca9298bbd152100a81baac441120aa::composition_party_role::CompositionPartyRole>>(&mut v6.credits, v0, arg3);
        let v7 = CompositionCreditAddedEvent{
            composition_id : 0x2::object::id<0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::composition::Composition<T0>>(arg0),
            party_id       : v0,
            display_name   : *0xf6c09b6b20a514c9494b6b31443642841441d2965c8c49968315b54f27bc2222::credit::display_name<0xe6f27140ed9512299942c388c83b1eadbaca9298bbd152100a81baac441120aa::composition_party_role::CompositionPartyRole>(&arg3),
            roles          : *0xf6c09b6b20a514c9494b6b31443642841441d2965c8c49968315b54f27bc2222::credit::roles<0xe6f27140ed9512299942c388c83b1eadbaca9298bbd152100a81baac441120aa::composition_party_role::CompositionPartyRole>(&arg3),
        };
        0x2::event::emit<CompositionCreditAddedEvent>(v7);
    }

    public fun credits<T0>(arg0: &0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::composition::Composition<T0>) : &0x2::vec_map::VecMap<0x2::object::ID, 0xf6c09b6b20a514c9494b6b31443642841441d2965c8c49968315b54f27bc2222::credit::Credit<0xe6f27140ed9512299942c388c83b1eadbaca9298bbd152100a81baac441120aa::composition_party_role::CompositionPartyRole>> {
        let v0 = CompositionCreditsKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists<CompositionCreditsKey>(0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::composition::uid<T0>(arg0), v0), 2);
        let v1 = CompositionCreditsKey{dummy_field: false};
        &0x2::dynamic_field::borrow<CompositionCreditsKey, CompositionCredits>(0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::composition::uid<T0>(arg0), v1).credits
    }

    public fun has_credits<T0>(arg0: &0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::composition::Composition<T0>) : bool {
        let v0 = CompositionCreditsKey{dummy_field: false};
        0x2::dynamic_field::exists<CompositionCreditsKey>(0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::composition::uid<T0>(arg0), v0)
    }

    public fun remove_credit<T0>(arg0: &mut 0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::composition::Composition<T0>, arg1: &0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::composition::CompositionAdminCap<T0>, arg2: 0x2::object::ID) {
        let v0 = 0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::composition::uid_mut<T0>(arg0, arg1);
        let v1 = CompositionCreditsKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists<CompositionCreditsKey>(v0, v1), 2);
        let v2 = CompositionCreditsKey{dummy_field: false};
        let v3 = 0x2::dynamic_field::borrow_mut<CompositionCreditsKey, CompositionCredits>(v0, v2);
        assert!(0x2::vec_map::contains<0x2::object::ID, 0xf6c09b6b20a514c9494b6b31443642841441d2965c8c49968315b54f27bc2222::credit::Credit<0xe6f27140ed9512299942c388c83b1eadbaca9298bbd152100a81baac441120aa::composition_party_role::CompositionPartyRole>>(&v3.credits, &arg2), 3);
        let (_, _) = 0x2::vec_map::remove<0x2::object::ID, 0xf6c09b6b20a514c9494b6b31443642841441d2965c8c49968315b54f27bc2222::credit::Credit<0xe6f27140ed9512299942c388c83b1eadbaca9298bbd152100a81baac441120aa::composition_party_role::CompositionPartyRole>>(&mut v3.credits, &arg2);
        if (0x2::vec_map::is_empty<0x2::object::ID, 0xf6c09b6b20a514c9494b6b31443642841441d2965c8c49968315b54f27bc2222::credit::Credit<0xe6f27140ed9512299942c388c83b1eadbaca9298bbd152100a81baac441120aa::composition_party_role::CompositionPartyRole>>(&v3.credits)) {
            let v6 = CompositionCreditsKey{dummy_field: false};
            let CompositionCredits { credits: v7 } = 0x2::dynamic_field::remove<CompositionCreditsKey, CompositionCredits>(v0, v6);
            0x2::vec_map::destroy_empty<0x2::object::ID, 0xf6c09b6b20a514c9494b6b31443642841441d2965c8c49968315b54f27bc2222::credit::Credit<0xe6f27140ed9512299942c388c83b1eadbaca9298bbd152100a81baac441120aa::composition_party_role::CompositionPartyRole>>(v7);
        };
        let v8 = CompositionCreditRemovedEvent{
            composition_id : 0x2::object::id<0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::composition::Composition<T0>>(arg0),
            party_id       : arg2,
        };
        0x2::event::emit<CompositionCreditRemovedEvent>(v8);
    }

    // decompiled from Move bytecode v7
}

