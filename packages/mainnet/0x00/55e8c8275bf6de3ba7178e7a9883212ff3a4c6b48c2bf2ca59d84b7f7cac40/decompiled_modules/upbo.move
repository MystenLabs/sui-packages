module 0x55e8c8275bf6de3ba7178e7a9883212ff3a4c6b48c2bf2ca59d84b7f7cac40::upbo {
    struct UPBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: UPBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UPBO>(arg0, 9, b"UPBO", b"UPB", b"Banggg", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/937ad511-cab6-43ac-a34d-c4a17a1a8981.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UPBO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UPBO>>(v1);
    }

    // decompiled from Move bytecode v6
}

