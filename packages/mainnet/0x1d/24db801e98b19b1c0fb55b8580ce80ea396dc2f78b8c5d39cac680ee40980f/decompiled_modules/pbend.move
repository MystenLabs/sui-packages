module 0x1d24db801e98b19b1c0fb55b8580ce80ea396dc2f78b8c5d39cac680ee40980f::pbend {
    struct PBEND has drop {
        dummy_field: bool,
    }

    fun init(arg0: PBEND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PBEND>(arg0, 9, b"PBEND", b"hejd", b"bebe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/74870737-531e-46ee-b117-900cc1f46eee.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PBEND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PBEND>>(v1);
    }

    // decompiled from Move bytecode v6
}

