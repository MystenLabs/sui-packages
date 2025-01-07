module 0x5fc8031f59cce40793516082a4625e39c629d3f1c4c4c6a51158fcdf0485c6ab::mshcrpees {
    struct MSHCRPEES has drop {
        dummy_field: bool,
    }

    fun init(arg0: MSHCRPEES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MSHCRPEES>(arg0, 9, b"MSHCRPEES", b"MashaC", b"Make Masha happy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/96832d85-f056-4bf0-9436-4bd4f9ee6bfd-DSC_1643.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MSHCRPEES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MSHCRPEES>>(v1);
    }

    // decompiled from Move bytecode v6
}

