module 0x4966ff0635a6cc8cf1739e0e07f0e7240867425953d8d2284d3002dab6fc8cf6::spy {
    struct SPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPY>(arg0, 9, b"SPY", b"SPICYSURF", b"Always Reliable ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c78b056b-bb3d-4d2c-994d-d442f815e411.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

