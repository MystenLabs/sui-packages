module 0x14feadb5ac49e951c80543fce53283e623bb7e298375fbdfab4c1953440c198b::migrate {
    struct MigrateComplete has copy, drop {
        package: 0x2::object::ID,
    }

    public fun migrate(arg0: &mut 0x14feadb5ac49e951c80543fce53283e623bb7e298375fbdfab4c1953440c198b::state::State, arg1: vector<u8>, arg2: &0x2::clock::Clock) {
        0x14feadb5ac49e951c80543fce53283e623bb7e298375fbdfab4c1953440c198b::state::migrate__v__0_2_0(arg0);
        handle_migrate(arg0, arg1, arg2);
    }

    fun handle_migrate(arg0: &mut 0x14feadb5ac49e951c80543fce53283e623bb7e298375fbdfab4c1953440c198b::state::State, arg1: vector<u8>, arg2: &0x2::clock::Clock) {
        0x14feadb5ac49e951c80543fce53283e623bb7e298375fbdfab4c1953440c198b::state::migrate_version(arg0);
        let v0 = 0x14feadb5ac49e951c80543fce53283e623bb7e298375fbdfab4c1953440c198b::governance_message::verify_vaa<0x14feadb5ac49e951c80543fce53283e623bb7e298375fbdfab4c1953440c198b::upgrade_contract::GovernanceWitness>(arg0, 0x14feadb5ac49e951c80543fce53283e623bb7e298375fbdfab4c1953440c198b::vaa::parse_and_verify(arg0, arg1, arg2), 0x14feadb5ac49e951c80543fce53283e623bb7e298375fbdfab4c1953440c198b::upgrade_contract::authorize_governance(arg0));
        let v1 = 0x14feadb5ac49e951c80543fce53283e623bb7e298375fbdfab4c1953440c198b::state::assert_latest_only(arg0);
        0x14feadb5ac49e951c80543fce53283e623bb7e298375fbdfab4c1953440c198b::state::assert_authorized_digest(&v1, arg0, 0x14feadb5ac49e951c80543fce53283e623bb7e298375fbdfab4c1953440c198b::upgrade_contract::take_digest(0x14feadb5ac49e951c80543fce53283e623bb7e298375fbdfab4c1953440c198b::governance_message::payload<0x14feadb5ac49e951c80543fce53283e623bb7e298375fbdfab4c1953440c198b::upgrade_contract::GovernanceWitness>(&v0)));
        0x14feadb5ac49e951c80543fce53283e623bb7e298375fbdfab4c1953440c198b::governance_message::destroy<0x14feadb5ac49e951c80543fce53283e623bb7e298375fbdfab4c1953440c198b::upgrade_contract::GovernanceWitness>(v0);
        let v2 = MigrateComplete{package: 0x14feadb5ac49e951c80543fce53283e623bb7e298375fbdfab4c1953440c198b::state::current_package(&v1, arg0)};
        0x2::event::emit<MigrateComplete>(v2);
    }

    // decompiled from Move bytecode v7
}

