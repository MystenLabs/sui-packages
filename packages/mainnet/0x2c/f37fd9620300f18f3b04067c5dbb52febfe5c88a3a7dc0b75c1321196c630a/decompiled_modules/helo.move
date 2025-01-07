module 0x2cf37fd9620300f18f3b04067c5dbb52febfe5c88a3a7dc0b75c1321196c630a::helo {
    struct HELO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HELO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HELO>(arg0, 9, b"HELO", b"Hello", b"Non", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d2ddc71c-f6f0-4c89-8d5a-12daba4401cf.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HELO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HELO>>(v1);
    }

    // decompiled from Move bytecode v6
}

