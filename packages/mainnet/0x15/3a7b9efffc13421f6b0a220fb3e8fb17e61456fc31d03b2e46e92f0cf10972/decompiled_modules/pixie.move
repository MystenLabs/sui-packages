module 0x153a7b9efffc13421f6b0a220fb3e8fb17e61456fc31d03b2e46e92f0cf10972::pixie {
    struct PIXIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIXIE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<PIXIE>(arg0, 6, b"PIXIE", b"PixieAI by SuiAI", b"Pixie", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/20250112_225542_37c78f8eee.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PIXIE>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIXIE>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

