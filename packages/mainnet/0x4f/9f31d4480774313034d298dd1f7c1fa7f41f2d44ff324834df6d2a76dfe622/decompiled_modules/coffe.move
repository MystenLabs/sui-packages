module 0x4f9f31d4480774313034d298dd1f7c1fa7f41f2d44ff324834df6d2a76dfe622::coffe {
    struct COFFE has drop {
        dummy_field: bool,
    }

    fun init(arg0: COFFE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COFFE>(arg0, 9, b"COFFE", b"Black", b"Black coffe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/186d6c75-e7a8-4469-9e4d-94b87992c232.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COFFE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COFFE>>(v1);
    }

    // decompiled from Move bytecode v6
}

