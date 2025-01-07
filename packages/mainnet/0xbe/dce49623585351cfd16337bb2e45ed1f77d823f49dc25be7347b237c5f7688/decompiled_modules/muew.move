module 0xbedce49623585351cfd16337bb2e45ed1f77d823f49dc25be7347b237c5f7688::muew {
    struct MUEW has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUEW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUEW>(arg0, 6, b"MUEW", b"MUEW SUI", b"designed to connect", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_05_08_08_22_42_16380e3906.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUEW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MUEW>>(v1);
    }

    // decompiled from Move bytecode v6
}

