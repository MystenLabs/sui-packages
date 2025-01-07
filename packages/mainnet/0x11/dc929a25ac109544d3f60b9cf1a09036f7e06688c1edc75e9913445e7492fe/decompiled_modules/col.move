module 0x11dc929a25ac109544d3f60b9cf1a09036f7e06688c1edc75e9913445e7492fe::col {
    struct COL has drop {
        dummy_field: bool,
    }

    fun init(arg0: COL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COL>(arg0, 9, b"COL", b"RANGO", b"COLORFUL COLORFUL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0b70143f-b7a6-4b76-bdb9-8cdf08ccb4c1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COL>>(v1);
    }

    // decompiled from Move bytecode v6
}

