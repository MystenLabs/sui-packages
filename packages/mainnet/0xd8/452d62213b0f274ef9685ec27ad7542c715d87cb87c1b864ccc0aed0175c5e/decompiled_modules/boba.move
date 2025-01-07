module 0xd8452d62213b0f274ef9685ec27ad7542c715d87cb87c1b864ccc0aed0175c5e::boba {
    struct BOBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOBA>(arg0, 6, b"Boba", b"BobaonSui", b"Killing it since 96", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734734680125.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOBA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOBA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

