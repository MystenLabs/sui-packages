module 0x23d8d463d7f17910f8e1a3c0147faab3f6f0617b9632337fbd6165b887d1f496::fruits {
    struct FRUITS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRUITS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRUITS>(arg0, 6, b"FRUITS", b"Fruits on Sui", x"4e4557204d45544120494e205355492e0a0a4e4f2048554d414e2c204e4f20414e494d414c2c204f4e4c5920244652554954532021", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731430121672.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FRUITS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRUITS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

