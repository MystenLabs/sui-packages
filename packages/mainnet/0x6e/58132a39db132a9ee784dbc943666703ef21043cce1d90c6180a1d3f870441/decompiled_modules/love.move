module 0x6e58132a39db132a9ee784dbc943666703ef21043cce1d90c6180a1d3f870441::love {
    struct LOVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOVE>(arg0, 9, b"LOVE", b"Sos", b"Fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8d24333d-2492-4b76-9bdb-0ae525b4e396.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOVE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LOVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

