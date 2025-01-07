module 0x85037c80b284f3de3db299f9e0aba13a2ba0ddf07b59bb1c264d495ef8eed5c1::cr {
    struct CR has drop {
        dummy_field: bool,
    }

    fun init(arg0: CR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CR>(arg0, 9, b"CR", b"Chromium ", b"For chemistry ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ab9edf71-7354-458d-8ad1-a0371308f211.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CR>>(v1);
    }

    // decompiled from Move bytecode v6
}

