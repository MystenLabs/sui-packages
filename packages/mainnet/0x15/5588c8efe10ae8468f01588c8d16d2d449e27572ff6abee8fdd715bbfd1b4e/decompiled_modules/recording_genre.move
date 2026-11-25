module 0x155588c8efe10ae8468f01588c8d16d2d449e27572ff6abee8fdd715bbfd1b4e::recording_genre {
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

    public fun add_genre<T0>(arg0: &mut 0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::Recording<T0>, arg1: &0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::RecordingAdminCap<T0>, arg2: &0xb68cda8807728abf98cfde2bbf2531e910a81ff3338692b6eab4953cb88ea2e::genre::Genre) {
        let v0 = 0x2::object::id<0xb68cda8807728abf98cfde2bbf2531e910a81ff3338692b6eab4953cb88ea2e::genre::Genre>(arg2);
        let v1 = 0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::uid_mut<T0>(arg0, arg1);
        let v2 = RecordingGenreKey{pos0: v0};
        assert!(!0x2::dynamic_field::exists<RecordingGenreKey>(v1, v2), 0);
        let v3 = RecordingGenreKey{pos0: v0};
        0x2::dynamic_field::add<RecordingGenreKey, bool>(v1, v3, true);
        let v4 = RecordingGenreAddedEvent{
            recording_id : 0x2::object::id<0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::Recording<T0>>(arg0),
            genre_id     : v0,
            genre_name   : *0xb68cda8807728abf98cfde2bbf2531e910a81ff3338692b6eab4953cb88ea2e::genre::name(arg2),
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

