module 0x82a3cd0331a08d7946ef7fa4759732df6d60558696e93f78c005c916032c2508::migrate {
    struct MigrateComplete has copy, drop {
        version: u64,
    }

    public fun migrate(arg0: &mut 0x82a3cd0331a08d7946ef7fa4759732df6d60558696e93f78c005c916032c2508::state::State) {
        0x82a3cd0331a08d7946ef7fa4759732df6d60558696e93f78c005c916032c2508::state::migrate_version(arg0);
        0x82a3cd0331a08d7946ef7fa4759732df6d60558696e93f78c005c916032c2508::state::migrate__v__1_0_0(arg0);
        let v0 = MigrateComplete{version: 1};
        0x2::event::emit<MigrateComplete>(v0);
    }

    // decompiled from Move bytecode v6
}

