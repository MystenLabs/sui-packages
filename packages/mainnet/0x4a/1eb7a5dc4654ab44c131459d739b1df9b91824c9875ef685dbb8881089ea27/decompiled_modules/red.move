module 0x4a1eb7a5dc4654ab44c131459d739b1df9b91824c9875ef685dbb8881089ea27::red {
    struct RED has drop {
        dummy_field: bool,
    }

    fun init(arg0: RED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RED>(arg0, 6, b"RED", b"REDWAVE", b"$RED TO $10M MC BY 11/05/2024", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/B51_D8_F03_11_FB_4_C1_B_9_D9_A_977_F5_AF_64382_76da0e1782.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RED>>(v1);
    }

    // decompiled from Move bytecode v6
}

