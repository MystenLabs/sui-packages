module 0x8aa81f1ca9233c1ab7ed9144067a1ee0f2efab5b4d1c2ac2f3f048f8cdbc69b7::ink {
    struct INK has drop {
        dummy_field: bool,
    }

    fun init(arg0: INK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<INK>(arg0, 9, b"INK", b"INK", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<INK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<INK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

