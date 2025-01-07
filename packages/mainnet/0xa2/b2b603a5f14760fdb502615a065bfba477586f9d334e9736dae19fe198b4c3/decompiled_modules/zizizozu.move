module 0xa2b2b603a5f14760fdb502615a065bfba477586f9d334e9736dae19fe198b4c3::zizizozu {
    struct ZIZIZOZU has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZIZIZOZU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZIZIZOZU>(arg0, 6, b"Zizizozu", b"Zoltaninu", b"ZizizozuZizizozuZizizozuZizizozuZizizozuZizizozuZizizozu", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/wn_TS_TGW_400x400_a1ddfb70f3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZIZIZOZU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZIZIZOZU>>(v1);
    }

    // decompiled from Move bytecode v6
}

