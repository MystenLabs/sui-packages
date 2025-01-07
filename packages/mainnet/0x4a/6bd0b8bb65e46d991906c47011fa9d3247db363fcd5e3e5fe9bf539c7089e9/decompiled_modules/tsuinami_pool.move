module 0x4a6bd0b8bb65e46d991906c47011fa9d3247db363fcd5e3e5fe9bf539c7089e9::tsuinami_pool {
    struct TSUINAMI_POOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: TSUINAMI_POOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TSUINAMI_POOL>(arg0, 9, b"TSUINAMI POOL", b"TSUINAMI", b"https://t.me/tsuinamiportal http://tsuinami.xyz/", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TSUINAMI_POOL>(&mut v2, 1689574563000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TSUINAMI_POOL>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TSUINAMI_POOL>>(v1);
    }

    // decompiled from Move bytecode v6
}

