module 0x334872be83a01f8b7d7ec9849c1a0adb40c3541e9872169c156112a1fd8673be::tpepe {
    struct TPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TPEPE>(arg0, 9, b"TPEPE", b"Turbo Pepe", b"Inspiration from the combination of turbo and pepe which is already world famous and very famous. save and we will be very big", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/404f4c63-6d73-434e-8a54-ff1cecc4ef99.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TPEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TPEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

