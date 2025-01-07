module 0xe88b33f2753cefa7a41a6344651d7bb44ff0056517d84742e58f2e8299d4aefb::gbull {
    struct GBULL has drop {
        dummy_field: bool,
    }

    fun init(arg0: GBULL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GBULL>(arg0, 9, b"GBULL", b"GoldenBull", x"546865206269676765737420616e64206c6172676573742062756c6c2072756e20696e20686973746f72792068617320626567756e2e2054686520676f6c64656e2062756c6c20244742554c4c20697320726561647920746f20726f6c6c2e2050756d7020697420746f20746865206d6f6f6e20616e64206675636b20746865206265617273204d6f466f732e20f09f9a80f09f9a80f09f9a80f09f9a80", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c1c9f94e-7ec6-4c6a-9aba-9cdb23de9476.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GBULL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GBULL>>(v1);
    }

    // decompiled from Move bytecode v6
}

