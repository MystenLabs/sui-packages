module 0x2872407f4aeb219d0d4d880c7226d033b51a667a2d60313e5a9eaf02712b6a0e::maga_trump {
    struct MAGA_TRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAGA_TRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAGA_TRUMP>(arg0, 9, b"MAGA_TRUMP", b"MAGA", x"4d41474120436f696e206973206e6f74206a75737420612063727970746f63757272656e63792c206974e28099732061207265766f6c7574696f6e207772617070656420696e2061206a6f6b652c20696e73696465206120626c6f636b636861696e2e20204d41474120436f696e206973206865726520746f20707574206120736d696c65206f6e20796f7572206661636520616e64206120636f696e20696e20796f7572206469676974616c2077616c6c65742e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3b18204a-ae9a-4859-9c4b-7e48e29d7432.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAGA_TRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAGA_TRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

