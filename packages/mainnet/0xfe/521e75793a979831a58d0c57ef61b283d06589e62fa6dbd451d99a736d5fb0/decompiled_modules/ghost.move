module 0xfe521e75793a979831a58d0c57ef61b283d06589e62fa6dbd451d99a736d5fb0::ghost {
    struct GHOST has drop {
        dummy_field: bool,
    }

    fun init(arg0: GHOST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GHOST>(arg0, 6, b"Ghost", x"47686f73742048616c6c6f7765656e20f09f8e83", x"47686f73742048616c6c6f7765656e20244748414c20636f6d696e6720746f205355490a54673a2068747470733a2f2f742e6d652f2b2d4445653934765a447941784e6a686c0a576562736974653a2068747470733a2f2f67686f73742d68616c6c6f7765656e2e636f2e696e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730953581905.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GHOST>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GHOST>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

