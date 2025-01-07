module 0x23f46ec21f735e1cdbb8e48a4b3ed2dc6e4d61b41ae7c85079773284cecd4955::beast {
    struct BEAST has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEAST, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<BEAST>(arg0, 6, b"BEAST", b"Mrbeast.Ai by SuiAI", b"Have you ever asked what would MrBeast do. we built a trading bot based trained on Mrbeast videos.  This cutting-edge AI model has been trained on the internet's favorite philanthropist.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/mrbeast_optimized_e0af9fc6b7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BEAST>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEAST>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

