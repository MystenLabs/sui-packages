module 0x1359dac4d63abc896caa6a8971e4affec7c75590944ca33186c48c614a80583a::migrate {
    struct MigrateComplete has copy, drop {
        package: 0x2::object::ID,
    }

    public fun migrate(arg0: &mut 0x1359dac4d63abc896caa6a8971e4affec7c75590944ca33186c48c614a80583a::state::State, arg1: 0x1359dac4d63abc896caa6a8971e4affec7c75590944ca33186c48c614a80583a::governance::WormholeVAAVerificationReceipt) {
        handle_migrate(arg0, arg1);
    }

    fun handle_migrate(arg0: &mut 0x1359dac4d63abc896caa6a8971e4affec7c75590944ca33186c48c614a80583a::state::State, arg1: 0x1359dac4d63abc896caa6a8971e4affec7c75590944ca33186c48c614a80583a::governance::WormholeVAAVerificationReceipt) {
        0x1359dac4d63abc896caa6a8971e4affec7c75590944ca33186c48c614a80583a::state::migrate_version(arg0);
        let v0 = 0x1359dac4d63abc896caa6a8971e4affec7c75590944ca33186c48c614a80583a::state::assert_latest_only(arg0);
        0x1359dac4d63abc896caa6a8971e4affec7c75590944ca33186c48c614a80583a::state::assert_authorized_digest(&v0, arg0, 0x1359dac4d63abc896caa6a8971e4affec7c75590944ca33186c48c614a80583a::contract_upgrade::take_upgrade_digest(arg1));
        let v1 = MigrateComplete{package: 0x1359dac4d63abc896caa6a8971e4affec7c75590944ca33186c48c614a80583a::state::current_package(&v0, arg0)};
        0x2::event::emit<MigrateComplete>(v1);
    }

    // decompiled from Move bytecode v6
}

