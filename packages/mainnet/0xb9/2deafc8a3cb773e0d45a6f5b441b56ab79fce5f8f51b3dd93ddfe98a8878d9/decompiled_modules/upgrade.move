module 0xb92deafc8a3cb773e0d45a6f5b441b56ab79fce5f8f51b3dd93ddfe98a8878d9::upgrade {
    struct UpgradeManager has key {
        id: 0x2::object::UID,
        upgrade_cap: 0x2::package::UpgradeCap,
    }

    public fun admin_upgrade(arg0: &mut UpgradeManager, arg1: &0xb92deafc8a3cb773e0d45a6f5b441b56ab79fce5f8f51b3dd93ddfe98a8878d9::admin::AdminCap, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::package::UpgradeTicket {
        assert!(0x1::vector::length<u8>(&arg2) == 32, 5);
        0x2::package::authorize_upgrade(&mut arg0.upgrade_cap, 0x2::package::upgrade_policy(&arg0.upgrade_cap), arg2)
    }

    public(friend) fun new_and_share(arg0: 0x2::package::UpgradeCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = UpgradeManager{
            id          : 0x2::object::new(arg1),
            upgrade_cap : arg0,
        };
        0x2::transfer::share_object<UpgradeManager>(v0);
    }

    // decompiled from Move bytecode v6
}

