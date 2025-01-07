module 0x60b10931e1b6f18cebdd85492153fd3d062ddcdaca9a2ef97b0a7a9598da846c::denrian {
    struct DENRIAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DENRIAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DENRIAN>(arg0, 9, b"DENRIAN", b"DenRozd", x"d18120d0b4d0bdd0b5d0bc20d180d0bed0b6d0b4d0b5d0bdd0b8d18f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3304a760-5253-4b72-98c6-c46430e01946.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DENRIAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DENRIAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

