module 0x8088b6a747e2453efc171e693779c1450721395cab1b0b4fec40b78926b75534::mizu {
    struct MIZU has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIZU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIZU>(arg0, 6, b"MIZU", b"MIZUCOIN", b"In Japanese, synonymous with SUI, MIZU Token will take over the next WEB3 space", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2378_e00b7327ca.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIZU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MIZU>>(v1);
    }

    // decompiled from Move bytecode v6
}

