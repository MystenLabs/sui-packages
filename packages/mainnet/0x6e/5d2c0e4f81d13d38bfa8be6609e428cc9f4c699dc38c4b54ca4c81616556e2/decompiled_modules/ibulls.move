module 0x6e5d2c0e4f81d13d38bfa8be6609e428cc9f4c699dc38c4b54ca4c81616556e2::ibulls {
    struct IBULLS has drop {
        dummy_field: bool,
    }

    fun init(arg0: IBULLS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IBULLS>(arg0, 6, b"IBULLS", b"ISTANBULLS", b"If you believe that it is one of the most beautiful cities in the world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1747238024389.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IBULLS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IBULLS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

