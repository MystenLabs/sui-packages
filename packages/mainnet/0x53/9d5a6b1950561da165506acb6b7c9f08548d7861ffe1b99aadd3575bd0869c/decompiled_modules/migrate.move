module 0x539d5a6b1950561da165506acb6b7c9f08548d7861ffe1b99aadd3575bd0869c::migrate {
    struct MigrateComplete has copy, drop {
        package: 0x2::object::ID,
    }

    public fun migrate(arg0: &mut 0x539d5a6b1950561da165506acb6b7c9f08548d7861ffe1b99aadd3575bd0869c::state::State, arg1: vector<u8>, arg2: &0x2::clock::Clock) {
        0x539d5a6b1950561da165506acb6b7c9f08548d7861ffe1b99aadd3575bd0869c::state::migrate__v__0_2_0(arg0);
        handle_migrate(arg0, arg1, arg2);
    }

    fun handle_migrate(arg0: &mut 0x539d5a6b1950561da165506acb6b7c9f08548d7861ffe1b99aadd3575bd0869c::state::State, arg1: vector<u8>, arg2: &0x2::clock::Clock) {
        0x539d5a6b1950561da165506acb6b7c9f08548d7861ffe1b99aadd3575bd0869c::state::migrate_version(arg0);
        let v0 = 0x539d5a6b1950561da165506acb6b7c9f08548d7861ffe1b99aadd3575bd0869c::governance_message::verify_vaa<0x539d5a6b1950561da165506acb6b7c9f08548d7861ffe1b99aadd3575bd0869c::upgrade_contract::GovernanceWitness>(arg0, 0x539d5a6b1950561da165506acb6b7c9f08548d7861ffe1b99aadd3575bd0869c::vaa::parse_and_verify(arg0, arg1, arg2), 0x539d5a6b1950561da165506acb6b7c9f08548d7861ffe1b99aadd3575bd0869c::upgrade_contract::authorize_governance(arg0));
        let v1 = 0x539d5a6b1950561da165506acb6b7c9f08548d7861ffe1b99aadd3575bd0869c::state::assert_latest_only(arg0);
        0x539d5a6b1950561da165506acb6b7c9f08548d7861ffe1b99aadd3575bd0869c::state::assert_authorized_digest(&v1, arg0, 0x539d5a6b1950561da165506acb6b7c9f08548d7861ffe1b99aadd3575bd0869c::upgrade_contract::take_digest(0x539d5a6b1950561da165506acb6b7c9f08548d7861ffe1b99aadd3575bd0869c::governance_message::payload<0x539d5a6b1950561da165506acb6b7c9f08548d7861ffe1b99aadd3575bd0869c::upgrade_contract::GovernanceWitness>(&v0)));
        0x539d5a6b1950561da165506acb6b7c9f08548d7861ffe1b99aadd3575bd0869c::governance_message::destroy<0x539d5a6b1950561da165506acb6b7c9f08548d7861ffe1b99aadd3575bd0869c::upgrade_contract::GovernanceWitness>(v0);
        let v2 = MigrateComplete{package: 0x539d5a6b1950561da165506acb6b7c9f08548d7861ffe1b99aadd3575bd0869c::state::current_package(&v1, arg0)};
        0x2::event::emit<MigrateComplete>(v2);
    }

    // decompiled from Move bytecode v6
}

