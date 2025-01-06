module 0xc39818e080aa9f9d21fb77abcc796d566a1d33906cc6cf0a0a1fbc4fc0304b1a::sonex {
    struct SONEX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SONEX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SONEX>(arg0, 6, b"SONEX", b"Sonex", b"Sonex  is a memecoin built on the Sui blockchain, designed to entertain and connect the global crypto community. Sonex Coin combines humor, creativity, and advanced technology from the Sui ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20250106_211343_53e8b277c4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SONEX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SONEX>>(v1);
    }

    // decompiled from Move bytecode v6
}

