module 0x7967bfabec9da15e36454b9d0b0f03c3f2b47964a555ec39cf575dc71afbf4dc::suidino {
    struct SUIDINO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDINO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDINO>(arg0, 6, b"Suidino", b"Sui dino", b"Arrgghhhh", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1428_159cda34a6.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDINO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDINO>>(v1);
    }

    // decompiled from Move bytecode v6
}

