module 0xac71dbfe5a8427cf2d3939e650ddd47a9a46878cb0f0e898b16604f9eea852f1::comedian {
    struct COMEDIAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: COMEDIAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COMEDIAN>(arg0, 9, b"COMEDIAN", b"BAN", b"Banana on the wall", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fc5c61fa-49db-46f5-a444-a425112fdfd9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COMEDIAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COMEDIAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

