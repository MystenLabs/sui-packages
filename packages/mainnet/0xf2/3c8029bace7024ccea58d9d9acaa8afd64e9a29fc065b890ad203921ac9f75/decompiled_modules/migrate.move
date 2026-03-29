module 0xf23c8029bace7024ccea58d9d9acaa8afd64e9a29fc065b890ad203921ac9f75::migrate {
    struct MigrateComplete has copy, drop {
        package: 0x2::object::ID,
    }

    public fun migrate(arg0: &mut 0xf23c8029bace7024ccea58d9d9acaa8afd64e9a29fc065b890ad203921ac9f75::state::State, arg1: vector<u8>, arg2: &0x2::clock::Clock) {
        0xf23c8029bace7024ccea58d9d9acaa8afd64e9a29fc065b890ad203921ac9f75::state::migrate__v__0_2_0(arg0);
        handle_migrate(arg0, arg1, arg2);
    }

    fun handle_migrate(arg0: &mut 0xf23c8029bace7024ccea58d9d9acaa8afd64e9a29fc065b890ad203921ac9f75::state::State, arg1: vector<u8>, arg2: &0x2::clock::Clock) {
        0xf23c8029bace7024ccea58d9d9acaa8afd64e9a29fc065b890ad203921ac9f75::state::migrate_version(arg0);
        let v0 = 0xf23c8029bace7024ccea58d9d9acaa8afd64e9a29fc065b890ad203921ac9f75::governance_message::verify_vaa<0xf23c8029bace7024ccea58d9d9acaa8afd64e9a29fc065b890ad203921ac9f75::upgrade_contract::GovernanceWitness>(arg0, 0xf23c8029bace7024ccea58d9d9acaa8afd64e9a29fc065b890ad203921ac9f75::vaa::parse_and_verify(arg0, arg1, arg2), 0xf23c8029bace7024ccea58d9d9acaa8afd64e9a29fc065b890ad203921ac9f75::upgrade_contract::authorize_governance(arg0));
        let v1 = 0xf23c8029bace7024ccea58d9d9acaa8afd64e9a29fc065b890ad203921ac9f75::state::assert_latest_only(arg0);
        0xf23c8029bace7024ccea58d9d9acaa8afd64e9a29fc065b890ad203921ac9f75::state::assert_authorized_digest(&v1, arg0, 0xf23c8029bace7024ccea58d9d9acaa8afd64e9a29fc065b890ad203921ac9f75::upgrade_contract::take_digest(0xf23c8029bace7024ccea58d9d9acaa8afd64e9a29fc065b890ad203921ac9f75::governance_message::payload<0xf23c8029bace7024ccea58d9d9acaa8afd64e9a29fc065b890ad203921ac9f75::upgrade_contract::GovernanceWitness>(&v0)));
        0xf23c8029bace7024ccea58d9d9acaa8afd64e9a29fc065b890ad203921ac9f75::governance_message::destroy<0xf23c8029bace7024ccea58d9d9acaa8afd64e9a29fc065b890ad203921ac9f75::upgrade_contract::GovernanceWitness>(v0);
        let v2 = MigrateComplete{package: 0xf23c8029bace7024ccea58d9d9acaa8afd64e9a29fc065b890ad203921ac9f75::state::current_package(&v1, arg0)};
        0x2::event::emit<MigrateComplete>(v2);
    }

    // decompiled from Move bytecode v6
}

