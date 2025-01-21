module 0x7c5dbc462ee5e52994db7143ddb25122ce689ed09029d46ff8e594752844f164::ai {
    struct AI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AI>(arg0, 6, b"AI", b"AI BackEnd", b"Just a AI who going to 10M.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0xaa228b0e90f6e7748795bf2e2c0f219aafe95af7b0ce55e9c5bbff0f6e1bfb11_beth_beth_fb75f5ea14.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AI>>(v1);
    }

    // decompiled from Move bytecode v6
}

