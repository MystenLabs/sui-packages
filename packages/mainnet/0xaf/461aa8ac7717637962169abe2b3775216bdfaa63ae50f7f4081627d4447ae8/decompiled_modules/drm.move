module 0xaf461aa8ac7717637962169abe2b3775216bdfaa63ae50f7f4081627d4447ae8::drm {
    struct DRM has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRM>(arg0, 9, b"DRM", b"Dream", b"Dreaming about dream", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7595a5fc-d538-4883-8a0e-3aa9a7ca358e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DRM>>(v1);
    }

    // decompiled from Move bytecode v6
}

