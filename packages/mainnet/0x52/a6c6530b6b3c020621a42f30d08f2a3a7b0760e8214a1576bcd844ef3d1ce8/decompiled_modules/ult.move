module 0x52a6c6530b6b3c020621a42f30d08f2a3a7b0760e8214a1576bcd844ef3d1ce8::ult {
    struct ULT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ULT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ULT>(arg0, 9, b"ULT", b"Ultimate", b"The most valuable memecoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a2c26482-5e96-4b86-9928-2c80ce4ae7f9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ULT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ULT>>(v1);
    }

    // decompiled from Move bytecode v6
}

