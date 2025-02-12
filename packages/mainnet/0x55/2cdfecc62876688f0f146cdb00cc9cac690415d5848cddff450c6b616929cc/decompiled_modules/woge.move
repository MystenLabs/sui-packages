module 0x552cdfecc62876688f0f146cdb00cc9cac690415d5848cddff450c6b616929cc::woge {
    struct WOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOGE>(arg0, 6, b"WOGE", b"Wings Of Doge", b"Just a messing around MEME I promised to make for someone", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/WOGE_647fdbb661.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WOGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

