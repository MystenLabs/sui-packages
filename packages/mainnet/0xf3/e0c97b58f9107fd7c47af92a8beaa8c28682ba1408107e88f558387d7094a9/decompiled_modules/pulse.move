module 0xf3e0c97b58f9107fd7c47af92a8beaa8c28682ba1408107e88f558387d7094a9::pulse {
    struct PULSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PULSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PULSE>(arg0, 6, b"Pulse", b"Pulse on sui", b"Pulse ON SUI community today and be part of the next wave of meme token success on the SUI blockchain. Get ready for a journey full of laughter, innovation, and opportunity!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2_2356a2cef9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PULSE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PULSE>>(v1);
    }

    // decompiled from Move bytecode v6
}

