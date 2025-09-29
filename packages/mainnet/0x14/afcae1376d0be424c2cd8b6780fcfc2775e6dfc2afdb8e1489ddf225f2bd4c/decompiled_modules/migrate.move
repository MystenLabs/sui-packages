module 0x14afcae1376d0be424c2cd8b6780fcfc2775e6dfc2afdb8e1489ddf225f2bd4c::migrate {
    struct MigrateComplete has copy, drop {
        version: u64,
    }

    public fun migrate(arg0: &mut 0x14afcae1376d0be424c2cd8b6780fcfc2775e6dfc2afdb8e1489ddf225f2bd4c::state::State) {
        0x14afcae1376d0be424c2cd8b6780fcfc2775e6dfc2afdb8e1489ddf225f2bd4c::state::migrate_version(arg0);
        0x14afcae1376d0be424c2cd8b6780fcfc2775e6dfc2afdb8e1489ddf225f2bd4c::state::migrate__v__1_0_0(arg0);
        let v0 = MigrateComplete{version: 1};
        0x2::event::emit<MigrateComplete>(v0);
    }

    // decompiled from Move bytecode v6
}

