module 0xd41a7624aac3cab2692c8f5f15de15e2ca1ac3188867e759f7e06ca11d4208ba::cheepo {
    struct CHEEPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHEEPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHEEPO>(arg0, 6, b"CHEEPO", b"CHEEPO THE GOAT", b"The CHEEPO GOAT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000142481_cae3bb688e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHEEPO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHEEPO>>(v1);
    }

    // decompiled from Move bytecode v6
}

