module 0x92da58c54321af4128a8fc28c9ab8a8d04fc5a9485e0796a869c5a590951f711::release_kind {
    struct ReleaseKindKey has copy, drop, store {
        dummy_field: bool,
    }

    struct ReleaseKindSetEvent has copy, drop {
        release_id: 0x2::object::ID,
        kind: 0x1::string::String,
    }

    struct ReleaseKindClearedEvent has copy, drop {
        release_id: 0x2::object::ID,
    }

    public fun clear_kind(arg0: &mut 0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::release::Release, arg1: &0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::release::ReleaseAdminCap) {
        let v0 = 0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::release::uid_mut(arg0, arg1);
        let v1 = ReleaseKindKey{dummy_field: false};
        if (0x2::dynamic_field::exists<ReleaseKindKey>(v0, v1)) {
            let v2 = ReleaseKindKey{dummy_field: false};
            0x2::dynamic_field::remove<ReleaseKindKey, 0x1::string::String>(v0, v2);
            let v3 = ReleaseKindClearedEvent{release_id: 0x2::object::id<0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::release::Release>(arg0)};
            0x2::event::emit<ReleaseKindClearedEvent>(v3);
        };
    }

    public fun has_kind(arg0: &0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::release::Release) : bool {
        let v0 = ReleaseKindKey{dummy_field: false};
        0x2::dynamic_field::exists<ReleaseKindKey>(0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::release::uid(arg0), v0)
    }

    public fun kind(arg0: &0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::release::Release) : &0x1::string::String {
        assert!(has_kind(arg0), 0);
        let v0 = ReleaseKindKey{dummy_field: false};
        0x2::dynamic_field::borrow<ReleaseKindKey, 0x1::string::String>(0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::release::uid(arg0), v0)
    }

    public fun set_kind(arg0: &mut 0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::release::Release, arg1: &0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::release::ReleaseAdminCap, arg2: 0x1::string::String) {
        assert!(!0x1::string::is_empty(&arg2), 1);
        assert!(0x1::string::length(&arg2) <= 32, 2);
        let v0 = 0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::release::uid_mut(arg0, arg1);
        let v1 = ReleaseKindKey{dummy_field: false};
        if (0x2::dynamic_field::exists<ReleaseKindKey>(v0, v1)) {
            let v2 = ReleaseKindKey{dummy_field: false};
            let v3 = 0x2::dynamic_field::borrow_mut<ReleaseKindKey, 0x1::string::String>(v0, v2);
            if (*v3 == arg2) {
                return
            };
            *v3 = arg2;
        } else {
            let v4 = ReleaseKindKey{dummy_field: false};
            0x2::dynamic_field::add<ReleaseKindKey, 0x1::string::String>(v0, v4, arg2);
        };
        let v5 = ReleaseKindSetEvent{
            release_id : 0x2::object::id<0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::release::Release>(arg0),
            kind       : arg2,
        };
        0x2::event::emit<ReleaseKindSetEvent>(v5);
    }

    // decompiled from Move bytecode v7
}

