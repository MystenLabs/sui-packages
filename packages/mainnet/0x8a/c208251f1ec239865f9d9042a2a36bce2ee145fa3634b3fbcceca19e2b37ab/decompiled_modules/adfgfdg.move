module 0x8ac208251f1ec239865f9d9042a2a36bce2ee145fa3634b3fbcceca19e2b37ab::adfgfdg {
    struct ADFGFDG has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADFGFDG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADFGFDG>(arg0, 9, b"ADFGFDG", b"ffdg", b"dfgfdgf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/61e9b366-f5f9-429f-99e8-b81e3fe7f039.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADFGFDG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ADFGFDG>>(v1);
    }

    // decompiled from Move bytecode v6
}

