module 0x1869534d2630d8aa560564726c3b29ac1b5b44de12e88a1daf3223c5b0f4fb42::mad {
    struct MAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAD>(arg0, 6, b"Mad", b"Mad Trump", b"Donald Trump as far back as the 1990s, but it's not really all that surprising. Although Trump wasn't elected president until 2016, he had already been a public figure for most of his life. In fact, shortly after he became president,Mad", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241027_222914_8efe0b6cbb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

