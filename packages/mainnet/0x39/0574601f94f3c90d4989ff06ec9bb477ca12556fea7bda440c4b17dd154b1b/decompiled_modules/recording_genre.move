module 0x390574601f94f3c90d4989ff06ec9bb477ca12556fea7bda440c4b17dd154b1b::recording_genre {
    struct RecordingGenreKey has copy, drop, store {
        pos0: 0x2::object::ID,
    }

    struct RecordingGenreAddedEvent has copy, drop {
        recording_id: 0x2::object::ID,
        genre_id: 0x2::object::ID,
        genre_name: 0x1::string::String,
    }

    struct RecordingGenreRemovedEvent has copy, drop {
        recording_id: 0x2::object::ID,
        genre_id: 0x2::object::ID,
    }

    public fun add_genre<T0>(arg0: &mut 0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::Recording<T0>, arg1: &0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::RecordingAdminCap<T0>, arg2: &0xfa21fae0a05165943e5a4b466e84b34d7a8ea6d1b29c86d1185675e793a34363::genre::Genre) {
        let v0 = 0x2::object::id<0xfa21fae0a05165943e5a4b466e84b34d7a8ea6d1b29c86d1185675e793a34363::genre::Genre>(arg2);
        let v1 = 0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::uid_mut<T0>(arg0, arg1);
        let v2 = RecordingGenreKey{pos0: v0};
        assert!(!0x2::dynamic_field::exists<RecordingGenreKey>(v1, v2), 0);
        let v3 = RecordingGenreKey{pos0: v0};
        0x2::dynamic_field::add<RecordingGenreKey, bool>(v1, v3, true);
        let v4 = RecordingGenreAddedEvent{
            recording_id : 0x2::object::id<0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::Recording<T0>>(arg0),
            genre_id     : v0,
            genre_name   : *0xfa21fae0a05165943e5a4b466e84b34d7a8ea6d1b29c86d1185675e793a34363::genre::name(arg2),
        };
        0x2::event::emit<RecordingGenreAddedEvent>(v4);
    }

    public fun has_genre<T0>(arg0: &0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::Recording<T0>, arg1: 0x2::object::ID) : bool {
        let v0 = RecordingGenreKey{pos0: arg1};
        0x2::dynamic_field::exists<RecordingGenreKey>(0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::uid<T0>(arg0), v0)
    }

    public fun remove_genre<T0>(arg0: &mut 0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::Recording<T0>, arg1: &0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::RecordingAdminCap<T0>, arg2: 0x2::object::ID) {
        let v0 = 0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::uid_mut<T0>(arg0, arg1);
        let v1 = RecordingGenreKey{pos0: arg2};
        assert!(0x2::dynamic_field::exists<RecordingGenreKey>(v0, v1), 1);
        let v2 = RecordingGenreKey{pos0: arg2};
        0x2::dynamic_field::remove<RecordingGenreKey, bool>(v0, v2);
        let v3 = RecordingGenreRemovedEvent{
            recording_id : 0x2::object::id<0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::Recording<T0>>(arg0),
            genre_id     : arg2,
        };
        0x2::event::emit<RecordingGenreRemovedEvent>(v3);
    }

    // decompiled from Move bytecode v7
}

