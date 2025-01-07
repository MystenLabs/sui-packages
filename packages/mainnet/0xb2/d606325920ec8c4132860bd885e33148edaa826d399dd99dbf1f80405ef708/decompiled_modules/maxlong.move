module 0xb2d606325920ec8c4132860bd885e33148edaa826d399dd99dbf1f80405ef708::maxlong {
    struct MAXLONG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAXLONG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAXLONG>(arg0, 6, b"MAXLONG", b"Max Long Sui", b"I'm Max. Max Long Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000031174_4068e7ac54.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAXLONG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAXLONG>>(v1);
    }

    // decompiled from Move bytecode v6
}

