module 0x45946b403701a0220aeeba744dd14a215699bea5af2dc5c3bb0958799b03f1ca::migrate {
    struct MigrateComplete has copy, drop {
        version: u64,
    }

    public fun migrate(arg0: &mut 0x45946b403701a0220aeeba744dd14a215699bea5af2dc5c3bb0958799b03f1ca::state::State) {
        0x45946b403701a0220aeeba744dd14a215699bea5af2dc5c3bb0958799b03f1ca::state::migrate_version(arg0);
        0x45946b403701a0220aeeba744dd14a215699bea5af2dc5c3bb0958799b03f1ca::state::migrate__v__1_0_0(arg0);
        let v0 = MigrateComplete{version: 1};
        0x2::event::emit<MigrateComplete>(v0);
    }

    // decompiled from Move bytecode v6
}

