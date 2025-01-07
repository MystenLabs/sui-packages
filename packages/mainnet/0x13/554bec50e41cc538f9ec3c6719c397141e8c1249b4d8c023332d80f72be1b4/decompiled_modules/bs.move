module 0x13554bec50e41cc538f9ec3c6719c397141e8c1249b4d8c023332d80f72be1b4::bs {
    struct BS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BS>(arg0, 9, b"BS", b"Blue Sky", x"5472e1bb9d692078616e68", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e636c4b3-7bb3-43dd-aa1c-1d6e34a13490.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BS>>(v1);
    }

    // decompiled from Move bytecode v6
}

