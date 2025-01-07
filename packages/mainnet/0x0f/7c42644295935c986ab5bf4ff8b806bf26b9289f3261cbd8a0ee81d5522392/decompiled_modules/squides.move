module 0xf7c42644295935c986ab5bf4ff8b806bf26b9289f3261cbd8a0ee81d5522392::squides {
    struct SQUIDES has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQUIDES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQUIDES>(arg0, 6, b"SQUIDES", b"SQUIDE", b"SQUIDE SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Mm_Kigj_Ro_400x400_2061423ad1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQUIDES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SQUIDES>>(v1);
    }

    // decompiled from Move bytecode v6
}

