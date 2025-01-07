module 0x49a9c7283ed40291b41078975fea8bb7e1b6e2f74eda29c61ffb4b9e628896d9::sproto {
    struct SPROTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPROTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPROTO>(arg0, 6, b"SPROTO", b"Sproto Gremlin", b"Welcome to $SPROTO Gremlins, the official mascot of HarryPotterObamaSonic10Inu! These mischievous creatures bring a playful edge, spreading energy, fun, and unstoppable meme magic.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0x2ac689cdcd3a865df42ee5fca11501b2c04ba247_26f8f07805.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPROTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPROTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

