module 0x51eb3b114895ec6c9f63439412603cfb7106e8c4731488fe74f599b2cae6576d::vbgsdg {
    struct VBGSDG has drop {
        dummy_field: bool,
    }

    fun init(arg0: VBGSDG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VBGSDG>(arg0, 9, b"VBGSDG", b"AF", b"ZXVC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e82ce8b8-3f23-40c7-be32-03f97dad7d35.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VBGSDG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VBGSDG>>(v1);
    }

    // decompiled from Move bytecode v6
}

