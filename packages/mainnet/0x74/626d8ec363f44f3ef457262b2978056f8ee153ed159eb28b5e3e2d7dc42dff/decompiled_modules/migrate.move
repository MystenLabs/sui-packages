module 0x74626d8ec363f44f3ef457262b2978056f8ee153ed159eb28b5e3e2d7dc42dff::migrate {
    struct MigrateComplete has copy, drop {
        package: 0x2::object::ID,
    }

    public fun migrate(arg0: &mut 0x74626d8ec363f44f3ef457262b2978056f8ee153ed159eb28b5e3e2d7dc42dff::state::State, arg1: vector<u8>, arg2: &0x2::clock::Clock) {
        0x74626d8ec363f44f3ef457262b2978056f8ee153ed159eb28b5e3e2d7dc42dff::state::migrate__v__0_2_0(arg0);
        handle_migrate(arg0, arg1, arg2);
    }

    fun handle_migrate(arg0: &mut 0x74626d8ec363f44f3ef457262b2978056f8ee153ed159eb28b5e3e2d7dc42dff::state::State, arg1: vector<u8>, arg2: &0x2::clock::Clock) {
        0x74626d8ec363f44f3ef457262b2978056f8ee153ed159eb28b5e3e2d7dc42dff::state::migrate_version(arg0);
        let v0 = 0x74626d8ec363f44f3ef457262b2978056f8ee153ed159eb28b5e3e2d7dc42dff::governance_message::verify_vaa<0x74626d8ec363f44f3ef457262b2978056f8ee153ed159eb28b5e3e2d7dc42dff::upgrade_contract::GovernanceWitness>(arg0, 0x74626d8ec363f44f3ef457262b2978056f8ee153ed159eb28b5e3e2d7dc42dff::vaa::parse_and_verify(arg0, arg1, arg2), 0x74626d8ec363f44f3ef457262b2978056f8ee153ed159eb28b5e3e2d7dc42dff::upgrade_contract::authorize_governance(arg0));
        let v1 = 0x74626d8ec363f44f3ef457262b2978056f8ee153ed159eb28b5e3e2d7dc42dff::state::assert_latest_only(arg0);
        0x74626d8ec363f44f3ef457262b2978056f8ee153ed159eb28b5e3e2d7dc42dff::state::assert_authorized_digest(&v1, arg0, 0x74626d8ec363f44f3ef457262b2978056f8ee153ed159eb28b5e3e2d7dc42dff::upgrade_contract::take_digest(0x74626d8ec363f44f3ef457262b2978056f8ee153ed159eb28b5e3e2d7dc42dff::governance_message::payload<0x74626d8ec363f44f3ef457262b2978056f8ee153ed159eb28b5e3e2d7dc42dff::upgrade_contract::GovernanceWitness>(&v0)));
        0x74626d8ec363f44f3ef457262b2978056f8ee153ed159eb28b5e3e2d7dc42dff::governance_message::destroy<0x74626d8ec363f44f3ef457262b2978056f8ee153ed159eb28b5e3e2d7dc42dff::upgrade_contract::GovernanceWitness>(v0);
        let v2 = MigrateComplete{package: 0x74626d8ec363f44f3ef457262b2978056f8ee153ed159eb28b5e3e2d7dc42dff::state::current_package(&v1, arg0)};
        0x2::event::emit<MigrateComplete>(v2);
    }

    // decompiled from Move bytecode v6
}

