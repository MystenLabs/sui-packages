module 0xae2ca12eeb3bd61e2ca357da1fc6c1f75c751be1eb7514ea7f13b12ac4ecc87b::puff {
    struct PUFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUFF>(arg0, 6, b"PUFF", b"DIDDY THE PREDATOR", b"BUY NOW OR CRY LATER ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731600661565.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PUFF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUFF>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

