module 0x1b3a38274270e3a8124f8b946c4d79dbf1caafe61a89d41b858ad7c3fe75edb8::slama {
    struct SLAMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLAMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLAMA>(arg0, 6, b"SLAMA", b"Suillama", b"New chart pattern spotted in the sea of sui. SLAMA IS THE NEW BREAKOUT INDICATOR!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/slama_f76bc6d99d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLAMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLAMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

