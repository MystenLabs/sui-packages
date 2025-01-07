module 0x7158bbe55d757ef2ba8db356cdb18382a04d9af9e9536b46dbc8c0e7f8d856c8::mshcrpees {
    struct MSHCRPEES has drop {
        dummy_field: bool,
    }

    fun init(arg0: MSHCRPEES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MSHCRPEES>(arg0, 9, b"MSHCRPEES", b"MashaC", b"Make Masha happy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/62cde334-fb3e-4102-b692-ca2096bee8ea-DSC_1643.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MSHCRPEES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MSHCRPEES>>(v1);
    }

    // decompiled from Move bytecode v6
}

