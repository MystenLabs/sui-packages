module 0xbc37fb0d43b3c4b53fb546fb000ef1cc603fc1df00ff0330ae0b0acb467e02ad::catgg {
    struct CATGG has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATGG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATGG>(arg0, 9, b"CATGG", b"CATG", b"GG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c2f5b23e-f164-4114-8545-45e7a745d20b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATGG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CATGG>>(v1);
    }

    // decompiled from Move bytecode v6
}

