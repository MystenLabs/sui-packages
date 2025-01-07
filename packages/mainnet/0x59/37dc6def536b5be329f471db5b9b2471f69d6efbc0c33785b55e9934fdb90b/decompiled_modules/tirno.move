module 0x5937dc6def536b5be329f471db5b9b2471f69d6efbc0c33785b55e9934fdb90b::tirno {
    struct TIRNO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TIRNO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TIRNO>(arg0, 9, b"TIRNO", b"Tirno kong", b"Tirnokong", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fd2dbde3-a975-4026-b282-ce63af9cce2e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TIRNO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TIRNO>>(v1);
    }

    // decompiled from Move bytecode v6
}

