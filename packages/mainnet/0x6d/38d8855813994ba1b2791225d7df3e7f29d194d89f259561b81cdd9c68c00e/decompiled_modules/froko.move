module 0x6d38d8855813994ba1b2791225d7df3e7f29d194d89f259561b81cdd9c68c00e::froko {
    struct FROKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FROKO>(arg0, 6, b"FROKO", b"Froko", b"Another frog another story", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2024_10_16_at_17_01_26_e1b1f17610.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FROKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FROKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

