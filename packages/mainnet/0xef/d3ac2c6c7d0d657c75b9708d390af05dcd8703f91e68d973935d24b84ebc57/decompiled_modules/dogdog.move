module 0xefd3ac2c6c7d0d657c75b9708d390af05dcd8703f91e68d973935d24b84ebc57::dogdog {
    struct DOGDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGDOG>(arg0, 6, b"DOGDOG", b"SUIDOG", b"SUNDOG Satoshi Nakamoto anonymously initiates MEME", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000016479_a13209618a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

