module 0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::migrate {
    struct MigrateComplete has copy, drop {
        package: 0x2::object::ID,
    }

    public fun migrate(arg0: &mut 0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::state::State, arg1: vector<u8>, arg2: &0x2::clock::Clock) {
        0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::state::migrate__v__0_2_0(arg0);
        handle_migrate(arg0, arg1, arg2);
    }

    fun handle_migrate(arg0: &mut 0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::state::State, arg1: vector<u8>, arg2: &0x2::clock::Clock) {
        0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::state::migrate_version(arg0);
        let v0 = 0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::governance_message::verify_vaa<0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::upgrade_contract::GovernanceWitness>(arg0, 0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::vaa::parse_and_verify(arg0, arg1, arg2), 0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::upgrade_contract::authorize_governance(arg0));
        let v1 = 0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::state::assert_latest_only(arg0);
        0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::state::assert_authorized_digest(&v1, arg0, 0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::upgrade_contract::take_digest(0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::governance_message::payload<0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::upgrade_contract::GovernanceWitness>(&v0)));
        0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::governance_message::destroy<0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::upgrade_contract::GovernanceWitness>(v0);
        let v2 = MigrateComplete{package: 0x99de5c967d8206ef4b75c0afab3df2a59eb02b05c282821db803831008ac25b4::state::current_package(&v1, arg0)};
        0x2::event::emit<MigrateComplete>(v2);
    }

    // decompiled from Move bytecode v6
}

