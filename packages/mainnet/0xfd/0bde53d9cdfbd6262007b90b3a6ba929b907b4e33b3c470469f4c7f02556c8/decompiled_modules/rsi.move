module 0xfd0bde53d9cdfbd6262007b90b3a6ba929b907b4e33b3c470469f4c7f02556c8::rsi {
    struct RSI has drop {
        dummy_field: bool,
    }

    fun init(arg0: RSI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RSI>(arg0, 6, b"RSI", b"Relative Strength Index", b"The first RSI indicator in the market", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000019663_d687128d00.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RSI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RSI>>(v1);
    }

    // decompiled from Move bytecode v6
}

