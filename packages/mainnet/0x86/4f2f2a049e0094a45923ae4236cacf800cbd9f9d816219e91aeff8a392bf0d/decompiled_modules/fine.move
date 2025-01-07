module 0x864f2f2a049e0094a45923ae4236cacf800cbd9f9d816219e91aeff8a392bf0d::fine {
    struct FINE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FINE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FINE>(arg0, 6, b"FINE", b"This is Fine", b"This is Fine is an iconic meme created by KC Green's 2013 six-panel comic On Fire ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2024_10_14_15_29_10_4c5f464c4d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FINE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FINE>>(v1);
    }

    // decompiled from Move bytecode v6
}

