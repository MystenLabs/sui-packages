module 0x2f401da86f551f8eea1ff063e84f83327016ff5e50b4a006026b3f3620f38741::hatter {
    struct HATTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: HATTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HATTER>(arg0, 6, b"HATTER", b"MAD HATTER", b"$HATTER isnt about hype or empty promises; its about the people behind the project. With transparency at our core and a strong, loyal community, we aim to redefine what a meme coin can be. Join us as we grow together in this exciting, grassroots journey.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Hatter_acd2647c83.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HATTER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HATTER>>(v1);
    }

    // decompiled from Move bytecode v6
}

