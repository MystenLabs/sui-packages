module 0x86f72c0677c95e7f8e2a8aa118b095f604c9f6e83436531b6ca839a53470d858::dcck {
    struct DCCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DCCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DCCK>(arg0, 9, b"DCCK", b"DCCK Air", b"DCCK Aidrop", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2927e010-c0de-4a57-8b74-50f40be86a0f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DCCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DCCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

