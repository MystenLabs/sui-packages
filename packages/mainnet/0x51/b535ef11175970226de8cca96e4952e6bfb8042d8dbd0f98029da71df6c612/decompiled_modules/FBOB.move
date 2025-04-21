module 0x51b535ef11175970226de8cca96e4952e6bfb8042d8dbd0f98029da71df6c612::FBOB {
    struct FBOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: FBOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FBOB>(arg0, 6, b"FBOB", b"freakbob", b"freakbob is calling...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://uptos-pump.myfilebase.com/ipfs/QmTm8UggLti8jS1aH6pfLfgTbXrACBGqZhmMMkP8fzr9Be")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FBOB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FBOB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

