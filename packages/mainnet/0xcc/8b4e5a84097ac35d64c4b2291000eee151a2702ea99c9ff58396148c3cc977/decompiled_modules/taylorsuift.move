module 0xcc8b4e5a84097ac35d64c4b2291000eee151a2702ea99c9ff58396148c3cc977::taylorsuift {
    struct TAYLORSUIFT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TAYLORSUIFT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TAYLORSUIFT>(arg0, 6, b"TaylorSuift", b"TAYLOR SUIFT", x"54484520515545454e204f4620535549210a434f4d4d554e4954592054414b45204f56455220544f4b454e210a4e4f20534f4349414c532121200a53454e442054484953204d41544841462a434b41212121", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Polish_20241116_185517750_3b11a7649f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TAYLORSUIFT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TAYLORSUIFT>>(v1);
    }

    // decompiled from Move bytecode v6
}

