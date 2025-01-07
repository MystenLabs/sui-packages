module 0x63a60738c37b1ef46f600fea237c58f4747efbd31d3cc229feb7d7d90d7f4a2e::djnvdw {
    struct DJNVDW has drop {
        dummy_field: bool,
    }

    fun init(arg0: DJNVDW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DJNVDW>(arg0, 9, b"djnvdw", b"djnvdw", b"reqfgf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DJNVDW>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DJNVDW>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DJNVDW>>(v1);
    }

    // decompiled from Move bytecode v6
}

