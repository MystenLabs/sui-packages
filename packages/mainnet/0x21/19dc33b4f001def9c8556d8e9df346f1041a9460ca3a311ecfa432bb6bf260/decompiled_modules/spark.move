module 0x2119dc33b4f001def9c8556d8e9df346f1041a9460ca3a311ecfa432bb6bf260::spark {
    struct SPARK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPARK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPARK>(arg0, 6, b"SPARK", b"Spark AI", b"The first all in One AI Agent & Insured Financial Advisor.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734618175575.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPARK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPARK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

