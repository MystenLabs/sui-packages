module 0x5e3e000108978e2c20d73df29e5e9ff5f6f83524498f15e02ec369260c023db7::sjs {
    struct SJS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SJS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SJS>(arg0, 9, b"SJS", b"Sincerely ", b"Subscribe for the most popular video game ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9afa7357-8420-43ce-9b46-39aa22af950f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SJS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SJS>>(v1);
    }

    // decompiled from Move bytecode v6
}

