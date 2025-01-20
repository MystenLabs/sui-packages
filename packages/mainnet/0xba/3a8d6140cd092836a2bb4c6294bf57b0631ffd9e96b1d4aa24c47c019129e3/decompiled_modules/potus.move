module 0xba3a8d6140cd092836a2bb4c6294bf57b0631ffd9e96b1d4aa24c47c019129e3::potus {
    struct POTUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: POTUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POTUS>(arg0, 6, b"POTUS", b"POTUS Meme", b"Official POTUS Meme $POTUS is a meme coin inspired by the hype of Trump and Melania tokens. Get ready for the next big thing in crypto! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250121_034106_076_9656d42ea3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POTUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POTUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

