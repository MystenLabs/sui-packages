module 0xeb606ba5fa7e1647b355e9e6e25d1b14d41f5b6cb7e5fc7fcadc4d1af19f59b7::godog {
    struct GODOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GODOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GODOG>(arg0, 9, b"GODOG", b"GoodDog", b"Good dog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/adcc750e-21cf-4ea2-a0ad-0c258336705f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GODOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GODOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

