module 0x71fb93819ecb38f0dd0d5e46e57c24f5c6d7736951e831ae9a5fcd29bfba3150::phamhiep {
    struct PHAMHIEP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PHAMHIEP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PHAMHIEP>(arg0, 9, b"PHAMHIEP", b"Momo ", b"Im momo tokens ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/efd87674-7702-49a3-8fb1-4c1ae83b2dd6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PHAMHIEP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PHAMHIEP>>(v1);
    }

    // decompiled from Move bytecode v6
}

