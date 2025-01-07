module 0x5fa45a3776b1270a7f76736953a1ee247e24795c0428defc9d7d793d310c7a40::speedy {
    struct SPEEDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPEEDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPEEDY>(arg0, 6, b"SPEEDY", b"SPEEDYSUI", b"Introducing SPEEDY, the memecoin that's here to remind you that greatness comes not from rushing, but from steady, thoughtful progress.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/vecteezy_a_cartoon_turtle_with_blue_shell_and_black_eyes_50143556_f40be29abd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPEEDY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPEEDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

