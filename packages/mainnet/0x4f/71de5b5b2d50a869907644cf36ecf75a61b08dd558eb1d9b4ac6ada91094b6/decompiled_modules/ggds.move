module 0x4f71de5b5b2d50a869907644cf36ecf75a61b08dd558eb1d9b4ac6ada91094b6::ggds {
    struct GGDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GGDS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GGDS>(arg0, 9, b"GGDS", b"ggds", b"JGHGHFES", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1afa2411-db4d-4416-9a9c-31f4294a82de.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GGDS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GGDS>>(v1);
    }

    // decompiled from Move bytecode v6
}

