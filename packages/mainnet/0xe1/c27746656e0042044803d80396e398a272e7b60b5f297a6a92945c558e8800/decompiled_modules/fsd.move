module 0xe1c27746656e0042044803d80396e398a272e7b60b5f297a6a92945c558e8800::fsd {
    struct FSD has drop {
        dummy_field: bool,
    }

    fun init(arg0: FSD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FSD>(arg0, 9, b"FSD", b"FGWE", b"VCS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/35735db7-1995-478e-a71d-b988bacc4dca.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FSD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FSD>>(v1);
    }

    // decompiled from Move bytecode v6
}

