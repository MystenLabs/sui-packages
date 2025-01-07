module 0x7405a3e6b42fb74152c82226b482d3afc5b22001829d38a0136d970a5b187946::mbb {
    struct MBB has drop {
        dummy_field: bool,
    }

    fun init(arg0: MBB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MBB>(arg0, 6, b"MBB", b"Mountain", b"Mountain is the best view", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pub-efea87dea3f94e8084e073588c980c50.r2.dev/logo/01JB6H8Z8RA40Q1PR383Z5ZSMF/01JB6J0JJM0N205X04DYN800V1")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MBB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MBB>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

