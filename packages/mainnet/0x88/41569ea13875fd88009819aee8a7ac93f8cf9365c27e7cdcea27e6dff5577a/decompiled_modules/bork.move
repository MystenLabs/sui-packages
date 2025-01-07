module 0x8841569ea13875fd88009819aee8a7ac93f8cf9365c27e7cdcea27e6dff5577a::bork {
    struct BORK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BORK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BORK>(arg0, 6, b"BORK", b"SuiBork", x"436f6d6d756e6974792064726976656e207765623320746f6b656e202620234d656d65636f696e206261636b65640a56616c696461746f7220666f7220537569", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9548_cd657d2d24.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BORK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BORK>>(v1);
    }

    // decompiled from Move bytecode v6
}

