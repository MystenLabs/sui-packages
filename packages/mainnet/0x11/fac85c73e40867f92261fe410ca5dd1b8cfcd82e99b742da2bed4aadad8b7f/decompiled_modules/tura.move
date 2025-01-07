module 0x11fac85c73e40867f92261fe410ca5dd1b8cfcd82e99b742da2bed4aadad8b7f::tura {
    struct TURA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TURA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TURA>(arg0, 6, b"TURA", b"TURBO RANGER", b"Its Turbo time", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730956145219.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TURA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TURA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

