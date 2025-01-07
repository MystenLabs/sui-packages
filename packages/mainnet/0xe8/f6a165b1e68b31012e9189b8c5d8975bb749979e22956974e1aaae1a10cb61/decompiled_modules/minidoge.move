module 0xe8f6a165b1e68b31012e9189b8c5d8975bb749979e22956974e1aaae1a10cb61::minidoge {
    struct MINIDOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MINIDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MINIDOGE>(arg0, 6, b"MINIDOGE", b"Mini Doge", b"The cutest meme token you've ever seen. Pump it! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732253999507.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MINIDOGE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MINIDOGE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

