module 0x1eb298aab24109f29be453988b60b63d835c8d19785c85a136c1432f01606ea9::hachi {
    struct HACHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HACHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HACHI>(arg0, 6, b"HACHI", b"Hachikun Inu", b"Hachikun Inu isnt just another dog in the meme coin race were here to build a lasting legacy. Inspired by the legendary loyalty of Hachiko, were all about creating a tight knit community where every member feels valued and respected.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/APTOS_1_3e16a0662f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HACHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HACHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

