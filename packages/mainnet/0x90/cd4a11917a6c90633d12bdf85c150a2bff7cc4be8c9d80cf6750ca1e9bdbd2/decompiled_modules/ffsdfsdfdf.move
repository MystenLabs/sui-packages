module 0x90cd4a11917a6c90633d12bdf85c150a2bff7cc4be8c9d80cf6750ca1e9bdbd2::ffsdfsdfdf {
    struct FFSDFSDFDF has drop {
        dummy_field: bool,
    }

    fun init(arg0: FFSDFSDFDF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FFSDFSDFDF>(arg0, 9, b"FFSDFSDFDF", b"ZDASDFSFSF", b"SFDFDFDSfdfd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1d768fc2-2ebc-4cdd-8998-82c39af9290a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FFSDFSDFDF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FFSDFSDFDF>>(v1);
    }

    // decompiled from Move bytecode v6
}

