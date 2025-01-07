module 0x22b135135a7e4396dcabc14780f55391de67afc7693dec1b0f9d12a84d3ceab1::gsr {
    struct GSR has drop {
        dummy_field: bool,
    }

    fun init(arg0: GSR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GSR>(arg0, 6, b"GSR", b"Gigantic Sui Rebirth", b"Gigantic Sui Rebirth is about to come ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_8874_878a886f28.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GSR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GSR>>(v1);
    }

    // decompiled from Move bytecode v6
}

