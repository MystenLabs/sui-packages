module 0x62f492d710b433430f0b0b8c7e5509a364875b02ea06392eabc5ab7e23dfcfdf::dinoinu {
    struct DINOINU has drop {
        dummy_field: bool,
    }

    fun init(arg0: DINOINU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DINOINU>(arg0, 6, b"DINOINU", b"DINO INU", b"Of course every dinosaurs are big. Every body knows that, but there was just one dinosaur that is small. DinoINu wasn't big but has bigger dream.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_28_02_26_29_7502e2d35e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DINOINU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DINOINU>>(v1);
    }

    // decompiled from Move bytecode v6
}

