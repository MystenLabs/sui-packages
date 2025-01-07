module 0x3009dc440f5825b7bce629a93031d9f14570c95c17df3b8c7409783a952bc5f8::batt {
    struct BATT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BATT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BATT>(arg0, 9, b"BATT", b"OMBACT", b"live like a bat in a cave quietly watching the market and acting wisely is the message of coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8f12fc83-a891-4be8-8e27-717a92a56d0c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BATT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BATT>>(v1);
    }

    // decompiled from Move bytecode v6
}

