module 0x240010cec35db495214f83c246cd544e91b19af104657d11b7dc937b5dbc58c9::drez {
    struct DREZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: DREZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DREZ>(arg0, 6, b"DREZ", b"Drez Devil", b"Drez the devil is taking over  the meme coin world", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000002022_36e95dad83.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DREZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DREZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

