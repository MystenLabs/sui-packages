module 0x98746f299d4a236bad12979a43f0a0231294d44f2ec55de09479c6d7c4da9f82::obamam {
    struct OBAMAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: OBAMAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OBAMAM>(arg0, 6, b"OBAMAM", b"Obamamid", b"Obamamid is staring into your soul calling you to buy some of this meme coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2324_ab1b6e9bb3.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OBAMAM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OBAMAM>>(v1);
    }

    // decompiled from Move bytecode v6
}

