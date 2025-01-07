module 0x29d72fe21181a418ac4f783d62b7aff8f5fbaa5a049776fbadbdfa9d97858592::bullish {
    struct BULLISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: BULLISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BULLISH>(arg0, 6, b"BULLISH", b"BULLISH ON", x"49276d2042756c6c697368206f6e20746865206d61726b65742c20646f6e277420686f6c64206d65206261636b206265636175736520776527726520676f696e6720746f20666c79212121202442554c4c495348200a0a782e636f6d2f536f6c42756c6c6973685f4f4e0a4e6f2077656273697465207965742e2028534f4f4e29", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730959581752.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BULLISH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BULLISH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

