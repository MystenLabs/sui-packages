module 0xb1d6bd676656a68f5234d0ca47b24d07025ff2d03d9912959c84293f0d43deac::aligol {
    struct ALIGOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALIGOL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ALIGOL>(arg0, 6, b"ALIGOL", b"Aligol by SuiAI", b"Ali Gol meme trump", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_6819_c2511f6d03.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ALIGOL>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALIGOL>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

