module 0xd8f99fa4b9387d2aefb225b2c960e4cb0e2d549f790b70c9345a59e8ab24214::alphaai {
    struct ALPHAAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALPHAAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ALPHAAI>(arg0, 6, b"ALPHAAI", b"ALPHA AI by SuiAI", b"ALPHA AI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/images_13_e3d66f9fb6.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ALPHAAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALPHAAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

