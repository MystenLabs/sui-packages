module 0x672c691534290e0e17de97953d5ad6a016cdf1e094021ec8cc190d9b5b558883::ddddd123 {
    struct DDDDD123 has drop {
        dummy_field: bool,
    }

    fun init(arg0: DDDDD123, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DDDDD123>(arg0, 6, b"DDDDD123", b"DDD", b"312314", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ken_Kaneki_2c74f894dd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DDDDD123>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DDDDD123>>(v1);
    }

    // decompiled from Move bytecode v6
}

