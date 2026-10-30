module 0xdd4840c2b5360e50a43d51d0ee60885c309805666078f9ab2b3c781e7e49b5c1::release_cover_art {
    struct ReleaseCoverArt has store {
        cover: 0x1::option::Option<0xd2a68cbe10a1724af7bf5036a78dcb4d39a9c1fa853076a629c2dff0740a101::cover_art::CoverArt>,
        track_covers: 0x651df92c6817dc9669fb96225937469406bfcd2ea60d8995b5ea331a6a385830::release_track_data::ReleaseTrackData<0x1::option::Option<0xd2a68cbe10a1724af7bf5036a78dcb4d39a9c1fa853076a629c2dff0740a101::cover_art::CoverArt>>,
    }

    struct ReleaseCoverArtKey has copy, drop, store {
        dummy_field: bool,
    }

    struct ReleaseCoverArtSetEvent has copy, drop {
        release_id: 0x2::object::ID,
        still_blob_id: u256,
        animated_blob_id: 0x1::option::Option<u256>,
    }

    struct ReleaseCoverArtClearedEvent has copy, drop {
        release_id: 0x2::object::ID,
    }

    struct ReleaseTrackCoverArtSetEvent has copy, drop {
        release_id: 0x2::object::ID,
        track_index: u8,
        still_blob_id: u256,
        animated_blob_id: 0x1::option::Option<u256>,
    }

    struct ReleaseTrackCoverArtClearedEvent has copy, drop {
        release_id: 0x2::object::ID,
        track_index: u8,
    }

    fun borrow(arg0: &0x2::object::UID) : &ReleaseCoverArt {
        let v0 = ReleaseCoverArtKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists<ReleaseCoverArtKey>(arg0, v0), 0);
        let v1 = ReleaseCoverArtKey{dummy_field: false};
        0x2::dynamic_field::borrow<ReleaseCoverArtKey, ReleaseCoverArt>(arg0, v1)
    }

    fun borrow_mut_or_init(arg0: &mut 0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::release::Release, arg1: &0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::release::ReleaseAdminCap) : &mut ReleaseCoverArt {
        let v0 = 0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::release::uid_mut(arg0, arg1);
        let v1 = ReleaseCoverArtKey{dummy_field: false};
        if (0x2::dynamic_field::exists<ReleaseCoverArtKey>(v0, v1)) {
            let v2 = ReleaseCoverArtKey{dummy_field: false};
            return 0x2::dynamic_field::borrow_mut<ReleaseCoverArtKey, ReleaseCoverArt>(v0, v2)
        };
        let v3 = 0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::release::uid_mut(arg0, arg1);
        let v4 = ReleaseCoverArtKey{dummy_field: false};
        let v5 = ReleaseCoverArt{
            cover        : 0x1::option::none<0xd2a68cbe10a1724af7bf5036a78dcb4d39a9c1fa853076a629c2dff0740a101::cover_art::CoverArt>(),
            track_covers : 0x651df92c6817dc9669fb96225937469406bfcd2ea60d8995b5ea331a6a385830::release_track_data::filled<0x1::option::Option<0xd2a68cbe10a1724af7bf5036a78dcb4d39a9c1fa853076a629c2dff0740a101::cover_art::CoverArt>>(arg0, 0x1::option::none<0xd2a68cbe10a1724af7bf5036a78dcb4d39a9c1fa853076a629c2dff0740a101::cover_art::CoverArt>()),
        };
        0x2::dynamic_field::add<ReleaseCoverArtKey, ReleaseCoverArt>(v3, v4, v5);
        let v6 = ReleaseCoverArtKey{dummy_field: false};
        0x2::dynamic_field::borrow_mut<ReleaseCoverArtKey, ReleaseCoverArt>(v3, v6)
    }

    public fun clear_cover(arg0: &mut 0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::release::Release, arg1: &0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::release::ReleaseAdminCap) {
        let v0 = 0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::release::uid_mut(arg0, arg1);
        let v1 = ReleaseCoverArtKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<ReleaseCoverArtKey>(v0, v1)) {
            return
        };
        let v2 = ReleaseCoverArtKey{dummy_field: false};
        let v3 = 0x2::dynamic_field::borrow_mut<ReleaseCoverArtKey, ReleaseCoverArt>(v0, v2);
        if (0x1::option::is_none<0xd2a68cbe10a1724af7bf5036a78dcb4d39a9c1fa853076a629c2dff0740a101::cover_art::CoverArt>(&v3.cover)) {
            return
        };
        v3.cover = 0x1::option::none<0xd2a68cbe10a1724af7bf5036a78dcb4d39a9c1fa853076a629c2dff0740a101::cover_art::CoverArt>();
        if (is_empty(v3)) {
            let v4 = ReleaseCoverArtKey{dummy_field: false};
            let ReleaseCoverArt {
                cover        : _,
                track_covers : _,
            } = 0x2::dynamic_field::remove<ReleaseCoverArtKey, ReleaseCoverArt>(v0, v4);
        };
        let v7 = ReleaseCoverArtClearedEvent{release_id: 0x2::object::id<0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::release::Release>(arg0)};
        0x2::event::emit<ReleaseCoverArtClearedEvent>(v7);
    }

    public fun clear_track_cover(arg0: &mut 0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::release::Release, arg1: &0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::release::ReleaseAdminCap, arg2: u8) {
        let v0 = 0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::release::uid_mut(arg0, arg1);
        assert!((arg2 as u64) < 0x1::vector::length<0x2::object::ID>(0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::release::recording_ids(arg0)), 1);
        let v1 = ReleaseCoverArtKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<ReleaseCoverArtKey>(v0, v1)) {
            return
        };
        let v2 = ReleaseCoverArtKey{dummy_field: false};
        let v3 = 0x2::dynamic_field::borrow_mut<ReleaseCoverArtKey, ReleaseCoverArt>(v0, v2);
        let v4 = 0x651df92c6817dc9669fb96225937469406bfcd2ea60d8995b5ea331a6a385830::release_track_data::borrow_mut<0x1::option::Option<0xd2a68cbe10a1724af7bf5036a78dcb4d39a9c1fa853076a629c2dff0740a101::cover_art::CoverArt>>(&mut v3.track_covers, arg2);
        if (0x1::option::is_none<0xd2a68cbe10a1724af7bf5036a78dcb4d39a9c1fa853076a629c2dff0740a101::cover_art::CoverArt>(v4)) {
            return
        };
        *v4 = 0x1::option::none<0xd2a68cbe10a1724af7bf5036a78dcb4d39a9c1fa853076a629c2dff0740a101::cover_art::CoverArt>();
        if (is_empty(v3)) {
            let v5 = ReleaseCoverArtKey{dummy_field: false};
            let ReleaseCoverArt {
                cover        : _,
                track_covers : _,
            } = 0x2::dynamic_field::remove<ReleaseCoverArtKey, ReleaseCoverArt>(v0, v5);
        };
        let v8 = ReleaseTrackCoverArtClearedEvent{
            release_id  : 0x2::object::id<0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::release::Release>(arg0),
            track_index : arg2,
        };
        0x2::event::emit<ReleaseTrackCoverArtClearedEvent>(v8);
    }

    public fun cover(arg0: &0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::release::Release) : &0x1::option::Option<0xd2a68cbe10a1724af7bf5036a78dcb4d39a9c1fa853076a629c2dff0740a101::cover_art::CoverArt> {
        &borrow(0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::release::uid(arg0)).cover
    }

    public fun has_cover_art(arg0: &0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::release::Release) : bool {
        let v0 = ReleaseCoverArtKey{dummy_field: false};
        0x2::dynamic_field::exists<ReleaseCoverArtKey>(0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::release::uid(arg0), v0)
    }

    fun is_empty(arg0: &ReleaseCoverArt) : bool {
        let v0 = 0x1::option::is_none<0xd2a68cbe10a1724af7bf5036a78dcb4d39a9c1fa853076a629c2dff0740a101::cover_art::CoverArt>(&arg0.cover);
        let v1 = 0;
        while (v1 < 0x651df92c6817dc9669fb96225937469406bfcd2ea60d8995b5ea331a6a385830::release_track_data::length<0x1::option::Option<0xd2a68cbe10a1724af7bf5036a78dcb4d39a9c1fa853076a629c2dff0740a101::cover_art::CoverArt>>(&arg0.track_covers)) {
            let v2 = v0 && 0x1::option::is_none<0xd2a68cbe10a1724af7bf5036a78dcb4d39a9c1fa853076a629c2dff0740a101::cover_art::CoverArt>(0x651df92c6817dc9669fb96225937469406bfcd2ea60d8995b5ea331a6a385830::release_track_data::borrow<0x1::option::Option<0xd2a68cbe10a1724af7bf5036a78dcb4d39a9c1fa853076a629c2dff0740a101::cover_art::CoverArt>>(&arg0.track_covers, v1));
            v0 = v2;
            v1 = v1 + 1;
        };
        v0
    }

    public fun set_cover(arg0: &mut 0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::release::Release, arg1: &0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::release::ReleaseAdminCap, arg2: 0xd2a68cbe10a1724af7bf5036a78dcb4d39a9c1fa853076a629c2dff0740a101::cover_art::CoverArt) {
        let v0 = 0x2::object::id<0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::release::Release>(arg0);
        let v1 = &mut borrow_mut_or_init(arg0, arg1).cover;
        if (0x1::option::contains<0xd2a68cbe10a1724af7bf5036a78dcb4d39a9c1fa853076a629c2dff0740a101::cover_art::CoverArt>(v1, &arg2)) {
            return
        };
        0x1::option::swap_or_fill<0xd2a68cbe10a1724af7bf5036a78dcb4d39a9c1fa853076a629c2dff0740a101::cover_art::CoverArt>(v1, arg2);
        let v2 = ReleaseCoverArtSetEvent{
            release_id       : v0,
            still_blob_id    : 0xd2a68cbe10a1724af7bf5036a78dcb4d39a9c1fa853076a629c2dff0740a101::cover_art::still_blob_id(&arg2),
            animated_blob_id : 0xd2a68cbe10a1724af7bf5036a78dcb4d39a9c1fa853076a629c2dff0740a101::cover_art::animated_blob_id(&arg2),
        };
        0x2::event::emit<ReleaseCoverArtSetEvent>(v2);
    }

    public fun set_track_cover(arg0: &mut 0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::release::Release, arg1: &0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::release::ReleaseAdminCap, arg2: u8, arg3: 0xd2a68cbe10a1724af7bf5036a78dcb4d39a9c1fa853076a629c2dff0740a101::cover_art::CoverArt) {
        let v0 = 0x2::object::id<0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::release::Release>(arg0);
        let v1 = 0x1::vector::length<0x2::object::ID>(0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::release::recording_ids(arg0));
        let v2 = borrow_mut_or_init(arg0, arg1);
        assert!((arg2 as u64) < v1, 1);
        let v3 = 0x651df92c6817dc9669fb96225937469406bfcd2ea60d8995b5ea331a6a385830::release_track_data::borrow_mut<0x1::option::Option<0xd2a68cbe10a1724af7bf5036a78dcb4d39a9c1fa853076a629c2dff0740a101::cover_art::CoverArt>>(&mut v2.track_covers, arg2);
        if (0x1::option::contains<0xd2a68cbe10a1724af7bf5036a78dcb4d39a9c1fa853076a629c2dff0740a101::cover_art::CoverArt>(v3, &arg3)) {
            return
        };
        0x1::option::swap_or_fill<0xd2a68cbe10a1724af7bf5036a78dcb4d39a9c1fa853076a629c2dff0740a101::cover_art::CoverArt>(v3, arg3);
        let v4 = ReleaseTrackCoverArtSetEvent{
            release_id       : v0,
            track_index      : arg2,
            still_blob_id    : 0xd2a68cbe10a1724af7bf5036a78dcb4d39a9c1fa853076a629c2dff0740a101::cover_art::still_blob_id(&arg3),
            animated_blob_id : 0xd2a68cbe10a1724af7bf5036a78dcb4d39a9c1fa853076a629c2dff0740a101::cover_art::animated_blob_id(&arg3),
        };
        0x2::event::emit<ReleaseTrackCoverArtSetEvent>(v4);
    }

    public fun track_cover(arg0: &0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::release::Release, arg1: u8) : 0x1::option::Option<0xd2a68cbe10a1724af7bf5036a78dcb4d39a9c1fa853076a629c2dff0740a101::cover_art::CoverArt> {
        assert!((arg1 as u64) < 0x1::vector::length<0x2::object::ID>(0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::release::recording_ids(arg0)), 1);
        let v0 = borrow(0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::release::uid(arg0));
        let v1 = 0x651df92c6817dc9669fb96225937469406bfcd2ea60d8995b5ea331a6a385830::release_track_data::borrow<0x1::option::Option<0xd2a68cbe10a1724af7bf5036a78dcb4d39a9c1fa853076a629c2dff0740a101::cover_art::CoverArt>>(&v0.track_covers, arg1);
        if (0x1::option::is_some<0xd2a68cbe10a1724af7bf5036a78dcb4d39a9c1fa853076a629c2dff0740a101::cover_art::CoverArt>(v1)) {
            *v1
        } else {
            v0.cover
        }
    }

    public fun track_cover_override(arg0: &0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::release::Release, arg1: u8) : &0x1::option::Option<0xd2a68cbe10a1724af7bf5036a78dcb4d39a9c1fa853076a629c2dff0740a101::cover_art::CoverArt> {
        assert!((arg1 as u64) < 0x1::vector::length<0x2::object::ID>(0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::release::recording_ids(arg0)), 1);
        0x651df92c6817dc9669fb96225937469406bfcd2ea60d8995b5ea331a6a385830::release_track_data::borrow<0x1::option::Option<0xd2a68cbe10a1724af7bf5036a78dcb4d39a9c1fa853076a629c2dff0740a101::cover_art::CoverArt>>(&borrow(0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::release::uid(arg0)).track_covers, arg1)
    }

    // decompiled from Move bytecode v7
}

