module 0x17bfce923d799ccd6b3f0f3082e2b09e8139a02862045967ab05bf5e955f1714::wien {
    struct WIEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: WIEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WIEN>(arg0, 9, b"WIEN", b"hjcc", b"hrn", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3b09260f-27d8-466e-8f1d-f784b5e79ac7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WIEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WIEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

