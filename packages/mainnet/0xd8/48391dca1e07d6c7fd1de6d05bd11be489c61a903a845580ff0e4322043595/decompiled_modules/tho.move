module 0xd848391dca1e07d6c7fd1de6d05bd11be489c61a903a845580ff0e4322043595::tho {
    struct THO has drop {
        dummy_field: bool,
    }

    fun init(arg0: THO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THO>(arg0, 9, b"THO", b"Tao", b"a token to be used to confirm transactions on the sui eco system and dex ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/66226ba6-008b-4482-b72e-f77a79e3deb3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<THO>>(v1);
    }

    // decompiled from Move bytecode v6
}

