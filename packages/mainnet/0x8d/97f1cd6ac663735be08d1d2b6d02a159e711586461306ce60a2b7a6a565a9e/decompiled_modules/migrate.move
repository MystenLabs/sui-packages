module 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::migrate {
    struct MigrateComplete has copy, drop {
        package: 0x2::object::ID,
    }

    public fun migrate(arg0: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg1: 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::governance::WormholeVAAVerificationReceipt) {
        handle_migrate(arg0, arg1);
    }

    fun handle_migrate(arg0: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg1: 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::governance::WormholeVAAVerificationReceipt) {
        0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::migrate_version(arg0);
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::assert_latest_only(arg0);
        0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::assert_authorized_digest(&v0, arg0, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::contract_upgrade::take_upgrade_digest(arg1));
        let v1 = MigrateComplete{package: 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::current_package(&v0, arg0)};
        0x2::event::emit<MigrateComplete>(v1);
    }

    // decompiled from Move bytecode v6
}

