module 0xa4a483e155dd148c5ab26ad8d72dad68054f9a7073b43b28936ca8a7535a92ce::catb {
    struct CATB has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATB>(arg0, 9, b"CATB", b"cute cats", b"A vibrant community of cat lovers", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b2b4147e-49b4-425a-bdfe-164f4bbd6c76.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CATB>>(v1);
    }

    // decompiled from Move bytecode v6
}

