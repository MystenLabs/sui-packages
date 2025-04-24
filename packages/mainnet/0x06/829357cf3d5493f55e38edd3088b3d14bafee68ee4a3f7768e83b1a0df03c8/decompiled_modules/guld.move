module 0x6829357cf3d5493f55e38edd3088b3d14bafee68ee4a3f7768e83b1a0df03c8::guld {
    struct GULD has drop {
        dummy_field: bool,
    }

    fun init(arg0: GULD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GULD>(arg0, 6, b"Guld", b"guld on Sui", b"looong ur guld cuz its ur best bet agenst inflation", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pump_IMG_4b6fc125ad.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GULD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GULD>>(v1);
    }

    // decompiled from Move bytecode v6
}

