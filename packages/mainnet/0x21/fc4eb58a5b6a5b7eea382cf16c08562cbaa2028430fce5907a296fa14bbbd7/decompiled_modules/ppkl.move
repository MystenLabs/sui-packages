module 0x21fc4eb58a5b6a5b7eea382cf16c08562cbaa2028430fce5907a296fa14bbbd7::ppkl {
    struct PPKL has drop {
        dummy_field: bool,
    }

    fun init(arg0: PPKL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PPKL>(arg0, 9, b"PPKL", b"PUMPPICKLE", b"PUMP THIS PICKLE TO PUMP YOUR WALLET!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/119045a8-3445-467f-80d0-72745873b983.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PPKL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PPKL>>(v1);
    }

    // decompiled from Move bytecode v6
}

