module 0x40a23537281a7a45a70ad196b76efbee81311b3d9a7cbc110a7beff598a0ef1::fishy {
    struct FISHY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FISHY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FISHY>(arg0, 6, b"FISHY", b"FISHY on me", x"4669736879206f6e206d6520697427732074686520666973687920746f206265200a0a68747470733a2f2f796f7574752e62652f5a436c755f49365536614d3f73693d7431544258306e646c47635633655932", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000058598_c471223de2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FISHY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FISHY>>(v1);
    }

    // decompiled from Move bytecode v6
}

