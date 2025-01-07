module 0x80a4b8e2fbc6b5741a301e2295e431c3ca54ad7ff0b20291c433c05cb53b35ce::shork {
    struct SHORK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHORK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHORK>(arg0, 6, b"SHORK", b"Shork", x"5269646520746865205761766520f09fa688f09f8c8a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731369287970.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHORK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHORK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

