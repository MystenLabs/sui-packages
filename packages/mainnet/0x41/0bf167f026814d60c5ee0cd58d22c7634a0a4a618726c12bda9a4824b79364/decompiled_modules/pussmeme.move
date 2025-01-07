module 0x410bf167f026814d60c5ee0cd58d22c7634a0a4a618726c12bda9a4824b79364::pussmeme {
    struct PUSSMEME has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUSSMEME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUSSMEME>(arg0, 9, b"PUSSMEME", b"Puss coin", b"So wonderfull", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0e0eb881-33b5-42c1-a4e1-2484bcb1431c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUSSMEME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PUSSMEME>>(v1);
    }

    // decompiled from Move bytecode v6
}

