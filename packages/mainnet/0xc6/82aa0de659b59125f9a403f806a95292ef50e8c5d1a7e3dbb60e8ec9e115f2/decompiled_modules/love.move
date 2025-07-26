module 0xc682aa0de659b59125f9a403f806a95292ef50e8c5d1a7e3dbb60e8ec9e115f2::love {
    struct LOVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOVE>(arg0, 6, b"Love", b"One Love Coin", x"4f6e65204c6f76652c204f6e65204e6174696f6e20616e64206a757374204f6e6520537569206e656564656420746f206765742075732074686572652070656570732e0a0a4f6e65204c6f7665", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1753546732304.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LOVE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOVE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

