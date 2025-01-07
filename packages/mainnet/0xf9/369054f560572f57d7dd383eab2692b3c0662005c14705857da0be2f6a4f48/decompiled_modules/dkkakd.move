module 0xf9369054f560572f57d7dd383eab2692b3c0662005c14705857da0be2f6a4f48::dkkakd {
    struct DKKAKD has drop {
        dummy_field: bool,
    }

    fun init(arg0: DKKAKD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DKKAKD>(arg0, 9, b"DKKAKD", b"Yejaka", b"Dmsmsmmc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/08903c41-cf68-4bc3-a4d3-fc66997df67d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DKKAKD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DKKAKD>>(v1);
    }

    // decompiled from Move bytecode v6
}

