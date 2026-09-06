module 0x88e5ade80a203d64539bec5aeb3b79a318850a53af2338df3b08daedd696c7e5::nxsui {
    struct NXSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NXSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NXSUI>(arg0, 9, b"NXSUI", b"Nexus Sui", b"EventTrader Sui launchpad first-light coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NXSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NXSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

