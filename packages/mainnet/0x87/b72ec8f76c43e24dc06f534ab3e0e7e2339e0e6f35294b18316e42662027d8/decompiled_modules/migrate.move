module 0x87b72ec8f76c43e24dc06f534ab3e0e7e2339e0e6f35294b18316e42662027d8::migrate {
    struct MigrateComplete has copy, drop {
        package: 0x2::object::ID,
    }

    public fun migrate(arg0: &mut 0x87b72ec8f76c43e24dc06f534ab3e0e7e2339e0e6f35294b18316e42662027d8::state::State, arg1: vector<u8>, arg2: &0x2::clock::Clock) {
        0x87b72ec8f76c43e24dc06f534ab3e0e7e2339e0e6f35294b18316e42662027d8::state::migrate__v__0_2_0(arg0);
        handle_migrate(arg0, arg1, arg2);
    }

    fun handle_migrate(arg0: &mut 0x87b72ec8f76c43e24dc06f534ab3e0e7e2339e0e6f35294b18316e42662027d8::state::State, arg1: vector<u8>, arg2: &0x2::clock::Clock) {
        0x87b72ec8f76c43e24dc06f534ab3e0e7e2339e0e6f35294b18316e42662027d8::state::migrate_version(arg0);
        let v0 = 0x87b72ec8f76c43e24dc06f534ab3e0e7e2339e0e6f35294b18316e42662027d8::governance_message::verify_vaa<0x87b72ec8f76c43e24dc06f534ab3e0e7e2339e0e6f35294b18316e42662027d8::upgrade_contract::GovernanceWitness>(arg0, 0x87b72ec8f76c43e24dc06f534ab3e0e7e2339e0e6f35294b18316e42662027d8::vaa::parse_and_verify(arg0, arg1, arg2), 0x87b72ec8f76c43e24dc06f534ab3e0e7e2339e0e6f35294b18316e42662027d8::upgrade_contract::authorize_governance(arg0));
        let v1 = 0x87b72ec8f76c43e24dc06f534ab3e0e7e2339e0e6f35294b18316e42662027d8::state::assert_latest_only(arg0);
        0x87b72ec8f76c43e24dc06f534ab3e0e7e2339e0e6f35294b18316e42662027d8::state::assert_authorized_digest(&v1, arg0, 0x87b72ec8f76c43e24dc06f534ab3e0e7e2339e0e6f35294b18316e42662027d8::upgrade_contract::take_digest(0x87b72ec8f76c43e24dc06f534ab3e0e7e2339e0e6f35294b18316e42662027d8::governance_message::payload<0x87b72ec8f76c43e24dc06f534ab3e0e7e2339e0e6f35294b18316e42662027d8::upgrade_contract::GovernanceWitness>(&v0)));
        0x87b72ec8f76c43e24dc06f534ab3e0e7e2339e0e6f35294b18316e42662027d8::governance_message::destroy<0x87b72ec8f76c43e24dc06f534ab3e0e7e2339e0e6f35294b18316e42662027d8::upgrade_contract::GovernanceWitness>(v0);
        let v2 = MigrateComplete{package: 0x87b72ec8f76c43e24dc06f534ab3e0e7e2339e0e6f35294b18316e42662027d8::state::current_package(&v1, arg0)};
        0x2::event::emit<MigrateComplete>(v2);
    }

    // decompiled from Move bytecode v6
}

