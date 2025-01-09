module 0xbbeac1ef49f43f599314d11e4fedaa0ee1e18b6f05116febb2e0ad516cd17e3c::sylvi {
    struct SYLVI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SYLVI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SYLVI>(arg0, 6, b"SYLVI", b"SYLVI AGENT", b"First advanced ai monitoring agent on Sui. Real-time sentiment analysis and market intelligence at 80-90%.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736409418335.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SYLVI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SYLVI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

