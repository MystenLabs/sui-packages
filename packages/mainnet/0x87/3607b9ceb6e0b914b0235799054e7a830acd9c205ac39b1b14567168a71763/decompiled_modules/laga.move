module 0x873607b9ceb6e0b914b0235799054e7a830acd9c205ac39b1b14567168a71763::laga {
    struct LAGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAGA>(arg0, 9, b"LAGA", b"Laga Laga ", b"Laga memes ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/871b77b6-9e29-4665-bd3f-1e95a72a979f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LAGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LAGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

