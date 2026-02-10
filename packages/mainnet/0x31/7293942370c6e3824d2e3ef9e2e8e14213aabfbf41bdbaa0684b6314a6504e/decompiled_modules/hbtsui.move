module 0x317293942370c6e3824d2e3ef9e2e8e14213aabfbf41bdbaa0684b6314a6504e::hbtsui {
    struct HBTSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HBTSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HBTSUI>(arg0, 9, b"HBTSUI", b"HeartbeatSui", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HBTSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HBTSUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

