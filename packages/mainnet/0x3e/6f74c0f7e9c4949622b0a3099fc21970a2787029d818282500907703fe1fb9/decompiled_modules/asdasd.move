module 0x3e6f74c0f7e9c4949622b0a3099fc21970a2787029d818282500907703fe1fb9::asdasd {
    struct ASDASD has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASDASD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASDASD>(arg0, 9, b"ASDASD", b"ASADS", b"CVBCVBDFF", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6b6ca10a-5395-4fab-ae6f-e226ba4a70d0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASDASD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ASDASD>>(v1);
    }

    // decompiled from Move bytecode v6
}

