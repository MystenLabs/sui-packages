module 0x3fbdad435cdb4210427bc3993b80459b8b0e3c0ec0f9caa9302b4e719391314::migrate {
    struct MigrateComplete has copy, drop {
        package: 0x2::object::ID,
    }

    public fun migrate(arg0: &mut 0x3fbdad435cdb4210427bc3993b80459b8b0e3c0ec0f9caa9302b4e719391314::state::State, arg1: 0x3fbdad435cdb4210427bc3993b80459b8b0e3c0ec0f9caa9302b4e719391314::governance::WormholeVAAVerificationReceipt) {
        handle_migrate(arg0, arg1);
    }

    fun handle_migrate(arg0: &mut 0x3fbdad435cdb4210427bc3993b80459b8b0e3c0ec0f9caa9302b4e719391314::state::State, arg1: 0x3fbdad435cdb4210427bc3993b80459b8b0e3c0ec0f9caa9302b4e719391314::governance::WormholeVAAVerificationReceipt) {
        0x3fbdad435cdb4210427bc3993b80459b8b0e3c0ec0f9caa9302b4e719391314::state::migrate_version(arg0);
        let v0 = 0x3fbdad435cdb4210427bc3993b80459b8b0e3c0ec0f9caa9302b4e719391314::state::assert_latest_only(arg0);
        0x3fbdad435cdb4210427bc3993b80459b8b0e3c0ec0f9caa9302b4e719391314::state::assert_authorized_digest(&v0, arg0, 0x3fbdad435cdb4210427bc3993b80459b8b0e3c0ec0f9caa9302b4e719391314::contract_upgrade::take_upgrade_digest(arg1));
        let v1 = MigrateComplete{package: 0x3fbdad435cdb4210427bc3993b80459b8b0e3c0ec0f9caa9302b4e719391314::state::current_package(&v0, arg0)};
        0x2::event::emit<MigrateComplete>(v1);
    }

    // decompiled from Move bytecode v6
}

