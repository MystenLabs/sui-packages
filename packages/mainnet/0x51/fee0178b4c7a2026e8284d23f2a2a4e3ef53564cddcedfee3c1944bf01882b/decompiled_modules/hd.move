module 0x51fee0178b4c7a2026e8284d23f2a2a4e3ef53564cddcedfee3c1944bf01882b::hd {
    struct HD has drop {
        dummy_field: bool,
    }

    fun init(arg0: HD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HD>(arg0, 9, b"HD", b"Miftahu", b"Happy  digital 2025", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5ef69c87-fce3-44f1-9a44-a1209cbde785.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HD>>(v1);
    }

    // decompiled from Move bytecode v6
}

