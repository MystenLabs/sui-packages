module 0x85dc60b32ff5a7bd8dcb3a5e405d5c7604004792dccc887e574a7d02f683da3f::freemoney {
    struct FREEMONEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FREEMONEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FREEMONEY>(arg0, 6, b"FreeMoney", b"For the Free Money", b"I'm making this so I'm one of the first 100 projects and I get rewards. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730951238954.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FREEMONEY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FREEMONEY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

