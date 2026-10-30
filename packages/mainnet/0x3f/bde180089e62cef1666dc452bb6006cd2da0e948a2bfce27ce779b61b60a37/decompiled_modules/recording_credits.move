module 0x3fbde180089e62cef1666dc452bb6006cd2da0e948a2bfce27ce779b61b60a37::recording_credits {
    struct RecordingCredits has store {
        credits: 0x2::vec_map::VecMap<0x2::object::ID, 0xf6c09b6b20a514c9494b6b31443642841441d2965c8c49968315b54f27bc2222::credit::Credit<0x3fbde180089e62cef1666dc452bb6006cd2da0e948a2bfce27ce779b61b60a37::recording_party_role::RecordingPartyRole>>,
    }

    struct RecordingCreditsKey has copy, drop, store {
        dummy_field: bool,
    }

    struct RecordingCreditAddedEvent has copy, drop {
        recording_id: 0x2::object::ID,
        party_id: 0x2::object::ID,
        display_name: 0x1::string::String,
        roles: vector<0x3fbde180089e62cef1666dc452bb6006cd2da0e948a2bfce27ce779b61b60a37::recording_party_role::RecordingPartyRole>,
    }

    struct RecordingCreditRemovedEvent has copy, drop {
        recording_id: 0x2::object::ID,
        party_id: 0x2::object::ID,
    }

    fun borrow(arg0: &0x2::object::UID) : &RecordingCredits {
        let v0 = RecordingCreditsKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists<RecordingCreditsKey>(arg0, v0), 3);
        let v1 = RecordingCreditsKey{dummy_field: false};
        0x2::dynamic_field::borrow<RecordingCreditsKey, RecordingCredits>(arg0, v1)
    }

    public fun add_credit<T0>(arg0: &mut 0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::Recording<T0>, arg1: &0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::RecordingAdminCap<T0>, arg2: &0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::Party, arg3: 0xf6c09b6b20a514c9494b6b31443642841441d2965c8c49968315b54f27bc2222::credit::Credit<0x3fbde180089e62cef1666dc452bb6006cd2da0e948a2bfce27ce779b61b60a37::recording_party_role::RecordingPartyRole>) {
        assert!(0x1::vector::length<0x3fbde180089e62cef1666dc452bb6006cd2da0e948a2bfce27ce779b61b60a37::recording_party_role::RecordingPartyRole>(0xf6c09b6b20a514c9494b6b31443642841441d2965c8c49968315b54f27bc2222::credit::roles<0x3fbde180089e62cef1666dc452bb6006cd2da0e948a2bfce27ce779b61b60a37::recording_party_role::RecordingPartyRole>(&arg3)) <= 10, 0);
        let v0 = 0x3fbde180089e62cef1666dc452bb6006cd2da0e948a2bfce27ce779b61b60a37::recording_party_role::new_primary_role();
        let v1 = if (0x1::vector::contains<0x3fbde180089e62cef1666dc452bb6006cd2da0e948a2bfce27ce779b61b60a37::recording_party_role::RecordingPartyRole>(0xf6c09b6b20a514c9494b6b31443642841441d2965c8c49968315b54f27bc2222::credit::roles<0x3fbde180089e62cef1666dc452bb6006cd2da0e948a2bfce27ce779b61b60a37::recording_party_role::RecordingPartyRole>(&arg3), &v0)) {
            let v2 = 0x3fbde180089e62cef1666dc452bb6006cd2da0e948a2bfce27ce779b61b60a37::recording_party_role::new_featured_role();
            0x1::vector::contains<0x3fbde180089e62cef1666dc452bb6006cd2da0e948a2bfce27ce779b61b60a37::recording_party_role::RecordingPartyRole>(0xf6c09b6b20a514c9494b6b31443642841441d2965c8c49968315b54f27bc2222::credit::roles<0x3fbde180089e62cef1666dc452bb6006cd2da0e948a2bfce27ce779b61b60a37::recording_party_role::RecordingPartyRole>(&arg3), &v2)
        } else {
            false
        };
        assert!(!v1, 5);
        let v3 = 0x2::object::id<0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::Party>(arg2);
        let v4 = 0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::uid_mut<T0>(arg0, arg1);
        let v5 = RecordingCreditsKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<RecordingCreditsKey>(v4, v5)) {
            let v6 = RecordingCreditsKey{dummy_field: false};
            let v7 = RecordingCredits{credits: 0x2::vec_map::empty<0x2::object::ID, 0xf6c09b6b20a514c9494b6b31443642841441d2965c8c49968315b54f27bc2222::credit::Credit<0x3fbde180089e62cef1666dc452bb6006cd2da0e948a2bfce27ce779b61b60a37::recording_party_role::RecordingPartyRole>>()};
            0x2::dynamic_field::add<RecordingCreditsKey, RecordingCredits>(v4, v6, v7);
        };
        let v8 = RecordingCreditsKey{dummy_field: false};
        let v9 = 0x2::dynamic_field::borrow_mut<RecordingCreditsKey, RecordingCredits>(v4, v8);
        assert!(0x2::vec_map::length<0x2::object::ID, 0xf6c09b6b20a514c9494b6b31443642841441d2965c8c49968315b54f27bc2222::credit::Credit<0x3fbde180089e62cef1666dc452bb6006cd2da0e948a2bfce27ce779b61b60a37::recording_party_role::RecordingPartyRole>>(&v9.credits) < 150, 1);
        assert!(!0x2::vec_map::contains<0x2::object::ID, 0xf6c09b6b20a514c9494b6b31443642841441d2965c8c49968315b54f27bc2222::credit::Credit<0x3fbde180089e62cef1666dc452bb6006cd2da0e948a2bfce27ce779b61b60a37::recording_party_role::RecordingPartyRole>>(&v9.credits, &v3), 2);
        0x2::vec_map::insert<0x2::object::ID, 0xf6c09b6b20a514c9494b6b31443642841441d2965c8c49968315b54f27bc2222::credit::Credit<0x3fbde180089e62cef1666dc452bb6006cd2da0e948a2bfce27ce779b61b60a37::recording_party_role::RecordingPartyRole>>(&mut v9.credits, v3, arg3);
        let v10 = RecordingCreditAddedEvent{
            recording_id : 0x2::object::id<0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::Recording<T0>>(arg0),
            party_id     : v3,
            display_name : *0xf6c09b6b20a514c9494b6b31443642841441d2965c8c49968315b54f27bc2222::credit::display_name<0x3fbde180089e62cef1666dc452bb6006cd2da0e948a2bfce27ce779b61b60a37::recording_party_role::RecordingPartyRole>(&arg3),
            roles        : *0xf6c09b6b20a514c9494b6b31443642841441d2965c8c49968315b54f27bc2222::credit::roles<0x3fbde180089e62cef1666dc452bb6006cd2da0e948a2bfce27ce779b61b60a37::recording_party_role::RecordingPartyRole>(&arg3),
        };
        0x2::event::emit<RecordingCreditAddedEvent>(v10);
    }

    public fun credits<T0>(arg0: &0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::Recording<T0>) : &0x2::vec_map::VecMap<0x2::object::ID, 0xf6c09b6b20a514c9494b6b31443642841441d2965c8c49968315b54f27bc2222::credit::Credit<0x3fbde180089e62cef1666dc452bb6006cd2da0e948a2bfce27ce779b61b60a37::recording_party_role::RecordingPartyRole>> {
        &borrow(0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::uid<T0>(arg0)).credits
    }

    public fun has_credits<T0>(arg0: &0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::Recording<T0>) : bool {
        let v0 = RecordingCreditsKey{dummy_field: false};
        0x2::dynamic_field::exists<RecordingCreditsKey>(0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::uid<T0>(arg0), v0)
    }

    fun has_role<T0>(arg0: &0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::Recording<T0>, arg1: 0x2::object::ID, arg2: 0x3fbde180089e62cef1666dc452bb6006cd2da0e948a2bfce27ce779b61b60a37::recording_party_role::RecordingPartyRole) : bool {
        if (has_credits<T0>(arg0)) {
            let v1 = 0x2::vec_map::try_get<0x2::object::ID, 0xf6c09b6b20a514c9494b6b31443642841441d2965c8c49968315b54f27bc2222::credit::Credit<0x3fbde180089e62cef1666dc452bb6006cd2da0e948a2bfce27ce779b61b60a37::recording_party_role::RecordingPartyRole>>(&borrow(0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::uid<T0>(arg0)).credits, &arg1);
            let v2 = &v1;
            0x1::option::is_some<0xf6c09b6b20a514c9494b6b31443642841441d2965c8c49968315b54f27bc2222::credit::Credit<0x3fbde180089e62cef1666dc452bb6006cd2da0e948a2bfce27ce779b61b60a37::recording_party_role::RecordingPartyRole>>(v2) && 0x1::vector::contains<0x3fbde180089e62cef1666dc452bb6006cd2da0e948a2bfce27ce779b61b60a37::recording_party_role::RecordingPartyRole>(0xf6c09b6b20a514c9494b6b31443642841441d2965c8c49968315b54f27bc2222::credit::roles<0x3fbde180089e62cef1666dc452bb6006cd2da0e948a2bfce27ce779b61b60a37::recording_party_role::RecordingPartyRole>(0x1::option::borrow<0xf6c09b6b20a514c9494b6b31443642841441d2965c8c49968315b54f27bc2222::credit::Credit<0x3fbde180089e62cef1666dc452bb6006cd2da0e948a2bfce27ce779b61b60a37::recording_party_role::RecordingPartyRole>>(v2)), &arg2)
        } else {
            false
        }
    }

    public fun is_featured_artist<T0>(arg0: &0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::Recording<T0>, arg1: 0x2::object::ID) : bool {
        has_role<T0>(arg0, arg1, 0x3fbde180089e62cef1666dc452bb6006cd2da0e948a2bfce27ce779b61b60a37::recording_party_role::new_featured_role())
    }

    public fun is_primary_artist<T0>(arg0: &0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::Recording<T0>, arg1: 0x2::object::ID) : bool {
        has_role<T0>(arg0, arg1, 0x3fbde180089e62cef1666dc452bb6006cd2da0e948a2bfce27ce779b61b60a37::recording_party_role::new_primary_role())
    }

    public fun remove_credit<T0>(arg0: &mut 0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::Recording<T0>, arg1: &0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::RecordingAdminCap<T0>, arg2: 0x2::object::ID) {
        let v0 = 0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::uid_mut<T0>(arg0, arg1);
        let v1 = RecordingCreditsKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists<RecordingCreditsKey>(v0, v1), 3);
        let v2 = RecordingCreditsKey{dummy_field: false};
        let v3 = 0x2::dynamic_field::borrow_mut<RecordingCreditsKey, RecordingCredits>(v0, v2);
        assert!(0x2::vec_map::contains<0x2::object::ID, 0xf6c09b6b20a514c9494b6b31443642841441d2965c8c49968315b54f27bc2222::credit::Credit<0x3fbde180089e62cef1666dc452bb6006cd2da0e948a2bfce27ce779b61b60a37::recording_party_role::RecordingPartyRole>>(&v3.credits, &arg2), 4);
        let (_, _) = 0x2::vec_map::remove<0x2::object::ID, 0xf6c09b6b20a514c9494b6b31443642841441d2965c8c49968315b54f27bc2222::credit::Credit<0x3fbde180089e62cef1666dc452bb6006cd2da0e948a2bfce27ce779b61b60a37::recording_party_role::RecordingPartyRole>>(&mut v3.credits, &arg2);
        if (0x2::vec_map::is_empty<0x2::object::ID, 0xf6c09b6b20a514c9494b6b31443642841441d2965c8c49968315b54f27bc2222::credit::Credit<0x3fbde180089e62cef1666dc452bb6006cd2da0e948a2bfce27ce779b61b60a37::recording_party_role::RecordingPartyRole>>(&v3.credits)) {
            let v6 = RecordingCreditsKey{dummy_field: false};
            let RecordingCredits { credits: v7 } = 0x2::dynamic_field::remove<RecordingCreditsKey, RecordingCredits>(v0, v6);
            0x2::vec_map::destroy_empty<0x2::object::ID, 0xf6c09b6b20a514c9494b6b31443642841441d2965c8c49968315b54f27bc2222::credit::Credit<0x3fbde180089e62cef1666dc452bb6006cd2da0e948a2bfce27ce779b61b60a37::recording_party_role::RecordingPartyRole>>(v7);
        };
        let v8 = RecordingCreditRemovedEvent{
            recording_id : 0x2::object::id<0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::Recording<T0>>(arg0),
            party_id     : arg2,
        };
        0x2::event::emit<RecordingCreditRemovedEvent>(v8);
    }

    // decompiled from Move bytecode v7
}

