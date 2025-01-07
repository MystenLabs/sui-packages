module 0x4257855f4ff912ba3a7604142095bfb2a37ed8acd42b5df3896d1b438d99ca0a::sfrog {
    struct SFROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SFROG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SFROG>(arg0, 9, b"SFROG", b"SMILE FROG", b"A SMILLIN FROG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/83fc32b0-8fa1-4bc7-954b-00730a19d476.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SFROG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SFROG>>(v1);
    }

    // decompiled from Move bytecode v6
}

