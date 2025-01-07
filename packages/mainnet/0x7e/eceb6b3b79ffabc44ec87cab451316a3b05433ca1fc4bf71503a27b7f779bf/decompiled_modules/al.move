module 0x7eeceb6b3b79ffabc44ec87cab451316a3b05433ca1fc4bf71503a27b7f779bf::al {
    struct AL has drop {
        dummy_field: bool,
    }

    fun init(arg0: AL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AL>(arg0, 9, b"AL", b"Kabir", b"Pour communiquer avec moi et je vous remercie ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0f21c156-0f3c-455e-969b-2c8f3fd2fb55.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AL>>(v1);
    }

    // decompiled from Move bytecode v6
}

