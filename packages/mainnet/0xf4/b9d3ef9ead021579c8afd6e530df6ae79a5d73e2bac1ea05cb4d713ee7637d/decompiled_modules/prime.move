module 0xf4b9d3ef9ead021579c8afd6e530df6ae79a5d73e2bac1ea05cb4d713ee7637d::prime {
    struct PRIME has drop {
        dummy_field: bool,
    }

    fun init(arg0: PRIME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRIME>(arg0, 6, b"PRIME", b"Prime Objects", b"Owned Objects < Shared Objects < Prime Objects (IYKYK)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730971059894.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PRIME>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRIME>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

