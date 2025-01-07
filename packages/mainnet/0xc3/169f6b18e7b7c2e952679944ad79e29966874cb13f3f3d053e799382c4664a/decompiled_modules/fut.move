module 0xc3169f6b18e7b7c2e952679944ad79e29966874cb13f3f3d053e799382c4664a::fut {
    struct FUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUT>(arg0, 6, b"Fut", b"The future", b"The future is gonna be fantastic", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000010684_ce6bbd184c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUT>>(v1);
    }

    // decompiled from Move bytecode v6
}

