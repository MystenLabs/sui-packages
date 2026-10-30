module 0x12c62597c4b2b41fff94c8a937ceac17a98035195f79cb08e4a9226e91f188cc::recording_version {
    struct RecordingVersionKey has copy, drop, store {
        dummy_field: bool,
    }

    struct RecordingVersionSetEvent has copy, drop {
        recording_id: 0x2::object::ID,
        version: 0x1::string::String,
    }

    struct RecordingVersionClearedEvent has copy, drop {
        recording_id: 0x2::object::ID,
    }

    public fun clear_version<T0>(arg0: &mut 0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::Recording<T0>, arg1: &0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::RecordingAdminCap<T0>) {
        let v0 = 0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::uid_mut<T0>(arg0, arg1);
        let v1 = RecordingVersionKey{dummy_field: false};
        if (0x2::dynamic_field::exists<RecordingVersionKey>(v0, v1)) {
            let v2 = RecordingVersionKey{dummy_field: false};
            0x2::dynamic_field::remove<RecordingVersionKey, 0x1::string::String>(v0, v2);
            let v3 = RecordingVersionClearedEvent{recording_id: 0x2::object::id<0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::Recording<T0>>(arg0)};
            0x2::event::emit<RecordingVersionClearedEvent>(v3);
        };
    }

    public fun has_version<T0>(arg0: &0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::Recording<T0>) : bool {
        let v0 = RecordingVersionKey{dummy_field: false};
        0x2::dynamic_field::exists<RecordingVersionKey>(0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::uid<T0>(arg0), v0)
    }

    public fun set_version<T0>(arg0: &mut 0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::Recording<T0>, arg1: &0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::RecordingAdminCap<T0>, arg2: 0x1::string::String) {
        assert!(!0x1::string::is_empty(&arg2), 1);
        assert!(0x1::string::length(&arg2) <= 300, 2);
        let v0 = 0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::uid_mut<T0>(arg0, arg1);
        let v1 = RecordingVersionKey{dummy_field: false};
        if (0x2::dynamic_field::exists<RecordingVersionKey>(v0, v1)) {
            let v2 = RecordingVersionKey{dummy_field: false};
            let v3 = 0x2::dynamic_field::borrow_mut<RecordingVersionKey, 0x1::string::String>(v0, v2);
            if (*v3 == arg2) {
                return
            };
            *v3 = arg2;
        } else {
            let v4 = RecordingVersionKey{dummy_field: false};
            0x2::dynamic_field::add<RecordingVersionKey, 0x1::string::String>(v0, v4, arg2);
        };
        let v5 = RecordingVersionSetEvent{
            recording_id : 0x2::object::id<0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::Recording<T0>>(arg0),
            version      : arg2,
        };
        0x2::event::emit<RecordingVersionSetEvent>(v5);
    }

    public fun version<T0>(arg0: &0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::Recording<T0>) : &0x1::string::String {
        assert!(has_version<T0>(arg0), 0);
        let v0 = RecordingVersionKey{dummy_field: false};
        0x2::dynamic_field::borrow<RecordingVersionKey, 0x1::string::String>(0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::uid<T0>(arg0), v0)
    }

    // decompiled from Move bytecode v7
}

