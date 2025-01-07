module 0x9df931a2e424fbf6a76d0ab2eebd132221e423b2affcb3887cdc59692da52edf::trwon {
    struct TRWON has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRWON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRWON>(arg0, 9, b"TRWON", b"TRUMPWON", b"Support trump won", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a9e274ec-0497-47c1-935a-d55d2fa80b6f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRWON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRWON>>(v1);
    }

    // decompiled from Move bytecode v6
}

