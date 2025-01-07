module 0x20b91b76b5d224207507680e02e6413092a700a5b99d50c2046e532bfe0261b9::infinity {
    struct INFINITY has drop {
        dummy_field: bool,
    }

    fun init(arg0: INFINITY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<INFINITY>(arg0, 6, b"Infinity", b"Infinity SUI", b"Atomicals sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_04_08_10_05_03_3ed11981c7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<INFINITY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<INFINITY>>(v1);
    }

    // decompiled from Move bytecode v6
}

