module 0xb477147709daa7693691a1a698b4b479dff6521c1628699b806055ce88e55fd5::sun_god {
    struct SUN_GOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUN_GOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUN_GOD>(arg0, 9, b"SUN_GOD", b"GEAR 5 ", x"4765617220353a2043727970746f205265766f6c7574696f6e0a200a47616d652d6368616e676572212047656172203520656d706f77657273207573657273207769746820636f6e74726f6c20616e642061636365737320746f20612076696272616e7420446546692065636f73797374656d2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fbf458d0-ca58-4654-adae-a0474e238844.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUN_GOD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUN_GOD>>(v1);
    }

    // decompiled from Move bytecode v6
}

