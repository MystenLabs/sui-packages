module 0xbd3e418d1eabffbd3432317d28d64ef45a3939e2da80837140807240b127232b::ask {
    struct ASK has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASK>(arg0, 6, b"ASK", b"ASUIKA", b"\"Hey, senpai,\" she said, using the honorific title with a playful smile. \"I've been watching $SUI, and I'm torn. Is it bearish or bullish?\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/asuika_8f11b08075.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ASK>>(v1);
    }

    // decompiled from Move bytecode v6
}

