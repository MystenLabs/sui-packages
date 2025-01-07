module 0xd58b409de6b3a1bb6a69589f6fd6822ee91e2c8525070504afcb79f5e0879a3e::squib {
    struct SQUIB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQUIB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQUIB>(arg0, 6, b"SQUIB", b"Squib", b"Tiny squid, big splash.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_29_11_48_03_28f5865e0f.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQUIB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SQUIB>>(v1);
    }

    // decompiled from Move bytecode v6
}

