module 0x5b6b7998e9e4d28db0a14ee91bb675332b65facdf8252d04ccb7a3383aee3968::tgotchi {
    struct TGOTCHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TGOTCHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TGOTCHI>(arg0, 6, b"TGOTCHI", b"TAMAGOTCHI", b"Welcome to the best next MemeCoin !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731257598267.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TGOTCHI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TGOTCHI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

