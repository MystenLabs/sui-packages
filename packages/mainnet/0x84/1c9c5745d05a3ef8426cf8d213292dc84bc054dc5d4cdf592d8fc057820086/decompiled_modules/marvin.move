module 0x841c9c5745d05a3ef8426cf8d213292dc84bc054dc5d4cdf592d8fc057820086::marvin {
    struct MARVIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MARVIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MARVIN>(arg0, 6, b"MARVIN", b"Marvin Elon Musk | SUI", b"Marvin Elon Musk | SUI. Dexscreener paid.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_newss_4a67f94686.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MARVIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MARVIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

