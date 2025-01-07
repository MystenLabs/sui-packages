module 0xd2eaebf01dc693f79854f65d0de3f2d1b51eec492988f3040a7d951741f84783::lai {
    struct LAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAI>(arg0, 9, b"LAI", b"Lisa Arimi", b"jaj", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ae95b017-b052-4f33-873e-b20b1a2e6e70.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

