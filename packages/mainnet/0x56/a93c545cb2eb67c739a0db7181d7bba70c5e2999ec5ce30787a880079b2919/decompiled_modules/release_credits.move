module 0x56a93c545cb2eb67c739a0db7181d7bba70c5e2999ec5ce30787a880079b2919::release_credits {
    struct ReleaseCredits has store {
        credits: 0x2::vec_map::VecMap<0x2::object::ID, 0xf6c09b6b20a514c9494b6b31443642841441d2965c8c49968315b54f27bc2222::credit::Credit<0x56a93c545cb2eb67c739a0db7181d7bba70c5e2999ec5ce30787a880079b2919::release_party_role::ReleasePartyRole>>,
    }

    struct ReleaseCreditsKey has copy, drop, store {
        dummy_field: bool,
    }

    struct ReleaseCreditAddedEvent has copy, drop {
        release_id: 0x2::object::ID,
        party_id: 0x2::object::ID,
        display_name: 0x1::string::String,
        role: 0x56a93c545cb2eb67c739a0db7181d7bba70c5e2999ec5ce30787a880079b2919::release_party_role::ReleasePartyRole,
    }

    struct ReleaseCreditRemovedEvent has copy, drop {
        release_id: 0x2::object::ID,
        party_id: 0x2::object::ID,
    }

    public fun add_credit(arg0: &mut 0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::release::Release, arg1: &0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::release::ReleaseAdminCap, arg2: &0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::Party, arg3: 0xf6c09b6b20a514c9494b6b31443642841441d2965c8c49968315b54f27bc2222::credit::Credit<0x56a93c545cb2eb67c739a0db7181d7bba70c5e2999ec5ce30787a880079b2919::release_party_role::ReleasePartyRole>) {
        assert!(0x1::vector::length<0x56a93c545cb2eb67c739a0db7181d7bba70c5e2999ec5ce30787a880079b2919::release_party_role::ReleasePartyRole>(0xf6c09b6b20a514c9494b6b31443642841441d2965c8c49968315b54f27bc2222::credit::roles<0x56a93c545cb2eb67c739a0db7181d7bba70c5e2999ec5ce30787a880079b2919::release_party_role::ReleasePartyRole>(&arg3)) == 1, 4);
        let v0 = 0x2::object::id<0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::Party>(arg2);
        let v1 = 0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::release::uid_mut(arg0, arg1);
        let v2 = ReleaseCreditsKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<ReleaseCreditsKey>(v1, v2)) {
            let v3 = ReleaseCreditsKey{dummy_field: false};
            let v4 = ReleaseCredits{credits: 0x2::vec_map::empty<0x2::object::ID, 0xf6c09b6b20a514c9494b6b31443642841441d2965c8c49968315b54f27bc2222::credit::Credit<0x56a93c545cb2eb67c739a0db7181d7bba70c5e2999ec5ce30787a880079b2919::release_party_role::ReleasePartyRole>>()};
            0x2::dynamic_field::add<ReleaseCreditsKey, ReleaseCredits>(v1, v3, v4);
        };
        let v5 = ReleaseCreditsKey{dummy_field: false};
        let v6 = 0x2::dynamic_field::borrow_mut<ReleaseCreditsKey, ReleaseCredits>(v1, v5);
        assert!(0x2::vec_map::length<0x2::object::ID, 0xf6c09b6b20a514c9494b6b31443642841441d2965c8c49968315b54f27bc2222::credit::Credit<0x56a93c545cb2eb67c739a0db7181d7bba70c5e2999ec5ce30787a880079b2919::release_party_role::ReleasePartyRole>>(&v6.credits) < 50, 0);
        assert!(!0x2::vec_map::contains<0x2::object::ID, 0xf6c09b6b20a514c9494b6b31443642841441d2965c8c49968315b54f27bc2222::credit::Credit<0x56a93c545cb2eb67c739a0db7181d7bba70c5e2999ec5ce30787a880079b2919::release_party_role::ReleasePartyRole>>(&v6.credits, &v0), 1);
        0x2::vec_map::insert<0x2::object::ID, 0xf6c09b6b20a514c9494b6b31443642841441d2965c8c49968315b54f27bc2222::credit::Credit<0x56a93c545cb2eb67c739a0db7181d7bba70c5e2999ec5ce30787a880079b2919::release_party_role::ReleasePartyRole>>(&mut v6.credits, v0, arg3);
        let v7 = ReleaseCreditAddedEvent{
            release_id   : 0x2::object::id<0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::release::Release>(arg0),
            party_id     : v0,
            display_name : *0xf6c09b6b20a514c9494b6b31443642841441d2965c8c49968315b54f27bc2222::credit::display_name<0x56a93c545cb2eb67c739a0db7181d7bba70c5e2999ec5ce30787a880079b2919::release_party_role::ReleasePartyRole>(&arg3),
            role         : *0x1::vector::borrow<0x56a93c545cb2eb67c739a0db7181d7bba70c5e2999ec5ce30787a880079b2919::release_party_role::ReleasePartyRole>(0xf6c09b6b20a514c9494b6b31443642841441d2965c8c49968315b54f27bc2222::credit::roles<0x56a93c545cb2eb67c739a0db7181d7bba70c5e2999ec5ce30787a880079b2919::release_party_role::ReleasePartyRole>(&arg3), 0),
        };
        0x2::event::emit<ReleaseCreditAddedEvent>(v7);
    }

    public fun credits(arg0: &0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::release::Release) : &0x2::vec_map::VecMap<0x2::object::ID, 0xf6c09b6b20a514c9494b6b31443642841441d2965c8c49968315b54f27bc2222::credit::Credit<0x56a93c545cb2eb67c739a0db7181d7bba70c5e2999ec5ce30787a880079b2919::release_party_role::ReleasePartyRole>> {
        assert!(has_credits(arg0), 2);
        let v0 = ReleaseCreditsKey{dummy_field: false};
        &0x2::dynamic_field::borrow<ReleaseCreditsKey, ReleaseCredits>(0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::release::uid(arg0), v0).credits
    }

    public fun has_credits(arg0: &0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::release::Release) : bool {
        let v0 = ReleaseCreditsKey{dummy_field: false};
        0x2::dynamic_field::exists<ReleaseCreditsKey>(0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::release::uid(arg0), v0)
    }

    public fun remove_credit(arg0: &mut 0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::release::Release, arg1: &0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::release::ReleaseAdminCap, arg2: 0x2::object::ID) {
        let v0 = 0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::release::uid_mut(arg0, arg1);
        let v1 = ReleaseCreditsKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists<ReleaseCreditsKey>(v0, v1), 2);
        let v2 = ReleaseCreditsKey{dummy_field: false};
        let v3 = 0x2::dynamic_field::borrow_mut<ReleaseCreditsKey, ReleaseCredits>(v0, v2);
        assert!(0x2::vec_map::contains<0x2::object::ID, 0xf6c09b6b20a514c9494b6b31443642841441d2965c8c49968315b54f27bc2222::credit::Credit<0x56a93c545cb2eb67c739a0db7181d7bba70c5e2999ec5ce30787a880079b2919::release_party_role::ReleasePartyRole>>(&v3.credits, &arg2), 3);
        let (_, _) = 0x2::vec_map::remove<0x2::object::ID, 0xf6c09b6b20a514c9494b6b31443642841441d2965c8c49968315b54f27bc2222::credit::Credit<0x56a93c545cb2eb67c739a0db7181d7bba70c5e2999ec5ce30787a880079b2919::release_party_role::ReleasePartyRole>>(&mut v3.credits, &arg2);
        if (0x2::vec_map::is_empty<0x2::object::ID, 0xf6c09b6b20a514c9494b6b31443642841441d2965c8c49968315b54f27bc2222::credit::Credit<0x56a93c545cb2eb67c739a0db7181d7bba70c5e2999ec5ce30787a880079b2919::release_party_role::ReleasePartyRole>>(&v3.credits)) {
            let v6 = ReleaseCreditsKey{dummy_field: false};
            let ReleaseCredits { credits: v7 } = 0x2::dynamic_field::remove<ReleaseCreditsKey, ReleaseCredits>(v0, v6);
            0x2::vec_map::destroy_empty<0x2::object::ID, 0xf6c09b6b20a514c9494b6b31443642841441d2965c8c49968315b54f27bc2222::credit::Credit<0x56a93c545cb2eb67c739a0db7181d7bba70c5e2999ec5ce30787a880079b2919::release_party_role::ReleasePartyRole>>(v7);
        };
        let v8 = ReleaseCreditRemovedEvent{
            release_id : 0x2::object::id<0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::release::Release>(arg0),
            party_id   : arg2,
        };
        0x2::event::emit<ReleaseCreditRemovedEvent>(v8);
    }

    // decompiled from Move bytecode v7
}

