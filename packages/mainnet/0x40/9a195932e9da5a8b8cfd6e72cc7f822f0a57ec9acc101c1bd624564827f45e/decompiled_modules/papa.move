module 0x409a195932e9da5a8b8cfd6e72cc7f822f0a57ec9acc101c1bd624564827f45e::papa {
    struct PAPA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAPA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAPA>(arg0, 6, b"PAPA", b"PAPA LOFI", b"Papa Lofi is not happy lofi the yeti was supposed to attend college not run off for fame! Papa will catch him! Socials will be listed here", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5952_751ee8da29.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAPA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PAPA>>(v1);
    }

    // decompiled from Move bytecode v6
}

