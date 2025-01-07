module 0x77513ac4ff864c5b69a87a985c66711374c049f3fa74c442ada996df85e8b61d::goatseusmaximus {
    struct GOATSEUSMAXIMUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOATSEUSMAXIMUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOATSEUSMAXIMUS>(arg0, 6, b"GoatseusMaximus", b"GOAT", b"it's happening", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Snipaste_2024_10_13_13_37_01_baa9fb0a66.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOATSEUSMAXIMUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOATSEUSMAXIMUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

