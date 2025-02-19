module 0x662982b206d0417488c813376ac94e443bc2b081e4a060f759bfa5f6c597fbd8::tgkc {
    struct TGKC has drop {
        dummy_field: bool,
    }

    fun init(arg0: TGKC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TGKC>(arg0, 9, b"TGKC", b"TGKCOM", b"funny", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e05bd9c2-c2bc-474c-9d5d-f30dd987a2e4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TGKC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TGKC>>(v1);
    }

    // decompiled from Move bytecode v6
}

