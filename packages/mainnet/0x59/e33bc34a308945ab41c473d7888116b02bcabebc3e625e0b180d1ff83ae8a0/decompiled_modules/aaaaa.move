module 0x59e33bc34a308945ab41c473d7888116b02bcabebc3e625e0b180d1ff83ae8a0::aaaaa {
    struct AAAAA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAAA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAAA>(arg0, 6, b"AAAAA", b"aaaBeaver", b"It's aaaBevaer, beaver is known meme.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_7abe9db602.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAAA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAAAA>>(v1);
    }

    // decompiled from Move bytecode v6
}

