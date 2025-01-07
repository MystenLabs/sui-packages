module 0x6a69a75b1ad36c8cdfe095422fb1df3804bef17a54602b760ba29f75962eef95::gdsag {
    struct GDSAG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GDSAG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GDSAG>(arg0, 9, b"GDSAG", b"dasgsa", b"DSG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c23741f4-d65e-4029-86f9-818f53a249ab.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GDSAG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GDSAG>>(v1);
    }

    // decompiled from Move bytecode v6
}

