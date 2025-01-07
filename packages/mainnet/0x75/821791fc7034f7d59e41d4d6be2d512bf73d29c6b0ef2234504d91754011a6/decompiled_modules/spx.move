module 0x75821791fc7034f7d59e41d4d6be2d512bf73d29c6b0ef2234504d91754011a6::spx {
    struct SPX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPX>(arg0, 6, b"SPX", b"SPX6900", b"SPX6900 on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731050836187.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPX>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

