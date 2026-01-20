module 0x1282fcec75fe0c36418b3702d384e401fc95d7b0a719e83169b736ad5c9ce44e::upgrade {
    struct UpgradeManager has key {
        id: 0x2::object::UID,
        upgrade_cap: 0x2::package::UpgradeCap,
    }

    public fun admin_upgrade(arg0: &mut UpgradeManager, arg1: &0x1282fcec75fe0c36418b3702d384e401fc95d7b0a719e83169b736ad5c9ce44e::admin::AdminCap, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::package::UpgradeTicket {
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

