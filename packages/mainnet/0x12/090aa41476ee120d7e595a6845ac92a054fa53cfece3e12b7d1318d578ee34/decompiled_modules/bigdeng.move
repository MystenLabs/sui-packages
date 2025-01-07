module 0x12090aa41476ee120d7e595a6845ac92a054fa53cfece3e12b7d1318d578ee34::bigdeng {
    struct BIGDENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIGDENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIGDENG>(arg0, 6, b"Bigdeng", b"dengbig", b"big deng", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1_4ca626ec38.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIGDENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BIGDENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

