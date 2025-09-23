module 0x66c40befefea61899ffd3b98db0261496f2e191a0fb57e896452b1a6a600955::migrate {
    struct MigrateComplete has copy, drop {
        version: u64,
    }

    public fun migrate(arg0: &mut 0x66c40befefea61899ffd3b98db0261496f2e191a0fb57e896452b1a6a600955::state::State) {
        0x66c40befefea61899ffd3b98db0261496f2e191a0fb57e896452b1a6a600955::state::migrate_version(arg0);
        0x66c40befefea61899ffd3b98db0261496f2e191a0fb57e896452b1a6a600955::state::migrate__v__1_0_0(arg0);
        let v0 = MigrateComplete{version: 1};
        0x2::event::emit<MigrateComplete>(v0);
    }

    // decompiled from Move bytecode v6
}

