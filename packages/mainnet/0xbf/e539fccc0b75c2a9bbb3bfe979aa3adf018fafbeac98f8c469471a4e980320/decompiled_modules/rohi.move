module 0xbfe539fccc0b75c2a9bbb3bfe979aa3adf018fafbeac98f8c469471a4e980320::rohi {
    struct ROHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROHI>(arg0, 9, b"ROHI", b"Rohit", b"My self ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/567570cb-ea3d-4b38-ace1-e99b77a436d5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ROHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

