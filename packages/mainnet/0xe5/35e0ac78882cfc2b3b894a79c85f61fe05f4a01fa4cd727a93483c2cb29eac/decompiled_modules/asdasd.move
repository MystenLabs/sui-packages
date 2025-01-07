module 0xe535e0ac78882cfc2b3b894a79c85f61fe05f4a01fa4cd727a93483c2cb29eac::asdasd {
    struct ASDASD has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASDASD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASDASD>(arg0, 9, b"ASDASD", b"ASADS", b"CVBCVBDFF", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f36e5494-c728-4c2c-aee1-530bd2b1f1f1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASDASD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ASDASD>>(v1);
    }

    // decompiled from Move bytecode v6
}

