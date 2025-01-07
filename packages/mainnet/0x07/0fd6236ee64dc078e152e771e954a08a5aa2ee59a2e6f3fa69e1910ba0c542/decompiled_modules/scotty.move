module 0x70fd6236ee64dc078e152e771e954a08a5aa2ee59a2e6f3fa69e1910ba0c542::scotty {
    struct SCOTTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCOTTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCOTTY>(arg0, 6, b"SCOTTY", b"Scotty The Ai", b"In the vast and complex world of cryptocurrency, there existed a legend of a dog named Scotty the AI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Suc_Kl_VS_4_400x400_9b7b618b3a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCOTTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCOTTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

