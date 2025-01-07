module 0x6f67636de0d0c87ffa51bb9527d960052f77565639b8333c3cc763b7a0f1fb91::roll {
    struct ROLL has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROLL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROLL>(arg0, 9, b"ROLL", b"Roll kong", b"Rollkong", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ad2bc8e9-2b88-4880-87d2-a003b2daa979.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROLL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ROLL>>(v1);
    }

    // decompiled from Move bytecode v6
}

