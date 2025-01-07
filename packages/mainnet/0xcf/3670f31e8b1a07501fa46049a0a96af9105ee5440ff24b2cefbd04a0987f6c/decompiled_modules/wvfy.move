module 0xcf3670f31e8b1a07501fa46049a0a96af9105ee5440ff24b2cefbd04a0987f6c::wvfy {
    struct WVFY has drop {
        dummy_field: bool,
    }

    fun init(arg0: WVFY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WVFY>(arg0, 9, b"WVFY", b"WAVERV", x"5761766572202d2041206d656d6520746f6b656e20666f722074686f73652077686f206c69766520666f72207468652077617665732e205768657468657220796f75e28099726520612063727970746f20656e7468757369617374206f72206a757374206865726520666f72207468652066756e2c205761766572206973206865726520746f206d616b6520612073706c61736820696e20796f75722077616c6c657421", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c3d549b1-602c-4745-8aa9-aab8ee314c47.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WVFY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WVFY>>(v1);
    }

    // decompiled from Move bytecode v6
}

