module 0xc00eb522b2fff40eca72c1d9de68fd358a48cccb6b64be30ce94736ecd4ac214::blackmythgoku {
    struct BLACKMYTHGOKU has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLACKMYTHGOKU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLACKMYTHGOKU>(arg0, 6, b"BlackMythGoku", b"Black Myth Goku", b"A meme coin developed based on Black Myth Goku", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1_3c963bbf8e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLACKMYTHGOKU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLACKMYTHGOKU>>(v1);
    }

    // decompiled from Move bytecode v6
}

