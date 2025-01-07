module 0xc2de738b2a5dff67ce8bd9cc86502278380736c92476723a06ab0681691acd57::crash {
    struct CRASH has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRASH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRASH>(arg0, 9, b"CRASH", b"CRASH COIN", x"496e74726f647563696e6720437261736820436f696e3a205265646566696e696e67204d61726b657420566f6c6174696c6974790a0a437261736820436f696e206973206120636f6d6d756e6974792d64726976656e20746f6b656e206275696c7420746f2074687269766520696e20766f6c6174696c65206d61726b6574732e0a4a6f696e2074686520437261736820436f696e207265766f6c7574696f6e20616e64207475726e20766f6c6174696c69747920696e746f206f70706f7274756e6974792e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ea313cb2-61ce-4215-94a3-8cbd4b0cdb4b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRASH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CRASH>>(v1);
    }

    // decompiled from Move bytecode v6
}

