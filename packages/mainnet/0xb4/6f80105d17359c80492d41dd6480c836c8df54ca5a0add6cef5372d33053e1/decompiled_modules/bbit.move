module 0xb46f80105d17359c80492d41dd6480c836c8df54ca5a0add6cef5372d33053e1::bbit {
    struct BBIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBIT>(arg0, 9, b"BBIT", b"BeetleBit", b" Small but powerful in crypto land.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8d8b2f73-e92c-45dd-8010-f1a3a397306c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BBIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

