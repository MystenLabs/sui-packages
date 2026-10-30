module 0xeb07cbadcce336b27b157535b7ed74c1627e010065f39f1da4609c12a8664891::release_description {
    struct ReleaseDescriptionKey has copy, drop, store {
        dummy_field: bool,
    }

    struct ReleaseDescriptionSetEvent has copy, drop {
        release_id: 0x2::object::ID,
        description: 0x1::string::String,
    }

    struct ReleaseDescriptionClearedEvent has copy, drop {
        release_id: 0x2::object::ID,
    }

    public fun clear_description(arg0: &mut 0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::release::Release, arg1: &0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::release::ReleaseAdminCap) {
        let v0 = 0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::release::uid_mut(arg0, arg1);
        let v1 = ReleaseDescriptionKey{dummy_field: false};
        if (0x2::dynamic_field::exists<ReleaseDescriptionKey>(v0, v1)) {
            let v2 = ReleaseDescriptionKey{dummy_field: false};
            0x2::dynamic_field::remove<ReleaseDescriptionKey, 0x1::string::String>(v0, v2);
            let v3 = ReleaseDescriptionClearedEvent{release_id: 0x2::object::id<0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::release::Release>(arg0)};
            0x2::event::emit<ReleaseDescriptionClearedEvent>(v3);
        };
    }

    public fun description(arg0: &0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::release::Release) : &0x1::string::String {
        assert!(has_description(arg0), 0);
        let v0 = ReleaseDescriptionKey{dummy_field: false};
        0x2::dynamic_field::borrow<ReleaseDescriptionKey, 0x1::string::String>(0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::release::uid(arg0), v0)
    }

    public fun has_description(arg0: &0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::release::Release) : bool {
        let v0 = ReleaseDescriptionKey{dummy_field: false};
        0x2::dynamic_field::exists<ReleaseDescriptionKey>(0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::release::uid(arg0), v0)
    }

    public fun set_description(arg0: &mut 0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::release::Release, arg1: &0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::release::ReleaseAdminCap, arg2: 0x1::string::String) {
        assert!(!0x1::string::is_empty(&arg2), 1);
        assert!(0x1::string::length(&arg2) <= 8192, 2);
        let v0 = 0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::release::uid_mut(arg0, arg1);
        let v1 = ReleaseDescriptionKey{dummy_field: false};
        if (0x2::dynamic_field::exists<ReleaseDescriptionKey>(v0, v1)) {
            let v2 = ReleaseDescriptionKey{dummy_field: false};
            let v3 = 0x2::dynamic_field::borrow_mut<ReleaseDescriptionKey, 0x1::string::String>(v0, v2);
            if (*v3 == arg2) {
                return
            };
            *v3 = arg2;
        } else {
            let v4 = ReleaseDescriptionKey{dummy_field: false};
            0x2::dynamic_field::add<ReleaseDescriptionKey, 0x1::string::String>(v0, v4, arg2);
        };
        let v5 = ReleaseDescriptionSetEvent{
            release_id  : 0x2::object::id<0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::release::Release>(arg0),
            description : arg2,
        };
        0x2::event::emit<ReleaseDescriptionSetEvent>(v5);
    }

    // decompiled from Move bytecode v7
}

