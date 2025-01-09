module 0x8748bbe8942470f956d22d4e62161d38a87c51c5f43ea26487537d0a15d8a45::kado {
    struct KADO has drop {
        dummy_field: bool,
    }

    fun init(arg0: KADO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KADO>(arg0, 6, b"KADO", b"Kado Money", b"The easiest way to buy, sell, and spend crypto. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736441988343.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KADO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KADO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

