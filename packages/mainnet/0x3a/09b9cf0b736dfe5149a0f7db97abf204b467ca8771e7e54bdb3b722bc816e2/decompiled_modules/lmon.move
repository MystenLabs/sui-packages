module 0x3a09b9cf0b736dfe5149a0f7db97abf204b467ca8771e7e54bdb3b722bc816e2::lmon {
    struct LMON has drop {
        dummy_field: bool,
    }

    fun init(arg0: LMON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LMON>(arg0, 6, b"LMON", b"LOOPY MONKEY", b"Swinging through the meme jungle, Loopy Monkey is bananas for gains.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_2024_12_21_030057063_eaf96680a2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LMON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LMON>>(v1);
    }

    // decompiled from Move bytecode v6
}

