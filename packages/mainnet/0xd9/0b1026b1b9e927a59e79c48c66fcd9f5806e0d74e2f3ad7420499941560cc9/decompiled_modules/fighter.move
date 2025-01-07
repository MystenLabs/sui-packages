module 0xd90b1026b1b9e927a59e79c48c66fcd9f5806e0d74e2f3ad7420499941560cc9::fighter {
    struct FIGHTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIGHTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FIGHTER>(arg0, 6, b"FIGHTER", b"FIGHTER DOG", b"THIS VIRAL DOG MEME ON INTERNET ABOUT TO BLOW UP SOON", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2219_1213411000.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIGHTER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FIGHTER>>(v1);
    }

    // decompiled from Move bytecode v6
}

