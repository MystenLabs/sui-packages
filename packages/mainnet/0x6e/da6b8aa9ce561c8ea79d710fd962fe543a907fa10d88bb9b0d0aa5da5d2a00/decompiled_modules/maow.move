module 0x6eda6b8aa9ce561c8ea79d710fd962fe543a907fa10d88bb9b0d0aa5da5d2a00::maow {
    struct MAOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAOW>(arg0, 9, b"MAOW", b"Cato", b"Cats makes up happy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/38ccc14a-45e9-440a-9ef2-8da4c223302d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAOW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAOW>>(v1);
    }

    // decompiled from Move bytecode v6
}

