module 0x40b34eaafabb13c32e9a38ee9507ab32d845a34b6546d2d5b53b6a726a880fee::crl {
    struct CRL has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRL>(arg0, 9, b"CRL", b"Coral ", b"Corals the most important basis for marine life. Coral reefs directly support 500 million people worldwide through fishing, and reefs protect coastlines from surges and tsunamis more effectively than any man-made structures.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ce2e5b8d-b715-4f77-ad21-3d33301dea00.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CRL>>(v1);
    }

    // decompiled from Move bytecode v6
}

