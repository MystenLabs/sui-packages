module 0x68f32fffb638926b3ada1a36d965480dc2b50c945850c358916372b4273529ad::send {
    struct SEND has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEND>(arg0, 9, b"SEND", b"Sendit", b"If you believe in it, you can send it!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bd100c20-be8d-4b33-8cfd-a7594557593d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SEND>>(v1);
    }

    // decompiled from Move bytecode v6
}

