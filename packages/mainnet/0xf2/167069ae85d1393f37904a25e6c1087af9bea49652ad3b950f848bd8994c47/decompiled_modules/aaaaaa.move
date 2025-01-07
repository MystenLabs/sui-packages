module 0xf2167069ae85d1393f37904a25e6c1087af9bea49652ad3b950f848bd8994c47::aaaaaa {
    struct AAAAAA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAAAA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAAAA>(arg0, 6, b"AAAAAA", b"aaaBeaver", b"It's aaaBevaer, beaver is known meme.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_7abe9db602_369ad2ceb9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAAAA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAAAAA>>(v1);
    }

    // decompiled from Move bytecode v6
}

