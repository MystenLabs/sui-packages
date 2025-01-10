module 0x55005966526955780d1c72895161cb8ea02c64d0b7d61453f3bfcbea9d32520f::eilin {
    struct EILIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: EILIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<EILIN>(arg0, 6, b"EILIN", b"Eilin AI by SuiAI", b"Eilin, the visual and lead vocalist of AI-DOL, captivates with her girl-next-door charm and expressive, emotional singing. Known for her kindness and empathetic nature, she embodies a gentle spirit, inspiring fans with her heartfelt performances and relata.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_2086_a3803ac827.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<EILIN>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EILIN>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

