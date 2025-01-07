module 0x1392beec41beebd7e964fe7a660a2fd0188dcadf0b8c0069371ce7570c361e9::ticker {
    struct TICKER has drop {
        dummy_field: bool,
    }

    fun init(arg0: TICKER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TICKER>(arg0, 6, b"TICKER", b"Mystery Launch", b"All in this market is a mystery, you never know which ticker could get the hype, why not this $TICKER?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_04_22_28_58_56bf86f043.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TICKER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TICKER>>(v1);
    }

    // decompiled from Move bytecode v6
}

