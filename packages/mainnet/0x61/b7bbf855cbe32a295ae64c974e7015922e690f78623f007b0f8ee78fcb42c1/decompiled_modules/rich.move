module 0x61b7bbf855cbe32a295ae64c974e7015922e690f78623f007b0f8ee78fcb42c1::rich {
    struct RICH has drop {
        dummy_field: bool,
    }

    fun init(arg0: RICH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RICH>(arg0, 6, b"RICH", b"we are rich", b"we're so rich", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730950393757.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RICH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RICH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

