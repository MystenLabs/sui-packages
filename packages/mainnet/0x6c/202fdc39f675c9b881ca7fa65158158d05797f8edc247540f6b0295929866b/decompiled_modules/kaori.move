module 0x6c202fdc39f675c9b881ca7fa65158158d05797f8edc247540f6b0295929866b::kaori {
    struct KAORI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAORI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAORI>(arg0, 9, b"KAORI", b" KAORI", b"KA O RI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3cde7261-b9dc-45cd-be98-d41105d11efb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAORI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KAORI>>(v1);
    }

    // decompiled from Move bytecode v6
}

