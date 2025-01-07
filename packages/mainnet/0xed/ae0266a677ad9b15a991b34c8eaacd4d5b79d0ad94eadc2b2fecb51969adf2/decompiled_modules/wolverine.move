module 0xedae0266a677ad9b15a991b34c8eaacd4d5b79d0ad94eadc2b2fecb51969adf2::wolverine {
    struct WOLVERINE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOLVERINE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOLVERINE>(arg0, 9, b"WOLVERINE", b"wolverine", b"Logan", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/230e1a9d-5b9a-411d-94bb-de5d63ed2b9c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOLVERINE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WOLVERINE>>(v1);
    }

    // decompiled from Move bytecode v6
}

