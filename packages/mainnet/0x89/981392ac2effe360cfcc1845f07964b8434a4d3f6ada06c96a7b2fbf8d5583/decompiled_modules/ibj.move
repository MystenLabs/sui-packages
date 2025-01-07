module 0x89981392ac2effe360cfcc1845f07964b8434a4d3f6ada06c96a7b2fbf8d5583::ibj {
    struct IBJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: IBJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IBJ>(arg0, 9, b"IBJ", b"IBJAAD ", b"IBJAAD IS VERSATILE AND HERE TO STAY, HUMAN PROTOCOL SERVICE ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d0f5e04f-b9f1-47e1-8329-370d402f67ab.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IBJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IBJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

