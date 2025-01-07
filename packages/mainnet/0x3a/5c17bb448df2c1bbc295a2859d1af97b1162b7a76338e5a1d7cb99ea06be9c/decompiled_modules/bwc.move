module 0x3a5c17bb448df2c1bbc295a2859d1af97b1162b7a76338e5a1d7cb99ea06be9c::bwc {
    struct BWC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BWC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BWC>(arg0, 6, b"BWC", b"Black Myth Wukong", b"Meme token on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9414_2ea2cf66e8.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BWC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BWC>>(v1);
    }

    // decompiled from Move bytecode v6
}

