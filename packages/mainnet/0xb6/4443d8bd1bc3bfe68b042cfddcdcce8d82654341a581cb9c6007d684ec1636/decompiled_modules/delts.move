module 0xb64443d8bd1bc3bfe68b042cfddcdcce8d82654341a581cb9c6007d684ec1636::delts {
    struct DELTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DELTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DELTS>(arg0, 9, b"DELTS", b"DELTs", x"d09cd18b202d20d0bad0bed0b0d0bbd0b8d186d0b8d18f20d0bad0bbd0b0d0bdd0bed0b220446561746820456c656d656e74732e20d09cd18b20d0b8d0b3d180d0b0d0b5d0bc20d0b220576f726c64206f662054616e6b732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9ec4d44d-a1a8-44bd-b41e-19e4dc38c73b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DELTS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DELTS>>(v1);
    }

    // decompiled from Move bytecode v6
}

