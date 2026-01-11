module 0x96d8220a7d6ec53fa7df06f91d4585cac612c55e106273ad91abfe6625381422::donga {
    struct DONGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DONGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DONGA>(arg0, 6, b"DONGA", b"DON GARFIELD", b"GARFIEL IN THE SEA.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1768089526889.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DONGA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DONGA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

