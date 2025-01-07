module 0xb08b7f45f248b9341a7ece5aa1dc207790545aa9dd213b18b652b2aa3df2e09a::bert {
    struct BERT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BERT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BERT>(arg0, 6, b"BERT", b"Dogbert", b"Dogbert is Satoshi Nakamoto!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/png_transparent_dogbert_jake_the_dog_art_dilbert_elbonia_dog_draw_smiley_emoticon_jake_the_dog_thumbnail_removebg_preview_47f4c4df89.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BERT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BERT>>(v1);
    }

    // decompiled from Move bytecode v6
}

