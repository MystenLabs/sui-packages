module 0xc1ee4756b1b78e641ed45e6aaa74b43013b025a0ae286b8621df52d4774a41c8::meo {
    struct MEO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEO>(arg0, 9, b"MEO", b"BUMBUM", x"436f6e206dc3a86f206e68c3a0206dc3ac6e6820c491c3b3", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b665f615-0998-4be1-890e-e8f325a1d34d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEO>>(v1);
    }

    // decompiled from Move bytecode v6
}

