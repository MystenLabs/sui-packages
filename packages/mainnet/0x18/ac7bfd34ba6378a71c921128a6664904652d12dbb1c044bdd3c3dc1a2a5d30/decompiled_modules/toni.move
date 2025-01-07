module 0x18ac7bfd34ba6378a71c921128a6664904652d12dbb1c044bdd3c3dc1a2a5d30::toni {
    struct TONI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TONI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TONI>(arg0, 9, b"TONI", b"Toni dog", b"Tonidog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/238f7806-2a8a-494a-8c9e-923f1b0767fb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TONI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TONI>>(v1);
    }

    // decompiled from Move bytecode v6
}

