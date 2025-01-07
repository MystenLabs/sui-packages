module 0x97c4340f5671778082b4ea999de2c32b58f73e1d0a0335884e008b3a19b77e77::hsu {
    struct HSU has drop {
        dummy_field: bool,
    }

    fun init(arg0: HSU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HSU>(arg0, 9, b"HSU", b"LoI", b"To the mon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4c235418-56ea-4d5f-b797-fcd1701e1a45.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HSU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HSU>>(v1);
    }

    // decompiled from Move bytecode v6
}

