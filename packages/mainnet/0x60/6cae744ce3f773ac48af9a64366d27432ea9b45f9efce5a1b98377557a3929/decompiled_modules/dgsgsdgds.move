module 0x606cae744ce3f773ac48af9a64366d27432ea9b45f9efce5a1b98377557a3929::dgsgsdgds {
    struct DGSGSDGDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DGSGSDGDS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DGSGSDGDS>(arg0, 9, b"DGSGSDGDS", b"SGfh", b"GSGDSgsdg", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/35199613-b593-439d-b7db-84de759e87e3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DGSGSDGDS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DGSGSDGDS>>(v1);
    }

    // decompiled from Move bytecode v6
}

