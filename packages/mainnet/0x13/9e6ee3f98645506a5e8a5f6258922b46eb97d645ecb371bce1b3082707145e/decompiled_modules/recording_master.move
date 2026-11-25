module 0x139e6ee3f98645506a5e8a5f6258922b46eb97d645ecb371bce1b3082707145e::recording_master {
    struct RecordingMasterKey has copy, drop, store {
        pos0: u256,
    }

    struct RecordingMasterAddedEvent<phantom T0, phantom T1, phantom T2> has copy, drop {
        recording_id: 0x2::object::ID,
        blob_id: u256,
    }

    struct RecordingMasterRemovedEvent<phantom T0, phantom T1, phantom T2> has copy, drop {
        recording_id: 0x2::object::ID,
        blob_id: u256,
    }

    public fun add_master<T0, T1, T2: drop + store, T3: drop + store>(arg0: &mut 0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::Recording<T0>, arg1: &0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::RecordingAdminCap<T0>, arg2: 0x4eec45b7624d50d65da8d4e68674ea03497e2f22351d1f6075f2844a41078468::audio::Audio<T1, T2, T3>) {
        let v0 = 0xadefbe1aeb900807ed03144bddd80dc6478030c28ede3b2990f8e792606f317a::data::blob_id(0x4eec45b7624d50d65da8d4e68674ea03497e2f22351d1f6075f2844a41078468::audio::data<T1, T2, T3>(&arg2));
        let v1 = RecordingMasterKey{pos0: v0};
        let v2 = 0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::uid_mut<T0>(arg0, arg1);
        assert!(!0x2::dynamic_field::exists<RecordingMasterKey>(v2, v1), 1);
        0x2::dynamic_field::add<RecordingMasterKey, 0x4eec45b7624d50d65da8d4e68674ea03497e2f22351d1f6075f2844a41078468::audio::Audio<T1, T2, T3>>(v2, v1, arg2);
        let v3 = RecordingMasterAddedEvent<T1, T2, T3>{
            recording_id : 0x2::object::id<0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::Recording<T0>>(arg0),
            blob_id      : v0,
        };
        0x2::event::emit<RecordingMasterAddedEvent<T1, T2, T3>>(v3);
    }

    public fun has_master<T0>(arg0: &0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::Recording<T0>, arg1: u256) : bool {
        let v0 = RecordingMasterKey{pos0: arg1};
        0x2::dynamic_field::exists<RecordingMasterKey>(0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::uid<T0>(arg0), v0)
    }

    public fun master<T0, T1, T2: drop + store, T3: drop + store>(arg0: &0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::Recording<T0>, arg1: u256) : &0x4eec45b7624d50d65da8d4e68674ea03497e2f22351d1f6075f2844a41078468::audio::Audio<T1, T2, T3> {
        assert!(has_master<T0>(arg0, arg1), 0);
        let v0 = RecordingMasterKey{pos0: arg1};
        0x2::dynamic_field::borrow<RecordingMasterKey, 0x4eec45b7624d50d65da8d4e68674ea03497e2f22351d1f6075f2844a41078468::audio::Audio<T1, T2, T3>>(0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::uid<T0>(arg0), v0)
    }

    public fun remove_master<T0, T1, T2: drop + store, T3: drop + store>(arg0: &mut 0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::Recording<T0>, arg1: &0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::RecordingAdminCap<T0>, arg2: u256) : 0x4eec45b7624d50d65da8d4e68674ea03497e2f22351d1f6075f2844a41078468::audio::Audio<T1, T2, T3> {
        let v0 = RecordingMasterKey{pos0: arg2};
        let v1 = 0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::uid_mut<T0>(arg0, arg1);
        assert!(0x2::dynamic_field::exists<RecordingMasterKey>(v1, v0), 0);
        let v2 = 0x2::dynamic_field::remove<RecordingMasterKey, 0x4eec45b7624d50d65da8d4e68674ea03497e2f22351d1f6075f2844a41078468::audio::Audio<T1, T2, T3>>(v1, v0);
        let v3 = RecordingMasterRemovedEvent<T1, T2, T3>{
            recording_id : 0x2::object::id<0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::Recording<T0>>(arg0),
            blob_id      : arg2,
        };
        0x2::event::emit<RecordingMasterRemovedEvent<T1, T2, T3>>(v3);
        v2
    }

    // decompiled from Move bytecode v7
}

