module 0x695846ac1315ea04a39b70a4f03c2c773461535274d8ddd07deb6d81268583a::mtrump {
    struct MTRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: MTRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MTRUMP>(arg0, 6, b"MTRUMP", b"Melania Trump Sui", b"Do you miss TRUMP? Now Melania is bullish meme!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/92348815_gettyimages_621308234_jpg_c813dca326.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MTRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MTRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

