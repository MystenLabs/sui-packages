module 0x74310da58573fe34bd2643d5c1d2924ee4ceefd07dcf9320542a196414a44b23::suios {
    struct SUIOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIOS>(arg0, 6, b"SUIOS", b"SUIOS SUI", b"SUIOS IS THE MEME BEST OF SUI. WE ARE MAKE MOVEPUMP GREAT AGAIN AND SUIOS CAN DO THAT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0x22231a114bb2e9379fd8e33a6442cbcd26b3410c67918cd80faef04d32ea165a_suios_suios_bc8886f1ac.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

