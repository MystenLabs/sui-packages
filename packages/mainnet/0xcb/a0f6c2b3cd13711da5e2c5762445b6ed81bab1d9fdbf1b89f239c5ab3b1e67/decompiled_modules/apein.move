module 0xcba0f6c2b3cd13711da5e2c5762445b6ed81bab1d9fdbf1b89f239c5ab3b1e67::apein {
    struct APEIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: APEIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<APEIN>(arg0, 6, b"APEIN", b"Ape In", b"Ape In (APEIN) is a revolutionary meme-driven cryptocurrency that transforms primate-inspired humor into a serious blockchain ecosystem. Our mission: democratize crypto investing through playful, accessible technology.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732909912471.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<APEIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APEIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

