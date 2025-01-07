module 0xb10ebf76d71f8efee3844aae8014ca8ec671054b12c7a7fa71f40f514194d257::zai {
    struct ZAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZAI>(arg0, 9, b"ZAI", b"Zainab ", b"Zaitoken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/eb808515-5d1b-4f25-a417-cac1b1284a87.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

