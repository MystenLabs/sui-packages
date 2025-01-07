module 0xcaffe6f73b69d53d8ee39ff768fa6097e9b5af2c599042ccf077df84d2863269::peopep {
    struct PEOPEP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEOPEP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEOPEP>(arg0, 9, b"PEOPEP", b"Duck", b"Just create ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8d19b481-9b31-4f47-bdaa-31d21d4f2db1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEOPEP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEOPEP>>(v1);
    }

    // decompiled from Move bytecode v6
}

