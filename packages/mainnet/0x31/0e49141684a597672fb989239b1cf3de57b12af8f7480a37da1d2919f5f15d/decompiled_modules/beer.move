module 0x310e49141684a597672fb989239b1cf3de57b12af8f7480a37da1d2919f5f15d::beer {
    struct BEER has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEER>(arg0, 9, b"BEER", b"BEER", b"TASTY BEER", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.clawhammersupply.com/cdn/shop/articles/how_to_make_beer.jpg?v=1682910375&width=1532")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BEER>(&mut v2, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEER>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BEER>>(v1);
    }

    // decompiled from Move bytecode v6
}

