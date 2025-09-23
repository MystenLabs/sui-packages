module 0x3c9e4bc67127e98718ba93957a6ce84bf0bdaa82cd9954f58a230f6d5a36341c::migrate {
    struct MigrateComplete has copy, drop {
        version: u64,
    }

    public fun migrate(arg0: &mut 0x3c9e4bc67127e98718ba93957a6ce84bf0bdaa82cd9954f58a230f6d5a36341c::state::State) {
        0x3c9e4bc67127e98718ba93957a6ce84bf0bdaa82cd9954f58a230f6d5a36341c::state::migrate_version(arg0);
        0x3c9e4bc67127e98718ba93957a6ce84bf0bdaa82cd9954f58a230f6d5a36341c::state::migrate__v__1_0_0(arg0);
        let v0 = MigrateComplete{version: 1};
        0x2::event::emit<MigrateComplete>(v0);
    }

    // decompiled from Move bytecode v6
}

