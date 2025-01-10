module 0x58463ea48def4695294de01da2c360c1c3cca888cd915811ca37cb85bb26836e::haibot {
    struct HAIBOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAIBOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAIBOT>(arg0, 6, b"HAIBOT", b"HAPPY AI", b"ASK EVERYTHING TO HAPPY BOT!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/happy_face_lol_comm_templates_trollface_rage_comic_internet_troll_know_your_meme_internet_forum_internet_meme_1a944bfc03.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAIBOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HAIBOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

