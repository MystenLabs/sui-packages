module 0x2c71fdb28bdbbdd25e7f24359f9283bcc68fb72380eea23fe02bbabf4dad2050::pship {
    struct PSHIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PSHIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PSHIP>(arg0, 9, b"PSHIP", b"pink ship", b"pink ship token ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a40fcf72-a5d4-47e3-9b81-4f75605fe735.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PSHIP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PSHIP>>(v1);
    }

    // decompiled from Move bytecode v6
}

