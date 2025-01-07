module 0x88a16cee29cc83c5f5a2d04ba4efd88576e6deca646fbb1c6d32ff2d552611fc::suitrump {
    struct SUITRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITRUMP>(arg0, 6, b"SUITRUMP", b"SUI TRUMP", b"Surf the SUI wave with SUITRUMP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730962526177.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUITRUMP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITRUMP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

