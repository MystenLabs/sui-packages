module 0xb25b3ba98b1b4a58a5e9580ef2e23c723ce40c5693357c0ad6dcf1a664d451ed::release_dsp_link {
    struct ExtensionKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct ReleaseLinkSetEvent<phantom T0> has copy, drop {
        release_id: 0x2::object::ID,
    }

    struct ReleaseLinkClearedEvent<phantom T0> has copy, drop {
        release_id: 0x2::object::ID,
    }

    struct TrackLinkSetEvent<phantom T0> has copy, drop {
        release_id: 0x2::object::ID,
        track_index: u64,
    }

    fun borrow_track_links<T0: copy + drop + store>(arg0: &0x2::object::UID) : &0x6957682a420482177bf4b5b539e9604a32673ff19ce384c4d98195f29dff4272::per_track::PerTrack<0x1::option::Option<0x6bab6da95a2188dc789858176093ecf8ff82db87c504963594409406ab090586::dsp_link::DspLink<T0>>> {
        let v0 = ExtensionKey<T0>{dummy_field: false};
        0x2::dynamic_field::borrow<ExtensionKey<T0>, 0x6957682a420482177bf4b5b539e9604a32673ff19ce384c4d98195f29dff4272::per_track::PerTrack<0x1::option::Option<0x6bab6da95a2188dc789858176093ecf8ff82db87c504963594409406ab090586::dsp_link::DspLink<T0>>>>(arg0, v0)
    }

    fun borrow_track_links_mut<T0: copy + drop + store>(arg0: &mut 0x2::object::UID) : &mut 0x6957682a420482177bf4b5b539e9604a32673ff19ce384c4d98195f29dff4272::per_track::PerTrack<0x1::option::Option<0x6bab6da95a2188dc789858176093ecf8ff82db87c504963594409406ab090586::dsp_link::DspLink<T0>>> {
        let v0 = ExtensionKey<T0>{dummy_field: false};
        0x2::dynamic_field::borrow_mut<ExtensionKey<T0>, 0x6957682a420482177bf4b5b539e9604a32673ff19ce384c4d98195f29dff4272::per_track::PerTrack<0x1::option::Option<0x6bab6da95a2188dc789858176093ecf8ff82db87c504963594409406ab090586::dsp_link::DspLink<T0>>>>(arg0, v0)
    }

    public fun clear_release_link<T0: copy + drop + store>(arg0: &mut 0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::release::Release, arg1: &0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::release::ReleaseAdminCap) {
        if (0x6bab6da95a2188dc789858176093ecf8ff82db87c504963594409406ab090586::dsp_link::exists_<T0>(0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::release::uid(arg0))) {
            0x6bab6da95a2188dc789858176093ecf8ff82db87c504963594409406ab090586::dsp_link::clear<T0>(0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::release::uid_mut(arg0, arg1));
            let v0 = ReleaseLinkClearedEvent<T0>{release_id: 0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::release::id(arg0)};
            0x2::event::emit<ReleaseLinkClearedEvent<T0>>(v0);
        };
    }

    public fun clear_track_link<T0: copy + drop + store>(arg0: &mut 0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::release::Release, arg1: &0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::release::ReleaseAdminCap, arg2: u64) {
        let v0 = ExtensionKey<T0>{dummy_field: false};
        if (0x2::dynamic_field::exists<ExtensionKey<T0>>(0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::release::uid(arg0), v0)) {
            assert!(arg2 < 0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::release::total_tracks(arg0), 0);
            let v1 = 0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::release::uid_mut(arg0, arg1);
            *0x6957682a420482177bf4b5b539e9604a32673ff19ce384c4d98195f29dff4272::per_track::borrow_mut<0x1::option::Option<0x6bab6da95a2188dc789858176093ecf8ff82db87c504963594409406ab090586::dsp_link::DspLink<T0>>>(borrow_track_links_mut<T0>(v1), arg2) = 0x1::option::none<0x6bab6da95a2188dc789858176093ecf8ff82db87c504963594409406ab090586::dsp_link::DspLink<T0>>();
            let v2 = TrackLinkSetEvent<T0>{
                release_id  : 0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::release::id(arg0),
                track_index : arg2,
            };
            0x2::event::emit<TrackLinkSetEvent<T0>>(v2);
        };
    }

    public fun clear_track_links<T0: copy + drop + store>(arg0: &mut 0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::release::Release, arg1: &0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::release::ReleaseAdminCap) {
        let v0 = ExtensionKey<T0>{dummy_field: false};
        if (0x2::dynamic_field::exists<ExtensionKey<T0>>(0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::release::uid(arg0), v0)) {
            let v1 = ExtensionKey<T0>{dummy_field: false};
            0x2::dynamic_field::remove<ExtensionKey<T0>, 0x6957682a420482177bf4b5b539e9604a32673ff19ce384c4d98195f29dff4272::per_track::PerTrack<0x1::option::Option<0x6bab6da95a2188dc789858176093ecf8ff82db87c504963594409406ab090586::dsp_link::DspLink<T0>>>>(0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::release::uid_mut(arg0, arg1), v1);
        };
    }

    public fun has_release_link<T0: copy + drop + store>(arg0: &0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::release::Release) : bool {
        0x6bab6da95a2188dc789858176093ecf8ff82db87c504963594409406ab090586::dsp_link::exists_<T0>(0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::release::uid(arg0))
    }

    public fun release_link<T0: copy + drop + store>(arg0: &0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::release::Release) : 0x1::option::Option<0x6bab6da95a2188dc789858176093ecf8ff82db87c504963594409406ab090586::dsp_link::DspLink<T0>> {
        0x6bab6da95a2188dc789858176093ecf8ff82db87c504963594409406ab090586::dsp_link::get<T0>(0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::release::uid(arg0))
    }

    public fun set_release_link<T0: copy + drop + store>(arg0: &mut 0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::release::Release, arg1: &0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::release::ReleaseAdminCap, arg2: 0x6bab6da95a2188dc789858176093ecf8ff82db87c504963594409406ab090586::dsp_link::DspLink<T0>) {
        0x6bab6da95a2188dc789858176093ecf8ff82db87c504963594409406ab090586::dsp_link::set<T0>(0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::release::uid_mut(arg0, arg1), arg2);
        let v0 = ReleaseLinkSetEvent<T0>{release_id: 0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::release::id(arg0)};
        0x2::event::emit<ReleaseLinkSetEvent<T0>>(v0);
    }

    public fun set_track_link<T0: copy + drop + store>(arg0: &mut 0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::release::Release, arg1: &0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::release::ReleaseAdminCap, arg2: u64, arg3: 0x6bab6da95a2188dc789858176093ecf8ff82db87c504963594409406ab090586::dsp_link::DspLink<T0>) {
        assert!(arg2 < 0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::release::total_tracks(arg0), 0);
        let v0 = 0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::release::id(arg0);
        *0x6957682a420482177bf4b5b539e9604a32673ff19ce384c4d98195f29dff4272::per_track::borrow_mut<0x1::option::Option<0x6bab6da95a2188dc789858176093ecf8ff82db87c504963594409406ab090586::dsp_link::DspLink<T0>>>(track_links_mut_or_init<T0>(arg0, arg1), arg2) = 0x1::option::some<0x6bab6da95a2188dc789858176093ecf8ff82db87c504963594409406ab090586::dsp_link::DspLink<T0>>(arg3);
        let v1 = TrackLinkSetEvent<T0>{
            release_id  : v0,
            track_index : arg2,
        };
        0x2::event::emit<TrackLinkSetEvent<T0>>(v1);
    }

    public fun track_link<T0: copy + drop + store>(arg0: &0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::release::Release, arg1: u64) : 0x1::option::Option<0x6bab6da95a2188dc789858176093ecf8ff82db87c504963594409406ab090586::dsp_link::DspLink<T0>> {
        let v0 = 0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::release::uid(arg0);
        let v1 = ExtensionKey<T0>{dummy_field: false};
        if (!0x2::dynamic_field::exists<ExtensionKey<T0>>(v0, v1)) {
            return 0x1::option::none<0x6bab6da95a2188dc789858176093ecf8ff82db87c504963594409406ab090586::dsp_link::DspLink<T0>>()
        };
        assert!(arg1 < 0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::release::total_tracks(arg0), 0);
        *0x6957682a420482177bf4b5b539e9604a32673ff19ce384c4d98195f29dff4272::per_track::borrow<0x1::option::Option<0x6bab6da95a2188dc789858176093ecf8ff82db87c504963594409406ab090586::dsp_link::DspLink<T0>>>(borrow_track_links<T0>(v0), arg1)
    }

    fun track_links_mut_or_init<T0: copy + drop + store>(arg0: &mut 0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::release::Release, arg1: &0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::release::ReleaseAdminCap) : &mut 0x6957682a420482177bf4b5b539e9604a32673ff19ce384c4d98195f29dff4272::per_track::PerTrack<0x1::option::Option<0x6bab6da95a2188dc789858176093ecf8ff82db87c504963594409406ab090586::dsp_link::DspLink<T0>>> {
        let v0 = ExtensionKey<T0>{dummy_field: false};
        if (!0x2::dynamic_field::exists<ExtensionKey<T0>>(0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::release::uid(arg0), v0)) {
            let v1 = ExtensionKey<T0>{dummy_field: false};
            0x2::dynamic_field::add<ExtensionKey<T0>, 0x6957682a420482177bf4b5b539e9604a32673ff19ce384c4d98195f29dff4272::per_track::PerTrack<0x1::option::Option<0x6bab6da95a2188dc789858176093ecf8ff82db87c504963594409406ab090586::dsp_link::DspLink<T0>>>>(0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::release::uid_mut(arg0, arg1), v1, 0x6957682a420482177bf4b5b539e9604a32673ff19ce384c4d98195f29dff4272::per_track::filled<0x1::option::Option<0x6bab6da95a2188dc789858176093ecf8ff82db87c504963594409406ab090586::dsp_link::DspLink<T0>>>(arg0, 0x1::option::none<0x6bab6da95a2188dc789858176093ecf8ff82db87c504963594409406ab090586::dsp_link::DspLink<T0>>()));
        };
        let v2 = 0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::release::uid_mut(arg0, arg1);
        borrow_track_links_mut<T0>(v2)
    }

    // decompiled from Move bytecode v7
}

