module 0xa6c6d51f47add73dd7ed0fc14d3bac60e74a79f767b40944aaa1945cef635051::shoroom {
    struct SHOROOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHOROOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHOROOM>(arg0, 6, b"Shoroom", b"shizukake", b"https://www.shizukake.com/", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_1_6c41121e2e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHOROOM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHOROOM>>(v1);
    }

    // decompiled from Move bytecode v6
}

