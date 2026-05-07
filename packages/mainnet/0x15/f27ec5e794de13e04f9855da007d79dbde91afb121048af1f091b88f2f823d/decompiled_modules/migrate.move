module 0x15f27ec5e794de13e04f9855da007d79dbde91afb121048af1f091b88f2f823d::migrate {
    struct MigrateComplete has copy, drop {
        package: 0x2::object::ID,
    }

    public fun migrate(arg0: &mut 0x15f27ec5e794de13e04f9855da007d79dbde91afb121048af1f091b88f2f823d::state::State, arg1: 0x15f27ec5e794de13e04f9855da007d79dbde91afb121048af1f091b88f2f823d::governance::WormholeVAAVerificationReceipt) {
        handle_migrate(arg0, arg1);
    }

    fun handle_migrate(arg0: &mut 0x15f27ec5e794de13e04f9855da007d79dbde91afb121048af1f091b88f2f823d::state::State, arg1: 0x15f27ec5e794de13e04f9855da007d79dbde91afb121048af1f091b88f2f823d::governance::WormholeVAAVerificationReceipt) {
        0x15f27ec5e794de13e04f9855da007d79dbde91afb121048af1f091b88f2f823d::state::migrate_version(arg0);
        let v0 = 0x15f27ec5e794de13e04f9855da007d79dbde91afb121048af1f091b88f2f823d::state::assert_latest_only(arg0);
        0x15f27ec5e794de13e04f9855da007d79dbde91afb121048af1f091b88f2f823d::state::assert_authorized_digest(&v0, arg0, 0x15f27ec5e794de13e04f9855da007d79dbde91afb121048af1f091b88f2f823d::contract_upgrade::take_upgrade_digest(arg1));
        let v1 = MigrateComplete{package: 0x15f27ec5e794de13e04f9855da007d79dbde91afb121048af1f091b88f2f823d::state::current_package(&v0, arg0)};
        0x2::event::emit<MigrateComplete>(v1);
    }

    // decompiled from Move bytecode v7
}

