module 0xe3b93c6e6e2b39c74e89f7881f68e30de81ac2901820d1941680019cf6a27c58::usdb {
    struct USDB has drop {
        dummy_field: bool,
    }

    fun init(arg0: USDB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDB>(arg0, 6, b"USDB", b"USDB", b"Fixed-supply token on Sui. No USD peg or redemption guarantee. Liquidity provider positions may be withdrawn.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://usdb-assets.pages.dev/usdb-logo-v1.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<USDB>>(0x2::coin::mint<USDB>(&mut v2, 500000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<USDB>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<USDB>>(v1);
    }

    // decompiled from Move bytecode v7
}

