module 0x863bff726664c947c5897ee89cd8daf468c21de3950eb26f4fa49237690f8956::lee {
    struct LEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: LEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LEE>(arg0, 6, b"LEE", b"$LEE", b"LEE's a meme coin on SUI for those who get it. No roadmap just pure, unfiltered fun.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/freepik_retouch_44125_c4415fb7b4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LEE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LEE>>(v1);
    }

    // decompiled from Move bytecode v6
}

