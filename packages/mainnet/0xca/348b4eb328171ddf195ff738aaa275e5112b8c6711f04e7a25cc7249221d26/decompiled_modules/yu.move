module 0xca348b4eb328171ddf195ff738aaa275e5112b8c6711f04e7a25cc7249221d26::yu {
    struct YU has drop {
        dummy_field: bool,
    }

    fun init(arg0: YU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YU>(arg0, 6, b"YU", b"YUKI", b"Yuki, a cat from the Sui Heavens.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/211_0ae9cf90ae.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YU>>(v1);
    }

    // decompiled from Move bytecode v6
}

