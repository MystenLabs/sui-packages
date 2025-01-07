module 0x9f23cbb891a670b9fb2685dadf304f2e4508ce6f1a76db37c2acd0d374155ab7::skatebag {
    struct SKATEBAG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKATEBAG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKATEBAG>(arg0, 6, b"SKATEBAG", b"skate baguette sui", b"skate baguette on sui hehehe ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241204_112900_750_35118ae106.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKATEBAG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SKATEBAG>>(v1);
    }

    // decompiled from Move bytecode v6
}

