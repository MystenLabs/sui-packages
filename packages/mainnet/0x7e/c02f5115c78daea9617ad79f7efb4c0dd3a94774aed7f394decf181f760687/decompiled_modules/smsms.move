module 0x7ec02f5115c78daea9617ad79f7efb4c0dd3a94774aed7f394decf181f760687::smsms {
    struct SMSMS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMSMS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMSMS>(arg0, 9, b"SMSMS", b"Sms", b"For solving the web3 problem and get a solution ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0e61718b-fda1-4c5d-a501-4ba20f65c1c6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMSMS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SMSMS>>(v1);
    }

    // decompiled from Move bytecode v6
}

