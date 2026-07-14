module 0x90821ed2c91e3fdcd1d7ae915e19ced469760a9750cadacae4a7a227699c0176::policy {
    struct UpgradeGuard has key {
        id: 0x2::object::UID,
        cap: 0x2::package::UpgradeCap,
    }

    public fun authorize(arg0: &0x8d91a18f6ff3a54c6885d13f0b2c3f28711c7c331b2601faff82eb2b041bf847::governance::GovernanceConfig, arg1: &mut UpgradeGuard, arg2: &mut 0x8d91a18f6ff3a54c6885d13f0b2c3f28711c7c331b2601faff82eb2b041bf847::governance::Proposal, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : 0x2::package::UpgradeTicket {
        0x2::package::authorize_upgrade(&mut arg1.cap, 0x2::package::upgrade_policy(&arg1.cap), 0x8d91a18f6ff3a54c6885d13f0b2c3f28711c7c331b2601faff82eb2b041bf847::governance::consume_for_upgrade(arg0, arg2, arg3, arg4))
    }

    public fun commit(arg0: &mut UpgradeGuard, arg1: 0x2::package::UpgradeReceipt) {
        0x2::package::commit_upgrade(&mut arg0.cap, arg1);
    }

    public fun install(arg0: 0x2::package::UpgradeCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = UpgradeGuard{
            id  : 0x2::object::new(arg1),
            cap : arg0,
        };
        0x2::transfer::share_object<UpgradeGuard>(v0);
    }

    // decompiled from Move bytecode v7
}

