module 0x9d1eacfa5d35e3062fa70b6c45ebc5d957eb3946dd6c699f8c21bbe3933c0b5c::pinky {
    struct PINKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PINKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PINKY>(arg0, 6, b"PINKY", b"pineapple Pinky", b"meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/353fbd7f_7c9f_4de0_aa69_f37450ee149b_f8e2254369.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PINKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PINKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

