module 0xc24fa7aa2d8fc5e73a888839f320077ea0d8ab98015f01d8db9c0561b9d2b8c2::messi {
    struct MESSI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MESSI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MESSI>(arg0, 9, b"MESSI", b"MESSI", b"Messi Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MESSI>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MESSI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MESSI>>(v1);
    }

    // decompiled from Move bytecode v6
}

