module 0x82968cd1140fb2bef75d37da1cfc3d2913be5c8d1631e6f7a2f8a0bc9e3c4c98::lowkey {
    struct LOWKEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOWKEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOWKEY>(arg0, 6, b"Lowkey", b"Lowkey ", b"Innit", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1738903248194.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LOWKEY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOWKEY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

