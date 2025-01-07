module 0xa0f5ce898f4931784885ca06be1b567ed6d6aa984fbd5a278d283776ce89079f::fpi {
    struct FPI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FPI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FPI>(arg0, 6, b"FPI", b"Front ", b"Coin Front Pembela Islam (CFPI) is a digital currency designed to align with Islamic finance principles, utilizing blockchain to support ethical transactions. CFPI ensures compliance with values like *riba* (interest-free) and *gharar* (avoiding unce", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731020652812.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FPI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FPI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

