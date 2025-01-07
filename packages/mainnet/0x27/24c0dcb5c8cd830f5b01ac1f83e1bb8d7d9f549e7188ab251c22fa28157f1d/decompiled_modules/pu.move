module 0x2724c0dcb5c8cd830f5b01ac1f83e1bb8d7d9f549e7188ab251c22fa28157f1d::pu {
    struct PU has drop {
        dummy_field: bool,
    }

    fun init(arg0: PU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PU>(arg0, 9, b"PU", b"Puchai", b"Meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/420f29a7-c8ba-4b86-b8b8-5515c8a00367.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PU>>(v1);
    }

    // decompiled from Move bytecode v6
}

