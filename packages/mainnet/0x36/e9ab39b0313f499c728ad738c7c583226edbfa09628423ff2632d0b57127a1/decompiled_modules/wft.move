module 0x36e9ab39b0313f499c728ad738c7c583226edbfa09628423ff2632d0b57127a1::wft {
    struct WFT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WFT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WFT>(arg0, 9, b"WFT", b"Wavwithhat", x"5761766520f09f8c8a207769746820f09f8ea920", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/959a9d07-72f1-4de7-b5c2-d9e02f36e790.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WFT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WFT>>(v1);
    }

    // decompiled from Move bytecode v6
}

