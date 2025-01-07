module 0x260ed6988ad328f5bb10e88921149f90add5f99df95b3294c119ebc021bac21c::zqr {
    struct ZQR has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZQR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZQR>(arg0, 9, b"ZQR", b"Zhaqor", b"Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cdc70b80-27e1-45cb-af37-c0fe7b59bbb3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZQR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZQR>>(v1);
    }

    // decompiled from Move bytecode v6
}

