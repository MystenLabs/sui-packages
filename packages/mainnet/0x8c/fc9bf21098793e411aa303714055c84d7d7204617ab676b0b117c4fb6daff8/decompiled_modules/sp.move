module 0x8cfc9bf21098793e411aa303714055c84d7d7204617ab676b0b117c4fb6daff8::sp {
    struct SP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SP>(arg0, 9, b"SP", b"Suipump ", b"Created on the philosophy that Sui will lead the bullrun ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2c357aef-7b7a-4f62-ac22-0e5ac663040b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SP>>(v1);
    }

    // decompiled from Move bytecode v6
}

