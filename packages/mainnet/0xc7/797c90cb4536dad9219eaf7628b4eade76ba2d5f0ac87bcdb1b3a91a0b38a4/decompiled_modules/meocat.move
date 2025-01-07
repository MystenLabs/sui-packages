module 0xc7797c90cb4536dad9219eaf7628b4eade76ba2d5f0ac87bcdb1b3a91a0b38a4::meocat {
    struct MEOCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEOCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEOCAT>(arg0, 9, b"MEOCAT", b"MEOM", b"MEo mOe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2c696fee-b6f0-4947-9c68-f1b800b8e6b5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEOCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEOCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

