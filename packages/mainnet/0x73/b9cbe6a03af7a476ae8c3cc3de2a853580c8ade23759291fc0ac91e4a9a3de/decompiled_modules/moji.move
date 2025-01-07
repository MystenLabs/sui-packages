module 0x73b9cbe6a03af7a476ae8c3cc3de2a853580c8ade23759291fc0ac91e4a9a3de::moji {
    struct MOJI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOJI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOJI>(arg0, 9, b"MOJI", b"Moj", b"Best token on sui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7375e563-2cab-4a52-a5eb-43e2c72564fa.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOJI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOJI>>(v1);
    }

    // decompiled from Move bytecode v6
}

