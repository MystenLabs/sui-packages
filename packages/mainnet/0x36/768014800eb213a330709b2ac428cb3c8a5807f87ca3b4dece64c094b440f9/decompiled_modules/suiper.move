module 0x36768014800eb213a330709b2ac428cb3c8a5807f87ca3b4dece64c094b440f9::suiper {
    struct SUIPER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPER>(arg0, 6, b"SUIPER", b"Suipercycle", b"Mascot of the supercycle. First AI agent on SUI powered by TopHat.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1733319913055.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIPER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPER>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

