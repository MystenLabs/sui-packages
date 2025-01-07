module 0x4fe836b7979ee86ecd1d56f06ea2c159e8ea1c91cb1f7ebcc67b65a6d941e28::lai {
    struct LAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAI>(arg0, 9, b"LAI", b"Lisa Arimi", b"jaj", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b925f55e-56be-4146-8869-13b61c4a2e90.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

