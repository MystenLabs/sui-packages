module 0xf208e4bf1ea749e98a49751fe9b83b7d13cde08165fb5460a3d3ad0f1a898ed8::dream_100x {
    struct DREAM_100X has drop {
        dummy_field: bool,
    }

    fun init(arg0: DREAM_100X, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DREAM_100X>(arg0, 9, b"DREAM_100X", b"Dream", x"f09fa7bff09fa7bff09fa7bf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5f4feab9-39be-4c3c-92ab-a36ac983df58.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DREAM_100X>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DREAM_100X>>(v1);
    }

    // decompiled from Move bytecode v6
}

