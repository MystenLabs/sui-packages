module 0x90094b50260eb175428a2e978d4ac2d86267eddb2a9c9f347e59022ad3f3385c::buy {
    struct BUY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUY>(arg0, 6, b"BUY", b"Buy Me", b"Just Buy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000105374_2766e4286b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUY>>(v1);
    }

    // decompiled from Move bytecode v6
}

