module 0x4aae7710cb4370b014e4e6dfedfb3634c553cd7743ae31a5d3a52055cb505fe0::glacia {
    struct GLACIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GLACIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GLACIA>(arg0, 6, b"GLACIA", b"Glacia The Yeti", b"GLACIA is a playful meme token featuring a fun-loving, energetic Yeti from the icy peaks! Unlike ordinary Yetis, GLACIA brings joy, laughter, and surprises to the crypto world. With a laid-back but lively attitude, GLACIA invites the community to ride ...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000048888_6aaa1f7126.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GLACIA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GLACIA>>(v1);
    }

    // decompiled from Move bytecode v6
}

