module 0x313238613e8649e0ebb2caeecc6b47bee3cb5cf9db9a0a8329e5977f5d553a32::tfai {
    struct TFAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TFAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<TFAI>(arg0, 6, b"TFAI", b"TRUMP FAIGHT by SuiAI", b"Sui's AI Agent: Redefining the future, making it great like Trump MAGA.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/super_resolution_20250119224204729_83747466456631929246447_09152063868835068748879_c8cd984964.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TFAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TFAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

