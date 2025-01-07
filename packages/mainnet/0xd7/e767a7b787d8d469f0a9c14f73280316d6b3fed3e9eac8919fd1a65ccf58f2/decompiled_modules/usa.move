module 0xd7e767a7b787d8d469f0a9c14f73280316d6b3fed3e9eac8919fd1a65ccf58f2::usa {
    struct USA has drop {
        dummy_field: bool,
    }

    fun init(arg0: USA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USA>(arg0, 9, b"USA", b"AMERICA", x"50617472696f7420506f7765723a204561636820555341207472616e73616374696f6e20697320612073616c75746520746f2066726565646f6d2e20486f6c64696e672074686520746f6b656e3f20596f752772652061206d656d652d776f726c642070617472696f74210a46726565646f6d20746f204d6f6f6e3a205468652055534120746f6b656e20697320796f7572207061746820746f2066696e616e6369616c2022696e646570656e64656e63652220286a75737420666f722066756e292e0a4c696265727479204d656d65733a20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5fd1a965-de24-44ab-b33a-3c62ed2135e7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<USA>>(v1);
    }

    // decompiled from Move bytecode v6
}

