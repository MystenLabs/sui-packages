module 0xbc3af7253881549d952bdc09742897abfcbe1c6c4717a22398a8d3ad4a23d639::release_genre {
    struct ExtensionKey has copy, drop, store {
        dummy_field: bool,
    }

    struct ReleaseGenre has store {
        primary: 0x2::object::ID,
        primary_set_epoch: u64,
        secondary: vector<0x2::object::ID>,
        track_primary: 0x6957682a420482177bf4b5b539e9604a32673ff19ce384c4d98195f29dff4272::per_track::PerTrack<0x1::option::Option<0x2::object::ID>>,
    }

    struct PrimaryGenreSetEvent has copy, drop {
        release_id: 0x2::object::ID,
        genre_id: 0x2::object::ID,
        set_epoch: u64,
    }

    struct SecondaryGenreAddedEvent has copy, drop {
        release_id: 0x2::object::ID,
        genre_id: 0x2::object::ID,
    }

    struct SecondaryGenreRemovedEvent has copy, drop {
        release_id: 0x2::object::ID,
        genre_id: 0x2::object::ID,
    }

    struct TrackPrimaryGenreSetEvent has copy, drop {
        release_id: 0x2::object::ID,
        track_index: u64,
        genre_id: 0x2::object::ID,
    }

    struct TrackPrimaryGenreUnsetEvent has copy, drop {
        release_id: 0x2::object::ID,
        track_index: u64,
    }

    public fun add_secondary_genre(arg0: &mut 0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::release::Release, arg1: &0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::release::ReleaseAdminCap, arg2: &0x9b663c476982aaacaeb641cd67ca661d8b1fc672fed0aa424a0cef3408e876d::genre::Genre) {
        let v0 = 0x9b663c476982aaacaeb641cd67ca661d8b1fc672fed0aa424a0cef3408e876d::genre::id(arg2);
        let v1 = ExtensionKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists<ExtensionKey>(0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::release::uid(arg0), v1), 30);
        let v2 = ExtensionKey{dummy_field: false};
        let v3 = 0x2::dynamic_field::borrow_mut<ExtensionKey, ReleaseGenre>(0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::release::uid_mut(arg0, arg1), v2);
        assert!(v0 != v3.primary, 40);
        assert!(!0x1::vector::contains<0x2::object::ID>(&v3.secondary, &v0), 41);
        assert!(0x1::vector::length<0x2::object::ID>(&v3.secondary) < 5, 42);
        0x1::vector::push_back<0x2::object::ID>(&mut v3.secondary, v0);
        let v4 = SecondaryGenreAddedEvent{
            release_id : 0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::release::id(arg0),
            genre_id   : v0,
        };
        0x2::event::emit<SecondaryGenreAddedEvent>(v4);
    }

    public fun has_genre(arg0: &0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::release::Release) : bool {
        let v0 = ExtensionKey{dummy_field: false};
        0x2::dynamic_field::exists<ExtensionKey>(0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::release::uid(arg0), v0)
    }

    public fun primary_genre(arg0: &0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::release::Release) : 0x1::option::Option<0x2::object::ID> {
        let v0 = 0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::release::uid(arg0);
        let v1 = ExtensionKey{dummy_field: false};
        if (0x2::dynamic_field::exists<ExtensionKey>(v0, v1)) {
            let v3 = ExtensionKey{dummy_field: false};
            0x1::option::some<0x2::object::ID>(0x2::dynamic_field::borrow<ExtensionKey, ReleaseGenre>(v0, v3).primary)
        } else {
            0x1::option::none<0x2::object::ID>()
        }
    }

    public fun remove_secondary_genre(arg0: &mut 0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::release::Release, arg1: &0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::release::ReleaseAdminCap, arg2: &0x9b663c476982aaacaeb641cd67ca661d8b1fc672fed0aa424a0cef3408e876d::genre::Genre) {
        let v0 = 0x9b663c476982aaacaeb641cd67ca661d8b1fc672fed0aa424a0cef3408e876d::genre::id(arg2);
        let v1 = ExtensionKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists<ExtensionKey>(0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::release::uid(arg0), v1), 30);
        let v2 = ExtensionKey{dummy_field: false};
        let v3 = 0x2::dynamic_field::borrow_mut<ExtensionKey, ReleaseGenre>(0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::release::uid_mut(arg0, arg1), v2);
        let (v4, v5) = 0x1::vector::index_of<0x2::object::ID>(&v3.secondary, &v0);
        assert!(v4, 43);
        0x1::vector::remove<0x2::object::ID>(&mut v3.secondary, v5);
        let v6 = SecondaryGenreRemovedEvent{
            release_id : 0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::release::id(arg0),
            genre_id   : v0,
        };
        0x2::event::emit<SecondaryGenreRemovedEvent>(v6);
    }

    public fun secondary_genres(arg0: &0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::release::Release) : vector<0x2::object::ID> {
        let v0 = 0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::release::uid(arg0);
        let v1 = ExtensionKey{dummy_field: false};
        if (0x2::dynamic_field::exists<ExtensionKey>(v0, v1)) {
            let v3 = ExtensionKey{dummy_field: false};
            0x2::dynamic_field::borrow<ExtensionKey, ReleaseGenre>(v0, v3).secondary
        } else {
            0x1::vector::empty<0x2::object::ID>()
        }
    }

    public fun set_primary_genre(arg0: &mut 0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::release::Release, arg1: &0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::release::ReleaseAdminCap, arg2: &0x9b663c476982aaacaeb641cd67ca661d8b1fc672fed0aa424a0cef3408e876d::genre::Genre, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x9b663c476982aaacaeb641cd67ca661d8b1fc672fed0aa424a0cef3408e876d::genre::id(arg2);
        let v1 = 0x2::tx_context::epoch(arg3);
        let v2 = ExtensionKey{dummy_field: false};
        if (0x2::dynamic_field::exists<ExtensionKey>(0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::release::uid(arg0), v2)) {
            let v3 = ExtensionKey{dummy_field: false};
            let v4 = 0x2::dynamic_field::borrow_mut<ExtensionKey, ReleaseGenre>(0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::release::uid_mut(arg0, arg1), v3);
            assert!(v1 >= v4.primary_set_epoch + 30, 31);
            v4.primary = v0;
            v4.primary_set_epoch = v1;
        } else {
            let v5 = ExtensionKey{dummy_field: false};
            let v6 = ReleaseGenre{
                primary           : v0,
                primary_set_epoch : v1,
                secondary         : 0x1::vector::empty<0x2::object::ID>(),
                track_primary     : 0x6957682a420482177bf4b5b539e9604a32673ff19ce384c4d98195f29dff4272::per_track::filled<0x1::option::Option<0x2::object::ID>>(arg0, 0x1::option::none<0x2::object::ID>()),
            };
            0x2::dynamic_field::add<ExtensionKey, ReleaseGenre>(0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::release::uid_mut(arg0, arg1), v5, v6);
        };
        let v7 = PrimaryGenreSetEvent{
            release_id : 0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::release::id(arg0),
            genre_id   : v0,
            set_epoch  : v1,
        };
        0x2::event::emit<PrimaryGenreSetEvent>(v7);
    }

    public fun set_track_primary_genre(arg0: &mut 0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::release::Release, arg1: &0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::release::ReleaseAdminCap, arg2: u64, arg3: &0x9b663c476982aaacaeb641cd67ca661d8b1fc672fed0aa424a0cef3408e876d::genre::Genre) {
        let v0 = 0x9b663c476982aaacaeb641cd67ca661d8b1fc672fed0aa424a0cef3408e876d::genre::id(arg3);
        let v1 = ExtensionKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists<ExtensionKey>(0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::release::uid(arg0), v1), 30);
        assert!(arg2 < 0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::release::total_tracks(arg0), 50);
        let v2 = ExtensionKey{dummy_field: false};
        0x1::option::swap_or_fill<0x2::object::ID>(0x6957682a420482177bf4b5b539e9604a32673ff19ce384c4d98195f29dff4272::per_track::borrow_mut<0x1::option::Option<0x2::object::ID>>(&mut 0x2::dynamic_field::borrow_mut<ExtensionKey, ReleaseGenre>(0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::release::uid_mut(arg0, arg1), v2).track_primary, arg2), v0);
        let v3 = TrackPrimaryGenreSetEvent{
            release_id  : 0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::release::id(arg0),
            track_index : arg2,
            genre_id    : v0,
        };
        0x2::event::emit<TrackPrimaryGenreSetEvent>(v3);
    }

    public fun track_primary_genre(arg0: &0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::release::Release, arg1: u64) : 0x1::option::Option<0x2::object::ID> {
        let v0 = 0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::release::uid(arg0);
        let v1 = ExtensionKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<ExtensionKey>(v0, v1)) {
            return 0x1::option::none<0x2::object::ID>()
        };
        assert!(arg1 < 0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::release::total_tracks(arg0), 50);
        let v2 = ExtensionKey{dummy_field: false};
        let v3 = 0x2::dynamic_field::borrow<ExtensionKey, ReleaseGenre>(v0, v2);
        let v4 = 0x6957682a420482177bf4b5b539e9604a32673ff19ce384c4d98195f29dff4272::per_track::borrow<0x1::option::Option<0x2::object::ID>>(&v3.track_primary, arg1);
        if (0x1::option::is_some<0x2::object::ID>(v4)) {
            *v4
        } else {
            0x1::option::some<0x2::object::ID>(v3.primary)
        }
    }

    public fun unset_track_primary_genre(arg0: &mut 0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::release::Release, arg1: &0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::release::ReleaseAdminCap, arg2: u64) {
        let v0 = ExtensionKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists<ExtensionKey>(0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::release::uid(arg0), v0), 30);
        assert!(arg2 < 0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::release::total_tracks(arg0), 50);
        let v1 = ExtensionKey{dummy_field: false};
        *0x6957682a420482177bf4b5b539e9604a32673ff19ce384c4d98195f29dff4272::per_track::borrow_mut<0x1::option::Option<0x2::object::ID>>(&mut 0x2::dynamic_field::borrow_mut<ExtensionKey, ReleaseGenre>(0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::release::uid_mut(arg0, arg1), v1).track_primary, arg2) = 0x1::option::none<0x2::object::ID>();
        let v2 = TrackPrimaryGenreUnsetEvent{
            release_id  : 0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::release::id(arg0),
            track_index : arg2,
        };
        0x2::event::emit<TrackPrimaryGenreUnsetEvent>(v2);
    }

    // decompiled from Move bytecode v7
}

