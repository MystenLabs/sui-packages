module 0x6d80a541bc41f45a8095a9c6f95bba2777b574c54552426e1e9260c0b709d249::doji {
    struct DOJI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOJI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOJI>(arg0, 6, b"DOJI", b"Dojiman on SUI", b"$DOJI is ready to flex on the market with a punchline as strong as its gains!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/CANDLE_6c1fb0b58b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOJI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOJI>>(v1);
    }

    // decompiled from Move bytecode v6
}

