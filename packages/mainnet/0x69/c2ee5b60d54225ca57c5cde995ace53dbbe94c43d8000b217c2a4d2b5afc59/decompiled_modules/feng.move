module 0x69c2ee5b60d54225ca57c5cde995ace53dbbe94c43d8000b217c2a4d2b5afc59::feng {
    struct FENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FENG>(arg0, 6, b"Feng", b"Feng-Sui", b"Welcome to Feng-Sui!  Feel the harmony, balance, and positive vibes in our space! $FENGSUI https://t.me/fengsuicoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3052_f6cbaf5acf.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

