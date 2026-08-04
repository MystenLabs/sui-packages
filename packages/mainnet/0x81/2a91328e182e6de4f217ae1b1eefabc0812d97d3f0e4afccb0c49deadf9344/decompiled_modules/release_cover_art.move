module 0x812a91328e182e6de4f217ae1b1eefabc0812d97d3f0e4afccb0c49deadf9344::release_cover_art {
    struct ExtensionKey has copy, drop, store {
        dummy_field: bool,
    }

    struct ReleaseCoverArt has store {
        cover: 0x1::option::Option<0xb613fc81f1bb8db1685ecbaa2d0b89a03057a4833acebff0aab0f6316dbd5e4e::cover_art::CoverArt>,
        track_covers: 0x6957682a420482177bf4b5b539e9604a32673ff19ce384c4d98195f29dff4272::per_track::PerTrack<0x1::option::Option<0xb613fc81f1bb8db1685ecbaa2d0b89a03057a4833acebff0aab0f6316dbd5e4e::cover_art::CoverArt>>,
    }

    fun borrow(arg0: &0x2::object::UID) : &ReleaseCoverArt {
        let v0 = ExtensionKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists<ExtensionKey>(arg0, v0), 1);
        let v1 = ExtensionKey{dummy_field: false};
        0x2::dynamic_field::borrow<ExtensionKey, ReleaseCoverArt>(arg0, v1)
    }

    fun borrow_mut(arg0: &mut 0x2::object::UID) : &mut ReleaseCoverArt {
        let v0 = ExtensionKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists<ExtensionKey>(arg0, v0), 1);
        let v1 = ExtensionKey{dummy_field: false};
        0x2::dynamic_field::borrow_mut<ExtensionKey, ReleaseCoverArt>(arg0, v1)
    }

    fun borrow_mut_or_init(arg0: &mut 0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::release::Release, arg1: &0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::release::ReleaseAdminCap) : &mut ReleaseCoverArt {
        let v0 = ExtensionKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<ExtensionKey>(0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::release::uid(arg0), v0)) {
            let v1 = ExtensionKey{dummy_field: false};
            let v2 = ReleaseCoverArt{
                cover        : 0x1::option::none<0xb613fc81f1bb8db1685ecbaa2d0b89a03057a4833acebff0aab0f6316dbd5e4e::cover_art::CoverArt>(),
                track_covers : 0x6957682a420482177bf4b5b539e9604a32673ff19ce384c4d98195f29dff4272::per_track::filled<0x1::option::Option<0xb613fc81f1bb8db1685ecbaa2d0b89a03057a4833acebff0aab0f6316dbd5e4e::cover_art::CoverArt>>(arg0, 0x1::option::none<0xb613fc81f1bb8db1685ecbaa2d0b89a03057a4833acebff0aab0f6316dbd5e4e::cover_art::CoverArt>()),
            };
            0x2::dynamic_field::add<ExtensionKey, ReleaseCoverArt>(0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::release::uid_mut(arg0, arg1), v1, v2);
        };
        let v3 = 0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::release::uid_mut(arg0, arg1);
        borrow_mut(v3)
    }

    public fun cover(arg0: &0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::release::Release) : &0x1::option::Option<0xb613fc81f1bb8db1685ecbaa2d0b89a03057a4833acebff0aab0f6316dbd5e4e::cover_art::CoverArt> {
        &borrow(0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::release::uid(arg0)).cover
    }

    public fun has_cover_art(arg0: &0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::release::Release) : bool {
        let v0 = ExtensionKey{dummy_field: false};
        0x2::dynamic_field::exists<ExtensionKey>(0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::release::uid(arg0), v0)
    }

    public fun set_cover(arg0: &mut 0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::release::Release, arg1: &0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::release::ReleaseAdminCap, arg2: 0xb613fc81f1bb8db1685ecbaa2d0b89a03057a4833acebff0aab0f6316dbd5e4e::cover_art::CoverArt) {
        0x1::option::swap_or_fill<0xb613fc81f1bb8db1685ecbaa2d0b89a03057a4833acebff0aab0f6316dbd5e4e::cover_art::CoverArt>(&mut borrow_mut_or_init(arg0, arg1).cover, arg2);
    }

    public fun set_track_cover(arg0: &mut 0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::release::Release, arg1: &0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::release::ReleaseAdminCap, arg2: u64, arg3: 0xb613fc81f1bb8db1685ecbaa2d0b89a03057a4833acebff0aab0f6316dbd5e4e::cover_art::CoverArt) {
        assert!(arg2 < 0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::release::total_tracks(arg0), 2);
        0x1::option::swap_or_fill<0xb613fc81f1bb8db1685ecbaa2d0b89a03057a4833acebff0aab0f6316dbd5e4e::cover_art::CoverArt>(0x6957682a420482177bf4b5b539e9604a32673ff19ce384c4d98195f29dff4272::per_track::borrow_mut<0x1::option::Option<0xb613fc81f1bb8db1685ecbaa2d0b89a03057a4833acebff0aab0f6316dbd5e4e::cover_art::CoverArt>>(&mut borrow_mut_or_init(arg0, arg1).track_covers, arg2), arg3);
    }

    public fun track_cover(arg0: &0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::release::Release, arg1: u64) : 0x1::option::Option<0xb613fc81f1bb8db1685ecbaa2d0b89a03057a4833acebff0aab0f6316dbd5e4e::cover_art::CoverArt> {
        assert!(arg1 < 0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::release::total_tracks(arg0), 2);
        let v0 = borrow(0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::release::uid(arg0));
        let v1 = 0x6957682a420482177bf4b5b539e9604a32673ff19ce384c4d98195f29dff4272::per_track::borrow<0x1::option::Option<0xb613fc81f1bb8db1685ecbaa2d0b89a03057a4833acebff0aab0f6316dbd5e4e::cover_art::CoverArt>>(&v0.track_covers, arg1);
        if (0x1::option::is_some<0xb613fc81f1bb8db1685ecbaa2d0b89a03057a4833acebff0aab0f6316dbd5e4e::cover_art::CoverArt>(v1)) {
            *v1
        } else {
            v0.cover
        }
    }

    public fun unset_cover(arg0: &mut 0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::release::Release, arg1: &0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::release::ReleaseAdminCap) {
        if (has_cover_art(arg0)) {
            let v0 = 0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::release::uid_mut(arg0, arg1);
            borrow_mut(v0).cover = 0x1::option::none<0xb613fc81f1bb8db1685ecbaa2d0b89a03057a4833acebff0aab0f6316dbd5e4e::cover_art::CoverArt>();
        };
    }

    public fun unset_track_cover(arg0: &mut 0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::release::Release, arg1: &0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::release::ReleaseAdminCap, arg2: u64) {
        if (has_cover_art(arg0)) {
            assert!(arg2 < 0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::release::total_tracks(arg0), 2);
            let v0 = 0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::release::uid_mut(arg0, arg1);
            *0x6957682a420482177bf4b5b539e9604a32673ff19ce384c4d98195f29dff4272::per_track::borrow_mut<0x1::option::Option<0xb613fc81f1bb8db1685ecbaa2d0b89a03057a4833acebff0aab0f6316dbd5e4e::cover_art::CoverArt>>(&mut borrow_mut(v0).track_covers, arg2) = 0x1::option::none<0xb613fc81f1bb8db1685ecbaa2d0b89a03057a4833acebff0aab0f6316dbd5e4e::cover_art::CoverArt>();
        };
    }

    // decompiled from Move bytecode v7
}

