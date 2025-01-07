module 0xf3eb5bd76435614b1d9c7df6b561bacf6c3a539158cfd33387c8185fbd3781bc::myca {
    struct MYCA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MYCA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MYCA>(arg0, 9, b"MYCA", b"MY CAR", x"41207374796c697368206272616e6420776974682068696768206f6374616e650a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a449d6eb-3c82-44f4-b606-293a15626e0d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MYCA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MYCA>>(v1);
    }

    // decompiled from Move bytecode v6
}

