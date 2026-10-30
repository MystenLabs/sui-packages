module 0xc08ae67dfd03a3df841e89586e7a93b33c9421ec075b216e61b22db7735868eb::release_title {
    struct ReleaseTitleKey has copy, drop, store {
        dummy_field: bool,
    }

    struct ReleaseTitleSetEvent has copy, drop {
        release_id: 0x2::object::ID,
        title: 0x1::string::String,
    }

    struct ReleaseTitleClearedEvent has copy, drop {
        release_id: 0x2::object::ID,
    }

    public fun clear_title(arg0: &mut 0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::release::Release, arg1: &0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::release::ReleaseAdminCap) {
        let v0 = 0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::release::uid_mut(arg0, arg1);
        let v1 = ReleaseTitleKey{dummy_field: false};
        if (0x2::dynamic_field::exists<ReleaseTitleKey>(v0, v1)) {
            let v2 = ReleaseTitleKey{dummy_field: false};
            0x2::dynamic_field::remove<ReleaseTitleKey, 0x1::string::String>(v0, v2);
            let v3 = ReleaseTitleClearedEvent{release_id: 0x2::object::id<0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::release::Release>(arg0)};
            0x2::event::emit<ReleaseTitleClearedEvent>(v3);
        };
    }

    public fun has_title(arg0: &0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::release::Release) : bool {
        let v0 = ReleaseTitleKey{dummy_field: false};
        0x2::dynamic_field::exists<ReleaseTitleKey>(0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::release::uid(arg0), v0)
    }

    public fun set_title(arg0: &mut 0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::release::Release, arg1: &0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::release::ReleaseAdminCap, arg2: 0x1::string::String) {
        assert!(!0x1::string::is_empty(&arg2), 1);
        assert!(0x1::string::length(&arg2) <= 300, 2);
        let v0 = 0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::release::uid_mut(arg0, arg1);
        let v1 = ReleaseTitleKey{dummy_field: false};
        if (0x2::dynamic_field::exists<ReleaseTitleKey>(v0, v1)) {
            let v2 = ReleaseTitleKey{dummy_field: false};
            let v3 = 0x2::dynamic_field::borrow_mut<ReleaseTitleKey, 0x1::string::String>(v0, v2);
            if (*v3 == arg2) {
                return
            };
            *v3 = arg2;
        } else {
            let v4 = ReleaseTitleKey{dummy_field: false};
            0x2::dynamic_field::add<ReleaseTitleKey, 0x1::string::String>(v0, v4, arg2);
        };
        let v5 = ReleaseTitleSetEvent{
            release_id : 0x2::object::id<0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::release::Release>(arg0),
            title      : arg2,
        };
        0x2::event::emit<ReleaseTitleSetEvent>(v5);
    }

    public fun title(arg0: &0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::release::Release) : &0x1::string::String {
        assert!(has_title(arg0), 0);
        let v0 = ReleaseTitleKey{dummy_field: false};
        0x2::dynamic_field::borrow<ReleaseTitleKey, 0x1::string::String>(0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::release::uid(arg0), v0)
    }

    // decompiled from Move bytecode v7
}

