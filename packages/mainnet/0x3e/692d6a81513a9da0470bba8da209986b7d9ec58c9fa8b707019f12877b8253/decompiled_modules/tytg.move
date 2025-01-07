module 0x3e692d6a81513a9da0470bba8da209986b7d9ec58c9fa8b707019f12877b8253::tytg {
    struct TYTG has drop {
        dummy_field: bool,
    }

    fun init(arg0: TYTG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<TYTG>(arg0, 6, b"TYTG", b"ThankyouToadGod", b"For all the fallen frogs, spreading the lore far and wide, as @toadgod1017 on twitter has instructed. .", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/toby_toad_3273e595c6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TYTG>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TYTG>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

