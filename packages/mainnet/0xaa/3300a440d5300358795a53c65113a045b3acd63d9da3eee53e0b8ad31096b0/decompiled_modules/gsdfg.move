module 0xaa3300a440d5300358795a53c65113a045b3acd63d9da3eee53e0b8ad31096b0::gsdfg {
    struct GSDFG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GSDFG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GSDFG>(arg0, 9, b"GSDFG", b"REREW", b"SF", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/36c34471-49b2-4185-82b1-07820752466f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GSDFG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GSDFG>>(v1);
    }

    // decompiled from Move bytecode v6
}

