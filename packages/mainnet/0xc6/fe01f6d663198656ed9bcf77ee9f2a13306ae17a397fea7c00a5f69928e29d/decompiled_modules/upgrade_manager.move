module 0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::upgrade_manager {
    struct SystemUpgradeInitiated has copy, drop {
        safe_versions: vector<u64>,
        bridge_versions: vector<u64>,
        initiator: address,
    }

    struct SystemUpgradeCompleted has copy, drop {
        new_version: u64,
        previous_versions: vector<u64>,
    }

    public fun abort_system_migration(arg0: &mut 0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::safe::BridgeSafe, arg1: &mut 0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::bridge::Bridge, arg2: &mut 0x2::tx_context::TxContext) {
        0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::safe::checkOwnerRole(arg0, arg2);
        0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::safe::abort_migration(arg0, arg2);
        0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::bridge::abort_bridge_migration(arg1, arg0, arg2);
    }

    public fun complete_system_migration(arg0: &mut 0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::safe::BridgeSafe, arg1: &mut 0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::bridge::Bridge, arg2: &mut 0x2::tx_context::TxContext) {
        0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::safe::checkOwnerRole(arg0, arg2);
        0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::safe::complete_migration(arg0, arg2);
        0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::bridge::complete_bridge_migration(arg1, arg0, arg2);
        let v0 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v0, 0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::bridge_version_control::current_version() - 1);
        let v1 = SystemUpgradeCompleted{
            new_version       : 0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::bridge_version_control::current_version(),
            previous_versions : v0,
        };
        0x2::event::emit<SystemUpgradeCompleted>(v1);
    }

    public fun is_system_migration_in_progress(arg0: &0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::safe::BridgeSafe, arg1: &0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::bridge::Bridge) : bool {
        0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::safe::is_migration_in_progress(arg0) || 0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::bridge::is_bridge_migration_in_progress(arg1)
    }

    public fun start_system_migration(arg0: &mut 0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::safe::BridgeSafe, arg1: &mut 0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::bridge::Bridge, arg2: &mut 0x2::tx_context::TxContext) {
        0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::safe::checkOwnerRole(arg0, arg2);
        0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::safe::start_migration(arg0, arg2);
        0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::bridge::start_bridge_migration(arg1, arg0, arg2);
        let v0 = SystemUpgradeInitiated{
            safe_versions   : 0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::safe::compatible_versions(arg0),
            bridge_versions : 0xc6fe01f6d663198656ed9bcf77ee9f2a13306ae17a397fea7c00a5f69928e29d::bridge::bridge_compatible_versions(arg1),
            initiator       : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<SystemUpgradeInitiated>(v0);
    }

    // decompiled from Move bytecode v6
}

