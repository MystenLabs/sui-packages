module 0xa4bc24667942bc1049380b8765be422e2256f3ef9bb0cdf34c627be1b44f53f1::recording_master {
    struct RecordingMasterKey has copy, drop, store {
        pos0: 0x2::object::ID,
    }

    struct RecordingMasterAddedEvent<phantom T0> has copy, drop {
        recording_id: 0x2::object::ID,
        audio_id: 0x2::object::ID,
    }

    struct RecordingMasterRemovedEvent<phantom T0> has copy, drop {
        recording_id: 0x2::object::ID,
        audio_id: 0x2::object::ID,
    }

    public fun add_master<T0, T1>(arg0: &mut 0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::Recording<T0>, arg1: &0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::RecordingAdminCap<T0>, arg2: &0x5dafcccd44bc253b50bf35b23086e0495264956662fd96fb87b8068eef8eeaeb::audio::Audio<T1>) {
        let v0 = 0x2::object::id<0x5dafcccd44bc253b50bf35b23086e0495264956662fd96fb87b8068eef8eeaeb::audio::Audio<T1>>(arg2);
        let v1 = RecordingMasterKey{pos0: v0};
        let v2 = 0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::uid_mut<T0>(arg0, arg1);
        assert!(!0x2::dynamic_field::exists<RecordingMasterKey>(v2, v1), 1);
        0x2::dynamic_field::add<RecordingMasterKey, bool>(v2, v1, true);
        let v3 = RecordingMasterAddedEvent<T1>{
            recording_id : 0x2::object::id<0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::Recording<T0>>(arg0),
            audio_id     : v0,
        };
        0x2::event::emit<RecordingMasterAddedEvent<T1>>(v3);
    }

    public fun has_master<T0>(arg0: &0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::Recording<T0>, arg1: 0x2::object::ID) : bool {
        let v0 = RecordingMasterKey{pos0: arg1};
        0x2::dynamic_field::exists<RecordingMasterKey>(0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::uid<T0>(arg0), v0)
    }

    public fun remove_master<T0, T1>(arg0: &mut 0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::Recording<T0>, arg1: &0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::RecordingAdminCap<T0>, arg2: 0x2::object::ID) {
        let v0 = RecordingMasterKey{pos0: arg2};
        let v1 = 0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::uid_mut<T0>(arg0, arg1);
        assert!(0x2::dynamic_field::exists<RecordingMasterKey>(v1, v0), 0);
        0x2::dynamic_field::remove<RecordingMasterKey, bool>(v1, v0);
        let v2 = RecordingMasterRemovedEvent<T1>{
            recording_id : 0x2::object::id<0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::Recording<T0>>(arg0),
            audio_id     : arg2,
        };
        0x2::event::emit<RecordingMasterRemovedEvent<T1>>(v2);
    }

    // decompiled from Move bytecode v7
}

