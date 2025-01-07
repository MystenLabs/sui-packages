module 0xe7b01cc501c799d002f0cb4ef2339210395b38864916bc40ce5b066433654065::dkl {
    struct DKL has drop {
        dummy_field: bool,
    }

    fun init(arg0: DKL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DKL>(arg0, 9, b"DKL", b"DARK LORD", b"DARK LORD ORDER YOU HIS MEME COIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/99ab4f5a-bec9-4dd2-b0ec-9cf9dddc23b3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DKL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DKL>>(v1);
    }

    // decompiled from Move bytecode v6
}

