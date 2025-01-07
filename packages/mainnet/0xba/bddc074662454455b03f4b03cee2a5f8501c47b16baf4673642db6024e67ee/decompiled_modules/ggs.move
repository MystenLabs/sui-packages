module 0xbabddc074662454455b03f4b03cee2a5f8501c47b16baf4673642db6024e67ee::ggs {
    struct GGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GGS>(arg0, 6, b"GGs", b"GGS", b"its over", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732610819848.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GGS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GGS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

