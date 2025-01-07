module 0x4396968280e6233057dc30f3f54228fdd855b33dddf69f18fbe4d9c0f5690db5::seven {
    struct SEVEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEVEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEVEN>(arg0, 9, b"SEVEN", b"777", b"A selected number 777", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/91c895a8-d772-4cab-9dd4-b99b92f891d9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEVEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SEVEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

