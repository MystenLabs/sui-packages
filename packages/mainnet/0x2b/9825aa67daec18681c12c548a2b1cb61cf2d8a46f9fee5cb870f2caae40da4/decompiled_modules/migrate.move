module 0x2b9825aa67daec18681c12c548a2b1cb61cf2d8a46f9fee5cb870f2caae40da4::migrate {
    struct MigrateComplete has copy, drop {
        version: u64,
    }

    public fun migrate(arg0: &mut 0x2b9825aa67daec18681c12c548a2b1cb61cf2d8a46f9fee5cb870f2caae40da4::state::State) {
        0x2b9825aa67daec18681c12c548a2b1cb61cf2d8a46f9fee5cb870f2caae40da4::state::migrate_version(arg0);
        0x2b9825aa67daec18681c12c548a2b1cb61cf2d8a46f9fee5cb870f2caae40da4::state::migrate__v__1_0_0(arg0);
        let v0 = MigrateComplete{version: 1};
        0x2::event::emit<MigrateComplete>(v0);
    }

    // decompiled from Move bytecode v6
}

