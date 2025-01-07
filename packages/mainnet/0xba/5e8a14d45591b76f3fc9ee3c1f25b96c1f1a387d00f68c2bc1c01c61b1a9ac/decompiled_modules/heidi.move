module 0xba5e8a14d45591b76f3fc9ee3c1f25b96c1f1a387d00f68c2bc1c01c61b1a9ac::heidi {
    struct HEIDI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HEIDI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HEIDI>(arg0, 9, b"HEIDI", b"Heidi cat", b"Heidicat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bcbab788-7915-45cc-9bf4-9587cedca3cf.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HEIDI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HEIDI>>(v1);
    }

    // decompiled from Move bytecode v6
}

