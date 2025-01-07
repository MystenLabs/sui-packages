module 0x82d1424a65ecdd0e4ea824ee33f91fdf6334e6640f60460d5dfc47ab97783489::catsbaby {
    struct CATSBABY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATSBABY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATSBABY>(arg0, 9, b"CATSBABY", x"537569636174c4b1", b"Baby cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/98e6470e-9d0d-48ae-a1b8-d1e2e920827e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATSBABY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CATSBABY>>(v1);
    }

    // decompiled from Move bytecode v6
}

