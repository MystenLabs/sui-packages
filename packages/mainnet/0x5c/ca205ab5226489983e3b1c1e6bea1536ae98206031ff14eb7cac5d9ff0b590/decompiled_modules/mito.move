module 0x5cca205ab5226489983e3b1c1e6bea1536ae98206031ff14eb7cac5d9ff0b590::mito {
    struct MITO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MITO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MITO>(arg0, 9, b"MITO", b"Mito Token", b"token community", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5f00e24d-4fe1-4bc1-a273-e1cdcdcba288.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MITO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MITO>>(v1);
    }

    // decompiled from Move bytecode v6
}

