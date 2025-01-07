module 0x6058aeb4503dcc8872c9cff1a0ddf24c765b8b59f975949d06d78f3a8172daa8::sensui {
    struct SENSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SENSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SENSUI>(arg0, 6, b"SENSUI", b"SenSui", b"Master the blockchain with SenSui, inspired by Sensei", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sensui_logo_6d4d41d5ea.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SENSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SENSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

