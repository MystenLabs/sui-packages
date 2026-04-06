module 0x82d5574d149954f355908cbaaaeb584bd5a918736fb7465a099f846cf0ab9f91::upgrade_manager {
    struct SystemUpgradeInitiated has copy, drop {
        safe_versions: vector<u64>,
        bridge_versions: vector<u64>,
        initiator: address,
    }

    struct SystemUpgradeCompleted has copy, drop {
        new_version: u64,
        previous_versions: vector<u64>,
    }

    public fun abort_system_migration(arg0: &mut 0x82d5574d149954f355908cbaaaeb584bd5a918736fb7465a099f846cf0ab9f91::safe::BridgeSafe, arg1: &mut 0x82d5574d149954f355908cbaaaeb584bd5a918736fb7465a099f846cf0ab9f91::bridge::Bridge, arg2: &mut 0x2::tx_context::TxContext) {
        0x82d5574d149954f355908cbaaaeb584bd5a918736fb7465a099f846cf0ab9f91::safe::checkOwnerRole(arg0, arg2);
        0x82d5574d149954f355908cbaaaeb584bd5a918736fb7465a099f846cf0ab9f91::safe::abort_migration(arg0, arg2);
        0x82d5574d149954f355908cbaaaeb584bd5a918736fb7465a099f846cf0ab9f91::bridge::abort_bridge_migration(arg1, arg0, arg2);
    }

    public fun complete_system_migration(arg0: &mut 0x82d5574d149954f355908cbaaaeb584bd5a918736fb7465a099f846cf0ab9f91::safe::BridgeSafe, arg1: &mut 0x82d5574d149954f355908cbaaaeb584bd5a918736fb7465a099f846cf0ab9f91::bridge::Bridge, arg2: &mut 0x2::tx_context::TxContext) {
        0x82d5574d149954f355908cbaaaeb584bd5a918736fb7465a099f846cf0ab9f91::safe::checkOwnerRole(arg0, arg2);
        0x82d5574d149954f355908cbaaaeb584bd5a918736fb7465a099f846cf0ab9f91::safe::complete_migration(arg0, arg2);
        0x82d5574d149954f355908cbaaaeb584bd5a918736fb7465a099f846cf0ab9f91::bridge::complete_bridge_migration(arg1, arg0, arg2);
        let v0 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v0, 0x82d5574d149954f355908cbaaaeb584bd5a918736fb7465a099f846cf0ab9f91::bridge_version_control::current_version() - 1);
        let v1 = SystemUpgradeCompleted{
            new_version       : 0x82d5574d149954f355908cbaaaeb584bd5a918736fb7465a099f846cf0ab9f91::bridge_version_control::current_version(),
            previous_versions : v0,
        };
        0x2::event::emit<SystemUpgradeCompleted>(v1);
    }

    public fun is_system_migration_in_progress(arg0: &0x82d5574d149954f355908cbaaaeb584bd5a918736fb7465a099f846cf0ab9f91::safe::BridgeSafe, arg1: &0x82d5574d149954f355908cbaaaeb584bd5a918736fb7465a099f846cf0ab9f91::bridge::Bridge) : bool {
        0x82d5574d149954f355908cbaaaeb584bd5a918736fb7465a099f846cf0ab9f91::safe::is_migration_in_progress(arg0) || 0x82d5574d149954f355908cbaaaeb584bd5a918736fb7465a099f846cf0ab9f91::bridge::is_bridge_migration_in_progress(arg1)
    }

    public fun start_system_migration(arg0: &mut 0x82d5574d149954f355908cbaaaeb584bd5a918736fb7465a099f846cf0ab9f91::safe::BridgeSafe, arg1: &mut 0x82d5574d149954f355908cbaaaeb584bd5a918736fb7465a099f846cf0ab9f91::bridge::Bridge, arg2: &mut 0x2::tx_context::TxContext) {
        0x82d5574d149954f355908cbaaaeb584bd5a918736fb7465a099f846cf0ab9f91::safe::checkOwnerRole(arg0, arg2);
        0x82d5574d149954f355908cbaaaeb584bd5a918736fb7465a099f846cf0ab9f91::safe::start_migration(arg0, arg2);
        0x82d5574d149954f355908cbaaaeb584bd5a918736fb7465a099f846cf0ab9f91::bridge::start_bridge_migration(arg1, arg0, arg2);
        let v0 = SystemUpgradeInitiated{
            safe_versions   : 0x82d5574d149954f355908cbaaaeb584bd5a918736fb7465a099f846cf0ab9f91::safe::compatible_versions(arg0),
            bridge_versions : 0x82d5574d149954f355908cbaaaeb584bd5a918736fb7465a099f846cf0ab9f91::bridge::bridge_compatible_versions(arg1),
            initiator       : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<SystemUpgradeInitiated>(v0);
    }

    // decompiled from Move bytecode v7
}

