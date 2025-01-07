module 0xbbe2814f6faaf3f9577f8dfec6f323f102f33b6a9c16af4a7deddcf5d5d61301::bga {
    struct BGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BGA>(arg0, 6, b"BGA", b"Bugna MEME", b"A Flying Meme Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0069_c372a9e6a4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

