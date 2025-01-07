module 0x84b77cb32f128a3348e613cbbdf133d98566a77b55b7d5a185783c0be204b662::phamhiep {
    struct PHAMHIEP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PHAMHIEP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PHAMHIEP>(arg0, 9, b"PHAMHIEP", b"Momo ", b"Im momo tokens ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a6c1c797-ceab-40f9-835d-65f14868996d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PHAMHIEP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PHAMHIEP>>(v1);
    }

    // decompiled from Move bytecode v6
}

