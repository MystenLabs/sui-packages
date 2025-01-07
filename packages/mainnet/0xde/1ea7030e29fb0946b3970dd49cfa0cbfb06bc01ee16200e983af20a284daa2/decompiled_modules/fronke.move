module 0xde1ea7030e29fb0946b3970dd49cfa0cbfb06bc01ee16200e983af20a284daa2::fronke {
    struct FRONKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRONKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRONKE>(arg0, 6, b"Fronke", b"fronke", b"I like banana's", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2_1_scaled_1_6a397d7676.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRONKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FRONKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

