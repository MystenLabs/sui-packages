module 0xb486f702ad6b62630f404450818429c0c8b1487f25caf7ff41d71115179f223d::gish {
    struct GISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: GISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GISH>(arg0, 6, b"GISH", b"GISHER'S", b"$GISH is the official currency used by the Gisher community in Sui Land.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731007993049.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GISH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GISH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

