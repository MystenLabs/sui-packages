module 0xce971c9bd07b70cfc7d1b0b592f614cebdfb51f4311789eb0c60b9637f0aafde::migrate {
    struct MigrateComplete has copy, drop {
        package: 0x2::object::ID,
    }

    public fun migrate(arg0: &mut 0xce971c9bd07b70cfc7d1b0b592f614cebdfb51f4311789eb0c60b9637f0aafde::state::State, arg1: vector<u8>, arg2: &0x2::clock::Clock) {
        0xce971c9bd07b70cfc7d1b0b592f614cebdfb51f4311789eb0c60b9637f0aafde::state::migrate__v__0_2_0(arg0);
        handle_migrate(arg0, arg1, arg2);
    }

    fun handle_migrate(arg0: &mut 0xce971c9bd07b70cfc7d1b0b592f614cebdfb51f4311789eb0c60b9637f0aafde::state::State, arg1: vector<u8>, arg2: &0x2::clock::Clock) {
        0xce971c9bd07b70cfc7d1b0b592f614cebdfb51f4311789eb0c60b9637f0aafde::state::migrate_version(arg0);
        let v0 = 0xce971c9bd07b70cfc7d1b0b592f614cebdfb51f4311789eb0c60b9637f0aafde::governance_message::verify_vaa<0xce971c9bd07b70cfc7d1b0b592f614cebdfb51f4311789eb0c60b9637f0aafde::upgrade_contract::GovernanceWitness>(arg0, 0xce971c9bd07b70cfc7d1b0b592f614cebdfb51f4311789eb0c60b9637f0aafde::vaa::parse_and_verify(arg0, arg1, arg2), 0xce971c9bd07b70cfc7d1b0b592f614cebdfb51f4311789eb0c60b9637f0aafde::upgrade_contract::authorize_governance(arg0));
        let v1 = 0xce971c9bd07b70cfc7d1b0b592f614cebdfb51f4311789eb0c60b9637f0aafde::state::assert_latest_only(arg0);
        0xce971c9bd07b70cfc7d1b0b592f614cebdfb51f4311789eb0c60b9637f0aafde::state::assert_authorized_digest(&v1, arg0, 0xce971c9bd07b70cfc7d1b0b592f614cebdfb51f4311789eb0c60b9637f0aafde::upgrade_contract::take_digest(0xce971c9bd07b70cfc7d1b0b592f614cebdfb51f4311789eb0c60b9637f0aafde::governance_message::payload<0xce971c9bd07b70cfc7d1b0b592f614cebdfb51f4311789eb0c60b9637f0aafde::upgrade_contract::GovernanceWitness>(&v0)));
        0xce971c9bd07b70cfc7d1b0b592f614cebdfb51f4311789eb0c60b9637f0aafde::governance_message::destroy<0xce971c9bd07b70cfc7d1b0b592f614cebdfb51f4311789eb0c60b9637f0aafde::upgrade_contract::GovernanceWitness>(v0);
        let v2 = MigrateComplete{package: 0xce971c9bd07b70cfc7d1b0b592f614cebdfb51f4311789eb0c60b9637f0aafde::state::current_package(&v1, arg0)};
        0x2::event::emit<MigrateComplete>(v2);
    }

    // decompiled from Move bytecode v6
}

