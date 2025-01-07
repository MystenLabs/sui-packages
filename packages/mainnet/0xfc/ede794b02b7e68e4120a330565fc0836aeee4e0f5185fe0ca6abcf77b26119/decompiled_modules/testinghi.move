module 0xfcede794b02b7e68e4120a330565fc0836aeee4e0f5185fe0ca6abcf77b26119::testinghi {
    struct TESTINGHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTINGHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTINGHI>(arg0, 9, b"TESTINGHI", b"Testhgg", b"Testing", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8eb51379-be66-42a9-8f5e-14abf66bb763.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTINGHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TESTINGHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

