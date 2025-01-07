module 0x819c13bb2701f2da0c8a03b7f6166eed5865bd5c493c59f14669b1a591def139::sp500 {
    struct SP500 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SP500, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SP500>(arg0, 6, b"SP500", b"Satoshi & Pussy 500", b"S&P500 (Satoshi and pussy 500)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1025_4f3ae673bd.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SP500>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SP500>>(v1);
    }

    // decompiled from Move bytecode v6
}

