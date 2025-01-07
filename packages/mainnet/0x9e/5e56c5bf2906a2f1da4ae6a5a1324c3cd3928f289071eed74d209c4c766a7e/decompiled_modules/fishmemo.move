module 0x9e5e56c5bf2906a2f1da4ae6a5a1324c3cd3928f289071eed74d209c4c766a7e::fishmemo {
    struct FISHMEMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: FISHMEMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FISHMEMO>(arg0, 9, b"FISHMEMO", b"MEMO", b"meme coin adaption from fish memo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ae41c5ec-0aa5-474b-845a-53b6ce501617.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FISHMEMO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FISHMEMO>>(v1);
    }

    // decompiled from Move bytecode v6
}

