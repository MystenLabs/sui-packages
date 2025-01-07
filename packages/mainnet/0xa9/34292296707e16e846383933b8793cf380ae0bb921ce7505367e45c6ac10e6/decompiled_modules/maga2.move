module 0xa934292296707e16e846383933b8793cf380ae0bb921ce7505367e45c6ac10e6::maga2 {
    struct MAGA2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAGA2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAGA2>(arg0, 6, b"MAGA2", b"TRUMP2025", b"FUND MEDICAL AI PROJECT WITH MEME COINES. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Memecoin_Logo_ddf4700e23.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAGA2>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAGA2>>(v1);
    }

    // decompiled from Move bytecode v6
}

