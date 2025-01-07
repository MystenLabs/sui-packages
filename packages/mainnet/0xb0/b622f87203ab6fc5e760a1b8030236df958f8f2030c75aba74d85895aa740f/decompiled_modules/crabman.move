module 0xb0b622f87203ab6fc5e760a1b8030236df958f8f2030c75aba74d85895aa740f::crabman {
    struct CRABMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRABMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRABMAN>(arg0, 6, b"CrabMan", b"Crab Man On SUI", x"54686520416e696d616c206f6e205355492c206272696e67696e67206372616220746f2074686520776f726c64206f66206d656d65730a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/472219462_1296982641335227_2352972152456745042_n_bd2046b339.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRABMAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CRABMAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

