module 0x8a8169b13836478f7968b1a2193b370c90e9b6a5e487ccfb181268674540dc8f::rd {
    struct RD has drop {
        dummy_field: bool,
    }

    fun init(arg0: RD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RD>(arg0, 9, b"RD", b"RainboDash", b"RainbowDash", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/310d3899-0cd6-442b-919e-c5091d0e1277.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RD>>(v1);
    }

    // decompiled from Move bytecode v6
}

