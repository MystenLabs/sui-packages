module 0xb94f9071d3fac364ec25242dd5ed3af8bf87cc7581a2ccb0394cb2cee8a1bd52::queeninu {
    struct QUEENINU has drop {
        dummy_field: bool,
    }

    fun init(arg0: QUEENINU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QUEENINU>(arg0, 9, b"QUEENINU", b"Queenafriq", b"Queeninu is a great token from ancient civilizations. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/01c7fb00-d63d-47f4-b4dd-5be4d36bf1f9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QUEENINU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<QUEENINU>>(v1);
    }

    // decompiled from Move bytecode v6
}

