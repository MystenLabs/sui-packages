module 0x9d66f025232b518d63f71f3e56347072682fdc5b3800202f80b9c23c2500c305::sadsuik {
    struct SADSUIK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SADSUIK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SADSUIK>(arg0, 6, b"SADSUIK", b"Sad SUI Keanu ", b"Sad Keanu is here on SUI. Can you make him smile?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1738791025777.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SADSUIK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SADSUIK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

