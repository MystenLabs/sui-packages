module 0xfddda6f81619576c20fc4c9d84fbeac5bf4caa41637bef6706febe9098e485a7::suker {
    struct SUKER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUKER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUKER>(arg0, 6, b"SUKER", b"SUIKER", b"JOKER", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9003_f6467e85ce.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUKER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUKER>>(v1);
    }

    // decompiled from Move bytecode v6
}

