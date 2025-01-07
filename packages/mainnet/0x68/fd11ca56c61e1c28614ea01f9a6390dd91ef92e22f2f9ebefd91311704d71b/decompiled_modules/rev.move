module 0x68fd11ca56c61e1c28614ea01f9a6390dd91ef92e22f2f9ebefd91311704d71b::rev {
    struct REV has drop {
        dummy_field: bool,
    }

    fun init(arg0: REV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REV>(arg0, 9, b"REV", b"REVIEW EVE", b"Review Everything", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5466aba4-b2d0-4f60-84d3-cd5267c37777.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<REV>>(v1);
    }

    // decompiled from Move bytecode v6
}

