module 0xe47a555acce65d2bc970ed847f17fbecd41d0646775ee6b686780063bb18b93b::boga {
    struct BOGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOGA>(arg0, 6, b"BOGA", b"BOGA BOGA", b"BOGA BOGA X AI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Gav_C_Hcc_Ww_AARZC_9_8cd8bb5591.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

