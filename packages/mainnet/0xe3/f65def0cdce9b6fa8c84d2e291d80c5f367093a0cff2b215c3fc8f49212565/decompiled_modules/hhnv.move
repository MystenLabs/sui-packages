module 0xe3f65def0cdce9b6fa8c84d2e291d80c5f367093a0cff2b215c3fc8f49212565::hhnv {
    struct HHNV has drop {
        dummy_field: bool,
    }

    fun init(arg0: HHNV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HHNV>(arg0, 6, b"HHNV", b"HNV", b"Fixed-supply token on Sui. No USD peg or redemption guarantee. Liquidity provider positions may be withdrawn.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://hhnv-assets.pages.dev/hnv-logo-v1.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<HHNV>>(0x2::coin::mint<HHNV>(&mut v2, 500000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<HHNV>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HHNV>>(v1);
    }

    // decompiled from Move bytecode v7
}

