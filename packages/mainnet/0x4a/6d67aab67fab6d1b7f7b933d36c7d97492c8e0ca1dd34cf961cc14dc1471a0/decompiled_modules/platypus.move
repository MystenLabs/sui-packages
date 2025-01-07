module 0x4a6d67aab67fab6d1b7f7b933d36c7d97492c8e0ca1dd34cf961cc14dc1471a0::platypus {
    struct PLATYPUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLATYPUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLATYPUS>(arg0, 6, b"PLATYPUS", b"FRED PLATYPUS", b"Fred the fast and turbos platypus", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730988653629.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PLATYPUS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLATYPUS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

