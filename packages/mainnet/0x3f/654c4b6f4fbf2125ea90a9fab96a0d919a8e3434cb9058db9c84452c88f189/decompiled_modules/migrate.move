module 0x3f654c4b6f4fbf2125ea90a9fab96a0d919a8e3434cb9058db9c84452c88f189::migrate {
    struct MigrateComplete has copy, drop {
        version: u64,
    }

    public fun migrate(arg0: &mut 0x3f654c4b6f4fbf2125ea90a9fab96a0d919a8e3434cb9058db9c84452c88f189::state::State) {
        0x3f654c4b6f4fbf2125ea90a9fab96a0d919a8e3434cb9058db9c84452c88f189::state::migrate_version(arg0);
        0x3f654c4b6f4fbf2125ea90a9fab96a0d919a8e3434cb9058db9c84452c88f189::state::migrate__v__1_0_0(arg0);
        let v0 = MigrateComplete{version: 1};
        0x2::event::emit<MigrateComplete>(v0);
    }

    // decompiled from Move bytecode v6
}

