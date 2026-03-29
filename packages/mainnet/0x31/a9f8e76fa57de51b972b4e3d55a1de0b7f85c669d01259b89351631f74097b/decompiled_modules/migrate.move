module 0x31a9f8e76fa57de51b972b4e3d55a1de0b7f85c669d01259b89351631f74097b::migrate {
    struct MigrateComplete has copy, drop {
        package: 0x2::object::ID,
    }

    public fun migrate(arg0: &mut 0x31a9f8e76fa57de51b972b4e3d55a1de0b7f85c669d01259b89351631f74097b::state::State, arg1: vector<u8>, arg2: &0x2::clock::Clock) {
        0x31a9f8e76fa57de51b972b4e3d55a1de0b7f85c669d01259b89351631f74097b::state::migrate__v__0_2_0(arg0);
        handle_migrate(arg0, arg1, arg2);
    }

    fun handle_migrate(arg0: &mut 0x31a9f8e76fa57de51b972b4e3d55a1de0b7f85c669d01259b89351631f74097b::state::State, arg1: vector<u8>, arg2: &0x2::clock::Clock) {
        0x31a9f8e76fa57de51b972b4e3d55a1de0b7f85c669d01259b89351631f74097b::state::migrate_version(arg0);
        let v0 = 0x31a9f8e76fa57de51b972b4e3d55a1de0b7f85c669d01259b89351631f74097b::governance_message::verify_vaa<0x31a9f8e76fa57de51b972b4e3d55a1de0b7f85c669d01259b89351631f74097b::upgrade_contract::GovernanceWitness>(arg0, 0x31a9f8e76fa57de51b972b4e3d55a1de0b7f85c669d01259b89351631f74097b::vaa::parse_and_verify(arg0, arg1, arg2), 0x31a9f8e76fa57de51b972b4e3d55a1de0b7f85c669d01259b89351631f74097b::upgrade_contract::authorize_governance(arg0));
        let v1 = 0x31a9f8e76fa57de51b972b4e3d55a1de0b7f85c669d01259b89351631f74097b::state::assert_latest_only(arg0);
        0x31a9f8e76fa57de51b972b4e3d55a1de0b7f85c669d01259b89351631f74097b::state::assert_authorized_digest(&v1, arg0, 0x31a9f8e76fa57de51b972b4e3d55a1de0b7f85c669d01259b89351631f74097b::upgrade_contract::take_digest(0x31a9f8e76fa57de51b972b4e3d55a1de0b7f85c669d01259b89351631f74097b::governance_message::payload<0x31a9f8e76fa57de51b972b4e3d55a1de0b7f85c669d01259b89351631f74097b::upgrade_contract::GovernanceWitness>(&v0)));
        0x31a9f8e76fa57de51b972b4e3d55a1de0b7f85c669d01259b89351631f74097b::governance_message::destroy<0x31a9f8e76fa57de51b972b4e3d55a1de0b7f85c669d01259b89351631f74097b::upgrade_contract::GovernanceWitness>(v0);
        let v2 = MigrateComplete{package: 0x31a9f8e76fa57de51b972b4e3d55a1de0b7f85c669d01259b89351631f74097b::state::current_package(&v1, arg0)};
        0x2::event::emit<MigrateComplete>(v2);
    }

    // decompiled from Move bytecode v6
}

