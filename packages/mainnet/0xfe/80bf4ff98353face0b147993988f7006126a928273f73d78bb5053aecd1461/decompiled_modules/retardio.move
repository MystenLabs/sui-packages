module 0xfe80bf4ff98353face0b147993988f7006126a928273f73d78bb5053aecd1461::retardio {
    struct RETARDIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: RETARDIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RETARDIO>(arg0, 6, b"RETARDIO", b"RETARDIO PNUT SUI", x"544845204f4720524554415244494f20504e55540a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241223_231829_956_aa641a02ee.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RETARDIO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RETARDIO>>(v1);
    }

    // decompiled from Move bytecode v6
}

