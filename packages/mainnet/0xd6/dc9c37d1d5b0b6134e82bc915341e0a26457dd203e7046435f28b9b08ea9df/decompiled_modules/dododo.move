module 0xd6dc9c37d1d5b0b6134e82bc915341e0a26457dd203e7046435f28b9b08ea9df::dododo {
    struct DODODO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DODODO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DODODO>(arg0, 6, b"DODODO", b"DODODODO", b"The other token it's a scam, but i think this fits right on sui. Fuck the scammers", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/songs_babyshark_thumbnail_supersimpleapp_en_1200w_blog_1d0d7c978f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DODODO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DODODO>>(v1);
    }

    // decompiled from Move bytecode v6
}

