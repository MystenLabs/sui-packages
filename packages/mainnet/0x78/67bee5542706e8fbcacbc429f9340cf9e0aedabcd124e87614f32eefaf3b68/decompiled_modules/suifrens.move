module 0x7867bee5542706e8fbcacbc429f9340cf9e0aedabcd124e87614f32eefaf3b68::suifrens {
    struct SUIFRENS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIFRENS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIFRENS>(arg0, 6, b"SUIFRENS", b"SUI Friens", b"The most adorable meme coin from sui network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000020819_4a058d6a78.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIFRENS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIFRENS>>(v1);
    }

    // decompiled from Move bytecode v6
}

