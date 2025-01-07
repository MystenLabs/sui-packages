module 0xac857a79adce34ba36743d6dc0234a96f414139602c00ca2c97001bf10773a7a::gfghd {
    struct GFGHD has drop {
        dummy_field: bool,
    }

    fun init(arg0: GFGHD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GFGHD>(arg0, 9, b"GFGHD", b"ADFADAS", b"FNFGBFG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1fa533c0-e1d4-46b5-801c-30bc2336b0e8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GFGHD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GFGHD>>(v1);
    }

    // decompiled from Move bytecode v6
}

