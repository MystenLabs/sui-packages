module 0xc13d113c671a9d2804e18828be2fb9788930191a85aea2b4d009c5c129f5ca10::shifty {
    struct SHIFTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIFTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIFTY>(arg0, 6, b"SHIFTY", b"SUITTY", b"gotta be smoooth", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/download_ed1b6ce047.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIFTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHIFTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

