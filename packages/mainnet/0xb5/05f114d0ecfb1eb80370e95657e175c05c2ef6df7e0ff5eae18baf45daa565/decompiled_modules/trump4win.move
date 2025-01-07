module 0xb505f114d0ecfb1eb80370e95657e175c05c2ef6df7e0ff5eae18baf45daa565::trump4win {
    struct TRUMP4WIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMP4WIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMP4WIN>(arg0, 6, b"TRUMP4WIN", b"4WIN", x"544f4745544845520a345452554d500a3457494e0a3443525950544f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4_WIN_7d278d8914.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMP4WIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMP4WIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

