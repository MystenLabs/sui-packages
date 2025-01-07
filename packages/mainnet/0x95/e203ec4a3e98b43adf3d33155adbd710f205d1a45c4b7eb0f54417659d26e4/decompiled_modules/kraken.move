module 0x95e203ec4a3e98b43adf3d33155adbd710f205d1a45c4b7eb0f54417659d26e4::kraken {
    struct KRAKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: KRAKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KRAKEN>(arg0, 6, b"KRAKEN", b"Kraken AI Agent", b"no FOMO, just dominance", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736254756973.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KRAKEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KRAKEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

