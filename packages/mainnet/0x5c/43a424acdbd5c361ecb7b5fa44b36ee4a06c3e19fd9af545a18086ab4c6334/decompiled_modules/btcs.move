module 0x5c43a424acdbd5c361ecb7b5fa44b36ee4a06c3e19fd9af545a18086ab4c6334::btcs {
    struct BTCS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTCS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTCS>(arg0, 6, b"BTCS", b"BTC on Sui", b"BTC on Sui, will be Sui's version of Bitcoin on steroids, faster transaction than the BTC chain, It will be Sui's store of Value, and Scarce.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/BTCS_48ae3f0ab1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTCS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BTCS>>(v1);
    }

    // decompiled from Move bytecode v6
}

