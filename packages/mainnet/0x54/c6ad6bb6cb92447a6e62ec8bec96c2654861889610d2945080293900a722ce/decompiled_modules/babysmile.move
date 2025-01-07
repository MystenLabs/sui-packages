module 0x54c6ad6bb6cb92447a6e62ec8bec96c2654861889610d2945080293900a722ce::babysmile {
    struct BABYSMILE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYSMILE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYSMILE>(arg0, 9, b"BABYSMILE", b"BABY", b"Baby smile", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/377b6b34-793f-43a4-8f90-b5d751755b97.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYSMILE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BABYSMILE>>(v1);
    }

    // decompiled from Move bytecode v6
}

