module 0x3cd354cbd7931bf80de3976670df8ccd434e61281f232d0b39ff2af116e9a2c4::rage {
    struct RAGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAGE>(arg0, 6, b"RAGE", b"Rage", b"Do if for the gram", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/png_clipart_anime_character_internet_meme_rage_comic_trollface_internet_troll_meme_white_face_thumbnail_7a7b59c219.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RAGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

