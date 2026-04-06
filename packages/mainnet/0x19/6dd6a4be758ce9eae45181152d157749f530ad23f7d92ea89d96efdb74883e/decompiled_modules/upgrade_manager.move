module 0x196dd6a4be758ce9eae45181152d157749f530ad23f7d92ea89d96efdb74883e::upgrade_manager {
    struct SystemUpgradeInitiated has copy, drop {
        safe_versions: vector<u64>,
        bridge_versions: vector<u64>,
        initiator: address,
    }

    struct SystemUpgradeCompleted has copy, drop {
        new_version: u64,
        previous_versions: vector<u64>,
    }

    public fun abort_system_migration(arg0: &mut 0x196dd6a4be758ce9eae45181152d157749f530ad23f7d92ea89d96efdb74883e::safe::BridgeSafe, arg1: &mut 0x196dd6a4be758ce9eae45181152d157749f530ad23f7d92ea89d96efdb74883e::bridge::Bridge, arg2: &mut 0x2::tx_context::TxContext) {
        0x196dd6a4be758ce9eae45181152d157749f530ad23f7d92ea89d96efdb74883e::safe::checkOwnerRole(arg0, arg2);
        0x196dd6a4be758ce9eae45181152d157749f530ad23f7d92ea89d96efdb74883e::safe::abort_migration(arg0, arg2);
        0x196dd6a4be758ce9eae45181152d157749f530ad23f7d92ea89d96efdb74883e::bridge::abort_bridge_migration(arg1, arg0, arg2);
    }

    public fun complete_system_migration(arg0: &mut 0x196dd6a4be758ce9eae45181152d157749f530ad23f7d92ea89d96efdb74883e::safe::BridgeSafe, arg1: &mut 0x196dd6a4be758ce9eae45181152d157749f530ad23f7d92ea89d96efdb74883e::bridge::Bridge, arg2: &mut 0x2::tx_context::TxContext) {
        0x196dd6a4be758ce9eae45181152d157749f530ad23f7d92ea89d96efdb74883e::safe::checkOwnerRole(arg0, arg2);
        0x196dd6a4be758ce9eae45181152d157749f530ad23f7d92ea89d96efdb74883e::safe::complete_migration(arg0, arg2);
        0x196dd6a4be758ce9eae45181152d157749f530ad23f7d92ea89d96efdb74883e::bridge::complete_bridge_migration(arg1, arg0, arg2);
        let v0 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v0, 0x196dd6a4be758ce9eae45181152d157749f530ad23f7d92ea89d96efdb74883e::bridge_version_control::current_version() - 1);
        let v1 = SystemUpgradeCompleted{
            new_version       : 0x196dd6a4be758ce9eae45181152d157749f530ad23f7d92ea89d96efdb74883e::bridge_version_control::current_version(),
            previous_versions : v0,
        };
        0x2::event::emit<SystemUpgradeCompleted>(v1);
    }

    public fun is_system_migration_in_progress(arg0: &0x196dd6a4be758ce9eae45181152d157749f530ad23f7d92ea89d96efdb74883e::safe::BridgeSafe, arg1: &0x196dd6a4be758ce9eae45181152d157749f530ad23f7d92ea89d96efdb74883e::bridge::Bridge) : bool {
        0x196dd6a4be758ce9eae45181152d157749f530ad23f7d92ea89d96efdb74883e::safe::is_migration_in_progress(arg0) || 0x196dd6a4be758ce9eae45181152d157749f530ad23f7d92ea89d96efdb74883e::bridge::is_bridge_migration_in_progress(arg1)
    }

    public fun start_system_migration(arg0: &mut 0x196dd6a4be758ce9eae45181152d157749f530ad23f7d92ea89d96efdb74883e::safe::BridgeSafe, arg1: &mut 0x196dd6a4be758ce9eae45181152d157749f530ad23f7d92ea89d96efdb74883e::bridge::Bridge, arg2: &mut 0x2::tx_context::TxContext) {
        0x196dd6a4be758ce9eae45181152d157749f530ad23f7d92ea89d96efdb74883e::safe::checkOwnerRole(arg0, arg2);
        0x196dd6a4be758ce9eae45181152d157749f530ad23f7d92ea89d96efdb74883e::safe::start_migration(arg0, arg2);
        0x196dd6a4be758ce9eae45181152d157749f530ad23f7d92ea89d96efdb74883e::bridge::start_bridge_migration(arg1, arg0, arg2);
        let v0 = SystemUpgradeInitiated{
            safe_versions   : 0x196dd6a4be758ce9eae45181152d157749f530ad23f7d92ea89d96efdb74883e::safe::compatible_versions(arg0),
            bridge_versions : 0x196dd6a4be758ce9eae45181152d157749f530ad23f7d92ea89d96efdb74883e::bridge::bridge_compatible_versions(arg1),
            initiator       : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<SystemUpgradeInitiated>(v0);
    }

    // decompiled from Move bytecode v7
}

