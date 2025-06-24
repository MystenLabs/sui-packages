module 0xd0081eff5c853ba0dbeb4eb227472b41bd19ab62e61ee85fee08e8e964b1af6d::muve {
    struct MUVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUVE>(arg0, 6, b"MUVE", b"MUVE ON SUI", x"244d5556453a20546865204d757368726f6f6d2e20497420726f6f746564206465657020696e73696465207468652053756920426c6f636b636861696e2e0a4e6f77206974277320737072656164696e67206163726f737320746865206e6574776f726b2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiavjc7edeheem6qhktyvpi4xkcwvzwzdr5ydb6zqebx7liqievyim")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUVE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MUVE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

