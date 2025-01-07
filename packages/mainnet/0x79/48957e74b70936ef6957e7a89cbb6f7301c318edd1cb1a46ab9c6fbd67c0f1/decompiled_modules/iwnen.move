module 0x7948957e74b70936ef6957e7a89cbb6f7301c318edd1cb1a46ab9c6fbd67c0f1::iwnen {
    struct IWNEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: IWNEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IWNEN>(arg0, 9, b"IWNEN", b"bsns ", b"bebe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/17c9c214-6d43-4af6-bd65-24d189de6633.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IWNEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IWNEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

