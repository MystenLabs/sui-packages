module 0x18c7df810308b167ddafc25a1e9b63c7fabfb354c4799a15dee402b4eaf2f648::release_genre {
    struct ReleaseGenreKey has copy, drop, store {
        pos0: 0x2::object::ID,
    }

    struct ReleaseGenreAddedEvent has copy, drop {
        release_id: 0x2::object::ID,
        genre_id: 0x2::object::ID,
        genre_name: 0x1::string::String,
    }

    struct ReleaseGenreRemovedEvent has copy, drop {
        release_id: 0x2::object::ID,
        genre_id: 0x2::object::ID,
    }

    public fun add_genre(arg0: &mut 0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::release::Release, arg1: &0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::release::ReleaseAdminCap, arg2: &0xfa21fae0a05165943e5a4b466e84b34d7a8ea6d1b29c86d1185675e793a34363::genre::Genre) {
        let v0 = 0x2::object::id<0xfa21fae0a05165943e5a4b466e84b34d7a8ea6d1b29c86d1185675e793a34363::genre::Genre>(arg2);
        let v1 = 0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::release::uid_mut(arg0, arg1);
        let v2 = ReleaseGenreKey{pos0: v0};
        assert!(!0x2::dynamic_field::exists<ReleaseGenreKey>(v1, v2), 0);
        let v3 = ReleaseGenreKey{pos0: v0};
        0x2::dynamic_field::add<ReleaseGenreKey, bool>(v1, v3, true);
        let v4 = ReleaseGenreAddedEvent{
            release_id : 0x2::object::id<0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::release::Release>(arg0),
            genre_id   : v0,
            genre_name : *0xfa21fae0a05165943e5a4b466e84b34d7a8ea6d1b29c86d1185675e793a34363::genre::name(arg2),
        };
        0x2::event::emit<ReleaseGenreAddedEvent>(v4);
    }

    public fun has_genre(arg0: &0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::release::Release, arg1: 0x2::object::ID) : bool {
        let v0 = ReleaseGenreKey{pos0: arg1};
        0x2::dynamic_field::exists<ReleaseGenreKey>(0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::release::uid(arg0), v0)
    }

    public fun remove_genre(arg0: &mut 0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::release::Release, arg1: &0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::release::ReleaseAdminCap, arg2: 0x2::object::ID) {
        let v0 = 0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::release::uid_mut(arg0, arg1);
        let v1 = ReleaseGenreKey{pos0: arg2};
        assert!(0x2::dynamic_field::exists<ReleaseGenreKey>(v0, v1), 1);
        let v2 = ReleaseGenreKey{pos0: arg2};
        0x2::dynamic_field::remove<ReleaseGenreKey, bool>(v0, v2);
        let v3 = ReleaseGenreRemovedEvent{
            release_id : 0x2::object::id<0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::release::Release>(arg0),
            genre_id   : arg2,
        };
        0x2::event::emit<ReleaseGenreRemovedEvent>(v3);
    }

    // decompiled from Move bytecode v7
}

