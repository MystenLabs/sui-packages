module 0x160053c8e7e8afc987e706b34a92aa0ad671d42ae064ff3cede7c270c41726fa::stablecoin {
    struct STABLECOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: STABLECOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, _) = 0x160053c8e7e8afc987e706b34a92aa0ad671d42ae064ff3cede7c270c41726fa::upgrade_service::new<STABLECOIN>(arg0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_share_object<0x160053c8e7e8afc987e706b34a92aa0ad671d42ae064ff3cede7c270c41726fa::upgrade_service::UpgradeService<STABLECOIN>>(v0);
    }

    // decompiled from Move bytecode v6
}

