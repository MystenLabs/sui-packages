module 0x49768076133cbb5376b9643514f80b4f54488f55202b14815e9030e8ec45fd28::hsk {
    struct HSK has drop {
        dummy_field: bool,
    }

    fun init(arg0: HSK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HSK>(arg0, 9, b"HSK", b"Media", b"To used Memecoins for social interactions", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b5101a09-1dc3-41e0-bce9-16a481f607b1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HSK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HSK>>(v1);
    }

    // decompiled from Move bytecode v6
}

