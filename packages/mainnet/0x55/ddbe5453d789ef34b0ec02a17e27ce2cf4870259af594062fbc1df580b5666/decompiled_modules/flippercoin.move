module 0x55ddbe5453d789ef34b0ec02a17e27ce2cf4870259af594062fbc1df580b5666::flippercoin {
    struct FLIPPERCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLIPPERCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLIPPERCOIN>(arg0, 6, b"FLIPPERCOIN", b"Fliper Coin", b"Meet $FLIPPERCOIN! The meme-flipping dolphin! https://t.me/flipperflips https://flippercoin.no https://x.com/Flipper_MEME", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/36456_62c1dd01a1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLIPPERCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLIPPERCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

