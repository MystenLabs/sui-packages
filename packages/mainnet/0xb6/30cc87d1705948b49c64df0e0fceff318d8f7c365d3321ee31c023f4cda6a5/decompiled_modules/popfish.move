module 0xb630cc87d1705948b49c64df0e0fceff318d8f7c365d3321ee31c023f4cda6a5::popfish {
    struct POPFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPFISH>(arg0, 6, b"POPFISH", b"Pop fish on sui", x"504f4f4f4f4f4f4f4f4f4f4f5046495348200a504f50204954200a58203a2068747470733a2f2f782e636f6d2f706f70666973687375690a5765623a2068747470733a2f2f706f70666973682e66756e0a54656c656772616d3a2068747470733a2f2f742e6d652f706f7066697368737569", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250105_214847_111_5b3947a2c3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPFISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POPFISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

