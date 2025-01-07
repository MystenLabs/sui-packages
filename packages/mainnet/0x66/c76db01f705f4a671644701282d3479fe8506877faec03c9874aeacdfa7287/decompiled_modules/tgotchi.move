module 0x66c76db01f705f4a671644701282d3479fe8506877faec03c9874aeacdfa7287::tgotchi {
    struct TGOTCHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TGOTCHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TGOTCHI>(arg0, 6, b"TGOTCHI", b"TAMAGOTCHI", b"Welcome To The Best Next MemeCoin ! #Tamagotchi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731257471984.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TGOTCHI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TGOTCHI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

