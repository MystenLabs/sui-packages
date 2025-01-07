module 0x9b1f55b16dfeec59fc14fa4fb3b50fe7d3817d490e9c80d90d17048f4a5a3836::suibull {
    struct SUIBULL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBULL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBULL>(arg0, 6, b"SUIBULL", b"Sui Bull", x"4d65657420746865206f6666696369616c206d6173636f74206f6620746865205375692c20546865205375692042756c6c2e204c656164696e67207468652063686172676520696e746f20746865206e6578742062756c6c20736561736f6e2e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_40267c1d53.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBULL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBULL>>(v1);
    }

    // decompiled from Move bytecode v6
}

