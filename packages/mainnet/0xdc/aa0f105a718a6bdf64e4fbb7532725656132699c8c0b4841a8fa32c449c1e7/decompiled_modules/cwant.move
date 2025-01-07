module 0xdcaa0f105a718a6bdf64e4fbb7532725656132699c8c0b4841a8fa32c449c1e7::cwant {
    struct CWANT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CWANT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CWANT>(arg0, 6, b"CWANT", b"MY CWANT", b"A tiny fluffball with big, shiny eyes and endless mischief. Always chasing coins and spreading pawsitive vibes in the crypto world!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_11_21_03_47_39_389ac4b914.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CWANT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CWANT>>(v1);
    }

    // decompiled from Move bytecode v6
}

