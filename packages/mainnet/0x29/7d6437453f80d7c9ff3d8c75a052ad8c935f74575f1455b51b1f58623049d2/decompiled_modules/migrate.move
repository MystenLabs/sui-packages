module 0x297d6437453f80d7c9ff3d8c75a052ad8c935f74575f1455b51b1f58623049d2::migrate {
    struct MigrateComplete has copy, drop {
        version: u64,
    }

    public fun migrate(arg0: &mut 0x297d6437453f80d7c9ff3d8c75a052ad8c935f74575f1455b51b1f58623049d2::state::State) {
        0x297d6437453f80d7c9ff3d8c75a052ad8c935f74575f1455b51b1f58623049d2::state::migrate_version(arg0);
        0x297d6437453f80d7c9ff3d8c75a052ad8c935f74575f1455b51b1f58623049d2::state::migrate__v__1_0_0(arg0);
        let v0 = MigrateComplete{version: 1};
        0x2::event::emit<MigrateComplete>(v0);
    }

    // decompiled from Move bytecode v6
}

