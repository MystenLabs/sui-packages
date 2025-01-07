module 0x68346c8b1bb137ffcffad8f6762181d9afd13db74eb538bdf4652891ef8ef6da::tpo {
    struct TPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TPO>(arg0, 9, b"TPO", b"TRUMPO", b"Its", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6ef1a96d-0eee-4be8-841c-2c5da80ac361.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TPO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TPO>>(v1);
    }

    // decompiled from Move bytecode v6
}

