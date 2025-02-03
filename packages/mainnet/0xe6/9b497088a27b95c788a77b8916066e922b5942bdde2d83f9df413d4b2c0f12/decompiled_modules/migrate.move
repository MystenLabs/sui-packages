module 0xe69b497088a27b95c788a77b8916066e922b5942bdde2d83f9df413d4b2c0f12::migrate {
    struct MigrateComplete has copy, drop {
        package: 0x2::object::ID,
    }

    public fun migrate(arg0: &mut 0xe69b497088a27b95c788a77b8916066e922b5942bdde2d83f9df413d4b2c0f12::state::State, arg1: 0xe69b497088a27b95c788a77b8916066e922b5942bdde2d83f9df413d4b2c0f12::governance::WormholeVAAVerificationReceipt) {
        handle_migrate(arg0, arg1);
    }

    fun handle_migrate(arg0: &mut 0xe69b497088a27b95c788a77b8916066e922b5942bdde2d83f9df413d4b2c0f12::state::State, arg1: 0xe69b497088a27b95c788a77b8916066e922b5942bdde2d83f9df413d4b2c0f12::governance::WormholeVAAVerificationReceipt) {
        0xe69b497088a27b95c788a77b8916066e922b5942bdde2d83f9df413d4b2c0f12::state::migrate_version(arg0);
        let v0 = 0xe69b497088a27b95c788a77b8916066e922b5942bdde2d83f9df413d4b2c0f12::state::assert_latest_only(arg0);
        0xe69b497088a27b95c788a77b8916066e922b5942bdde2d83f9df413d4b2c0f12::state::assert_authorized_digest(&v0, arg0, 0xe69b497088a27b95c788a77b8916066e922b5942bdde2d83f9df413d4b2c0f12::contract_upgrade::take_upgrade_digest(arg1));
        let v1 = MigrateComplete{package: 0xe69b497088a27b95c788a77b8916066e922b5942bdde2d83f9df413d4b2c0f12::state::current_package(&v0, arg0)};
        0x2::event::emit<MigrateComplete>(v1);
    }

    // decompiled from Move bytecode v6
}

