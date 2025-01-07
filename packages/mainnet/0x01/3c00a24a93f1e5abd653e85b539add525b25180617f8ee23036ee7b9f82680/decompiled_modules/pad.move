module 0x13c00a24a93f1e5abd653e85b539add525b25180617f8ee23036ee7b9f82680::pad {
    struct PAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAD>(arg0, 9, b"PAD", b"Panda", b"Pandakid", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7886f8ff-4844-444f-b5ec-26ad09cd1ed1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

