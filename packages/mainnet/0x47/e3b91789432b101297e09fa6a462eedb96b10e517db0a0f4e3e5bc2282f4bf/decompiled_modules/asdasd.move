module 0x47e3b91789432b101297e09fa6a462eedb96b10e517db0a0f4e3e5bc2282f4bf::asdasd {
    struct ASDASD has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASDASD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASDASD>(arg0, 9, b"ASDASD", b"ASADS", b"CVBCVBDFF", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/31e95132-1472-4d6c-9c6f-4c1b32aa156a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASDASD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ASDASD>>(v1);
    }

    // decompiled from Move bytecode v6
}

