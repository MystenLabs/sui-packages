module 0x3631aca3a1d36b5bdc2ee9f9f4806b3a15c8d71cb241174fd27754340e3258f5::azy {
    struct AZY has drop {
        dummy_field: bool,
    }

    fun init(arg0: AZY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AZY>(arg0, 9, b"AZY", b"Azy83", b"Azy is a meme token inspired by the creator", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/aa9afa57-5eca-4c58-bf51-907d10db35b4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AZY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AZY>>(v1);
    }

    // decompiled from Move bytecode v6
}

