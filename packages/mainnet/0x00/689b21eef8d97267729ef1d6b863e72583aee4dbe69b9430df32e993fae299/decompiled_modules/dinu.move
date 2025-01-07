module 0x689b21eef8d97267729ef1d6b863e72583aee4dbe69b9430df32e993fae299::dinu {
    struct DINU has drop {
        dummy_field: bool,
    }

    fun init(arg0: DINU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DINU>(arg0, 6, b"DINU", b"DINO INU", b"Of course every dinosaurs are big. Every body knows that, but there was just one dinosaur that is small. DinoINu wasn't big but has bigger dream.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_28_02_26_29_42ef48227d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DINU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DINU>>(v1);
    }

    // decompiled from Move bytecode v6
}

