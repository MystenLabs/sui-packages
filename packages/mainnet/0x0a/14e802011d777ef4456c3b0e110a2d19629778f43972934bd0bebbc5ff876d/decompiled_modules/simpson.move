module 0xa14e802011d777ef4456c3b0e110a2d19629778f43972934bd0bebbc5ff876d::simpson {
    struct SIMPSON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIMPSON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIMPSON>(arg0, 6, b"SIMPSON", b"Homer Simpson", b"Homer $Simpson - The Meme Coin that will make you say \"Woo Hoo!\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/download_648954282a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIMPSON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIMPSON>>(v1);
    }

    // decompiled from Move bytecode v6
}

