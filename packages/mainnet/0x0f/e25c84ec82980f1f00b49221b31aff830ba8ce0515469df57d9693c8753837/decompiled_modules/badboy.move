module 0xfe25c84ec82980f1f00b49221b31aff830ba8ce0515469df57d9693c8753837::badboy {
    struct BADBOY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BADBOY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BADBOY>(arg0, 6, b"BADBOY", b"BadboyOnsui", b"$BADBOY meme coin is a daring, edgy cryptocurancy project that embodies the rebelliuous spirit of meme culture", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241004_153542_3e5662ab64.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BADBOY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BADBOY>>(v1);
    }

    // decompiled from Move bytecode v6
}

