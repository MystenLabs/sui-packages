module 0x66866ce3a25c47597f6eaa92365b9541cdc44daa610927f6d092a300a49608fa::migrate {
    struct MigrateComplete has copy, drop {
        package: 0x2::object::ID,
    }

    public fun migrate(arg0: &mut 0x66866ce3a25c47597f6eaa92365b9541cdc44daa610927f6d092a300a49608fa::state::State, arg1: vector<u8>, arg2: &0x2::clock::Clock) {
        0x66866ce3a25c47597f6eaa92365b9541cdc44daa610927f6d092a300a49608fa::state::migrate__v__0_2_0(arg0);
        handle_migrate(arg0, arg1, arg2);
    }

    fun handle_migrate(arg0: &mut 0x66866ce3a25c47597f6eaa92365b9541cdc44daa610927f6d092a300a49608fa::state::State, arg1: vector<u8>, arg2: &0x2::clock::Clock) {
        0x66866ce3a25c47597f6eaa92365b9541cdc44daa610927f6d092a300a49608fa::state::migrate_version(arg0);
        let v0 = 0x66866ce3a25c47597f6eaa92365b9541cdc44daa610927f6d092a300a49608fa::governance_message::verify_vaa<0x66866ce3a25c47597f6eaa92365b9541cdc44daa610927f6d092a300a49608fa::upgrade_contract::GovernanceWitness>(arg0, 0x66866ce3a25c47597f6eaa92365b9541cdc44daa610927f6d092a300a49608fa::vaa::parse_and_verify(arg0, arg1, arg2), 0x66866ce3a25c47597f6eaa92365b9541cdc44daa610927f6d092a300a49608fa::upgrade_contract::authorize_governance(arg0));
        let v1 = 0x66866ce3a25c47597f6eaa92365b9541cdc44daa610927f6d092a300a49608fa::state::assert_latest_only(arg0);
        0x66866ce3a25c47597f6eaa92365b9541cdc44daa610927f6d092a300a49608fa::state::assert_authorized_digest(&v1, arg0, 0x66866ce3a25c47597f6eaa92365b9541cdc44daa610927f6d092a300a49608fa::upgrade_contract::take_digest(0x66866ce3a25c47597f6eaa92365b9541cdc44daa610927f6d092a300a49608fa::governance_message::payload<0x66866ce3a25c47597f6eaa92365b9541cdc44daa610927f6d092a300a49608fa::upgrade_contract::GovernanceWitness>(&v0)));
        0x66866ce3a25c47597f6eaa92365b9541cdc44daa610927f6d092a300a49608fa::governance_message::destroy<0x66866ce3a25c47597f6eaa92365b9541cdc44daa610927f6d092a300a49608fa::upgrade_contract::GovernanceWitness>(v0);
        let v2 = MigrateComplete{package: 0x66866ce3a25c47597f6eaa92365b9541cdc44daa610927f6d092a300a49608fa::state::current_package(&v1, arg0)};
        0x2::event::emit<MigrateComplete>(v2);
    }

    // decompiled from Move bytecode v6
}

