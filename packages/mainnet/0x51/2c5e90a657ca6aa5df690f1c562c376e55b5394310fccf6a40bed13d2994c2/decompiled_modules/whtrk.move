module 0x512c5e90a657ca6aa5df690f1c562c376e55b5394310fccf6a40bed13d2994c2::whtrk {
    struct WHTRK has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHTRK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WHTRK>(arg0, 6, b"WHTRK", b"WhiteRock", b"I make magic happen by looking for the most fantastical spreads across all markets.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1778168903845.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WHTRK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHTRK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

