module 0x9bf86aba2fb530b4b19b6289b687403a60f1fad480484a17a0f5ae400ec4bd11::bby {
    struct BBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBY>(arg0, 9, b"BBY", b"baby", x"f09f91b65468652061646f7261626c652063727970746f63757272656e6379207468617427732067726f77696e672074696e792070726f6669747320696e746f20626967206761696e73", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3835524e-3e75-466b-ba8c-b839a928ea27.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BBY>>(v1);
    }

    // decompiled from Move bytecode v6
}

