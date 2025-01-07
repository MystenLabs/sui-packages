module 0x1aa0a11fdd7c0204526faee81cf0262c1f443e1b81f9c414ae52ea84619f512f::coin {
    struct COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COIN>(arg0, 6, b"DOGS", b"DOGS", b"COIN_DESCRIPTION", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<COIN>>(0x2::coin::mint<COIN>(&mut v2, 2000000000000, arg1), @0xc15a5f577fe59d3a60299f059e3a1d8a20d6885605a184f6cce2a21db12b27a7);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COIN>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<COIN>>(v2);
    }

    // decompiled from Move bytecode v6
}

