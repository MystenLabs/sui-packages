module 0x6daf4699d1067e91595aef1b990bdaa8c4b1b559f1e6358d810efae2f51c0aa7::pussygrabberpotus {
    struct PUSSYGRABBERPOTUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUSSYGRABBERPOTUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUSSYGRABBERPOTUS>(arg0, 6, b"PUSSYGRABBERPOTUS", b"Pussy Grabber POTUS", b"The Official Coin of the man that makes America pussy again, Pussy Grabber POTUS.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Pussy_Coin_5c8f2fe0b6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUSSYGRABBERPOTUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUSSYGRABBERPOTUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

