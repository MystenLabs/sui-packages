module 0x867147a1682a9b3486a5dfb7bf828ab5e5ce3e43b62dd7d1a0c7a8711de5ba1a::st_sui {
    struct ST_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ST_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ST_SUI>(arg0, 9, b"ST_SUI", b"Staked SUI", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ST_SUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ST_SUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

