module 0x9f82b0a8c9ca42c35e33aad7ca3de961f9bdf3ab81abf1c3119a8f6b0263f91e::suichiro {
    struct SUICHIRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICHIRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICHIRO>(arg0, 6, b"SUICHIRO", b"Suichiro", b"Suichiro is all about good vibes, chill times, and smooth transactions.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/h_Jvxqs_Fd_400x400_c985cf12ac.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICHIRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICHIRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

