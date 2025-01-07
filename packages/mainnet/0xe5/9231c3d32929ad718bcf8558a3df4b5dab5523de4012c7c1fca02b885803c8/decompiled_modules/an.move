module 0xe59231c3d32929ad718bcf8558a3df4b5dab5523de4012c7c1fca02b885803c8::an {
    struct AN has drop {
        dummy_field: bool,
    }

    fun init(arg0: AN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AN>(arg0, 9, b"AN", b"Tuan", b"Haha", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/11b925fa-a1a6-4dd3-837e-6d4f79d5df98.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AN>>(v1);
    }

    // decompiled from Move bytecode v6
}

