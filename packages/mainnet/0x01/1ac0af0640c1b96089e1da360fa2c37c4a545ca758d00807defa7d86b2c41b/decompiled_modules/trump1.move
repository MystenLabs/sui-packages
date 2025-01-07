module 0x11ac0af0640c1b96089e1da360fa2c37c4a545ca758d00807defa7d86b2c41b::trump1 {
    struct TRUMP1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMP1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMP1>(arg0, 9, b"TRUMP1", b"Trump", b"Trump Becomes President for America", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5a652e7a-b538-409d-8574-95a107f21067.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMP1>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUMP1>>(v1);
    }

    // decompiled from Move bytecode v6
}

