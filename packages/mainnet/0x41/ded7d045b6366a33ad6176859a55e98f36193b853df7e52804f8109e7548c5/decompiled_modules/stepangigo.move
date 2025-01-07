module 0x41ded7d045b6366a33ad6176859a55e98f36193b853df7e52804f8109e7548c5::stepangigo {
    struct STEPANGIGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEPANGIGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEPANGIGO>(arg0, 9, b"STEPANGIGO", b"Gigo", b"The first real CryptoStepanGigo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/eedb8601-ffa8-44b2-b86f-39346e1aa338.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEPANGIGO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STEPANGIGO>>(v1);
    }

    // decompiled from Move bytecode v6
}

