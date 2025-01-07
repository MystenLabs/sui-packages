module 0x5ecfb5611f5f758f2e2ae1e228edd951e7db5cdaf7c6eda3c57a92427a2c0339::newo {
    struct NEWO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEWO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEWO>(arg0, 9, b"NEWO", b"Nemo", b"Finding nemo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8113b7ab-874a-41ec-b4a8-7a8443f24d0d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEWO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NEWO>>(v1);
    }

    // decompiled from Move bytecode v6
}

